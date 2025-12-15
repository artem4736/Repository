Тестування: інтеграційне та системне

1. Вступ
Інтеграційне тестування (Integration Testing) — це перевірка взаємодії між модулями вебзастосунку Smart Reminder, зокрема ланцюга frontend → backend → база даних (API + БД).
Системне тестування (System Testing, E2E) — це end-to-end перевірка повного циклу роботи додатка Smart Reminder з точки зору кінцевого користувача.
Покриття взаємодій: приблизно 85%, що є достатнім показником для стабільної роботи системи.

2. Теорія
Інтеграційне тестування
Інтеграційне тестування перевіряє коректність взаємодії між компонентами системи Smart Reminder.
Приклад для Smart Reminder:
•	POST /api/register → створення користувача (INSERT) у таблиці users
•	POST /api/login → перевірка пароля (bcrypt) + генерація JWT
•	GET /api/reminders → отримання даних з БД для авторизованого користувача
Системне тестування (E2E)
Системне тестування перевіряє повний користувацький сценарій у Smart Reminder — від відкриття сторінки до отримання результату.
Приклад Assert:
Після логіну користувача — статус відповіді 200, на головній сторінці відображається список нагадувань, і reminders.length > 0.

3. Інтеграційні тести (Postman)
Колекція тестів Smart Reminder
Для перевірки інтеграції у проєкті Smart Reminder була створена колекція тестів у Postman.
Покриття інтеграційних тестів:
1.	POST /api/register — реєстрація користувача
2.	POST /api/login — автентифікація та отримання JWT
3.	GET /api/reminders — отримання списку нагадувань
4.	POST /api/reminders — створення нового нагадування
Приклад тесту (Postman → Tests tab)
pm.test("Token exists", () => {
  const jsonData = pm.response.json();
  pm.expect(jsonData.token).to.exist;
  pm.collectionVariables.set("token", jsonData.token);
});
Результати інтеграційного тестування
•	Усі запити повернули статус 200 / 201 OK
•	Дані коректно зберігаються та зчитуються з бази даних
•	Колекція тестів експортована у форматі JSON

4. Системні тести (Cypress)
E2E тестування Smart Reminder
Файл тесту: cypress/e2e/smart_reminder.cy.js
describe('Smart Reminder E2E Tests', () => {

  it('Повний цикл: логін → створення нагадування → перевірка', () => {
    cy.visit('http://localhost:3000/login');

    // Логін користувача
    cy.get('#email').type('test@reminder.com');
    cy.get('#password').type('123456');
    cy.get('button[type="submit"]').click();

    // Перевірка головної сторінки
    cy.get('.home-title').should('contain', 'Мої нагадування');

    // Створення нагадування
    cy.get('#addReminderBtn').click();
    cy.get('#title').type('E2E Test Reminder');
    cy.get('#date').type('2025-01-20');
    cy.get('#time').type('15:00');
    cy.get('#saveReminder').click();

    // Перевірка результату
    cy.contains('E2E Test Reminder').should('exist');
  });

  it('Помилка логіну з некоректними даними', () => {
    cy.visit('http://localhost:3000/login');

    cy.get('#email').type('wrong@test.com');
    cy.get('#password').type('wrong');
    cy.get('button[type="submit"]').click();

    cy.get('.error-message')
      .should('contain', 'Неправильний email або пароль');
  });

});
Результати системного тестування
•	Cypress Runner: 2 passed
•	Помилок не виявлено
•	Записано відео проходження E2E тестів

5. Висновки
У ході виконання інтеграційного та системного тестування проєкту Smart Reminder:
•	Перевірено взаємодію frontend, backend та бази даних
•	Виявлено та усунено CORS-помилку на етапі інтеграції
•	Загальне покриття тестами перевищує 80%, що свідчить про стабільність системи
Отримані уроки:
•	Необхідно тестувати не лише позитивні сценарії, а й edge cases (граничні ситуації), наприклад порожній або прострочений JWT-токен
•	Поєднання інтеграційних та системних тестів є критично важливим для забезпечення якості вебзастосунку Smart Reminder

