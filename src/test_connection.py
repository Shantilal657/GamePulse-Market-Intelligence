from sqlalchemy import create_engine

engine = create_engine(
    "postgresql+psycopg2://postgres:Shantilal04%40@localhost:5432/gamepulse_market_intelligence"
)

try:
    with engine.connect() as conn:
        print("✅ Database Connected Successfully!")

except Exception as e:
    print("❌ Connection Failed")
    print(e)