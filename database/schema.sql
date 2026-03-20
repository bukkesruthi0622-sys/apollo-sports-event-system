-- ============================================
-- Apollo Sports Event Management System
-- Clean Database Schema
-- ============================================

DROP DATABASE IF EXISTS apollo_sports;
CREATE DATABASE apollo_sports;
USE apollo_sports;

-- ============================================
-- 1. USERS
-- ============================================
CREATE TABLE Users (
    user_id       INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('student', 'volunteer', 'pt_staff') NOT NULL,
    department    VARCHAR(50),
    mobile        VARCHAR(15),
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. EVENT
-- ============================================
CREATE TABLE Event (
    event_id       INT PRIMARY KEY AUTO_INCREMENT,
    event_name     VARCHAR(100) NOT NULL,
    event_date     DATE NOT NULL,
    event_location VARCHAR(100),
    status         ENUM('upcoming', 'active', 'completed') DEFAULT 'upcoming'
);

-- ============================================
-- 3. GAME
-- ============================================
CREATE TABLE Game (
    game_id   INT PRIMARY KEY AUTO_INCREMENT,
    event_id  INT NOT NULL,
    game_name VARCHAR(50) NOT NULL,
    game_mode ENUM('solo', 'team') DEFAULT 'solo',
    team_size INT DEFAULT 1,
    rules     TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

-- ============================================
-- 4. PLAYER
-- ============================================
CREATE TABLE Player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id   INT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ============================================
-- 5. REGISTRATION
-- ============================================
CREATE TABLE Registration (
    registration_id   INT PRIMARY KEY AUTO_INCREMENT,
    player_id         INT NOT NULL,
    game_id           INT NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status            ENUM('registered', 'cancelled', 'replaced') DEFAULT 'registered',
    UNIQUE (player_id, game_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id),
    FOREIGN KEY (game_id)   REFERENCES Game(game_id)
);

-- ============================================
-- 6. TEAM
-- ============================================
CREATE TABLE Team (
    team_id   INT PRIMARY KEY AUTO_INCREMENT,
    game_id   INT NOT NULL,
    team_name VARCHAR(50),
    UNIQUE (team_name, game_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- ============================================
-- 7. TEAM_MEMBERS
-- ============================================
CREATE TABLE Team_Members (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    team_id   INT NOT NULL,
    player_id INT NOT NULL,
    UNIQUE (team_id, player_id),
    FOREIGN KEY (team_id)   REFERENCES Team(team_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

-- ============================================
-- 8. MATCHES
-- ============================================
CREATE TABLE Matches (
    match_id   INT PRIMARY KEY AUTO_INCREMENT,
    game_id    INT NOT NULL,
    player1_id INT NULL,
    player2_id INT NULL,
    team1_id   INT NULL,
    team2_id   INT NULL,
    match_date DATETIME,
    status     ENUM('scheduled', 'ongoing', 'completed', 'cancelled') DEFAULT 'scheduled',

    CHECK (
        (player1_id IS NOT NULL AND player2_id IS NOT NULL
            AND team1_id IS NULL AND team2_id IS NULL)
        OR
        (team1_id IS NOT NULL AND team2_id IS NOT NULL
            AND player1_id IS NULL AND player2_id IS NULL)
    ),

    FOREIGN KEY (game_id)    REFERENCES Game(game_id),
    FOREIGN KEY (player1_id) REFERENCES Player(player_id),
    FOREIGN KEY (player2_id) REFERENCES Player(player_id),
    FOREIGN KEY (team1_id)   REFERENCES Team(team_id),
    FOREIGN KEY (team2_id)   REFERENCES Team(team_id)
);

-- ============================================
-- 9. ATTENDANCE (FINAL CORRECT)
-- ============================================
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id     INT NULL,
    team_id       INT NULL,
    match_id      INT NOT NULL,
    status        ENUM('present', 'absent') DEFAULT 'absent',
    marked_by     INT,
    marked_at     DATETIME DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        (player_id IS NOT NULL AND team_id IS NULL)
        OR
        (team_id IS NOT NULL AND player_id IS NULL)
    ),

    UNIQUE (player_id, match_id),
    UNIQUE (team_id, match_id),

    FOREIGN KEY (player_id) REFERENCES Player(player_id),
    FOREIGN KEY (team_id)   REFERENCES Team(team_id),
    FOREIGN KEY (match_id)  REFERENCES Matches(match_id),
    FOREIGN KEY (marked_by) REFERENCES Users(user_id)
);

-- ============================================
-- 10. SCORE
-- ============================================
CREATE TABLE Score (
    score_id           INT PRIMARY KEY AUTO_INCREMENT,
    match_id           INT NOT NULL UNIQUE,
    participant1_score INT DEFAULT 0,
    participant2_score INT DEFAULT 0,
    updated_by         INT,
    updated_at         DATETIME DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id)   REFERENCES Matches(match_id),
    FOREIGN KEY (updated_by) REFERENCES Users(user_id)
);

-- ============================================
-- 11. RESULT
-- ============================================
CREATE TABLE Result (
    result_id        INT PRIMARY KEY AUTO_INCREMENT,
    match_id         INT NOT NULL UNIQUE,
    winner_player_id INT NULL,
    runner_player_id INT NULL,
    winner_team_id   INT NULL,
    runner_team_id   INT NULL,
    final_score      VARCHAR(20),
    result_type      ENUM('normal', 'walkover', 'cancelled') DEFAULT 'normal',
    declared_by      INT,
    declared_at      DATETIME DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        (winner_player_id IS NOT NULL AND runner_player_id IS NOT NULL
            AND winner_team_id IS NULL AND runner_team_id IS NULL)
        OR
        (winner_team_id IS NOT NULL AND runner_team_id IS NOT NULL
            AND winner_player_id IS NULL AND runner_player_id IS NULL)
        OR
        (result_type = 'cancelled')
    ),

    FOREIGN KEY (match_id)         REFERENCES Matches(match_id),
    FOREIGN KEY (winner_player_id) REFERENCES Player(player_id),
    FOREIGN KEY (runner_player_id) REFERENCES Player(player_id),
    FOREIGN KEY (winner_team_id)   REFERENCES Team(team_id),
    FOREIGN KEY (runner_team_id)   REFERENCES Team(team_id),
    FOREIGN KEY (declared_by)      REFERENCES Users(user_id)
);

-- ============================================
-- 12. VOLUNTEER
-- ============================================
CREATE TABLE Volunteer (
    volunteer_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id      INT NOT NULL,
    match_id     INT NOT NULL,
    assigned_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, match_id),
    FOREIGN KEY (user_id)  REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);

-- ============================================
-- FINAL CHECK
-- ============================================
SHOW TABLES;