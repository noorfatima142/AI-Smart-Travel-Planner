-- ====================================================================================
-- == SMART TRAVEL PLANNER - COMPLETE DATABASE SETUP SCRIPT
-- == This single file will create and populate the entire database from scratch.
-- == WARNING: This will delete any existing 'travel_planner' database.
-- ====================================================================================

DROP DATABASE IF EXISTS travel_planner;
CREATE DATABASE travel_planner;
USE travel_planner;

-- ---------------------------------
-- 1. TABLE CREATION
-- ---------------------------------
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE countries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE hotels (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    star_rating VARCHAR(50),
    details TEXT,
    booking_link VARCHAR(512),
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE restaurants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    cuisine VARCHAR(100),
    travel_style VARCHAR(100),
    details TEXT,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE places (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    type VARCHAR(100),
    travel_style VARCHAR(100),
    details TEXT,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

-- ---------------------------------
-- 2. DATA INSERTION
-- ---------------------------------

-- Add a sample user
INSERT INTO users (username, email, password) VALUES ('testuser', 'test@example.com', 'password123');

-- Add all 20 countries
INSERT INTO countries (name) VALUES
('Australia'), ('Canada'), ('China'), ('Egypt'), ('France'), ('Germany'), ('Greece'), ('India'), ('Italy'), ('Japan'),
('Mexico'), ('Pakistan'), ('Qatar'), ('Saudi Arabia'), ('Spain'), ('Thailand'), ('Turkey'), ('UAE'), ('United Kingdom'), ('United States');

-- --- DATA FOR AUSTRALIA ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Australia'), 'Park Hyatt Sydney', 'Sydney', '5-star', 'https://www.booking.com/searchresults.html?ss=Park+Hyatt+Sydney', 'Offers unrivaled, front-row views of the Sydney Opera House and Harbour Bridge.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Australia'), 'Great Barrier Reef', 'Queensland', 'Natural Wonder', 'Adventure', 'The world''s largest coral reef system. Snorkel or dive to witness its breathtaking beauty.');

-- --- DATA FOR CANADA ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Canada'), 'Fairmont Chateau Lake Louise', 'Lake Louise', '5-star', 'https://www.booking.com/searchresults.html?ss=Fairmont+Chateau+Lake+Louise', 'A historic luxury resort on the shores of the stunning, turquoise-colored Lake Louise.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Canada'), 'Capilano Suspension Bridge', 'Vancouver', 'Activity', 'Adventure', 'Walk among the treetops on a thrilling suspension bridge and a series of cliff-side walkways.');

-- --- DATA FOR CHINA ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='China'), 'The Peninsula Shanghai', 'Shanghai', '5-star', 'https://www.booking.com/searchresults.html?ss=The+Peninsula+Shanghai', 'A luxurious hotel on the historic Bund waterfront, blending Art Deco style with modern technology.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='China'), 'The Great Wall of China (Mutianyu)', 'Beijing', 'Historic Site', 'History', 'Walk along a beautifully restored section of this iconic wonder of the world, with watchtowers and stunning mountain scenery.');

-- --- DATA FOR EGYPT ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Egypt'), 'Marriott Mena House, Cairo', 'Cairo', '5-star', 'https://www.booking.com/searchresults.html?ss=Marriott+Mena+House+Cairo', 'A historic palace hotel offering incredible, direct views of the Pyramids of Giza from its rooms and gardens.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Egypt'), 'Pyramids of Giza & the Sphinx', 'Cairo', 'Historic Site', 'History', 'The last surviving wonder of the ancient world. Stand in awe of the Great Pyramid and the enigmatic Great Sphinx.');

-- --- DATA FOR FRANCE ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='France'), 'Le Bristol Paris', 'Paris', '5-star', 'https://www.booking.com/searchresults.html?ss=Le+Bristol+Paris', 'An icon of French elegance, with a three-Michelin-star restaurant and a tranquil interior courtyard garden.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='France'), 'Le Bouillon Chartier', 'Paris', 'French', 'History', 'A historic, bustling restaurant serving traditional French food at incredibly low prices since 1896.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='France'), 'Eiffel Tower', 'Paris', 'Landmark', 'History', 'The iconic symbol of Paris. Ascend for breathtaking panoramic views of the city.');

-- --- DATA FOR GERMANY ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Germany'), 'Hotel Adlon Kempinski', 'Berlin', '5-star', 'https://www.booking.com/searchresults.html?ss=Hotel+Adlon+Kempinski+Berlin', 'A legendary luxury hotel located next to the Brandenburg Gate, rich in history and elegance.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Germany'), 'Neuschwanstein Castle', 'Bavaria', 'Historic Site', 'History', 'The fairytale castle that inspired Disney''s Sleeping Beauty Castle, perched on a rugged hill.');

-- --- DATA FOR GREECE ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Greece'), 'Canaves Oia Suites', 'Santorini', 'Boutique', 'https://www.booking.com/searchresults.html?ss=Canaves+Oia+Suites', 'Luxurious cave suites carved into the cliffside, offering private plunge pools and stunning caldera views.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Greece'), 'The Acropolis of Athens', 'Athens', 'Historic Site', 'History', 'The ancient citadel standing high above the city, home to the iconic Parthenon temple.');

-- --- DATA FOR INDIA ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='India'), 'The Taj Mahal Palace', 'Mumbai', '5-star', 'https://www.booking.com/searchresults.html?ss=The+Taj+Mahal+Palace+Mumbai', 'India''s first luxury hotel, an iconic and historic building overlooking the Gateway of India.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='India'), 'Bukhara', 'New Delhi', 'Indian', 'Foodie', 'A world-renowned restaurant famous for its rustic Northwest Frontier cuisine and tandoori dishes.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='India'), 'The Taj Mahal', 'Agra', 'Historic Site', 'History', 'An immense mausoleum of white marble, a monument to eternal love and a wonder of the world.');

-- --- DATA FOR ITALY ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Italy'), 'Hotel Hassler Roma', 'Rome', '5-star', 'https://www.booking.com/searchresults.html?ss=Hotel+Hassler+Roma', 'An iconic hotel at the top of the Spanish Steps, offering breathtaking views of the city.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Italy'), 'Trattoria Da Enzo al 29', 'Rome', 'Roman', 'Foodie', 'An authentic and bustling Roman trattoria in Trastevere, famous for its classic pasta dishes.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Italy'), 'The Colosseum', 'Rome', 'Historic Site', 'History', 'The largest ancient amphitheater ever built, an iconic symbol of Imperial Rome.');

-- --- DATA FOR JAPAN ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Japan'), 'Park Hyatt Tokyo', 'Tokyo', '5-star', 'https://www.booking.com/searchresults.html?ss=Park+Hyatt+Tokyo', 'Iconic hotel famous from "Lost in Translation," offering incredible panoramic city views.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Japan'), 'Ichiran Ramen (Shibuya)', 'Tokyo', 'Ramen', 'Foodie', 'A famous ramen chain where you eat in individual "flavor concentration booths".');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Japan'), 'Fushimi Inari Shrine', 'Kyoto', 'Religious Site', 'Adventure', 'Famous for its thousands of vibrant red torii gates that wind up a mountainside forest.');

-- --- DATA FOR MEXICO ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Mexico'), 'Rosewood Mayakoba', 'Riviera Maya', '5-star', 'https://www.booking.com/searchresults.html?ss=Rosewood+Mayakoba', 'A luxurious resort built along serene lagoons, with private plunge pools and boat transportation.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Mexico'), 'Chichen Itza', 'Yucatán', 'Historic Site', 'History', 'A massive, ancient Mayan city with the iconic El Castillo pyramid at its center.');

-- --- DATA FOR PAKISTAN ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Pakistan'), 'Serena Hotel Islamabad', 'Islamabad', '5-star', 'https://www.booking.com/searchresults.html?ss=Serena+Hotel+Islamabad', 'A luxurious hotel known for its beautiful Mughal-inspired architecture and lush gardens.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Pakistan'), 'Badshahi Mosque', 'Lahore', 'Historic Site', 'History', 'A majestic Mughal-era mosque with enormous domes and minarets. One of the most iconic landmarks in Pakistan.');

-- --- DATA FOR QATAR ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Qatar'), 'Marsa Malaz Kempinski', 'Doha', '5-star', 'https://www.booking.com/searchresults.html?ss=Marsa+Malaz+Kempinski+The+Pearl+Doha', 'A palatial hotel on a man-made island, providing a luxurious beachside experience.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Qatar'), 'Museum of Islamic Art (MIA)', 'Doha', 'Museum', 'History', 'An architectural masterpiece housing a world-class collection of Islamic art spanning 1,400 years.');

-- --- DATA FOR SAUDI ARABIA ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Saudi Arabia'), 'Raffles Makkah Palace', 'Makkah', '5-star', 'https://www.booking.com/searchresults.html?ss=Raffles+Makkah+Palace', 'A luxurious hotel with an unbeatable location directly overlooking the Grand Mosque and Kaaba.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Saudi Arabia'), 'Hegra (Mada''in Salih)', 'AlUla', 'Historic Site', 'History', 'Saudi Arabia''s first UNESCO World Heritage Site with tombs carved into sandstone outcrops.');

-- --- DATA FOR SPAIN ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Spain'), 'W Barcelona', 'Barcelona', '5-star', 'https://www.booking.com/searchresults.html?ss=W+Barcelona', 'An iconic sail-shaped hotel with panoramic sea views and a vibrant nightlife scene.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Spain'), 'The Alhambra', 'Granada', 'Historic Site', 'History', 'A breathtaking palace and fortress complex of the Moorish rulers, known for its intricate Islamic architecture.');

-- --- DATA FOR THAILAND ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Thailand'), 'Mandarin Oriental, Bangkok', 'Bangkok', '5-star', 'https://www.booking.com/searchresults.html?ss=Mandarin+Oriental+Bangkok', 'A legendary hotel on the Chao Phraya River, renowned for its classic style and impeccable service.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Thailand'), 'The Grand Palace', 'Bangkok', 'Historic Site', 'History', 'The spectacular former home of the King of Thailand, and home to the revered Emerald Buddha.');

-- --- DATA FOR TURKEY ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='Turkey'), 'Four Seasons Bosphorus', 'Istanbul', '5-star', 'https://www.booking.com/searchresults.html?ss=Four+Seasons+Hotel+Istanbul+at+the+Bosphorus', 'A stunningly restored 19th-century Ottoman palace with luxurious spa and waterfront views.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Turkey'), 'Mikla Restaurant', 'Istanbul', 'Anatolian', 'Foodie', 'World-class rooftop dining with breathtaking 360-degree city views and visionary "New Anatolian" cuisine.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='Turkey'), 'Hagia Sophia', 'Istanbul', 'Historic Site', 'History', 'An architectural marvel that has served as a Byzantine cathedral and an Ottoman mosque.');

-- --- DATA FOR UAE ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='UAE'), 'Burj Al Arab Jumeirah', 'Dubai', '5-star', 'https://www.booking.com/searchresults.html?ss=Burj+Al+Arab+Jumeirah+Dubai', 'The world''s most iconic hotel. Its sail-shaped silhouette defines the Dubai skyline.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='UAE'), 'The Burj Khalifa', 'Dubai', 'Landmark', 'History', 'The tallest building in the world. Ascend to the "At the Top" observation deck for stunning, panoramic views.');

-- --- DATA FOR UNITED KINGDOM ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='United Kingdom'), 'The Savoy', 'London', '5-star', 'https://www.booking.com/searchresults.html?ss=The+Savoy+London', 'One of London''s most famous hotels, blending Edwardian and Art Deco style on the banks of the Thames.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='United Kingdom'), 'Tower of London', 'London', 'Historic Site', 'History', 'A historic castle that has served as a royal palace, prison, and treasury, housing the Crown Jewels.');

-- --- DATA FOR UNITED STATES ---
INSERT INTO hotels (country_id, name, city, star_rating, booking_link, details) VALUES ((SELECT id FROM countries WHERE name='United States'), 'The Plaza', 'New York', '5-star', 'https://www.booking.com/searchresults.html?ss=The+Plaza+New+York', 'A landmark hotel at the corner of Central Park, famous for its timeless elegance.');
INSERT INTO restaurants (country_id, name, city, cuisine, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='United States'), 'Katz''s Delicatessen', 'New York', 'Deli', 'Foodie', 'A legendary NYC institution serving towering pastrami sandwiches since 1888.');
INSERT INTO places (country_id, name, city, type, travel_style, details) VALUES ((SELECT id FROM countries WHERE name='United States'), 'Grand Canyon National Park', 'Arizona', 'Natural Wonder', 'Adventure', 'Witness the immense, colorful, and awe-inspiring canyon carved by the Colorado River.');

-- ---------------------------------
-- 3. SCRIPT COMPLETE
-- ---------------------------------
SELECT 'Database setup complete. All 20 countries and their data have been loaded.' AS Status;