import pandas as pd

FILE_PATH = "data/raw/game.csv"

def extract_data():
    """
    Extract Steam game data from CSV file
    Returns:
        pandas.DataFrame
    """

    try:
        df = pd.read_csv(FILE_PATH)

        print("=" * 50)
        print("DATA LOADED SUCCESSFULLY")
        print("=" * 50)
        print(f"Rows    : {df.shape[0]}")
        print(f"Columns : {df.shape[1]}")

        return df

    except Exception as e:
        print(f"Error loading data: {e}")
        return None


if __name__ == "__main__":
    df = extract_data()