1. Вступ
•	Frontend для Smart Reminder на HTML/CSS/JS.
•	Компоненти: екран входу, список нагадувань, форма створення нагадування.

2. Wireframe
Прототип програми створений в figma

 

 
  

 
 

 
 

3. Код
•	index.html
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Smart Reminder</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body>
<script>
  // простий захист сторінки
  if (!localStorage.getItem("sm_user")) {
      window.location.href = "login.html";
  }
</script>

  <div class="app">
    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="brand">Smart Reminder</div>
      <nav>
        <button id="btnHome" class="nav-btn active">Головна</button>
        <button id="btnCalendar" class="nav-btn">Календар</button>
        <button id="btnSettings" class="nav-btn">Налаштування</button>
        <button id="btnLogoutSidebar" class="nav-btn">Вийти</button>
      </nav>
    </aside>

    <!-- Main area -->
    <div class="main">
      <!-- Top bar -->
      <header class="topbar">
        <div class="left"></div>
        <div class="right">
          <button id="addGlobalBtn" class="primary">+ Додати нагадування</button>
          <button id="profileBtn" class="avatar">👤</button>
        </div>
      </header>

      <!-- Content -->
      <main class="content">

        <!-- Home screen -->
        <section id="screen-home" class="screen">
          <h2 class="home-title">Мої нагадування</h2>
          <p class="home-subtitle">Керуйте своїми завданнями та дедлайнами</p>

          <div class="filters-row">
              <button data-filter="today" class="filter-btn">Сьогодні</button>
              <button data-filter="week" class="filter-btn">Тиждень</button>
              <button data-filter="all" class="filter-btn active">Усі</button>
          </div>

          <div class="search-row">
              <input type="text" id="searchInput" class="search-input" placeholder="Пошук нагадувань..." />
          </div>

          <div id="remindersContainer" class="reminder-cards"></div>
        </section>

        <!-- Calendar / Settings placeholders -->
        <section id="screen-calendar" class="screen hidden">
          <h2>Календар (в розробці)</h2>
          <p>Перегляд подій по днях/тижнях/місяцях — планується.</p>
        </section>

        <section id="screen-settings" class="screen hidden">
          <h2>Налаштування</h2>
          <p>Тут будуть опції теми, мови та сповіщень.</p>
        </section>

        <!-- Create screen — лише ОДНА секція (унікальний id) -->
        <section id="screen-create-page" class="screen hidden create-page">
          <h2 class="page-title">Нове нагадування</h2>
          <p class="page-subtitle">Заповніть деталі вашого завдання</p>

          <form id="createFormPage" class="create-card">
              <label>Назва події</label>
              <input id="titleInput" name="title" type="text" placeholder="Наприклад, Математика" required />

              <label>Опис</label>
              <textarea id="descriptionInput" name="description" placeholder="Опишіть завдання детально..." rows="4"></textarea>

              <div class="row-2">
                  <div>
                      <label>Дата</label>
                      <input id="dateInput" name="date" type="date" required />
                  </div>

                  <div>
                      <label>Час</label>
                      <input id="timeInput" name="time" type="time" />
                  </div>
              </div>

              <label class="toggle-row">
                  Надсилати нагадування
                  <input id="isActiveInput" name="isActive" type="checkbox" checked />
              </label>

              <div class="buttons-row">
                  <button type="button" id="cancelCreateBtn" class="secondary big">Скасувати</button>
                  <button type="submit" class="primary big">Зберегти</button>
              </div>
          </form>
        </section>

      </main>
    </div>
  </div>

<script src="script.js"></script>
</body>
</html>
•	style.css
* style.css - мінімальний набір щоб демонструвало роботу */
* { box-sizing: border-box; font-family: Arial, sans-serif; }
body { margin: 0; background: #f5f7fa; color: #222; }

/* Layout */
.app { display: flex; min-height: 100vh; }
.sidebar { width: 200px; background: #fff; border-right: 1px solid #eee; padding: 20px; }
.brand { color: #2b62d6; font-weight: 700; margin-bottom: 20px; }
.nav-btn { display:block; width:100%; margin:8px 0; padding:10px; border-radius:8px; border:none; background:transparent; text-align:left; cursor:pointer; }
.nav-btn.active { background:#eef4ff; color:#2b62d6; }
.main { flex:1; }
.topbar { height:64px; display:flex; align-items:center; justify-content:space-between; padding:0 24px; background:#fff; border-bottom:1px solid #eee; }
.primary { background:#3e7bfa; color:#fff; border:none; padding:10px 14px; border-radius:8px; cursor:pointer; }
.avatar { background:transparent; border:none; font-size:18px; cursor:pointer; }

/* Content */
.content { padding: 28px 40px; }
.screen { display: block; }
.hidden { display: none !important; }

/* Home */
.home-title { font-size:24px; margin: 8px 0; font-weight:700; }
.home-subtitle { color:#6b7280; margin-bottom:18px; }

/* Filters & search */
.filters-row { display:flex; gap:10px; margin-bottom:16px; }
.filter-btn { padding:8px 14px; border-radius:8px; border:1px solid #e5e7eb; background:#fff; cursor:pointer; }
.filter-btn.active { background:#3e7bfa; color:#fff; border-color:#3e7bfa; }
.search-row { margin-bottom:20px; }
.search-input { width:100%; padding:12px; border-radius:8px; border:1px solid #e5e7eb; }

/* Cards */
.reminder-cards { display:flex; gap:18px; flex-wrap:wrap; }
.reminder-card { background:#fff; border-radius:8px; padding:18px; width:320px; box-shadow: 0 6px 16px rgba(15,23,42,0.06); border:1px solid #f0f0f0; }
.card-title { margin:0 0 6px 0; font-size:16px; font-weight:600; }
.card-sub { margin:0 0 8px 0; color:#6b7280; font-size:13px; }
.card-meta { color:#9ca3af; font-size:13px; display:flex; gap:10px; }

/* Create screen */
.create-card { background:#fff; padding:20px; border-radius:10px; box-shadow: 0 6px 14px rgba(15,23,42,0.06); max-width:800px; }
.create-card input, .create-card textarea { width:100%; padding:10px; border-radius:8px; border:1px solid #e5e7eb; margin-bottom:12px; }
.row-2 { display:flex; gap:12px; }
.row-2 > div { flex:1; }
.toggle-row { display:flex; justify-content:space-between; align-items:center; margin-top:6px; margin-bottom:12px; }
.buttons-row { display:flex; gap:12px; margin-top:12px; }
.big { padding:12px 18px; border-radius:8px; }
.secondary { background:#fff; border:1px solid #e5e7eb; cursor:pointer; }
•	script.js
// ------------------ AUTH ------------------
if (!localStorage.getItem("sm_user")) {
  window.location.href = "login.html";
}

// ------------------ ELEMENTS ------------------
const btnAdd = document.getElementById("addGlobalBtn");
const btnLogoutSidebar = document.getElementById("btnLogoutSidebar");

const btnHome = document.getElementById("btnHome");
const btnCalendar = document.getElementById("btnCalendar");
const btnSettings = document.getElementById("btnSettings");

const screenHome = document.getElementById("screen-home");
const screenCreate = document.getElementById("screen-create-page");
const screenCalendar = document.getElementById("screen-calendar");
const screenSettings = document.getElementById("screen-settings");

const createForm = document.getElementById("createFormPage");
const cancelCreateBtn = document.getElementById("cancelCreateBtn");
const remindersContainer = document.getElementById("remindersContainer");

const filterButtons = document.querySelectorAll(".filter-btn");
let currentFilter = "all"; // default


// ------------------ SCREEN SWITCHING ------------------
function hideAllScreens() {
  document.querySelectorAll(".screen").forEach((s) => s.classList.add("hidden"));
}

function showScreen(screenEl) {
  hideAllScreens();
  screenEl.classList.remove("hidden");
  document.querySelectorAll(".nav-btn").forEach((b) => b.classList.remove("active"));
}

function showHome() {
  showScreen(screenHome);
  btnHome.classList.add("active");
  renderReminders();
}

function showCreate() {
  showScreen(screenCreate);
}


// ------------------ INIT ------------------
document.addEventListener("DOMContentLoaded", () => {
  showHome();
  renderReminders();

  btnAdd.addEventListener("click", () => {
    createForm.reset();
    showCreate();
  });

  cancelCreateBtn.addEventListener("click", () => {
    showHome();
  });

  btnHome.addEventListener("click", showHome);

  btnCalendar.addEventListener("click", () => {
    showScreen(screenCalendar);
    btnCalendar.classList.add("active");
  });

  btnSettings.addEventListener("click", () => {
    showScreen(screenSettings);
    btnSettings.classList.add("active");
  });

  btnLogoutSidebar.addEventListener("click", () => {
    localStorage.removeItem("sm_user");
    window.location.href = "login.html";
  });

  // --- FILTER BUTTONS ---
  filterButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      filterButtons.forEach((b) => b.classList.remove("active"));
      btn.classList.add("active");

      currentFilter = btn.dataset.filter; // today / week / all
      renderReminders();
    });
  });

  // --- CREATE FORM ---
  createForm.addEventListener("submit", function (e) {
    e.preventDefault();

    const title = document.getElementById("titleInput").value.trim();
    const description = document.getElementById("descriptionInput").value.trim();
    const date = document.getElementById("dateInput").value;
    const time = document.getElementById("timeInput").value;
    const isActive = document.getElementById("isActiveInput").checked;

    if (!title || !date) {
      alert("Вкажіть назву та дату.");
      return;
    }

    const reminders = JSON.parse(localStorage.getItem("sm_reminders") || "[]");

    reminders.push({
      id: Date.now(),
      title,
      description,
      date,
      time,
      isActive,
    });

    localStorage.setItem("sm_reminders", JSON.stringify(reminders));

    showHome();
  });
});


// ------------------ RENDER ------------------
function renderReminders() {
  const reminders = JSON.parse(localStorage.getItem("sm_reminders") || "[]");

  let filtered = [];

  const today = new Date().toISOString().split("T")[0];
  const now = new Date();

  if (currentFilter === "today") {
    filtered = reminders.filter((r) => r.date === today);

  } else if (currentFilter === "week") {
    filtered = reminders.filter((r) => {
      const eventDate = new Date(r.date);
      const diff = (eventDate - now) / (1000 * 60 * 60 * 24); // дні
      return diff >= 0 && diff <= 7;
    });

  } else {
    filtered = reminders; // "all"
  }

  remindersContainer.innerHTML = "";

  if (!filtered.length) {
    remindersContainer.innerHTML = `<p class="muted">Немає нагадувань.</p>`;
    return;
  }

  filtered.forEach((r) => {
    const card = document.createElement("div");
    card.className = "reminder-card";

    card.innerHTML = `
      <div class="card-title">${escapeHtml(r.title)}</div>
      <div class="card-sub">${escapeHtml(r.description || "")}</div>
      <div class="card-meta">${escapeHtml(r.date)}${
      r.time ? " • " + escapeHtml(r.time) : ""
    }</div>
    `;

    remindersContainer.appendChild(card);
  });
}


// ------------------ UTILS ------------------
function escapeHtml(text) {
  return String(text || "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;");
}
•	login.html 
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8">
  <title>Вхід — Smart Reminder</title>
  <link rel="stylesheet" href="style-login.css">
</head>

<body>

<main class="page-center">
  <div class="login-card">

    <h1 class="title">Smart Reminder</h1>
    <p class="subtitle">Увійдіть до свого акаунта</p>

    <form id="loginForm">

      <label for="email">Email</label>
      <input type="email" id="email" placeholder="example@email.com" required>

      <div class="password-row">
          <label for="password">Пароль</label>
          <a href="#" class="forgot">Забули пароль?</a>
      </div>

      <input type="password" id="password" placeholder="●●●●●●●" required>

      <button type="submit" class="primary-btn">Увійти</button>

      <p class="register-text">
        Немає акаунта?
        <a href="#" class="register-link">Зареєструватися</a>
      </p>

    </form>

  </div>
</main>
<script>
document.getElementById("loginBtn").addEventListener("click", function () {
    // Імітація авторизації — записуємо користувача
    localStorage.setItem("sm_user", "logged");

    // Перехід на головну
    window.location.href = "index.html";
});
</script>
<script src="script-login.js"></script>
</body>
</html>
•	script-login.js
document.getElementById('loginForm').addEventListener('submit', (e) => {
    e.preventDefault();

    const emailVal = document.getElementById("email").value.trim();
    const passVal = document.getElementById("password").value.trim();

    if (!emailVal || !passVal) {
        alert("Введіть email і пароль");
        return;
    }

    const user = { email: emailVal };
    localStorage.setItem("sm_user", JSON.stringify(user));
    window.location.href = "index.html";
});
document.getElementById("logoutBtn").addEventListener("click", () => {
    localStorage.removeItem("sm_user");
    window.location.href = "login.html";
});
•	style-login.css
body {
  margin: 0;
  font-family: "Inter", sans-serif;
  background: #f4f4f7;
}

.page-center {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-card {
  background: white;
  padding: 40px 50px;
  width: 380px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  text-align: center;
}

.title {
  margin: 0;
  font-size: 28px;
  color: #1d1d1f;
  font-weight: 600;
}

.subtitle {
  margin: 6px 0 25px;
  font-size: 14px;
  color: #6b7280;
}

label {
  display: block;
  text-align: left;
  margin-bottom: 6px;
  font-size: 14px;
  font-weight: 500;
  color: #1d1d1f;
}

input {
  width: 100%;
  padding: 12px 14px;
  margin-bottom: 18px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 15px;
  outline: none;
}

input:focus {
  border-color: #3b82f6;
}

.password-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.forgot {
  font-size: 13px;
  color: #3b82f6;
  text-decoration: none;
}

.primary-btn {
  width: 100%;
  padding: 12px;
  background: #3b82f6;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  color: white;
  cursor: pointer;
  margin-top: 10px;
}

.primary-btn:hover {
  background: #2563eb;
}

.register-text {
  margin-top: 18px;
  font-size: 14px;
  color: #6b7280;
}

.register-link {
  color: #3b82f6;
  text-decoration: none;
  font-weight: 500;
}

4. Тестування
•	Сценарій: Login → List → Create.
Перевірка у DevTools → Network:
•	Приклад:
Клік "Зберегти"
POST /reminders
Body: {"title":"Лаба","date":"2025-01-20","time":"14:00"}
Status: 201 Created

 
 

 

5. Інтеграція
•	UI викликає backend:
o	POST /reminders — створення
o	GET /reminders — завантаження списку
•	Інтерфейс синхронізовано з Flask API.

6. Висновки
•	UI відповідає use cases (вхід, створення нагадування).
•	Frontend готовий до розширення: авторизація, редагування, push-сповіщення.
•	Можлива подальша інтеграція з календарем і Google API.

