-- Отримати всі завдання певного користувача
SELECT *
FROM tasks
WHERE user_id = 1;

-- Вибрати завдання зі статусом 'new'
SELECT *
FROM tasks
WHERE status_id = (
    SELECT id
    FROM status
    WHERE name = 'new'
);

-- Оновити статус завдання
UPDATE tasks
SET status_id = (
    SELECT id
    FROM status
    WHERE name = 'in progress'
)
WHERE id = 1;

-- Отримати користувачів без завдань
SELECT *
FROM users
WHERE id NOT IN (
    SELECT user_id
    FROM tasks
);

-- Додати нове завдання
INSERT INTO tasks(title, description, status_id, user_id)
VALUES (
    'Create report',
    'Prepare monthly report',
    (SELECT id FROM status WHERE name = 'new'),
    1
);

-- Отримати всі незавершені завдання
SELECT *
FROM tasks
WHERE status_id != (
    SELECT id
    FROM status
    WHERE name = 'completed'
);

-- Видалити завдання
DELETE FROM tasks
WHERE id = 1;

-- Знайти користувачів за email
SELECT *
FROM users
WHERE email LIKE '%example.com';

-- Оновити ім'я користувача
UPDATE users
SET fullname = 'John Smith'
WHERE id = 1;

-- Кількість завдань для кожного статусу
SELECT
    status.name,
    COUNT(tasks.id) AS task_count
FROM status
LEFT JOIN tasks
    ON status.id = tasks.status_id
GROUP BY status.name;

-- Завдання користувачів певного домену
SELECT
    tasks.id,
    tasks.title,
    users.fullname,
    users.email
FROM tasks
JOIN users
    ON tasks.user_id = users.id
WHERE users.email LIKE '%@example.net';

-- Завдання без опису
UPDATE tasks
SET description = ''
WHERE id = 1;

SELECT *
FROM tasks
WHERE description IS NULL
   OR description = '';

-- Користувачі та їх завдання зі статусом в прогресі
SELECT
    users.fullname,
    tasks.title
FROM users
INNER JOIN tasks
    ON users.id = tasks.user_id
INNER JOIN status
    ON tasks.status_id = status.id
WHERE status.name = 'in progress';

-- Користувачі та кількість їх завдань
SELECT
    users.fullname,
    COUNT(tasks.id) AS task_count
FROM users
LEFT JOIN tasks
    ON users.id = tasks.user_id
GROUP BY users.id, users.fullname;