-- =====================================================
-- Database : gamepulse_market_intelligence
-- Table    : steam_games
-- Purpose  : Store cleaned Steam Games dataset
-- =====================================================

DROP TABLE IF EXISTS steam_games;

CREATE TABLE steam_games (

    -- ==========================================
    -- Primary Key
    -- ==========================================

    game_id SERIAL PRIMARY KEY,

    -- ==========================================
    -- Game Information
    -- ==========================================

    title TEXT,
    release_date DATE,
    release_year INT,
    link TEXT,
    game_description TEXT,

    -- ==========================================
    -- Pricing Metrics
    -- ==========================================

    original_price NUMERIC(10,2),
    discounted_price NUMERIC(10,2),
    discount_amount NUMERIC(10,2),
    discount_percentage NUMERIC(10,2),

    -- ==========================================
    -- Review Metrics
    -- ==========================================

    recent_reviews_summary TEXT,
    recent_review_percentage NUMERIC(5,2),
    recent_review_count INT,

    all_reviews_summary TEXT,
    all_review_percentage NUMERIC(5,2),
    all_review_count INT,

    -- ==========================================
    -- Company Information
    -- ==========================================

    developer TEXT,
    publisher TEXT,

    -- ==========================================
    -- Game Metadata
    -- ==========================================

    supported_languages TEXT,
    popular_tags TEXT,
    game_features TEXT,

    -- ==========================================
    -- System Requirements
    -- ==========================================

    minimum_requirements TEXT

);

-- =====================================================
-- DATA VALIDATION QUERIES
-- =====================================================

-- Total Records

SELECT COUNT(*) AS total_games
FROM steam_games;

-- Preview Data

SELECT *
FROM steam_games
LIMIT 10;


SELECT MAX(original_price) FROM steam_games;

SELECT MAX(discounted_price) FROM steam_games;

-- Release Year Range

SELECT
    MIN(release_year) AS oldest_game,
    MAX(release_year) AS newest_game
FROM steam_games;


SELECT
    title,
    release_date,
    release_year
FROM steam_games
WHERE release_year >= 2030
ORDER BY release_year;

-- Games by Release Year

SELECT
    release_year,
    COUNT(*) AS total_games
FROM steam_games
GROUP BY release_year
ORDER BY release_year;



SELECT
    COUNT(*) AS total_games,
    COUNT(release_year) AS games_with_release_year,
    COUNT(*) - COUNT(release_year) AS unreleased_games
FROM steam_games;


-- Missing Developers

SELECT COUNT(*)
FROM steam_games
WHERE developer IS NULL;


SELECT COUNT(*)
FROM steam_games
WHERE TRIM(developer) = '';


-- Missing Publishers

SELECT COUNT(*)
FROM steam_games
WHERE publisher IS NULL;


SELECT COUNT(*)
FROM steam_games
WHERE TRIM(publisher) = '';


-- Price Statistics

SELECT
    MIN(original_price),
    MAX(original_price),
    AVG(original_price),
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY original_price) AS median_price
FROM steam_games;


-- Review Statistics

SELECT
    AVG(recent_review_percentage),
    AVG(all_review_percentage)
FROM steam_games;