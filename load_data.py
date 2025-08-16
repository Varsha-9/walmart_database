import pandas as pd
from sqlalchemy import create_engine
from config import CONNECTION_STRING

# Create SQLAlchemy engine
engine = create_engine(CONNECTION_STRING)

# Load CSV from your data folder
df = pd.read_csv("walmart_clean_data.csv")

# Write DataFrame to MySQL
df.to_sql("walmart", con=engine, if_exists="replace", index=False)

print("Data loaded successfully!")
