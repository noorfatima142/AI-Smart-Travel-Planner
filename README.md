# AI-Smart-Travel-Planner
It is a smart travel planner that generates personalized itineraries using a MySQL database and streamlit.

# ✈️ AI Smart Travel Planner

This is a personalized travel planner application built with Python and Streamlit. It uses a MySQL database to store recommendations and generates a custom, multi-day itinerary based on user preferences for destinations, budget, and travel style.

## Features

- **User Authentication:** Secure signup and login system.
- **Dynamic Recommendations:** Fetches hotels, restaurants, and activities from a MySQL database.
- **Personalized Filtering:** Users can filter recommendations by country, hotel preference, and travel interests.
- **AI Itinerary Generator:** Automatically creates a logical multi-day plan based on the user's choices.
- **External Booking Links:** Provides direct links to book recommended hotels on Booking.com.

## How to Run This Project Locally

Follow these steps to get the project running on your own machine.

### Prerequisites

- Python 3.8+
- MySQL Server

### Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
    cd YOUR_REPOSITORY_NAME
    ```

2.  **Set up the database:**
    - Ensure your MySQL server is running.
    - Create a new database named `travel_planner`.
    - Import the data by running the provided SQL scripts in your MySQL tool.
    - **Important:** Update your database credentials (`user`, `password`) in the `database.py` file.

3.  **Create and activate a virtual environment:**
    ```bash
    # Create the environment
    python -m venv venv

    # Activate on Windows
    .\venv\Scripts\activate.bat
    
    # Activate on macOS/Linux
    # source venv/bin/activate
    ```

4.  **Install the required libraries:**
    ```bash
    pip install -r requirements.txt
    ```

5.  **Run the Streamlit application:**
    ```bash
    streamlit run app.py
    ```

The application will open in your web browser!
