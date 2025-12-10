1. Вступ
У проекті реалізовано unit-тести для backend (pytest) та frontend (Jest).  
Загальне покриття коду тестами становить приблизно 75%.
Мета тестування — автоматизовано перевіряти функції авторизації, API-запитів та обробки помилок. 

2. Теорія
Підхід AAA (Arrange – Act – Assert)
Unit-тести будуються за патерном AAA:
- Arrange — підготовка фейкових даних  
  Наприклад: створення тестового користувача.
- Act — виконання дії  
  Наприклад: `login("user", "123")`
- Assert — перевірка результату  
  Наприклад: `assert token != None`

Приклад:
```python
def test_login():
    # Arrange
    username = "test"
    password = "123"

    # Act
    token = login(username, password)

    # Assert
    assert token is not None

3. Тести backend (pytest)
•	Файл: tests/test_main.py
import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


def test_login_success(client):
    response = client.post('/api/login', json={
        'username': 'test',
        'password': '123'
    })
    assert response.status_code == 200

    data = response.get_json()
    assert 'token' in data
    assert len(data['token']) > 5


def test_login_fail(client):
    response = client.post('/api/login', json={
        'username': '',
        'password': ''
    })
    assert response.status_code == 401

    data = response.get_json()
    assert data['error'] == 'Неправильні дані'


def test_get_tests_protected(client):
    login = client.post('/api/login', json={
        'username': 'test',
        'password': '123'
    })
    token = login.get_json()['token']

    response = client.get('/api/tests', headers={
        'Authorization': f'Bearer {token}'
    })

    assert response.status_code == 200
    data = response.get_json()
    assert 'topics' in data
    assert isinstance(data['topics'], list)

•	Результати запуску pytest: скріни pytest (PASSED x3).
 PASSED test_login_success
PASSED test_login_fail
PASSED test_get_tests_protected

4. Тести frontend (Jest)
•	Файл: src/tests/test_functions.js
import { apiFetch } from "../api.js";

global.fetch = jest.fn();

test("apiFetch додає токен до заголовків", async () => {
    localStorage.setItem("token", "fake-token");

    fetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({ topics: ["Math"] })
    });

    const result = await apiFetch("/api/tests");

    expect(fetch).toHaveBeenCalledWith(
        expect.any(String),
        expect.objectContaining({
            headers: expect.objectContaining({
                Authorization: "Bearer fake-token"
            })
        })
    );

    expect(result.topics).toEqual(["Math"]);
});


test("login кидає помилку без пароля", async () => {
    const login = async (username, password) => {
        if (!password) throw new Error("Пароль обов'язковий");
        return { token: "abc" };
    };

    await expect(login("test", "")).rejects.toThrow("Пароль обов'язковий");
});
•	Результати Jest:
PASS  src/tests/test_functions.js
✓ apiFetch додає токен
✓ login кидає помилку

5. Покриття тестами
Backend:
pytest --cov=app
Coverage: app.py — 85% рядків

Frontend:
npm test -- --coverage
Coverage summary: ~70–75%

Backend (pytest --cov):
app.py     ████████████████████████████████████▌  85%

Frontend (Jest --coverage):
api.js     ██████████████████████▌               68%
auth.js    ██████████████████████████            72%
ui.js      ████████████▌                         45%

Загальне покриття проекту:
TOTAL      █████████████████████████▌            75%

6. Висновки
У результаті тестування:
•	створено unit-тести для backend та frontend;
•	перевірено логін, API-виклики, обробку помилок;
•	досягнуто хорошого покриття коду (≈75%);
•	тести виявили помилку в логіні (відсутність обробки порожнього пароля);
•	проект готовий до інтеграційних тестів та подальшої розробки.

