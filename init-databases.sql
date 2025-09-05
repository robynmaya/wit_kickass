-- Initialize databases for each app
CREATE DATABASE express_todos_db;
CREATE DATABASE fastapi_tasks_db;
CREATE DATABASE rails_projects_db;

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE express_todos_db TO wit_user;
GRANT ALL PRIVILEGES ON DATABASE fastapi_tasks_db TO wit_user;
GRANT ALL PRIVILEGES ON DATABASE rails_projects_db TO wit_user;

-- Connect to each database and grant schema permissions
\c express_todos_db;
GRANT ALL ON SCHEMA public TO wit_user;

\c fastapi_tasks_db;
GRANT ALL ON SCHEMA public TO wit_user;

\c rails_projects_db;
GRANT ALL ON SCHEMA public TO wit_user;
