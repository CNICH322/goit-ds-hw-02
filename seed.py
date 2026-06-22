# seed.py
import sqlite3
from faker import Faker
from random import randint

DATABASE = "task_management.db"

fake = Faker()


def seed_status(conn):
    statuses = [
        ('new',),
        ('in progress',),
        ('completed',)
    ]
    
    sql = "INSERT OR IGNORE INTO status(name) VALUES (?)"
    
    cur = conn.cursor()
    cur.executemany(sql, statuses)
    conn.commit()

def seed_users(conn, count=10):
    sql = """
    INSERT INTO users(fullname, email)
    VALUES (?, ?)
    """

    cur = conn.cursor()

    for _ in range(count):
        cur.execute(
            sql,
            (
                fake.name(),
                fake.unique.email()
            )
        )

    conn.commit()
def seed_tasks(conn, count=30):
    sql = """
    INSERT INTO tasks(
        title,
        description,
        status_id,
        user_id
    )
    VALUES (?, ?, ?, ?)
    """

    cur = conn.cursor()

    for _ in range(count):
        cur.execute(
            sql,
            (
                fake.sentence(nb_words=4),
                fake.text(max_nb_chars=100),
                randint(1, 3),
                randint(1, 10)
            )
        )

    conn.commit()


if __name__ == "__main__":
    conn = sqlite3.connect(DATABASE)
    seed_status(conn)
    seed_users(conn)
    seed_tasks(conn)    
    conn.close()