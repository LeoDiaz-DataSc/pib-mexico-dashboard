import { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';
import { login, verifyMFA } from '../../services/api';

gsap.registerPlugin(useGSAP);

export default function Login() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [mfaToken, setMfaToken] = useState('');
    const [requireMFA, setRequireMFA] = useState(false);
    const [userId, setUserId] = useState(null);
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    
    const container = useRef();
    const navigate = useNavigate();

    useGSAP(() => {
        const tl = gsap.timeline();
        tl.from('.login-card', { y: 30, opacity: 0, duration: 0.6, ease: 'power3.out' })
          .from('.login-element', { y: 20, opacity: 0, duration: 0.4, stagger: 0.1, ease: 'power2.out' }, "-=0.2");
    }, { scope: container });

    const handleLogin = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            const data = await login(username, password);
            if (data.success) {
                if (data.require_mfa) {
                    setRequireMFA(true);
                    setUserId(data.user_id);
                } else {
                    localStorage.setItem('inegi_user', JSON.stringify(data.user));
                    gsap.to('.login-card', { scale: 0.95, opacity: 0, duration: 0.3, onComplete: () => navigate('/dashboard') });
                }
            } else {
                setError(data.message || 'Error de autenticación');
            }
        } catch (err) {
            setError(err.response?.data?.error || err.response?.data?.message || 'Credenciales inválidas');
        } finally {
            setLoading(false);
        }
    };

    const handleMFA = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            const data = await verifyMFA(userId, mfaToken);
            if (data.success) {
                // Fetch user data again or assume admin if only admin uses MFA
                localStorage.setItem('inegi_user', JSON.stringify({ id: userId, username, rol: 'admin' }));
                gsap.to('.login-card', { scale: 0.95, opacity: 0, duration: 0.3, onComplete: () => navigate('/admin/logs') });
            } else {
                setError(data.message || 'Token inválido');
            }
        } catch (err) {
            setError(err.response?.data?.message || 'Error verificando MFA');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div ref={container} style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#0f172a' }}>
            <div className="login-card card" style={{ maxWidth: '400px', width: '100%', padding: '2rem', background: '#1e293b', border: '1px solid #334155', borderRadius: '8px' }}>
                <div className="login-element" style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🇲🇽</div>
                    <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#3b82f6' }}>INEGI Data Platform</h1>
                    <p style={{ color: '#94a3b8', fontSize: '0.9rem', marginTop: '0.5rem' }}>Autenticación Segura (ISO 27001)</p>
                </div>

                {error && (
                    <div className="login-element" style={{ background: 'rgba(239, 68, 68, 0.1)', color: '#ef4444', padding: '0.75rem', borderRadius: '4px', marginBottom: '1rem', fontSize: '0.9rem', textAlign: 'center', border: '1px solid rgba(239, 68, 68, 0.2)' }}>
                        {error}
                    </div>
                )}

                {!requireMFA ? (
                    <form onSubmit={handleLogin}>
                        <div className="login-element" style={{ marginBottom: '1rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.85rem', color: '#cbd5e1' }}>Usuario</label>
                            <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #334155', background: '#0b1120', color: '#f8fafc' }} required autoFocus />
                        </div>
                        <div className="login-element" style={{ marginBottom: '1.5rem' }}>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.85rem', color: '#cbd5e1' }}>Contraseña</label>
                            <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #334155', background: '#0b1120', color: '#f8fafc' }} required />
                        </div>
                        <button className="login-element btn" type="submit" disabled={loading} style={{ width: '100%', padding: '0.75rem', justifyContent: 'center', fontWeight: 'bold', background: '#3b82f6', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                            {loading ? 'Verificando...' : 'Acceder'}
                        </button>
                    </form>
                ) : (
                    <form onSubmit={handleMFA}>
                        <div className="login-element" style={{ marginBottom: '1.5rem', textAlign: 'center' }}>
                            <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>🔒</div>
                            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.85rem', color: '#cbd5e1' }}>Token Autenticador (MFA)</label>
                            <input type="text" value={mfaToken} onChange={(e) => setMfaToken(e.target.value)} style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #334155', background: '#0b1120', color: '#f8fafc', textAlign: 'center', letterSpacing: '0.25rem', fontSize: '1.2rem' }} maxLength="6" required autoFocus />
                        </div>
                        <button className="login-element btn" type="submit" disabled={loading} style={{ width: '100%', padding: '0.75rem', justifyContent: 'center', fontWeight: 'bold', background: '#10b981', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                            {loading ? 'Verificando...' : 'Validar Token'}
                        </button>
                    </form>
                )}
            </div>
        </div>
    );
}
