Integration — Smart Reminder

Мета: Показати інтеграцію frontend ↔ backend: реєстрація, логін, виконання тесту (A/B/C), збереження результатів та перегляд "Мої результати".

1. Підготовка
1. Запустити backend:
   - Встановити залежності: pip install flask flask-cors flask-sqlalchemy flask-bcrypt
   - Запустити: python app.py
   - Перевірити: http://localhost:5000/ → "Smart Reminder backend працює"

2. Сервер для frontend (опціонально):
   - У папці frontend: python -m http.server 8000
   - Відкрити: http://localhost:8000/login.html

2. Реєстрація користувача
1. Відкрити register.html → заповнити ім'я, email, пароль.
2. Нажати "Зареєструватися".
3. Backend: POST /register → створюється запис у БД `users` з хешованим паролем.

3. Логін
1. Відкрити login.html → ввести email/password.
2. Backend: POST /login — перевірка bcrypt.
3. Після успішного логіну frontend зберігає user у localStorage та переходить на index.html.
  
 
4. Виконання тесту & збереження
1. На index.html вибрати варіант тесту:
   - A: ввести число → POST /results {user_id, score}
   - B: вибрати відповіді → POST /results {user_id, score, answers: [...]}
   - C: вибрати відповіді + correct → POST /results {user_id, score, details: [...]}
2. Backend зберігає записи у таблиці `results`.

5. Перегляд "Мої результати"
1. На сайті натиснути "Мої результати".
2. Frontend: GET /results/<user_id> → відображає список результатів з полями score, answers, details, created_at.

6. Підсумок
Інтеграція успішна: frontend викликає API backend, backend зберігає дані у SQLite. Бекенд використовує bcrypt для безпечного зберігання паролів.


