import { useState, useEffect } from 'react'
import './App.css'

interface Project {
  id: number;
  title: string;
  description: string;
  completed: boolean;
  created_at?: string;
  updated_at?: string;
}

function App() {
  const [projects, setProjects] = useState<Project[]>([]);
  const [newProject, setNewProject] = useState({ title: '', description: '' });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchProjects();
  }, []);

  const fetchProjects = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/projects');
      if (!response.ok) throw new Error('Failed to fetch projects');
      const data = await response.json();
      setProjects(data);
    } catch (error) {
      setError('Error fetching projects: ' + (error as Error).message);
    } finally {
      setLoading(false);
    }
  };

  const addProject = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newProject.title.trim()) return;

    try {
      const response = await fetch('http://localhost:3000/api/projects', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ project: newProject }),
      });
      
      if (!response.ok) throw new Error('Failed to create project');
      const project = await response.json();
      setProjects([...projects, project]);
      setNewProject({ title: '', description: '' });
    } catch (error) {
      setError('Error adding project: ' + (error as Error).message);
    }
  };

  const toggleCompleted = async (project: Project) => {
    try {
      const response = await fetch(`http://localhost:3000/api/projects/${project.id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
          project: { ...project, completed: !project.completed } 
        }),
      });
      
      if (!response.ok) throw new Error('Failed to update project');
      const updatedProject = await response.json();
      setProjects(projects.map(p => p.id === project.id ? updatedProject : p));
    } catch (error) {
      setError('Error updating project: ' + (error as Error).message);
    }
  };

  const deleteProject = async (projectId: number) => {
    try {
      const response = await fetch(`http://localhost:3000/api/projects/${projectId}`, {
        method: 'DELETE',
      });
      
      if (!response.ok) throw new Error('Failed to delete project');
      setProjects(projects.filter(p => p.id !== projectId));
    } catch (error) {
      setError('Error deleting project: ' + (error as Error).message);
    }
  };

  if (loading) {
    return <div className="app"><h1>Loading...</h1></div>;
  }

  return (
    <div className="app">
      <h1>React + Rails Project Manager</h1>
      
      {error && <div className="error">{error}</div>}
      
      <form onSubmit={addProject} className="project-form">
        <input
          type="text"
          value={newProject.title}
          onChange={(e) => setNewProject({ ...newProject, title: e.target.value })}
          placeholder="Project title..."
          className="project-input"
        />
        <textarea
          value={newProject.description}
          onChange={(e) => setNewProject({ ...newProject, description: e.target.value })}
          placeholder="Project description..."
          className="project-textarea"
          rows={3}
        />
        <button type="submit" className="add-button">Add Project</button>
      </form>

      <div className="projects">
        {projects.map((project) => (
          <div key={project.id} className={`project-item ${project.completed ? 'completed' : ''}`}>
            <div className="project-content">
              <h3>{project.title}</h3>
              <p>{project.description}</p>
            </div>
            <div className="project-actions">
              <button 
                onClick={() => toggleCompleted(project)}
                className={`toggle-button ${project.completed ? 'completed' : ''}`}
              >
                {project.completed ? '✅ Completed' : '⏳ In Progress'}
              </button>
              <button 
                onClick={() => deleteProject(project.id)}
                className="delete-button"
              >
                🗑 Delete
              </button>
            </div>
          </div>
        ))}
      </div>
      
      <div className="stats">
        <p>Total Projects: {projects.length}</p>
        <p>Completed: {projects.filter(p => p.completed).length}</p>
        <p>In Progress: {projects.filter(p => !p.completed).length}</p>
      </div>
    </div>
  )
}

export default App
