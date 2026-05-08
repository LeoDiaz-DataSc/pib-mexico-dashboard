import { BrowserRouter, Routes, Route, Navigate, useNavigate } from 'react-router-dom';
import Dashboard from './components/Dashboard/Dashboard';
import Login from './components/Login';
import LogsViewer from './components/Admin/LogsViewer';
import CronStatus from './components/Admin/CronStatus';
import { logout } from './services/api';
import './index.css';

const isAuthenticated = () => !!localStorage.getItem('inegi_token');
const isAdmin = () => {
  try {
    const user = JSON.parse(localStorage.getItem('inegi_user') || '{}');
    return user.rol === 'admin';
  } catch {
    return false;
  }
};

const PrivateRoute = ({ children, requireAdmin = false }) => {
  if (!isAuthenticated()) return <Navigate to="/login" replace />;
  if (requireAdmin && !isAdmin()) return <Navigate to="/" replace />;
  return children;
};

const Header = () => {
  const navigate = useNavigate();
  const handleLogout = () => {
      logout();
      localStorage.removeItem('inegi_user');
      navigate('/login');
  };

  const user = JSON.parse(localStorage.getItem('inegi_user') || '{}');

  return (
      <header style={{ 
          height: '64px', 
          background: 'var(--color-bg-sidebar)', 
          borderBottom: '1px solid var(--color-border)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          padding: '0 32px'
      }}>
          <div style={{
              fontSize: '1.25rem',
              fontWeight: '700',
              background: 'var(--gradient-primary)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              cursor: 'pointer'
          }} onClick={() => navigate('/')}>
              INEGI Economic Platform
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
              {isAuthenticated() && (
                  <>
                      {isAdmin() && (
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                          <button className="btn btn-secondary btn-sm" onClick={() => navigate('/admin/logs')}>Auditoría ISO</button>
                          <button className="btn btn-secondary btn-sm" onClick={() => navigate('/admin/cron')}>Estado ETL</button>
                        </div>
                      )}
                      <span style={{ color: 'var(--color-text-muted)', fontSize: '0.9rem', marginLeft: '1rem' }}>
                          Usuario: {user.username}
                      </span>
                      <button className="btn btn-secondary btn-sm" onClick={handleLogout}>
                          Cerrar Sesión
                      </button>
                  </>
              )}
          </div>
      </header>
  );
};

export default function App() {
  return (
    <BrowserRouter>
      <div className="app-layout" style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
        <Header />
        <main className="app-main page-container">
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
            <Route path="/admin/logs" element={<PrivateRoute requireAdmin={true}><LogsViewer /></PrivateRoute>} />
            <Route path="/admin/cron" element={<PrivateRoute requireAdmin={true}><CronStatus /></PrivateRoute>} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </main>
      </div>
    </BrowserRouter>
  );
}
