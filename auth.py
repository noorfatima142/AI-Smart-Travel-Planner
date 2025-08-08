# auth.py

import pymysql # <-- CHANGE: Import the new library
from database import get_connection

def create_user(username, email, password):
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            return "❌ Database connection failed. Check terminal for errors."

        with conn.cursor() as cursor:
            cursor.execute(
                "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
                (username, email, password)
            )
        conn.commit()
        return f"✅ User '{username}' created successfully!"

    except pymysql.MySQLError as err:
        print(f"!!!!!! DATABASE ERROR in create_user: {err} !!!!!!") 
        # Error code 1062 is for 'Duplicate entry'
        if err.args[0] == 1062: 
            return f"❌ Error: Username '{username}' or email already exists."
        
        if conn:
            conn.rollback()
        return f"❌ A database error occurred. See terminal for details."

    finally:
        if conn:
            conn.close()

def login_user(username, password):
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            return None

        with conn.cursor() as cursor:
            cursor.execute(
                "SELECT * FROM users WHERE username = %s AND password = %s",
                (username, password)
            )
            result = cursor.fetchone()
        return result

    except pymysql.MySQLError as err:
        print(f"!!!!!! DATABASE ERROR in login_user: {err} !!!!!!")
        return None
        
    finally:
        if conn:
            conn.close()