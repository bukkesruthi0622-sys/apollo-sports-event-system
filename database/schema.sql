-- Apollo Sports Event Management System
-- Corrected Database Schema

CREATE DATABASE IF NOT EXISTS apollo_sports;
USE apollo_sports;

-- 1. Users (handles login for all roles)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('student', 'volunteer', 'pt_staff') NOT NULL,
    department VARCHAR(50),
    mobile VARCHAR(15),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Event
CREATE TABLE Event (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_location VARCHAR(100),
    status ENUM('upcoming', 'active', 'completed') DEFAULT 'upcoming',
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id)
);

-- 3. Game
CREATE TABLE Game (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    game_name VARCHAR(50) NOT NULL,
    game_type VARCHAR(50),
    rules TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

-- 4. Player (linked to Users)
CREATE TABLE Player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    gender VARCHAR(10),
    mobile VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. Registration
CREATE TABLE Registration (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT NOT NULL,
    game_id INT NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('registered', 'cancelled') DEFAULT 'registered',
    FOREIGN KEY (player_id) REFERENCES Player(player_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- 6. Teams
CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL,
    game_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- 7. Match
CREATE TABLE Matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT NOT NULL,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE,
    status ENUM('scheduled', 'ongoing', 'completed') DEFAULT 'scheduled',
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id)
);

-- 8. Attendance
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    registration_id INT NOT NULL,
    match_id INT NOT NULL,
    status ENUM('present', 'absent') DEFAULT 'absent',
    marked_by INT,
    marked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (registration_id) REFERENCES Registration(registration_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (marked_by) REFERENCES Users(user_id)
);

-- 9. Score (live score updates)
CREATE TABLE Score (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT NOT NULL,
    team1_score INT DEFAULT 0,
    team2_score INT DEFAULT 0,
    updated_by INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (updated_by) REFERENCES Users(user_id)
);

-- 10. Result (final outcome only)
CREATE TABLE Result (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT NOT NULL,
    winner VARCHAR(100),
    runner_up VARCHAR(100),
    final_score VARCHAR(20),
    declared_by INT,
    declared_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (declared_by) REFERENCES Users(user_id)
);