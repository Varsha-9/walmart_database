# # Walmart Sales Data Loader Project

This project demonstrates how to load Walmart sales data into a MySQL database using Python. It uses environment variables for secure database credentials and supports loading both raw and cleaned CSV data.



## Project Structure


walmart_project/

├── config.py      # Loads environment variables for DB connection

├── load_data.py       # Script to load CSV into MySQL using pandas & SQLAlchemy

├── test_config.py      # Test DB connection

├── walmart.csv      # Raw Walmart sales data (not tracked in Git)

├── walmart_clean_data.csv   # Cleaned Walmart sales data (not tracked in Git)

├── .env   # Environment variables (ignored in Git)

├── .gitignore   # Specifies files/folders to ignore

├── my_env1/   # Python virtual environment (ignored in Git)

└── README.md   # Project documentation


## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository_url>
   cd walmart_project
   ```
2. **Create and activate virtual environment**
   ```bash
   python -m venv my_env1
   my_env1\Scripts\activate      # Windows
   source my_env1/bin/activate   # Linux/Mac
   ```
3. **Install dependencies**
   ```bash
      pip install --upgrade pip setuptools wheel
   ```
4. **Create a .env file**
   Store your database credentials:
   ```ini
   DB_USER=root
   DB_PASSWORD=your_password_here
   DB_HOST=localhost
   DB_NAME=walmart_database
   ```
6. **Test configuration**
   ```bash
   python test_config.py
   ```
   You should see your DB credentials printed without exposing them on GitHub.
7. **Load data into MySQL**
   ```bash
   python load_data.py
   ```
   This script reads walmart.csv (raw data) or walmart_clean_data.csv (cleaned data) and writes it to your MySQL database using pandas .to_sql() and SQLAlchemy.

## SQL Queries Example

   Once the data is loaded, you can run queries like:
```sql
   -- Check top 10 sales records
SELECT * FROM walmart LIMIT 10;

-- Aggregate sales by store
SELECT Store, SUM(Sales) AS Total_Sales
FROM walmart
GROUP BY Store;

-- Filter sales for a specific date
SELECT * FROM walmart
WHERE Date = '2012-01-06';
```

## Notes
   - Do not commit .env, my_env1/, or large data files to GitHub. They are included in .gitignore.
   - If your MySQL password contains special characters (like @), use urllib.parse.quote_plus() in config.py to encode it.
   - This setup works for both raw and cleaned CSV data. Change the file path in load_data.py accordingly.

## Dependencies
   - Python 3.11+
   - pandas
   - SQLAlchemy
   - PyMySQL
   - python-dotenv

## Author
   Varsha Reddy
