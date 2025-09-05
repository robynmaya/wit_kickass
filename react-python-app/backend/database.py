import psycopg2
import psycopg2.extras
from psycopg2.pool import SimpleConnectionPool
import os
from contextlib import contextmanager

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'port': os.getenv('DB_PORT', '5432'),
    'database': os.getenv('DB_NAME', 'fastapi_tasks_db'),
    'user': os.getenv('DB_USER', 'wit_user'),
    'password': os.getenv('DB_PASSWORD', 'dev_password')
}

# Connection pool
connection_pool = SimpleConnectionPool(1, 10, **DB_CONFIG)

@contextmanager
def get_db_connection():
    """Context manager for database connections."""
    conn = connection_pool.getconn()
    try:
        yield conn
    finally:
        connection_pool.putconn(conn)

def initialize_database():
    """Create the tasks table if it doesn't exist."""
    try:
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("""
                    CREATE TABLE IF NOT EXISTS tasks (
                        id SERIAL PRIMARY KEY,
                        title VARCHAR NOT NULL,
                        description TEXT,
                        completed BOOLEAN DEFAULT FALSE,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    )
                """)
                conn.commit()
        print("✅ Database initialized successfully")
    except Exception as error:
        print(f"❌ Database initialization failed: {error}")
        raise
