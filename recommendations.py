# recommendations.py

import pymysql
from database import get_connection

def get_filtered_recommendations(country_name, hotel_preference, interests):
    """
    Fetches recommendations from the database, filtered by user preferences.
    """
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            return [], [], []

        with conn.cursor() as cursor:
            # Get the country ID
            cursor.execute("SELECT id FROM countries WHERE name = %s", (country_name,))
            country_result = cursor.fetchone()
            if not country_result:
                return [], [], []
            country_id = country_result['id']

            # --- Filtered Queries ---
            
            # Fetch hotels matching the star rating
            cursor.execute("SELECT name, city, details FROM hotels WHERE country_id = %s AND star_rating = %s", (country_id, hotel_preference))
            hotels = cursor.fetchall()

            # Fetch places and restaurants matching any of the user's interests
            # Create a placeholder string for the IN clause like (%s, %s, %s)
            interest_placeholders = ', '.join(['%s'] * len(interests))
            
            # Combine interests with country_id for the query
            query_params = [country_id] + interests
            
            cursor.execute(f"SELECT name, city, type, details FROM places WHERE country_id = %s AND travel_style IN ({interest_placeholders})", query_params)
            places = cursor.fetchall()
            
            # Also filter restaurants by interest (e.g., 'Foodie')
            cursor.execute(f"SELECT name, city, cuisine, details FROM restaurants WHERE country_id = %s AND travel_style IN ({interest_placeholders})", query_params)
            restaurants = cursor.fetchall()
            
            return hotels, restaurants, places

    except pymysql.MySQLError as err:
        print(f"DATABASE ERROR in get_filtered_recommendations: {err}")
        return [], [], []
    finally:
        if conn:
            conn.close()

# --- THIS IS THE NEW FUNCTION ---
def get_all_countries():
   
    conn = None
    try:
        conn = get_connection()
        if conn is None:
            return [] # Return an empty list if connection fails

        with conn.cursor() as cursor:
            # The SQL query to get all names, ordered alphabetically
            cursor.execute("SELECT name FROM countries ORDER BY name ASC")
            results = cursor.fetchall()
            
            # Convert the list of dictionaries into a simple list of names
            # e.g., [{'name': 'Turkey'}] becomes ['Turkey']
            country_list = [country['name'] for country in results]
            return country_list

    except Exception as err:
        print(f"DATABASE ERROR in get_all_countries: {err}")
        return [] # Return empty list on error
    finally:
        if conn:
            conn.close()