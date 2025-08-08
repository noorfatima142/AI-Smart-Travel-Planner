# app.py (Final Version with DYNAMIC AI Itinerary)

import streamlit as st
import random
from auth import create_user, login_user
from recommendations import get_filtered_recommendations, get_all_countries
from datetime import timedelta # We need this to calculate dates

# --- Page Configuration ---
st.set_page_config(page_title="Smart Travel Planner", layout="wide")


# --- NEW: The AI Itinerary Generator is now DYNAMIC ---
def generate_ai_itinerary(hotels, restaurants, places, num_days):
    # Handle cases where there isn't enough data
    if not places:
        return "Not enough activity data for your interests to generate a daily plan. Please broaden your interests."
    if not restaurants:
        return "Not enough restaurant data for your interests to generate a daily plan. Please select 'Foodie'."
    
    itinerary = f"## ✨ Your AI-Generated {num_days}-Day Itinerary\n---\n"
    itinerary += f"Based on your selection, here is a sample plan. You'll be staying at the luxurious **{random.choice(hotels)['name'] if hotels else 'hotel of your choice'}**.\n\n"
    
    # --- THIS IS THE FIX: The loop now uses the REAL number of days ---
    for day in range(1, num_days + 1):
        itinerary += f"### **Day {day}**\n"
        
        place_morning = random.choice(places)
        restaurant_lunch = random.choice(restaurants)
        
        place_afternoon = random.choice(places)
        if len(places) > 1:
            while place_afternoon == place_morning:
                place_afternoon = random.choice(places)
        
        itinerary += f"- **Morning:** Visit the magnificent **{place_morning['name']}**.\n"
        itinerary += f"- **Lunch:** Enjoy a delicious meal at **{restaurant_lunch['name']}**.\n"
        itinerary += f"- **Afternoon:** Explore the wonders of **{place_afternoon['name']}**.\n\n"
        
    return itinerary


# --- Authentication and Main App Logic (No major changes) ---
def attempt_login(username, password):
    user = login_user(username, password)
    if user:
        st.session_state['logged_in'] = True
        st.session_state['username'] = user.get('username')
        st.rerun()
    else:
        st.error("Invalid username or password.")

def attempt_signup(username, email, password):
    if create_user(username, email, password):
        st.success("Account created successfully! Please log in.")
    else:
        st.error("Username or email already exists.")

if 'logged_in' not in st.session_state:
    st.session_state['logged_in'] = False

if not st.session_state['logged_in']:
    st.title("✈️ Welcome to the Smart Travel Planner")
    login_tab, signup_tab = st.tabs(["Login", "Create Account"])
    with login_tab:
        with st.form("login_form"):
            login_user_input = st.text_input("Username")
            login_pass_input = st.text_input("Password", type="password")
            if st.form_submit_button("Login"):
                attempt_login(login_user_input, login_pass_input)
    with signup_tab:
        with st.form("signup_form"):
            signup_user_input = st.text_input("Username", key="su_user")
            signup_email_input = st.text_input("Email", key="su_email")
            signup_pass_input = st.text_input("Password", type="password", key="su_pass")
            if st.form_submit_button("Create Account"):
                attempt_signup(signup_user_input, signup_email_input, signup_pass_input)
else:
    st.sidebar.title(f"Welcome, {st.session_state['username']}!")
    if st.sidebar.button("Logout"):
        del st.session_state['logged_in']; del st.session_state['username']; st.rerun()

    st.title("Tell Us About Your Dream Trip")
    st.markdown("Fill out the details below and we'll generate a personalized plan for you.")

    with st.form("planner_form"):
        all_countries_from_db = get_all_countries()
        country_input = st.selectbox("Destination Country", all_countries_from_db)
        col1, col2 = st.columns(2)
        with col1: start_date_input = st.date_input("Start Date")
        with col2: end_date_input = st.date_input("End Date", min_value=start_date_input + timedelta(days=1))
        col3, col4 = st.columns(2)
        with col3: travelers_input = st.number_input("Number of Travelers", value=1)
        with col4: budget_input = st.number_input("Budget per Person (USD)", value=1500)
        hotel_input = st.radio("Hotel Preference", ["5-star", "4-star", "Boutique", "Budget"], horizontal=True)
        interests_input = st.multiselect("Travel Style / Interests", ["History", "Adventure", "Relaxation", "Foodie", "Nightlife"])
        generate_submitted = st.form_submit_button("Generate My Plan")

    if generate_submitted:
        if not interests_input:
            st.warning("Please select at least one interest.")
        else:
            # --- THIS IS THE NEW LOGIC ---
            # 1. Validate that the end date is after the start date
            if start_date_input >= end_date_input:
                st.error("Error: The trip end date must be after the start date.")
            else:
                # 2. Calculate the total number of days for the trip
                duration = end_date_input - start_date_input
                num_days = duration.days
                
                # 3. Add a safety cap to keep the plan reasonable (e.g., max 7 days)
                num_days_capped = min(num_days, 7)
                
                hotels, restaurants, places = get_filtered_recommendations(country_input, hotel_input, interests_input)
                
                st.header("Your Personalized Travel Plan!")
                itinerary_tab, hotels_tab, activities_tab, dining_tab = st.tabs([
                    "✨ AI-Generated Itinerary", "🏨 Hotels", "🗺️ Activities", "🍽️ Dining"
                ])
                
                with itinerary_tab:
                    # 4. Pass the calculated number of days to the AI generator
                    ai_plan = generate_ai_itinerary(hotels, restaurants, places, num_days_capped)
                    st.markdown(ai_plan)
                    if num_days > 7:
                        st.info("Note: The AI itinerary is capped at 7 days for a better overview.")
                
                with hotels_tab:
                    # (Rest of the code is the same)
                    st.subheader("Hotel Recommendations")
                    if hotels:
                        for h in hotels:
                            st.markdown(f"**{h['name']}** ({h['city']})")
                            st.markdown(f"_{h['details']}_")
                            if h.get('booking_link'): st.link_button("Book on Booking.com", h['booking_link'])
                            st.markdown("---")
                    else: st.write("_No hotels found matching your specific preference._")

                with activities_tab:
                    st.subheader("Suggested Activities & Sights")
                    if places:
                        for p in places:
                            st.markdown(f"**{p['name']}** ({p['city']}) - *{p['type']}*")
                            st.markdown(p['details']); st.markdown("---")
                    else: st.write("_No activities found matching your interests._")

                with dining_tab:
                    st.subheader("Dining Recommendations")
                    if restaurants:
                        for r in restaurants:
                            st.markdown(f"**{r['name']}** ({r['city']}) - *{r['cuisine']}*")
                            st.markdown(r['details']); st.markdown("---")
                    else: st.write("_No specific restaurants found for your interests._")