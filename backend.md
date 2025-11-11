1.	Вступ: 
Backend для Smart Reminder. 
Реалізовано RESTful API на Flask.
Ендпоінти
- `GET /reminders` — отримати список нагадувань  
- `POST /users/register` — створити нового користувача

2.	Налаштування: 
Необхідні бібліотеки
```bash
pip install flask flask-cors flask-sqlalchemy
Конфігурація Flask
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///chatbot.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
3.	Код сервера: 
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///smart_reminder.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)

class Reminder(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(150), nullable=False)
    date = db.Column(db.String(50))
    time = db.Column(db.String(50))
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

db.create_all()

@app.route('/')
def home():
    return "Backend Smart Reminder працює!"

@app.route('/users/register', methods=['POST'])
def register_user():
    data = request.json
    if not data.get('name') or not data.get('email'):
        return jsonify({'error': 'Потрібні name та email'}), 400
    new_user = User(name=data['name'], email=data['email'])
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'id': new_user.id, 'name': new_user.name}), 201

@app.route('/reminders', methods=['GET'])
def get_reminders():
    reminders = Reminder.query.all()
    return jsonify([{'id': r.id, 'title': r.title, 'date': r.date} for r in reminders])

if __name__ == '__main__':
      app.run(  host = '0.0.0.0' )

4.	Тестування: 
Postman
•	GET /tests → 200 OK
(test1.png)
•	POST /users/register → 201 Created
(test2.png)
  
5.	Інтеграція з БД: 
Модель користувача (User) створює таблицю users у базі smart_reminder.db.
SELECT * FROM user;
  (test3.png)

6.	Висновки: 
API відповідає user stories (реєстрація користувача).
Готово до інтеграції з frontend.

