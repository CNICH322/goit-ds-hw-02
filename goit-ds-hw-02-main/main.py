import sqlite3

DATABASE = "task_management.db"


def create_tables():
    with open("task.sql", "r", encoding="utf-8") as file:
        sql_script = file.read()

    conn = sqlite3.connect(DATABASE)

    try:
        conn.executescript(sql_script)
    except sqlite3.Error as e:
        print(e)
    finally:
        conn.close()


if __name__ == "__main__":
    create_tables()