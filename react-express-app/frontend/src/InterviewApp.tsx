import { useState, useEffect } from 'react'

interface User {
  id: number
  name: string
  email: string
}

function InterviewApp() {
  const [users, setUsers] = useState<User[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    fetch('/api/users')
      .then(res => res.json())
      .then(data => {
        setUsers(data)
        setLoading(false)
      })
      .catch(err => {
        setError(err.message)
        setLoading(false)
      })
  }, [])

  if (loading) return <div>Loading...</div>
  if (error) return <div>Error: {error}</div>

  return (
    <div style={{ padding: '20px' }}>
      <header style={{ marginBottom: '20px', textAlign: 'center', background: '#f8f9fa', padding: '20px', borderRadius: '8px' }}>
        <h1>React + Express Interview App</h1>
        <p>Full-stack project ready for development</p>
      </header>
      
      <main>
        <section style={{ marginBottom: '30px' }}>
          <h2>✅ Backend Connection Test</h2>
          <p>Successfully connected to Express backend!</p>
        </section>

        <section>
          <h2>👥 Users from Database</h2>
          {users.length === 0 ? (
            <p style={{ fontStyle: 'italic', color: '#666' }}>
              No users in database yet. Ready to add CRUD functionality!
            </p>
          ) : (
            <ul>
              {users.map(user => (
                <li key={user.id} style={{ margin: '10px 0', padding: '10px', background: '#f8f9fa', borderRadius: '4px' }}>
                  <strong>{user.name}</strong> - {user.email}
                </li>
              ))}
            </ul>
          )}
        </section>

        <section style={{ marginTop: '40px', padding: '20px', border: '2px dashed #ddd', borderRadius: '8px' }}>
          <h3>🚀 Ready for Development</h3>
          <ul style={{ textAlign: 'left' }}>
            <li>✅ TypeScript configured</li>
            <li>✅ Backend API running (port 3001)</li>
            <li>✅ Database connected</li>
            <li>✅ CORS enabled for local development</li>
            <li>🎯 Start building your features here!</li>
          </ul>
        </section>
      </main>
    </div>
  )
}

export default InterviewApp