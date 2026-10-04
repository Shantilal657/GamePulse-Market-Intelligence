/*
=========================================================
STEAM GAMES ANALYTICS PROJECT
=========================================================

Dataset Size : 71,649 Steam Games

Tools Used:
PostgreSQL | SQL | Data Analysis

Project Objective:
Analyze Steam game catalog, pricing,
review performance, publisher trends,
developer activity, and release patterns
to generate business insights.

KPIs:
• Total Games
• Free vs Paid Games
• Average Price
• Review Performance
• Developer Analysis
• Publisher Analysis
• Release Trends
• Hidden Gems
=========================================================
*/


/*
=========================================================
1. TOTAL GAMES
=========================================================

Business Question:
How many games are available on Steam?

Result:
71,649 games

Insight:
Steam hosts a massive catalog of 71,649 games,
demonstrating the platform's scale and strong
presence in the digital game distribution market.

Business Use:
Tracks marketplace size and serves as a
baseline KPI for platform growth analysis.
*/

SELECT COUNT(*) AS total_games
FROM steam_games;


/*
=========================================================
2. FREE VS PAID GAMES
=========================================================

Business Question:
How many games on Steam are Free-to-Play versus Paid?

Result:
Free Games : 17,579
Paid Games : 54,070

Insight:
Paid games dominate the Steam marketplace,
accounting for approximately 75% of all titles,
while Free-to-Play games represent about 25%.

Business Use:
Helps understand Steam's monetization structure
and supports pricing strategy analysis for new
game launches.
*/

SELECT
    CASE
        WHEN original_price = 0 THEN 'Free'
        ELSE 'Paid'
    END AS game_type,
    COUNT(*) AS total_games
FROM steam_games
GROUP BY game_type;



/*
=========================================================
3. DATA QUALITY CHECK
=========================================================

Business Question:
How complete is the release date information
within the Steam dataset?

Result:
Total Games         : 71,649
Games With Release Year : 61,344
Unreleased Games    : 10,305

Insight:
Around 85.6% of games contain a valid release
year, while 14.4% have missing release dates.
These records likely represent upcoming titles,
announced games, or entries with incomplete
metadata.

Business Use:
Helps assess dataset completeness and identifies
the proportion of games that cannot be included
in release-year trend analysis.
*/

SELECT
    COUNT(*) AS total_games,
    COUNT(release_year) AS games_with_release_year,
    COUNT(*) - COUNT(release_year) AS unreleased_games
FROM steam_games;


/*
=========================================================
4. PRICE STATISTICS
=========================================================

Business Question:
What are the overall pricing characteristics
of games available on Steam?

Result:
Minimum Price : $0.00
Maximum Price : $455.92
Average Price : $4.64
Median Price  : $2.79

Insight:
The median price ($2.79) is significantly lower
than the average price ($4.64), indicating a
right-skewed distribution where a small number
of expensive titles increase the overall average.

Most Steam games are low-priced, with many
free-to-play titles contributing to the platform's
pricing structure.

Business Use:
Helps understand Steam's pricing landscape,
supports competitive pricing decisions, and
provides benchmarks for new game launches.
*/

SELECT
    MIN(original_price) AS min_price,
    MAX(original_price) AS max_price,
    ROUND(AVG(original_price),2) AS avg_price,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY original_price)
        AS median_price
FROM steam_games;

/*
=========================================================
5. TOP 10 MOST EXPENSIVE GAMES
=========================================================

Business Question:
Which games have the highest listed prices
on Steam after data cleaning and outlier
removal?

Result:
The most expensive games range from
$359.96 to $455.92.

Top Examples:
• COINS BATTLE ($455.92)
• Model Building Restoration ($455.92)
• Hidden Office Top-Down 3D ($411.92)
• Hidden Cube World Top-Down 3D ($411.92)
• Hidden Harbor 2 Top-Down 3D ($411.92)

Insight:
A small number of niche and specialty titles
are priced significantly higher than the Steam
market average of $4.64. These premium-priced
games represent a tiny fraction of the platform
and do not reflect typical Steam pricing.

Business Use:
Identifies premium-priced products, helps
benchmark pricing strategies, and highlights
games that may target specialized audiences
rather than the mass market.
*/

SELECT
    title,
    original_price
FROM steam_games
ORDER BY original_price DESC
LIMIT 10;

/*
=========================================================
6. TOP 10 MOST DISCOUNTED GAMES
=========================================================

Business Question:
Which games currently offer the highest
discount percentages on Steam?

Result:
The highest discounts range from
98.70% to 99.07%.

Top Examples:
• 3D PUZZLE - Medieval Inn (99.07%)
• Johnny Rocket (99.07%)
• 3D PUZZLE - Battle Royal (99.07%)
• Time Lock VR 1 (99.00%)
• DEPLOYMENT (99.00%)

Insight:
Several games are being offered at nearly
100% discounts, indicating aggressive pricing
strategies aimed at increasing visibility,
boosting player acquisition, or clearing
inventory for older titles.

Business Use:
Helps identify extreme promotional strategies,
supports competitive pricing analysis, and
provides insights into how publishers use
discounts to drive engagement and sales.
*/

SELECT
    title,
    discount_percentage
FROM steam_games
ORDER BY discount_percentage DESC
LIMIT 10;


/*
=========================================================
7. TOTAL DISCOUNT VALUE
=========================================================

Business Question:
What is the total monetary value of discounts
offered across all Steam games in the dataset?

Result:
Total Discount Value : $31,390.01

Insight:
Steam games collectively provide more than
$31,000 in price reductions compared to their
original listed prices. This highlights the
importance of discounting as a key sales and
marketing strategy on the platform.

Business Use:
Measures the overall scale of promotional
activity, supports pricing trend analysis, and
helps evaluate how aggressively publishers use
discounts to attract players.
*/

SELECT
    ROUND(
        SUM(discount_amount),
        2
    ) AS total_discount_value
FROM steam_games;


/*
=========================================================
8. RELEASE YEAR RANGE
=========================================================

Business Question:
What is the release year range of games
available in the Steam dataset?

Result:
Oldest Game Year : 1997
Newest Game Year : 2038

Insight:
The dataset spans more than four decades of
game releases, covering both historical titles
and future scheduled releases. The presence of
future years such as 2038 indicates upcoming
games that already have announced release dates.

Business Use:
Helps understand the temporal coverage of the
dataset and supports trend analysis across
different gaming generations and release periods.
*/

SELECT
    MIN(release_year) AS oldest_game,
    MAX(release_year) AS newest_game
FROM steam_games;


/*
=========================================================
9. GAMES RELEASED PER YEAR
=========================================================

Business Question:
How has the number of games released on Steam
changed over time?

Result:
Game releases increased significantly after 2014,
peaking at 9,928 games in 2022.

Key Years:
2020 → 7,464 games
2021 → 8,885 games
2022 → 9,928 games (Highest)
2023 → 7,833 games

Future Release Records:
2024 → 91 games
2025 → 14 games
2026 → 7 games
2028 → 1 game
2029 → 2 games
2030 → 3 games
2032 → 1 game
2038 → 1 game

Insight:
Steam experienced rapid catalog expansion between
2014 and 2022, reflecting strong growth in indie
game development, self-publishing tools, and
digital distribution adoption.

The sharp decline after 2023 does not represent
market contraction. These records mainly reflect
future scheduled releases and incomplete release
data in the dataset.

Business Use:
Useful for analyzing platform growth trends,
estimating market competition, and understanding
Steam's expansion over time.
*/

SELECT
    release_year,
    COUNT(*) AS total_games
FROM steam_games
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


/*
=========================================================
10. TOP RELEASE YEARS
=========================================================

Business Question:
Which years contributed the highest number of
game releases on Steam?

Result:
2022 recorded the highest number of releases
with 9,928 games, followed by 2021 with
8,885 games and 2023 with 7,833 games.

Top 10 Release Years:
2022 → 9,928 games
2021 → 8,885 games
2023 → 7,833 games
2020 → 7,464 games
2018 → 6,428 games
2019 → 5,992 games
2017 → 5,291 games
2016 → 3,818 games
2015 → 2,364 games
2014 → 1,441 games

Insight:
Steam experienced explosive growth between
2014 and 2022, with annual game releases
increasing nearly sevenfold.

The data indicates a strong rise in indie game
development, self-publishing, and digital
distribution adoption over the last decade.

Business Use:
Helps identify peak publishing periods,
market growth patterns, and increasing
competition among game developers on Steam.
*/

SELECT
    release_year,
    COUNT(*) AS total_games
FROM steam_games
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY total_games DESC
LIMIT 10;


/*
=========================================================
11. REVIEW STATISTICS
=========================================================

Business Question:
What is the average player sentiment across
Steam games based on recent and all-time reviews?

Result:
Average Recent Review Rating : 76.74%
Average All-Time Review Rating : 84.95%

Insight:
Games tend to receive stronger ratings when
considering their full review history.

The average all-time review score (84.95%)
is significantly higher than the average
recent review score (76.74%), suggesting
that many games may experience declining
player sentiment over time or receive more
critical feedback from recent players.

Overall, Steam games maintain generally
positive user ratings, with average review
scores remaining above 75%.

Business Use:
Useful for measuring overall customer
satisfaction, monitoring sentiment trends,
and identifying potential changes in player
perception over a game's lifecycle.
*/

SELECT
    ROUND(
        AVG(recent_review_percentage),
        2
    ) AS avg_recent_rating,

    ROUND(
        AVG(all_review_percentage),
        2
    ) AS avg_all_time_rating

FROM steam_games;

/*
=========================================================
12. MOST REVIEWED GAMES
=========================================================

Business Question:
Which games have received the highest number
of all-time user reviews on Steam?

Result:
Counter-Strike: Global Offensive leads the
platform with 7.43 million reviews, followed
by PUBG and Dota 2 with over 2 million reviews
each.

Top 10 Most Reviewed Games:
Counter-Strike: Global Offensive → 7,428,921
PUBG: BATTLEGROUNDS → 2,209,987
Dota 2 → 2,030,312
Grand Theft Auto V → 1,472,644
Tom Clancy's Rainbow Six Siege → 985,871
Team Fortress 2 → 979,063
Terraria → 936,527
Garry's Mod → 848,505
Rust → 781,742
Apex Legends → 701,597

Insight:
The most reviewed games are primarily
multiplayer and live-service titles that
maintain large active player communities.

These games generate substantial engagement,
long-term retention, and continuous player
interaction, leading to millions of user
reviews over time.

Business Use:
Helps identify high-engagement games,
benchmark community size, and understand
which game genres successfully sustain
long-term player activity.
*/

SELECT
    title,
    all_review_count
FROM steam_games
WHERE all_review_count IS NOT NULL
ORDER BY all_review_count DESC
LIMIT 10;


/*
=========================================================
13. HIGHEST RATED GAMES
=========================================================

Business Question:
Which games have achieved the highest
all-time user ratings on Steam?

Result:
Several games achieved an exceptional
99% all-time positive review score.

Top Rated Games:
Senren＊Banka → 99% (14,024 reviews)
A Short Hike → 99% (11,927 reviews)
Papa's Freezeria Deluxe → 99% (4,254 reviews)
Project Kat - Paper Lily Prologue → 99% (3,910 reviews)
TOEM → 99% (2,849 reviews)
Ib → 99% (2,567 reviews)
Patrick's Parabox → 99% (2,512 reviews)
Lil Gator Game → 99% (2,206 reviews)
Monster Prom 3: Monster Roadtrip → 99% (2,068 reviews)
A Castle Full of Cats → 99% (1,906 reviews)

Insight:
These games demonstrate exceptionally high
player satisfaction, maintaining near-perfect
review scores across thousands of user reviews.

Many of these titles are indie games,
highlighting that critical success on Steam
is not limited to large publishers or AAA
studios.

Business Use:
Useful for identifying best-in-class games,
benchmarking quality standards, and studying
the characteristics of highly successful
player experiences.
*/

SELECT
    title,
    all_review_percentage,
    all_review_count
FROM steam_games
WHERE all_review_percentage IS NOT NULL
ORDER BY all_review_percentage DESC,
         all_review_count DESC
LIMIT 10;

/*
=========================================================
14. LOWEST RATED GAMES
=========================================================

Business Question:
Which games have the lowest all-time user
ratings among titles with substantial
review volume?

Criteria:
Minimum 1,000 reviews

Result:
Call of Duty®: Modern Warfare® II recorded
the lowest rating among qualifying games
with only 12% positive reviews.

Lowest Rated Games:
Call of Duty®: Modern Warfare® II → 12% (1,516 reviews)
Flatout 3: Chaos & Destruction → 15% (2,841 reviews)
O2Jam Online → 17% (1,805 reviews)
MOBILE SUIT GUNDAM BATTLE OPERATION 2 → 20% (15,351 reviews)
HAWKEN REBORN → 24% (1,706 reviews)
Mirror 2: Project X → 25% (113,398 reviews)
Stronghold 3 Gold → 30% (2,679 reviews)
Their Land → 31% (1,220 reviews)

Insight:
These games received overwhelmingly negative
feedback despite attracting a meaningful
number of players and reviews.

Several titles accumulated thousands of
reviews, indicating that poor ratings are
not due to low visibility but rather
significant dissatisfaction among players.

Games with both high review volume and low
ratings represent valuable case studies for
understanding factors that negatively impact
player experience, retention, and reputation.

Business Use:
Helps identify failed product launches,
customer satisfaction issues, and potential
risks that publishers should avoid when
developing or updating games.
*/

SELECT
    title,
    all_review_percentage,
    all_review_count
FROM steam_games
WHERE all_review_count >= 1000
ORDER BY
    all_review_percentage ASC,
    all_review_count ASC
LIMIT 10;


/*
=========================================================
15. TOP DEVELOPERS BY GAME COUNT
=========================================================

Business Question:
Which developers have published the highest number
of games on Steam?

Result:
1. Choice of Games         → 162 games
2. Creobit                 → 136 games
3. Laush Dmitriy Sergeevich→ 119 games
4. Boogygames Studios      → 106 games
5. Sokpop Collective       → 101 games
6. Hosted Games            → 100 games
7. Reforged Group          → 95 games
8. Elephant Games          → 77 games
9. Dnovel                  → 71 games
10. Somer Games            → 70 games

Insight:
Choice of Games leads the platform with the
largest number of published titles. Several
indie and casual-game studios dominate the list,
indicating that high-volume publishing is largely
driven by smaller developers rather than major
AAA studios.

Business Use:
Identifies the most active game developers on
Steam and helps analyze publishing patterns,
developer productivity, and market concentration.
*/

SELECT
    developer,
    COUNT(*) AS total_games
FROM steam_games
WHERE developer <> 'Unknown'
GROUP BY developer
ORDER BY total_games DESC
LIMIT 10;

/*
=========================================================
16. TOP PUBLISHERS BY GAME COUNT
=========================================================

Business Question:
Which publishers have released the highest number
of games on Steam?

Result:
1. Big Fish Games   → 459 games
2. 8floor           → 258 games
3. Conglomerate 5   → 199 games
4. HH-Games         → 174 games
5. Choice of Games  → 162 games
6. Strategy First   → 146 games
7. Sekai Project    → 143 games
8. THQ Nordic       → 143 games
9. SEGA             → 142 games
10. Laush Studio    → 135 games

Insight:
Big Fish Games is the most active publisher on
Steam with 459 titles, significantly ahead of
other publishers. The list is dominated by indie,
casual, and mid-sized publishers, highlighting
the diversity of content creators on the platform.

Business Use:
Helps identify the most active publishers on
Steam, analyze publishing trends, evaluate market
presence, and understand content distribution
across the platform.
*/

SELECT
    publisher,
    COUNT(*) AS total_games
FROM steam_games
WHERE publisher IS NOT NULL
    AND TRIM(publisher) <> ''
    AND publisher <> 'Unknown'
GROUP BY publisher
ORDER BY total_games DESC
LIMIT 10;


/*
=========================================================
17. BEST RATED DEVELOPERS
=========================================================

Business Question:
Which developers consistently receive the highest
player ratings on Steam?

Result:
1. Quiet River             → 94.08% avg rating (12 games)
2. Nihon Falcom            → 91.83% avg rating (12 games)
3. Ryu Ga Gotoku Studio    → 91.08% avg rating (12 games)
4. Valve                   → 90.00% avg rating (19 games)
5. Traveller's Tales       → 90.00% avg rating (10 games)
6. ATLUS                   → 88.00% avg rating (10 games)
7. id Software             → 86.25% avg rating (12 games)
8. CAPCOM Co., Ltd.        → 84.03% avg rating (32 games)
9. Square Enix             → 83.71% avg rating (28 games)
10. SEGA                   → 82.82% avg rating (11 games)

Insight:
Quiet River achieved the highest average player
rating among developers with at least 10 games.
Well-known developers such as Valve, CAPCOM,
Square Enix, ATLUS, and SEGA also rank highly,
demonstrating strong player satisfaction and
consistent game quality across multiple releases.

Business Use:
Identifies developers with strong player approval,
helps benchmark quality standards, supports
publisher partnership decisions, and highlights
studios that consistently deliver successful
gaming experiences.
*/

SELECT
    developer,
    COUNT(*) AS total_games,
    ROUND(
        AVG(all_review_percentage),
        2
    ) AS avg_rating
FROM steam_games
WHERE all_review_percentage IS NOT NULL
GROUP BY developer
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC
LIMIT 10;


/*
=========================================================
18. BEST RATED PUBLISHERS
=========================================================

Business Question:
Which publishers consistently release the
highest-rated games on Steam?

Result:
1. Sekai Project           → 95.00% avg rating (23 games)
2. Quiet River            → 94.08% avg rating (12 games)
3. PLAYISM                → 92.18% avg rating (17 games)
4. Gamera Games           → 91.55% avg rating (11 games)
5. Valve                  → 90.14% avg rating (21 games)
6. Anatoliy Loginovskiy   → 90.00% avg rating (18 games)
7. Devolver Digital       → 89.80% avg rating (61 games)
8. LucasArts              → 89.75% avg rating (16 games)
9. Fellow Traveller       → 89.29% avg rating (14 games)
10. Annapurna Interactive → 89.00% avg rating (19 games)

Insight:
Sekai Project achieved the highest average player
rating among publishers with at least 10 released
games. Publishers such as Valve, Devolver Digital,
LucasArts, and Annapurna Interactive also maintain
excellent ratings across multiple titles, indicating
strong quality control and positive player reception.

Business Use:
Helps identify publishers with consistently
high-quality game portfolios, supports investment
and partnership decisions, and highlights publishers
that have built strong player trust and engagement.
*/

SELECT
    publisher,
    COUNT(*) AS total_games,
    ROUND(
        AVG(all_review_percentage),
        2
    ) AS avg_rating
FROM steam_games
WHERE all_review_percentage IS NOT NULL
GROUP BY publisher
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC
LIMIT 10;

/*
=========================================================
19. BEST VALUE GAMES
=========================================================

Business Question:
Which games deliver the highest customer value
by combining strong review ratings, large player
approval, and affordable pricing?

Result:
Top Value Games:

1. Geometry Dash      | Value Score: 427.44
2. Among Us           | Value Score: 408.70
3. Vampire Survivors  | Value Score: 341.85
4. Left 4 Dead 2      | Value Score: 204.39
5. Portal 2           | Value Score: 196.03
6. Terraria           | Value Score: 190.81
7. People Playground  | Value Score: 189.53
8. Garry's Mod        | Value Score: 187.48
9. Half-Life 2        | Value Score: 181.83
10. Portal            | Value Score: 181.82

Insight:
Geometry Dash, Among Us, and Vampire Survivors
provide exceptional value by maintaining very
high user ratings while remaining highly
affordable. Valve titles such as Portal 2,
Left 4 Dead 2, Half-Life 2, and Portal continue
to demonstrate strong long-term customer value,
highlighting the lasting commercial success of
well-designed games.

Business Use:
Helps identify games that maximize customer
satisfaction relative to price while accounting
for large-scale player validation. Useful for
pricing strategy, competitive benchmarking,
promotion planning, and understanding what
drives long-term player value.

*/

SELECT
    title,
    original_price,
    all_review_percentage,
    ROUND(
        (
            (all_review_percentage * LN(all_review_count))
            / original_price
        )::numeric,
        2
    ) AS value_score
FROM steam_games
WHERE original_price > 0
    AND all_review_percentage >= 90
    AND all_review_count >= 100000
ORDER BY value_score DESC;


/*
=========================================================
20. HIGHLY RATED DISCOUNTED GAMES
=========================================================

Business Question:
Which games currently offer the best combination
of strong player ratings and significant discounts?

Result:
Top Discounted High-Rated Games:

1. DEPLOYMENT                    | 99.00% Discount | 86% Rating
2. Borderlands 2                 | 92.00% Discount | 95% Rating
3. Rock 'N' Roll Defense         | 90.36% Discount | 87% Rating
4. Razortron 2000                | 90.36% Discount | 86% Rating
5. Soul Gambler                  | 90.32% Discount | 87% Rating
6. Fishing Adventure             | 90.27% Discount | 86% Rating
7. PAYDAY 2                      | 90.13% Discount | 89% Rating
8. Car Mechanic Simulator 2015   | 90.09% Discount | 92% Rating
9. Metro: Last Light Redux       | 90.07% Discount | 89% Rating
10. Shadow Tactics: Blades of the Shogun | 90.05% Discount | 96% Rating

Insight:
Several highly-rated games are available at
discounts exceeding 90%, creating exceptional
value opportunities for players. Borderlands 2,
PAYDAY 2, Metro: Last Light Redux, and Shadow
Tactics demonstrate how established titles can
maintain strong player satisfaction while using
deep discount strategies to drive additional sales.

Business Use:
Helps identify successful promotional strategies,
measure the effectiveness of discount campaigns,
and discover games that can attract new players
through aggressive pricing without sacrificing
customer satisfaction.

*/

SELECT
    title,
    discount_percentage,
    all_review_percentage
FROM steam_games
WHERE discount_percentage >= 50
    AND all_review_percentage >= 85
ORDER BY
    discount_percentage DESC,
    all_review_percentage DESC
LIMIT 20;


/*
=========================================================
21. PREMIUM GAMES WITH STRONG RATINGS
=========================================================

Business Question:
Which premium-priced games maintain exceptional
player satisfaction despite their higher cost?

Result:
Top Premium High-Rated Games:

1. Persona 5 Royal                 | $59.99 | 97% Rating
2. Resident Evil 4                 | $59.99 | 97% Rating
3. Marvel's Spider-Man Remastered  | $49.99 | 96% Rating
4. The Lab                         | $92.62 | 95% Rating
5. OCTOPATH TRAVELER II            | $69.98 | 95% Rating
6. Borderlands 2                   | $145.14 | 95% Rating
7. Lost Judgment                   | $59.99 | 95% Rating

Insight:
These titles demonstrate that players are willing
to pay premium prices when games deliver outstanding
quality and user experience. Persona 5 Royal and
Resident Evil 4 achieve exceptional satisfaction
scores despite being full-priced releases, while
Marvel's Spider-Man Remastered highlights the strong
commercial value of premium AAA titles.

Business Use:
Helps identify successful premium-pricing strategies,
benchmark high-value products, and understand which
types of games can command higher prices while
maintaining excellent player sentiment.

*/

SELECT
    title,
    original_price,
    all_review_percentage
FROM steam_games
WHERE original_price >= 49.99
    AND all_review_percentage >= 95
ORDER BY all_review_percentage DESC
LIMIT 20;


/*
=========================================================
22. HIDDEN GEMS
=========================================================

Business Question:
Which games have outstanding player ratings but
relatively low review counts, indicating potential
undiscovered gems on the Steam platform?

Result:
Top Hidden Gems:

1. It Steals                            | 99% Rating | 1,010 Reviews
2. Dialtown: Phone Dating Sim           | 99% Rating | 1,048 Reviews
3. Frog Detective 3: Corruption at Cowboy County | 99% Rating | 1,073 Reviews
4. Ghost Trick: Phantom Detective       | 99% Rating | 1,521 Reviews
5. A Castle Full of Cats                | 99% Rating | 1,906 Reviews
6. Monster Prom 3: Monster Roadtrip     | 99% Rating | 2,068 Reviews
7. Lil Gator Game                       | 99% Rating | 2,206 Reviews
8. Patrick's Parabox                    | 99% Rating | 2,512 Reviews
9. Ib                                   | 99% Rating | 2,567 Reviews
10. TOEM                                | 99% Rating | 2,849 Reviews

Insight:
These games achieve near-perfect player satisfaction
while maintaining relatively small review volumes.
This suggests strong player appreciation but limited
market visibility compared to mainstream titles.
Such games represent opportunities for increased
promotion, recommendation campaigns, and community
engagement initiatives.

Business Use:
Helps identify high-quality games with untapped
growth potential. Useful for recommendation engines,
marketing campaigns, indie game discovery programs,
and investment decisions focused on emerging titles.

*/

SELECT
    title,
    all_review_percentage,
    all_review_count
FROM steam_games
WHERE all_review_percentage >= 99
    AND all_review_count BETWEEN 1000 AND 5000
ORDER BY all_review_count;


/*
=========================================================
23. MOST POPULAR GAMES
=========================================================

Business Question:
Which Steam games have achieved massive player
engagement and sustained popularity based on
review volume and player satisfaction?

Result:
Top Popular Games:

1. Counter-Strike: Global Offensive | 7,428,921 Reviews | 88% Rating
2. Dota 2                           | 2,030,312 Reviews | 82% Rating
3. Grand Theft Auto V               | 1,472,644 Reviews | 86% Rating

Insight:
Counter-Strike: Global Offensive dominates the
Steam platform with over 7.4 million reviews,
making it the most popular game in the dataset.
Dota 2 and Grand Theft Auto V also demonstrate
exceptional player engagement, each surpassing
one million reviews while maintaining strong
player satisfaction scores.

Business Use:
Helps identify flagship titles that drive player
engagement, platform traffic, and community
activity. Useful for market benchmarking,
competitive analysis, partnership opportunities,
and understanding characteristics of blockbuster
games.

*/

SELECT
    title,
    all_review_count,
    all_review_percentage
FROM steam_games
WHERE all_review_count >= 1000000
    AND all_review_percentage >= 80
ORDER BY all_review_count DESC;


/*
=========================================================
24. PROJECT CONCLUSION
Steam Games Market Intelligence Analysis
=========================================================

Key Findings

• Dataset contains 71,649 Steam games after cleaning and validation.
• Total discount value across all games is $31,390.01.
• Release years range from 1997 to 2038.
• Steam game releases grew rapidly from 2014 onward.
• 2022 recorded the highest number of game releases (9,928 games).
• 2021 (8,885) and 2023 (7,833) were also peak release years.
• Average all-time review rating is 84.95%.
• Average recent review rating is 76.74%, indicating lower recent player satisfaction.
• Counter-Strike: Global Offensive is the most reviewed game with 7.43 million reviews.
• PUBG, Dota 2, GTA V, Rainbow Six Siege, and Team Fortress 2 are among the most reviewed titles.
• Several niche games achieved exceptional ratings of 99%, proving that popularity is not always required for strong player satisfaction.
• Call of Duty: Modern Warfare II and Flatout 3 rank among the lowest-rated games despite having significant review counts.
• Valve appears among the highest-rated major developers with a large portfolio and strong review performance.
• SEGA, Annapurna Interactive, Devolver Digital, LucasArts, and Sekai Project rank among the highest-rated publishers.
• Big Fish Games is the largest publisher by game count in the dataset.
• Geometry Dash, Among Us, Vampire Survivors, Portal 2, and Terraria provide some of the strongest value-for-money experiences based on price and review scores.
• Borderlands 2, PAYDAY 2, Metro: Last Light Redux, and similar titles combine high discounts with strong player ratings.
• Premium-priced games such as Persona 5 Royal, Resident Evil 4, and OCTOPATH TRAVELER II maintain excellent review scores despite higher prices.
• Hidden gems such as TOEM, Ib, Patrick's Parabox, and A Castle Full of Cats achieved near-perfect ratings with relatively low review counts.
• Counter-Strike, Dota 2, and Grand Theft Auto V remain the most popular games on Steam based on review volume.

Business Insights

• The Steam marketplace is highly competitive, with thousands of new games released annually.
• Positive review scores are not directly dependent on game popularity.
• Significant discounts are widely used to increase player acquisition and sales volume.
• Indie and niche titles can achieve exceptional customer satisfaction despite limited exposure.
• Strong community feedback remains one of the most important indicators of long-term game success.
• Value-for-money titles tend to maintain higher player engagement and positive sentiment.
• Review analysis can help identify hidden opportunities, successful publishers, top-performing developers, and market trends.

Project Outcome

This SQL-based Steam Market Intelligence project demonstrates how data analytics can be used to uncover pricing strategies, review trends, publisher performance, developer success, customer sentiment, game popularity, hidden gems, and market growth patterns.
The analysis provides actionable insights that can support business decisions in game publishing, marketing, pricing optimization, portfolio management, and player engagement strategies.

=========================================================
*/