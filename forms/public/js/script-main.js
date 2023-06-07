window.onload = init;

function init() {
	// Реакция на смену языка
	let langLinks = document.querySelectorAll(`.lang`);
	for (const langLink of langLinks) {
		if(langLink.dataset.lang) {
			langLink.addEventListener(`click`, ()=>changeLang(langLink.dataset.lang) );
		}
	}
}


function changeLang(lang) {
	document.cookie = `lang=${lang}`;
	location.reload();
}

