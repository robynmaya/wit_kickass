import React, { useState, useEffect } from 'react';
import './ProjectList.css';

interface Project {
  id: number;
  title: string;
  description: string;
  completed: boolean;
  created_at: string;
  updated_at: string;
}

const ProjectList: React.FC = () => {
  const [projects, setProjects] = useState<Project[]>([]);
  const [newProject, setNewProject] = useState({ title: '', description: '' });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const API_BASE = 'http://localhost:3000/api';

  // Fetch projects from backend
  const fetchProjects = async () => {
    try {
      setLoading(true);
      const response = await fetch(`${API_BASE}/projects`);
      if (!response.ok) throw new Error('Failed to fetch projects');
      const data = await response.json();
      setProjects(data);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  // Create new project
  const createProject = async () => {
    if (!newProject.title.trim()) return;
    
    try {
      const response = await fetch(`${API_BASE}/projects`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          project: {
            title: newProject.title.trim(),
            description: newProject.description.trim()
          }
        })
      });
      
      if (!response.ok) throw new Error('Failed to create project');
      
      setNewProject({ title: '', description: '' });
      await fetchProjects(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  // Toggle project completion
  const toggleProject = async (id: number, completed: boolean) => {
    try {
      const response = await fetch(`${API_BASE}/projects/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          project: { completed: !completed }
        })
      });
      
      if (!response.ok) throw new Error('Failed to update project');
      await fetchProjects(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  // Delete project
  const deleteProject = async (id: number) => {
    try {
      const response = await fetch(`${API_BASE}/projects/${id}`, {
        method: 'DELETE'
      });
      
      if (!response.ok) throw new Error('Failed to delete project');
      await fetchProjects(); // Refresh the list
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    }
  };

  useEffect(() => {
    fetchProjects();
  }, []);

  return (
    <div className="project-container">
      <h1>Rails Project Manager</h1>
      
      {error && <div className="error">Error: {error}</div>}
      
      <div className="project-form">
        <input
          type="text"
          value={newProject.title}
          onChange={(e) => setNewProject({ ...newProject, title: e.target.value })}
          placeholder="Project title..."
        />
        <textarea
          value={newProject.description}
          onChange={(e) => setNewProject({ ...newProject, description: e.target.value })}
          placeholder="Project description (optional)..."
          rows={4}
        />
        <button onClick={createProject} disabled={!newProject.title.trim()}>
          Create Project
        </button>
      </div>

      {loading ? (
        <div className="loading">Loading projects...</div>
      ) : (
        <div className="project-list">
          {projects.length === 0 ? (
            <p className="empty-state">No projects yet. Create one above!</p>
          ) : (
            projects.map((project) => (
              <div key={project.id} className={`project-item ${project.completed ? 'completed' : ''}`}>
                <div className="project-header">
                  <div className="project-status">
                    <input
                      type="checkbox"
                      checked={project.completed}
                      onChange={() => toggleProject(project.id, project.completed)}
                    />
                    <span className="status-badge">
                      {project.completed ? '✅ Completed' : '🚧 In Progress'}
                    </span>
                  </div>
                  <button 
                    className="delete-btn"
                    onClick={() => deleteProject(project.id)}
                  >
                    Delete
                  </button>
                </div>
                
                <h3 className="project-title">{project.title}</h3>
                
                {project.description && (
                  <p className="project-description">{project.description}</p>
                )}
                
                <div className="project-dates">
                  <span>Created: {new Date(project.created_at).toLocaleDateString()}</span>
                  {project.updated_at !== project.created_at && (
                    <span>Updated: {new Date(project.updated_at).toLocaleDateString()}</span>
                  )}
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default ProjectList;
