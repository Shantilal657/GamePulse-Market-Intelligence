import pandas as pd
import numpy as np
import re

INPUT_FILE = "data/raw/game.csv"
OUTPUT_FILE = "data/processed/game_cleaned.csv"


def clean_price(price):
    """
    Convert:
    $29.99 -> 29.99
    Free -> 0
    """

    if pd.isna(price):
        return np.nan

    price = str(price).strip()

    if price.lower() == "free":
        return 0.0

    price = price.replace("$", "").replace(",", "")

    try:
        return float(price)

    except:
        return np.nan


def extract_review_percentage(text):
    """
    Example:
    '- 96% of the 128,900 user reviews...'
    Returns:
    96
    """

    if pd.isna(text):
        return np.nan

    match = re.search(r"(\d+)%", str(text))

    if match:
        return int(match.group(1))

    return np.nan


def extract_review_count(text):
    """
    Example:
    '- 96% of the 128,900 user reviews...'
    Returns:
    128900
    """

    if pd.isna(text):
        return np.nan

    match = re.search(r"of the ([\d,]+)", str(text))

    if match:
        return int(match.group(1).replace(",", ""))

    return np.nan


def transform_data():

    print("=" * 50)
    print("LOADING DATA")
    print("=" * 50)

    df = pd.read_csv(INPUT_FILE)

    rows_before = len(df)

    # --------------------------------------------------
    # Remove Missing Titles
    # --------------------------------------------------

    df = df[df["Title"].notna()]

    # --------------------------------------------------
    # Fill Missing Developer & Publisher
    # --------------------------------------------------

    df["Developer"] = df["Developer"].fillna("Unknown")
    df["Publisher"] = df["Publisher"].fillna("Unknown")

    # --------------------------------------------------
    # Price Cleaning
    # --------------------------------------------------

    df["original_price"] = (
        df["Original Price"]
        .apply(clean_price)
    )

    df["discounted_price"] = (
        df["Discounted Price"]
        .apply(clean_price)
    )

    # --------------------------------------------------
    # Remove Unrealistic Price Outliers
    # EDA Finding:
    # 99.9% of games were below $277
    # Extreme values like 14046333,
    # 100000 and 9999 were anomalies
    # --------------------------------------------------

    df = df[
        (
            df["original_price"].isna()
        )
        |
        (
            df["original_price"] <= 500
        )
    ]

    df = df[
        (
            df["discounted_price"].isna()
        )
        |
        (
            df["discounted_price"] <= 500
        )
    ]

    # --------------------------------------------------
    # Discount Metrics
    # --------------------------------------------------

    df["discount_amount"] = (
        df["original_price"]
        - df["discounted_price"]
    )

    df["discount_percentage"] = np.where(
        df["original_price"] > 0,
        round(
            (
                df["discount_amount"]
                / df["original_price"]
            ) * 100,
            2
        ),
        0
    )

    # --------------------------------------------------
    # Release Date Cleaning
    # --------------------------------------------------

    invalid_dates = [
        "Coming Soon",
        "Coming soon",
        "To be announced",
        "To Be Announced"
    ]

    df["Release Date"] = df["Release Date"].replace(
        invalid_dates,
        np.nan
    )

    df["release_date"] = pd.to_datetime(
        df["Release Date"],
        errors="coerce"
    )

    df["release_year"] = (
        df["release_date"]
        .dt.year
    )

    # --------------------------------------------------
    # Remove Invalid Release Years
    # --------------------------------------------------

    rows_before_release_filter = len(df)

    df = df[
        (
            (df["release_year"] >= 1970)
            &
            (df["release_year"] <= 2050)
        )
        |
        (
            df["release_year"].isna()
        )
    ]

    rows_removed = (
        rows_before_release_filter
        - len(df)
    )

    print(
        f"Invalid Release Year Rows Removed: {rows_removed}"
    )

    # --------------------------------------------------
    # Review Metrics
    # --------------------------------------------------

    df["recent_review_percentage"] = (
        df["Recent Reviews Number"]
        .apply(extract_review_percentage)
    )

    df["recent_review_count"] = (
        df["Recent Reviews Number"]
        .apply(extract_review_count)
    )

    df["all_review_percentage"] = (
        df["All Reviews Number"]
        .apply(extract_review_percentage)
    )

    df["all_review_count"] = (
        df["All Reviews Number"]
        .apply(extract_review_count)
    )

    # --------------------------------------------------
    # Final Analytical Columns
    # --------------------------------------------------

    final_columns = [

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

    df = df[final_columns]

    # --------------------------------------------------
    # Save Cleaned Dataset
    # --------------------------------------------------

    df.to_csv(
        OUTPUT_FILE,
        index=False
    )

    print("=" * 50)
    print("TRANSFORMATION COMPLETE")
    print("=" * 50)

    print(
        f"Rows Before Cleaning : {rows_before}"
    )

    print(
        f"Rows After Cleaning  : {df.shape[0]}"
    )

    print(
        f"Rows Removed         : {rows_before - df.shape[0]}"
    )

    print(
        f"Columns              : {df.shape[1]}"
    )

    print(
        f"Saved To             : {OUTPUT_FILE}"
    )


if __name__ == "__main__":
    transform_data()