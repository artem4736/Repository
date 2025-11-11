# Database Design — Smart Reminder

## 1. Вступ
База даних призначена для зберігання користувачів, нагадувань, сповіщень і календарів.

## 2. ER-діаграма
![ER Diagram](images/er_diagrams.png)

## 3. Сутності та зв’язки
Users 1:N Reminders  
Reminders 1:1 Notifications  
Users 1:1 Calendar  
Calendar 1:1 GoogleIntegration  

## 4. Нормалізація
БД приведена до 3NF: кожен атрибут залежить лише від первинного ключа.

## 5. SQL-скрипти
Використовується PostgreSQL, створено таблиці users, reminders, notifications, calendars, google_integration.

## 6. Висновок
ER-діаграма та скрипти забезпечують узгоджене збереження даних і готові до інтеграції з додатком Smart Reminder.
