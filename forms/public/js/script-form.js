window.onload = init;

function init() {
	// Реакция на смену языка (TODO на странице форм нет компонента дял смены языка, она есть только на главной)
	let langLinks = document.querySelectorAll(`.lang`);
	for (const langLink of langLinks) {
		if(langLink.dataset.lang) {
			langLink.addEventListener(`click`, ()=>changeLang(langLink.dataset.lang) );
		}
	}

	// Обрабатываем метаданные инпутов
	const boxes = document.querySelectorAll(`.box`);
	for (const box of boxes) {
		// Берем все инпуты, для каждого вызываем обрабочик
		handeBoxDataset(box); // В основном вешаются валидаторы на изменение данных (и только у selectbox еще и обработка refillable)
	}

	initFileboxes();

	// Добавляем валидацию формы перед отправкой
	document.querySelector(`.wr-submitbox .button`).addEventListener(`click`, sendForm);
}



function handeBoxDataset(box) {
	/**
	 * Для зависимых selectbox'ов, ищет покровитилей, и вещает им событие - обновление зависимого компонента
	 * На textbox, checkbox, filebox - вешает метод валидатор, который убеждается в валидности данных компонента, в противном случае визуально помечает компонент не валидным.
	 */

	// Ищем метаданные
	const metaTag = box.querySelector(`.meta`);
	if(!metaTag || !metaTag.dataset) return;

	const dataset = metaTag.dataset;

	// Обработчик определяет тип инпута
	switch ( dataset[`type`] ) {
		case `selectbox`:
			{
				const selectEl = box.querySelector(`.wr-selectbox select`);

				// Вешаем валидатор на изменение данных
				selectEl.addEventListener(`change`, ()=> {
					validateSelectbox(box);
					// unmarkInvalidBox(box, "selectbox");
				});

				// Если пункты списка явл. зависимыми от других компонентов, вешаем "заполнятор" на родителей (покровителей) этого компонента (что бы когда родитель получил данные, инициироваль заполнение подчиненного)
				if(dataset[`refillable`] && dataset[`updaters`]) {
					// Определеям покровителей и заставляем обновлять этот зависимый список
					const updaters = JSON.parse( dataset[`updaters`] );

					// Если есть покровители
					if(updaters.length) {
						for (const updater of updaters) {
							// Ищем элемент покровителя, заставляем его обновлять зависимый список
							const patronEl = document.querySelector(`#${updater.component_id}`);
							if(!patronEl)
								throw `Для зависимого вып. списка, элемент покровитель с id: ${updater.component_id} не был найден!`;
							else {
								patronEl.addEventListener(`${updater.event}`, (e) => {
									if(e.target.value != "") {
										const url = `${location.origin}${dataset[`refillable_source`]}?${updater.as}=${e.target.value}`;
										updateSelectbox(url, selectEl);
									}
								});
							}
						}
					}
					else { // Если покровителей нет, загружаем данные сразу
						const url = `${location.origin}${dataset[`refillable_source`]}`;
						updateSelectbox(url, selectEl);
					}
				}
			}
			break;

		case `textbox`:
			{
				const textEL = box.querySelector(`input[type=text]`);

				// Сбрасывать метку невалидности при изменении данных
				textEL.addEventListener(`change`, ()=> {
					validateTextbox(box);
					// unmarkInvalidBox(box, "textbox");
				});
			}
			break;

		case `checkbox`:
			{
				const checkboxEL = box.querySelector(`input[type=checkbox]`);

				// Сбрасывать метку невалидности при изменении данных
				checkboxEL.addEventListener(`change`, ()=> {
					validateCheckbox(box);
					// unmarkInvalidBox(box, "checkbox");
				});
			}
			break;
		case `filebox`:
			{
				const fileInput = box.querySelector(`input[type=file]`);

				// Сбрасывать метку невалидности при изменении данных
				fileInput.addEventListener(`change`, ()=> {
					validateFilebox(box);
					// unmarkInvalidBox(box, "filetbox");
				});
			}
			break;
		default:
			break;
	}
}



// onclick
function updateSelectbox(url, selectEl) {

	// Получаем данные
	fetch(url).then((resp)=>{
		if( resp.ok ) {
			resp.json().then((json)=>{

				if(json.success) {
					// Данные получены
					// Обновляем содержимое selectbox
					selectEl.innerHTML = "";

					for (const row of json.data) {
						//id
						//name
						const newOption = document.createElement("option");
						newOption.text = row.name;
						newOption.value = row.id;
						selectEl.options.add(newOption);
					}
				}
				else {
					throw `Данные для выпадающего списка не были получены`;
				}
			});
		}
	});
}




async function uploadFilesBulk(fileInput, formKey) {
	const uploadedFileIdArr = [];

	for (const file of fileInput.files) {
		let formData = new FormData();

		formData.append("formKey", formKey);
		formData.append("file", file);
		const resp = await fetch('/api/uploadFile', {method: "POST", body: formData});
		/*
			resp = {
				success: true,
				data: {
					fileId: pgRes[0].id,
					fileName: file.filename,
					originalName: file.originalname,
					mimeType: file.mimetype,
					destination: file.destination,
					path: file.path,
					size: file.size
				}
			};
		*/
		const json = await resp.json();

		if(json.success) {
			uploadedFileIdArr.push(json.data.fileId);
		}
		else {
			console.error(`Не удалось загрузить файл: ${file.name}`);
			throw new Error(json.error);
		}
	}

	return uploadedFileIdArr;
}



async function sendForm(e) {

	// Убедимся что форма валидно заполнена
	const errCount = validateForm();
	const formIsValid = errCount < 1;
	let uploadIsSuccessful = true;
	let numberOfFiles = 0;
	if(!formIsValid) return;

	// Генерируем ключ заявки
	const formKey = FileBox.getRandomKey();

	// Для каждого .filebox загружаем файлы
	const fileboxes = document.querySelectorAll(`.filebox`);
	for (const filebox of fileboxes) {
		// Если файл указан загружаем его на сервер
		let fileInput = filebox.querySelector(`input[type=file]`);

		if(fileInput.files.length > 0) { // Если в тек. инпуте есть файлы
			try {
				// Загружаем все файлы на сервер
				const arrIdsOfUploadedFiles = await uploadFilesBulk(fileInput, formKey);
				numberOfFiles += arrIdsOfUploadedFiles.length;
			} catch (err) {
				//TODO: ROLLBACK FILES
				uploadIsSuccessful = false;
				console.error(`Ответ от сервера: ${err.message}`);
				markBoxAsInvalid(filebox, "Не удалось загрузить файл", "filebox"); // Помечаем файлбокс в котором сорвалась загрузка
				break;
			}
		}
		else {
			// Файл не выбран, еще раз убедимся что filebox валидный
			validateFilebox(filebox);
		}
	}

	if(uploadIsSuccessful) {
		const formEl = document.querySelector(`form#form`);

		// Добавляем ключ формы, для связи с файлами
		const formKeyInput = document.createElement('input');
		formKeyInput.setAttribute('name', "formKey");
		formKeyInput.setAttribute('value', formKey);
		formKeyInput.setAttribute('type', 'hidden');
		formEl.appendChild(formKeyInput);

		// Добавляе количество загруженных файлов, что бы бэк подвязал загруженные файлы
		const hasFilesInput = document.createElement('input');
		hasFilesInput.setAttribute('name', "hasFiles");
		hasFilesInput.setAttribute('value', numberOfFiles);
		hasFilesInput.setAttribute('type', 'hidden');
		formEl.appendChild(hasFilesInput);

		formEl.submit();

		// TODO: Сохранить ключ фаормы в локал-сторэдж или в куки, для просмотра статуса заявки
	}
}



function validateForm() {
	let errCount = 0;
	let scrolled = false;

	const boxes = document.querySelectorAll(`.box`);

	for (const box of boxes) {
		let innerErrCount = 0;

		switch (box.dataset.type) {
			case `selectbox`:
				innerErrCount += validateSelectbox(box);
				break;

			case `textbox`:
				innerErrCount += validateTextbox(box);
				break;

			case `checkbox`:
				innerErrCount += validateCheckbox(box);
				break;

			case `filebox`:
				innerErrCount += validateFilebox(box);
				break;
			default:
				break;
		}

		// Если тек. поле не валидно
		if(innerErrCount > 0) {
			errCount += innerErrCount;

			// Если это первое не валидное поле, скроолим окно к нему
			if(!scrolled) {
				box.scrollIntoView({block: "center", inline: "nearest", behavior: "smooth"});
				scrolled = true;
			}
		}
	}


	return errCount;
}



function validateSelectbox(selectbox) {
	const metaTag = selectbox.querySelector(`.meta`);
	let curValue;

	if(metaTag) {
		const metaData = metaTag.dataset;

		if(metaData.required) {
			curValue = selectbox.querySelector(`.wr-selectbox select`).value;
			if(curValue == "") {
				markBoxAsInvalid(selectbox, "Пункт не выбран!", "selectbox");
				return 1;
			}
		}
	}

	unmarkInvalidBox(selectbox, "selectbox");
	return 0;
}



function validateCheckbox(checkbox) {
	const metaTag = checkbox.querySelector(`.meta`);

	if(metaTag) {
		const metaData = metaTag.dataset;
		const checkboxEL = checkbox.querySelector(`input[type=checkbox]`);

		// Если отметка обязателена
		if(metaData.required) {
			// Если не отмечен
			if(!checkboxEL.checked) {
				markBoxAsInvalid(checkbox, null, "checkbox");
				return 1;
			}
		}
	}

	unmarkInvalidBox(checkbox, "checkbox");
	return 0;
}



function validateTextbox(textbox) {
	const metaTag = textbox.querySelector(`.meta`);

	if(metaTag) {
		const metaData = metaTag.dataset;
		const textEL = textbox.querySelector(`input[type=text]`);

		// Если заполнение обязателено
		if(metaData.required) {
			// Если текста нет
			if(textEL.value == "") {
				markBoxAsInvalid(textbox, "Поле не заполнено!", "textbox");
				return 1;
			}
		}

		// Если есть регулярка
		if(metaData.regex) {
			const regex = new RegExp(metaData.regex);

			if( !regex.test(textEL.value) ) {
				markBoxAsInvalid(textbox, "Не корректное значение!", "textbox");
				return 1;
			}
		}
	}

	unmarkInvalidBox(textbox, "textbox");
	return 0;
}



function validateFilebox(filebox) {
	const metaTag = filebox.querySelector(`.meta`);
	const fileInput = filebox.querySelector(`input[type=file]`);

	if(metaTag) {
		const metaData = metaTag.dataset;

		// Если файл обязателен, смотрим выбран ли он
		if(metaData.required) {
			// Если файл не выбран
			if(fileInput.files.length == 0) {
				markBoxAsInvalid(filebox, "Файл не выбран!", "filebox");
				return 1;
			}
		}

		// Для остальных проверок файл должен быть выбран
		// Убедимся что файл выбран
		if(fileInput.files.length != 0) {
			const file = fileInput.files[0];

			// Если имеется ограничение на размер файла
			if(metaData.maxSize) {
				if(file.size > metaData.maxSize) {
					markBoxAsInvalid(filebox, "Размер файла превышен!", "filebox");
					return 1;
				}
			}

			// Если имеется список разрешенных расширений
			if(metaData.ext) {
				const ext = JSON.parse(metaData.ext);
				const splited = file.name.split(".");
				if(splited.length) {
					const curExt = splited[ splited.length-1 ];
					if( !ext.includes(curExt) ) {
						markBoxAsInvalid(filebox, "Не корретный тип файла!", "filebox");
						return 1;
					}
				}
				else {
					markBoxAsInvalid(filebox, "Не корретный тип файла!", "filebox");
					return 1;
				}
			}
		}
	}

	// Снимаем метку не валидности
	unmarkInvalidBox(filebox, "filetbox");
	return 0;
}


async function unmarkInvalidBox(box, boxType = null) {
	// Если тип не указан
	if(!boxType) {
		boxType = box.dataset.type;
	}

	box.classList.remove(`invalidBox`);
	// Убираем подпись ошибки
	const errorDescEl = box.querySelector(`.errorDesc`);
	if(errorDescEl) {
		errorDescEl.innerText = "";
	}
}

/**
 * Помечает элемент ввода как невалидный
 * @param {*} box Обертка компонента ввода
 * @param {*} errorDesc Подпись ошибки
 * @param {*} boxType тип компонента
 */
async function markBoxAsInvalid(box, errorDesc, boxType = null) {
	// Если тип не указан
	if(!boxType) {
		boxType = box.dataset.type;
	}

	let errorDescEl = null;

	switch (boxType) {
		case "textbox":
			box.classList.add(`invalidBox`);
			// Подпишем ошибку
			errorDescEl = box.querySelector(`.errorDesc`);
			errorDescEl.innerText = errorDesc;
			break;
		case "selectbox":
			box.classList.add(`invalidBox`);
			// Подпишем ошибку
			errorDescEl = box.querySelector(`.errorDesc`);
			errorDescEl.innerText = errorDesc;
			break;
		case "checkbox":
			box.classList.add(`invalidBox`);
			break;
		case "filebox":
			box.classList.add(`invalidBox`);
			// Подпишем ошибку
			errorDescEl = box.querySelector(`.errorDesc`);
			errorDescEl.innerText = errorDesc;
			break;
		default:
			break;
	}
}


function changeLang(lang) {
	document.cookie = `lang=${lang}`;
	location.reload();
}



/**
 * Добавляет слушатель на файл-боксы, который пишет список файлов после выбора
 */
function initFileboxes() {
	// TODO почему этот метод не инициализируется в методе handeBoxDataset, когда вешаются валидаторы
	const fileboxes = document.querySelectorAll(`.filebox`);
	for (const filebox of fileboxes) {
		const fileInput = filebox.querySelector(`input[type=file]`);

		// При выборе файла менять имя
		fileInput.addEventListener(`change`, FileBox.onSelectFiles); // Событие - новый(е) файл(ы) выбран(ы)
	}
}



const colorIndex = {
	doc: `#5380c0`, xlsx: `#00ac53`, csv: `#00ac53`,
	mp4: `#819bbe`, avi: `#f8b617`,
	pdf: `#ed3e2b`, djvu: `#3b6bb5`,
	html: `#ed3e2b`, css: `#819bbe`,
	pptx: `#ed3e2b`, ppt: `#ed3e2b`,
	zip: `#586c87`, rar: `#586c87`, "7z": `#586c87`,
	png: `#00ac53`, jpeg: `#00ac53`, jpg: `#00ac53`, gif: `#00ac53`, webp: `#00ac53`,
	mp3: `#9a53a1`, wav: `#9a53a1`,
	ai: `#f27b1f`, ps: `#3b6bb5`,
	default: `#586c87`
};





class CommonUtils {
	static removeFileFromFileList(input, name) {
		const dt = new DataTransfer();

		for (const file of input.files) {
			if (name !== file.name)
				dt.items.add(file);
		}

		input.files = dt.files;
	}

	static getFileSvgIcon(filename) {
		let fileExt, fileColor;

		let ext = String(filename).match(/(?<=\.)[^.\s]+$/); // Определение расширения
		if(!ext) fileExt = '.';
		else fileExt = ext[0];

		if(!colorIndex[fileExt]) fileColor = colorIndex['default']; // Определение цвета
		else fileColor = colorIndex[fileExt];

		const res =`<svg class="fileIcon" version="1.2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 96" height="25">
		<path fill="${fileColor}" d="m56.9 95.2h-41.8c-8 0-14.5-6.5-14.5-14.5v-66.3c0-8 6.5-14.5 14.5-14.5h36.3l20 20.1v60.7c0 8-6.5 14.5-14.5 14.5z"></path>
		<path opacity="0.5" fill="#fff" d="m71.4 20h-15.9c-2.2 0-4-1.8-4-4.1l-0.1-16"></path>
		<text x="50%" y="65%" dominant-baseline="middle" text-anchor="middle" font-size="18" font-weight="bolder" font-family="sans-serif" fill="#fff">${fileExt}</text>
		</svg>`;
		return res;
	}
}


class FileBox {
	static getRandomKey() {
		return window.btoa( ( new Date() ).toISOString() + "@" + Math.random().toString(36).substring(2, 9) );
	}

	static onSelectFiles(e) {
		const fileInput = e.target;
		const newList = FileStorage.addFiles(fileInput.id, fileInput.files);
		const dt = new DataTransfer();
		for (const file of newList) dt.items.add(file);

		console.log(dt.items);

		fileInput.files = dt.files; // Записываем новый список файлов в input

		FileBox.drawFileNames(e.target);
	}


	static drawFileNames(fileInput) { // onFileSelected
		const fileNamesDiv = fileInput.parentElement.parentElement.querySelector(`.fileNames`);
		fileNamesDiv.innerHTML = "";
		const files = FileStorage.getFileList(fileInput.id);

		if(files.length) { // Есть хоть 1 файл
			for (const file of files) {
				// Меняем отображаемое имя файла
				const fileIco = CommonUtils.getFileSvgIcon(file.name);
				const htmlFileItem = `<div class="fileItem">${fileIco}<div class="fileName">${file.name}</div><div class="fileDelWr"><div class="fileDelBtn">Исключить</div></div></div>`;

				fileNamesDiv.insertAdjacentHTML("beforeend", htmlFileItem);
			}

			fileInput.parentElement.parentElement.querySelectorAll(`.fileDelBtn`).forEach(el => {
				el.addEventListener(`click`, FileBox.onClickExcludeFile);
			});
		}
	}

	static drawFileNamesOld(fileInput) { // onFileSelected
		const fileNamesDiv = fileInput.parentElement.parentElement.querySelector(`.fileNames`);
		fileNamesDiv.innerHTML = "";

		const files = fileInput.files;
		if(files.length) { // Есть хоть 1 файл
			for (const file of files) {
				// Меняем отображаемое имя файла
				const fileIco = CommonUtils.getFileSvgIcon(file.name);
				const htmlFileItem = `<div class="fileItem">${fileIco}<div class="fileName">${file.name}</div><div class="fileDelWr"><div class="fileDelBtn">Исключить</div></div></div>`;

				fileNamesDiv.insertAdjacentHTML("beforeend", htmlFileItem);
			}

			fileInput.parentElement.parentElement.querySelectorAll(`.fileDelBtn`).forEach(el => {
				el.addEventListener(`click`, FileBox.onClickExcludeFile);
			});
		}
	}


	static onClickExcludeFile(e) {
		const excludedFileName = e.target.parentElement.parentElement.querySelector(`.fileName`).textContent;
		const fileInput = e.target.parentElement.parentElement.parentElement.parentElement.parentElement.querySelector(`input[type=file]`);

		const newList = FileStorage.excludeFile(fileInput.id, excludedFileName);
		const dt = new DataTransfer();
		for (const file of newList) dt.items.add(file);
		fileInput.files = dt.files; // Записываем новый список файлов в input
		FileBox.drawFileNames(fileInput);
	}
}


class FileStorage {
	static inputs = {};

	static addFiles(inputId, selectedFiles) {
		if( FileStorage.inputs[inputId] === undefined ) {
			FileStorage.inputs[inputId] = {files: []};
		}


		for (let i=0; i<selectedFiles.length; i++) {
			const file = selectedFiles[i];
			// Если файла с таким именем не было, добавляем
			const indexOfFoundedFile = FileStorage.inputs[inputId].files.findIndex( (fileInStore)=>{ if(fileInStore.name === file.name) return true; } );
			if( indexOfFoundedFile === -1 ) { // Если файл с таким именем не найден, добавляем его в список
				FileStorage.inputs[inputId].files.push(file);
			}
		}

		return FileStorage.inputs[inputId].files;
	}

	static excludeFile(inputId, fileName) {
		// Если для тек. инпута не сохранено ни 1 элемента
		if( FileStorage.inputs[inputId] === undefined ) {
			return;
		}
		else { // Исключаем искомый файл (путем формирования нового массива)
			FileStorage.inputs[inputId].files = FileStorage.inputs[inputId].files.filter( (file)=> file.name !== fileName );
		}

		return FileStorage.inputs[inputId].files;
	}

	static getFileList(inputId) {
		if(FileStorage.inputs[inputId]) {
			return FileStorage.inputs[inputId].files;
		}
	}
}
