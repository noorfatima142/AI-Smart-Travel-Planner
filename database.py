# database.py

import pymysql # <-- CHANGE: Import the new library
import os # Used to get environment variables, good practice

def get_connection():
    try:
        # Use the new library to connect. The arguments are the same.
        conn = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="Fatima.2005", # Your MySQL password
            database="travel_planner",
            cursorclass=pymysql.cursors.DictCursor # Makes results easy to use, like a dict
        )
        return conn
    except pymysql.MySQLError as err:
        print(f"!!!!!! FATAL: COULD NOT CONNECT TO DATABASE WITH PyMySQL !!!!!!")
        print(f"!!!!!! ERROR DETAILS: {err} !!!!!!")
        return None

def save_travel_plan(username, data):
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            return "❌ Could not connect to the database."
            
        # The 'with' statement ensures the cursor is closed automatically
        with conn.cursor() as cursor:
            query = """
                INSERT INTO travel_plans 
                (username, country, start_date, end_date, people, budget, hotel_star)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                username, data["country"], data["start_date"],
                data["end_date"], data["people"], data["budget"], data["hotel_star"]
            )
            cursor.execute(query, values)
        
        conn.commit() # Commit the changes to the database
        return "✅ Travel plan saved successfully!"

    except pymysql.MySQLError as err:
        print(f"!!!!!! DATABASE ERROR in save_travel_plan: {err} !!!!!!")
        if conn:
            conn.rollback() # Roll back on error
        return "❌ Error saving travel plan. See terminal for details."

    finally:
        if conn:
            conn.close() # Close the connection