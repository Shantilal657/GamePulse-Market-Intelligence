import pandas as pd
from sqlalchemy import create_engine

# =====================================
# Database Connection
# =====================================

engine = create_engine(
    "postgresql+psycopg2://postgres:Shantilal04%40@localhost:5432/gamepulse_market_intelligence"
)

# =====================================
# File Path
# =====================================

CSV_FILE = "data/processed/game_cleaned.csv"

# =====================================
# Load Data Function
# =====================================

def load_data():

    print("=" * 50)
    print("READING CLEANED DATA")
    print("=" * 50)

    df = pd.read_csv(CSV_FILE)

    print(f"Rows Loaded : {df.shape[0]}")
    print(f"Columns     : {df.shape[1]}")

    # Keep only columns needed for PostgreSQL
    df = df[
        [
            "Title",
            "original_price",
            "discounted_price",
            "discount_amount",
            "discount_percentage",
            "release_date",
            "release_year",
            "Link",
            "Game Description",
            "Recent Reviews Summary",
            "All Reviews Summary",
            "recent_review_percentage",
            "recent_review_count",
            "all_review_percentage",
            "all_review_count",
            "Developer",
            "Publisher",
            "Supported Languages",
            "Popular Tags",
            "Game Features",
            "Minimum Requirements"
        ]
    ]

    # Rename columns to match PostgreSQL table
    df.columns = [
        "title",
        "original_price",
        "discounted_price",
        "discount_amount",
        "discount_percentage",
        "release_date",
        "release_year",
        "link",
        "game_description",
        "recent_reviews_summary",
        "all_reviews_summary",
        "recent_review_percentage",
        "recent_review_count",
        "all_review_percentage",
        "all_review_count",
        "developer",
        "publisher",
        "supported_languages",
        "popular_tags",
        "game_features",
        "minimum_requirements"
    ]

    # Convert release_date
    df["release_date"] = pd.to_datetime(
        df["release_date"],
        errors="coerce"
    )

    print("\nColumns being loaded:")
    print(df.columns.tolist())

    print("=" * 50)
    print("LOADING DATA INTO POSTGRESQL")
    print("=" * 50)

    df.to_sql(
        name="steam_games",
        con=engine,
        if_exists="append",
        index=False,
        chunksize=5000,
        method="multi"
    )

    print("=" * 50)
    print("DATA LOADED SUCCESSFULLY")
    print("=" * 50)
    print(f"Total Rows Loaded : {df.shape[0]}")


if __name__ == "__main__":
    load_data()