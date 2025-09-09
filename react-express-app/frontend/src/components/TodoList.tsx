import React, { useState, useEffect } from 'react';
import Search from './Search/Search';
import './TodoList.css';

interface Todo {
  id: number;
  text: string;
  completed: boolean;
  created_at: string;
  updated_at: string;
}

type FilterType = 'all' | 'completed' | 'incomplete';

const TodoList: React.FC = () => {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [allTodos, setAllTodos] = useState<Todo[]>([]);
  const [newTodo, setNewTodo] = useState('');
  const [currentFilter, setCurrentFilter] = useState<FilterType>('all');
  const [search, setSearch] = useState<string>('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const API_BASE = 'http://localhost:3001/api';

  const fetchTodos = async (filter: FilterType = 'all') => {
    try {
      setLoading(true);
      const url =
        filter === 'all'
          ? `${API_BASE}/todos`
          : filter
          ? `${API_BASE}/todos?filter=${filter}`
          : `${API_BASE}/todos?search=${search}`;
      const response = await fetch(url);
      if (!response.ok) throw new Error('Failed to fetch todos');
      const data = await response.json();
      setTodos(data);
      setAllTodos(data);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (filter: FilterType) => {
    setCurrentFilter(filter);
    fetchTodos(filter);
  };

  const handleSearch = (query: string) => {
    setSearch(query);
    const searchTerm = query.toLowerCase();
    setTodos(
      searchTerm === ' '
        ? allTodos
        : allTodos.filter((todo) =>
            todo.text.toLowerCase().includes(searchTerm.toLowerCase())
          )
    );
  };

  // Create new todo
  const createTodo = async () => {
    if (!newTodo.trim()) return;

    try {
      const response = await fetch(`${API_BASE}/todos`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ text: newTodo.trim() }),
      });

      if (!response.ok) throw new Error('Failed to create todo');

      setNewTodo('');
      await fetchTodos(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  // Toggle todo completion
  const toggleTodo = async (id: number, completed: boolean) => {
    try {
      const response = await fetch(`${API_BASE}/todos/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ completed: !completed }),
      });

      if (!response.ok) throw new Error('Failed to update todo');
      await fetchTodos(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  // Delete todo
  const deleteTodo = async (id: number) => {
    try {
      const response = await fetch(`${API_BASE}/todos/${id}`, {
        method: 'DELETE',
      });

      if (!response.ok) throw new Error('Failed to delete todo');
      await fetchTodos(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  useEffect(() => {
    fetchTodos();
  }, []);

  return (
    <div className='todo-container'>
      <h1>Express Todo App</h1>
      <h2>Search</h2>
      <Search value={search} handleSearch={handleSearch} />

      {error && <div className='error'>Error: {error}</div>}
      <div>
        <button
          className={currentFilter === 'all' ? 'active' : ''}
          onClick={() => handleFilterChange('all')}
        >
          All
        </button>
        <button
          className={currentFilter === 'completed' ? 'active' : ''}
          onClick={() => handleFilterChange('completed')}
        >
          Completed
        </button>
        <button
          className={currentFilter === 'incomplete' ? 'active' : ''}
          onClick={() => handleFilterChange('incomplete')}
        >
          Incomplete
        </button>
      </div>

      <div className='todo-input'>
        <input
          type='text'
          value={newTodo}
          onChange={(e) => setNewTodo(e.target.value)}
          placeholder='Enter a new todo...'
          onKeyPress={(e) => e.key === 'Enter' && createTodo()}
        />
        <button onClick={createTodo} disabled={!newTodo.trim()}>
          Add Todo
        </button>
      </div>

      {loading ? (
        <div className='loading'>Loading todos...</div>
      ) : (
        <div className='todo-list'>
          {todos.length === 0 ? (
            search === '' ? (
              <p className='empty-state'>No todos yet. Add one above!</p>
            ) : (
              <p className='empty-state'>No todos match your search.</p>
            )
          ) : (
            todos.map((todo) => (
              <div
                key={todo.id}
                className={`todo-item ${todo.completed ? 'completed' : ''}`}
              >
                <input
                  type='checkbox'
                  checked={todo.completed}
                  onChange={() => toggleTodo(todo.id, todo.completed)}
                />
                <span className='todo-text'>{todo.text}</span>
                <span className='todo-date'>
                  {new Date(todo.created_at).toLocaleDateString()}
                </span>
                <button
                  className='delete-btn'
                  onClick={() => deleteTodo(todo.id)}
                >
                  Delete
                </button>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default TodoList;
