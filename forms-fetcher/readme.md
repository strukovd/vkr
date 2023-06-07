Задачи сервиса
# forms-fetcher
Поскольку у сайта форм (forms.gazprom.kg) нет доступа к жире, сайт лишь сохраняет поступившие заявки в БД, forms-fetcher обрабатывает и направляет их в жиру.

## Локальный запуск
- В formsAPI.js отредактировать путь к сайту 192.168.50.85:8080 (forms.gazprom.kg) на локальный
- Отредактировать global.fullStoragePath в app.js 
	Так: global.fullStoragePath = \`${__dirname}/storage\`;