import { useState, useEffect } from 'react'
import './App.css'

interface Task {
  id: number;
  title: string;
  description: string;
  completed: boolean;
  created_at: string;
}

function App() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [newTask, setNewTask] = useState({ title: '', description: '' });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    try {
      const response = await fetch('http://localhost:5001/api/tasks');
      if (!response.ok) throw new Error('Failed to fetch tasks');
      const data = await response.json();
      setTasks(data);
    } catch (error) {
      setError('Error fetching tasks: ' + (error as Error).message);
    } finally {
      setLoading(false);
    }
  };

  const addTask = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newTask.title.trim()) return;

    try {
      const response = await fetch('http://localhost:5001/api/tasks', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(newTask),
      });
      
      if (!response.ok) throw new Error('Failed to create task');
      const task = await response.json();
      setTasks([...tasks, task]);
      setNewTask({ title: '', description: '' });
    } catch (error) {
      setError('Error adding task: ' + (error as Error).message);
    }
  };

  const toggleCompleted = async (task: Task) => {
    try {
      const response = await fetch(`http://localhost:5001/api/tasks/${task.id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ completed: !task.completed }),
      });
      
      if (!response.ok) throw new Error('Failed to update task');
      const updatedTask = await response.json();
      setTasks(tasks.map(t => t.id === task.id ? updatedTask : t));
    } catch (error) {
      setError('Error updating task: ' + (error as Error).message);
    }
  };

  const deleteTask = async (taskId: number) => {
    try {
      const response = await fetch(`http://localhost:5001/api/tasks/${taskId}`, {
        method: 'DELETE',
      });
      
      if (!response.ok) throw new Error('Failed to delete task');
      setTasks(tasks.filter(t => t.id !== taskId));
    } catch (error) {
      setError('Error deleting task: ' + (error as Error).message);
    }
  };

  if (loading) {
    return <div className="app"><h1>Loading...</h1></div>;
  }

  return (
    <div className="app">
      <h1>React + FastAPI Task Manager</h1>
      
      {error && <div className="error">{error}</div>}
      
      <div className="api-info">
        <p>🚀 Powered by FastAPI - <a href="http://localhost:5001/docs" target="_blank">View API Docs</a></p>
      </div>
      
      <form onSubmit={addTask} className="task-form">
        <input
          type="text"
          value={newTask.title}
          onChange={(e) => setNewTask({ ...newTask, title: e.target.value })}
          placeholder="Task title..."
          className="task-input"
        />
        <textarea
          value={newTask.description}
          onChange={(e) => setNewTask({ ...newTask, description: e.target.value })}
          placeholder="Task description..."
          className="task-textarea"
          rows={3}
        />
        <button type="submit" className="add-button">Add Task</button>
      </form>

      <div className="tasks">
        {tasks.map((task) => (
          <div key={task.id} className={`task-item ${task.completed ? 'completed' : ''}`}>
            <div className="task-content">
              <h3>{task.title}</h3>
              <p>{task.description}</p>
              <small>Created: {task.created_at}</small>
            </div>
            <div className="task-actions">
              <button 
                onClick={() => toggleCompleted(task)}
                className={`toggle-button ${task.completed ? 'completed' : ''}`}
              >
                {task.completed ? '✅ Completed' : '⏳ In Progress'}
              </button>
              <button 
                onClick={() => deleteTask(task.id)}
                className="delete-button"
              >
                🗑 Delete
              </button>
            </div>
          </div>
        ))}
      </div>
      
      <div className="stats">
        <p>Total Tasks: {tasks.length}</p>
        <p>Completed: {tasks.filter(t => t.completed).length}</p>
        <p>In Progress: {tasks.filter(t => !t.completed).length}</p>
      </div>
    </div>
  )
}

export default App
