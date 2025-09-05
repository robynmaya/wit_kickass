from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from datetime import datetime
from typing import List, Optional
from database import get_db_connection, initialize_database
import psycopg2.extras
import os

# Initialize database tables on startup
initialize_database()

app = FastAPI(title="FastAPI Task Manager", version="1.0.0")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5174", "http://localhost:5173"],  # React dev servers
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic models for request/response
class TaskCreate(BaseModel):
    title: str
    description: Optional[str] = ""

class TaskUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    completed: Optional[bool] = None

class TaskResponse(BaseModel):
    id: int
    title: str
    description: Optional[str]
    completed: bool
    created_at: str
    updated_at: Optional[str]

@app.get("/api/health")
async def health_check():
    return {
        "message": "FastAPI server is running!",
        "timestamp": datetime.now().isoformat(),
        "python_version": "3.x",
        "docs_url": "/docs"
    }

@app.get("/api/tasks", response_model=List[TaskResponse])
async def get_tasks():
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
                cursor.execute("SELECT * FROM tasks ORDER BY created_at DESC")
                tasks = cursor.fetchall()
                return [dict(task) for task in tasks]
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.post("/api/tasks", response_model=TaskResponse)
async def create_task(task: TaskCreate):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
                cursor.execute(
                    "INSERT INTO tasks (title, description) VALUES (%s, %s) RETURNING *",
                    (task.title, task.description)
                )
                new_task = cursor.fetchone()
                conn.commit()
                return dict(new_task)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.get("/api/tasks/{task_id}", response_model=TaskResponse)
async def get_task(task_id: int):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
                cursor.execute("SELECT * FROM tasks WHERE id = %s", (task_id,))
                task = cursor.fetchone()
                if not task:
                    raise HTTPException(status_code=404, detail="Task not found")
                return dict(task)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.put("/api/tasks/{task_id}", response_model=TaskResponse)
async def update_task(task_id: int, task_update: TaskUpdate):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
                # Check if task exists
                cursor.execute("SELECT * FROM tasks WHERE id = %s", (task_id,))
                if not cursor.fetchone():
                    raise HTTPException(status_code=404, detail="Task not found")
                
                # Build dynamic update query
                update_fields = []
                values = []
                
                if task_update.title is not None:
                    update_fields.append("title = %s")
                    values.append(task_update.title)
                
                if task_update.description is not None:
                    update_fields.append("description = %s")
                    values.append(task_update.description)
                
                if task_update.completed is not None:
                    update_fields.append("completed = %s")
                    values.append(task_update.completed)
                
                update_fields.append("updated_at = CURRENT_TIMESTAMP")
                values.append(task_id)
                
                query = f"UPDATE tasks SET {', '.join(update_fields)} WHERE id = %s RETURNING *"
                cursor.execute(query, values)
                updated_task = cursor.fetchone()
                conn.commit()
                return dict(updated_task)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.delete("/api/tasks/{task_id}")
async def delete_task(task_id: int):
    try:
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("DELETE FROM tasks WHERE id = %s RETURNING id", (task_id,))
                deleted = cursor.fetchone()
                if not deleted:
                    raise HTTPException(status_code=404, detail="Task not found")
                conn.commit()
                return {"message": "Task deleted successfully"}
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get('PORT', 5001))
    uvicorn.run("app:app", host="0.0.0.0", port=port, reload=True)
