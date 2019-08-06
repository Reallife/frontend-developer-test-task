# Тестовое задание для Frontend-разработчика

Необходимо разработать SPA-приложение с использованием [React][react-docs]/[Redux][redux-docs]/[React router][react-router-docs] ([Vue][vue-docs]/[Vuex][vuex-docs]/[Vue router][vue-router-docs]).

## :fire: Как начать выполнять тестовое задание

**Перед тем как начать выполнение задания дочитайте данный текст до конца.**

Решение данного задания рекомендуется размещать на GitHub, но если у вас нет такой возможности - вы можете разместить его на любом другом git-сервисе с публичным доступом. Результат выполнения тестового задания желательно разместить на `GitHub Pages`, при наличии возможности.

> **Внимание!** **Не следует** делать "fork" данного репозитория, и возвращать решение в виде PR.

Допускается создание шаблонного (`boilerplate`) приложения:
 
 ##### React:
 Установка пакета `create-react-app` как глобальной зависимости ([docs][create-react-app-docs]):
 ```bash
 $  yarn global add create-react-app
 ```
 Создание шаблона приложения:
 ```bash
 $  create-react-app /path/to/projects/avtocod-frontend-test-task
 ```
 Запуск приложения:
 ```bash
 $  cd /path/to/projects/avtocod-frontend-test-task && yarn start
 ```
 После этого в браузере по адресу http://localhost:3000 должно открыться шаблонное приложение.
 
 
 ##### Vue:
 Установка пакета `@vue/cli` как глобальной зависимости ([docs][vue-cli-docs]):
 ```bash
 $  yarn global add @vue/cli
 ```
 Создание шаблона приложения:
 ```bash
 $  vue create /path/to/projects/avtocod-frontend-test-task
 ```
 Запуск приложения:
 ```bash
 $  cd /path/to/projects/avtocod-frontend-test-task && yarn serve
 ```
 После этого в браузере по адресу http://localhost:8080 должно открыться шаблонное приложение.

## Описание необходимого функционала

Приложение служит для создания запросов на генерацию условных отчетов о данных транспортных средств. Пользователь должен "авторизоваться", для получения возможности создавать отчёты.

Приложение состоит из двух страниц:
 - Страница авторизации (url: `/login`)
 - Внутренняя страница со списком отчетов (url: `/`)
 
 Макеты страниц приложения:
 - [Figma prototype][figma-proto-link] (для полноценной работы необхадима учётная запись [Figma][figma-site])
 - [demo-application.fig (Figma)][figma-file]

 Изображения страниц:
 - Auth page [desktop][auth-page-image] | [mobile][auth-page-mobile-image]
 - Inner page [desktop][inner-page-image] | [mobile][inner-page-mobile-image]
 
 ### Страница авторизации
 
 При первой загрузке приложения пользователь попадает на [страницу авторизации][auth-page-image]. После ввода логина и пароля (login: `username`, password: `password`) пользователь попадает на внутреннюю страницу со списком отчётов. Если были введены некорректные авторизационные данные(отличные от login: `username`, password: `password`), то необходимо вывести сообщение об ошибке авторизации.
 При успешной авторизации нужно запомнить (в `cookies`, `localStorage` или другом месте) данные об авторизации пользователя: логин, дату и время авторизации.
 При обновлении страницы приложения пользователь должен сразу попадать на внутреннюю страницу. 
 
 ### Внутренняя страница
 
 На внутренней [странице приложения][inner-page-image] при клике по пункту меню `Выход` данные об авторизации пользователя должны быть очищены, а пользователь перенаправлен на страницу авторизации
 
 #### Создание отчета
 
 Условный отчет состоит из 4-х полей:
  - Тип идентификатора (тип запрашиваемого идентификатора, принимает одно из следующих значений `VIN`, `ГРЗ`, `BODY`)
  - Идентификатор (значение идентификатора)
  - Дата создания (дата и время создания отчёта)
  - Статус (принимает одно из следующих значений: `DONE`, `PROGRESS`, `ERROR`)
  
  При заполнениии пользователем формы создания отчета и нажатии кнопки `Создать`, необходимо создать отчет, сохранить его в `store` приложения. Статус отчета выбирается случайным образом из допустимых значений.

 #### Удаление отчета
 
При нажатии на кнопку удаления отчета(кнопка с изображением корзины) нужно удалить соответствующий отчет из `store` приложения.

## Требования к используемым технологиям

Задание должно быть:

- Выполнено с использованием React/Redux/React router (Vue/Vuex/Vue router);

## Требования к реализации

- Разрешено использовать любые сторонние npm-пакеты;
- После завершения работы в readme-файле вашего репозитория описать все действия, необходимые для запуска приложения с опциональными комментариями по решению задания.

## Плюсами будут являться

- Интуитивно-понятное разбитие коммитов - одной конкретной задаче - один коммит (её правки - отдельный коммит);
- Текст коммитов - на английском языке;
- Для всего реализованного функционала должны быть написаны Unit-тесты (например, `jest`);
- Создание приложения "с нуля", без использования шаблонного приложения (`create-react-app` или `vue-cli`). Хотелось бы увидеть навыки конфигурирования сборки приложения с помощью `webpack`.
- Написание `docker-compose.yml`, который запускает написанное приложение.
- Адаптивная вёрстка (desktop/mobile).
- Использование [Sass][sass-link] и [BEM][bem-link]
- Реализация дополнительного функционала:
  - Авторизация должна считаться просроченной, если с момента последней загрузки приложения пользователем прошло более 1 часа. В таком случае пользователь должен быть перенаправлен на страницу авторизации.
  - При изменении списка отчетов (создании/удалении отчета) необходимо сохранять `store` приложения. При обновлении страницы пользоваелю должны быть доступны все существующие отчеты.
  - Данные формы создания отчета должны проходить валидацию. 
    - Правила валидации `VIN`: [link][vin-validation-wikipedia]
    - Правила валидации `ГРЗ`: Первый, пятый и шестой символы - одна из кириллических букв `А, В, Е, К, М, Н, О, Р, С, Т, У, Х`. Со 2-го по 4-й и с 7-го по 9-й символы - цифры от 0 до 9. Общее число символов от 8 до 9.
    - Правила валидации `BODY`: строка от 7 до 15 символов. Допускаются символы латиницы, цифры, пробел и дефис(`-`).
  - При удалении отчета нужно запрашивать подтверждение пользователя
  
## Результат выполнения

Ссылку на репозиторий с вашей реализацией необходимо отправить нашему HR или TeamLead, от которого вы получили ссылку на данный репозиторий.

Приложение должно успешно запускаться после выполнения:

```bash
$ git clone https://github.com/%USERNAME%/frontend-developer-test-task.git ./test-task && cd $_
$ yarn install && yarn serve
```

И проходить все тесты (при их наличии):

```bash
$ yarn test
```

> Если в процессе выполнения у вас возникнут какие-либо неразрешимые вопросы - создайте [соответствующий issue][link_create_issue] в данном репозитории. На вопросы касательно деталей реализации ("А лучше так и так?") - вероятнее всего вы получите ответ "Как вы посчитаете правильнее".

[figma-proto-link]:https://www.figma.com/file/ZhhPbI0rJnQ5u15tw7bAWn/Demo-application?node-id=0%3A1
[figma-file]:https://github.com/avtocod/frontend-developer-test-task/raw/master/resources/demo-application.fig
[auth-page-image]:https://github.com/avtocod/frontend-developer-test-task/raw/master/resources/auth-page.png
[auth-page-mobile-image]:https://github.com/avtocod/frontend-developer-test-task/raw/master/resources/auth-page-mobile.png
[inner-page-image]:https://github.com/avtocod/frontend-developer-test-task/raw/master/resources/inner-page.png
[inner-page-mobile-image]:https://github.com/avtocod/frontend-developer-test-task/raw/master/resources/inner-page-mobile.png
[link_create_issue]:https://github.com/avtocod/frontend-developer-test-task/issues/new
[vin-validation-wikipedia]:https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D1%80%D0%BE%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5_%D1%87%D0%B8%D1%81%D0%BB%D0%BE#%D0%98%D0%B4%D0%B5%D0%BD%D1%82%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B9_%D0%BD%D0%BE%D0%BC%D0%B5%D1%80_%D1%82%D1%80%D0%B0%D0%BD%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B3%D0%BE_%D1%81%D1%80%D0%B5%D0%B4%D1%81%D1%82%D0%B2%D0%B0_(VIN)
[create-react-app-docs]:https://reactjs.org/docs/create-a-new-react-app.html#create-react-app
[vue-cli-docs]:https://cli.vuejs.org/ru/guide/installation.html
[react-router-docs]:https://reacttraining.com/react-router/web/guides/quick-start
[react-docs]:https://ru.reactjs.org/docs/getting-started.html
[redux-docs]:https://redux.js.org/
[vue-docs]:https://ru.vuejs.org/v2/guide/index.html
[vuex-docs]:https://vuex.vuejs.org/ru/
[vue-router-docs]:https://router.vuejs.org/ru/
[figma-site]:https://www.figma.com
[sass-link]:https://sass-lang.com/
[bem-link]:http://getbem.com/
