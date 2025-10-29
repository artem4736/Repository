CREATE DATABASE smart_reminder;
\c smart_reminder;

-- Таблиця користувачів
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Таблиця нагадувань
CREATE TABLE reminders (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    user_id INT REFERENCES users(id) ON DELETE CASCADE
);

-- Таблиця сповіщень
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reminder_id INT REFERENCES reminders(id) ON DELETE CASCADE
);

-- Таблиця календарів
CREATE TABLE calendars (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE
);

-- Таблиця інтеграцій з Google Calendar
CREATE TABLE google_integration (
    id SERIAL PRIMARY KEY,
    calendar_id INT REFERENCES calendars(id) ON DELETE CASCADE,
    token VARCHAR(255)
);

-- Індекси для швидшого пошуку
CREATE INDEX idx_reminders_date ON reminders(date);
CREATE INDEX idx_users_email ON users(email);
