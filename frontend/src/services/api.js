import axios from 'axios';

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL || 'http://localhost:3000/api',
    timeout: 10000,
});

// Interceptor para inyectar el Token JWT en todas las peticiones
api.interceptors.request.use((config) => {
    const token = localStorage.getItem('inegi_token');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

export const login = async (username, password) => {
    const response = await api.post('/auth/login', { username, password });
    if (response.data.success && response.data.token) {
        localStorage.setItem('inegi_token', response.data.token);
    }
    return response.data;
};

export const verifyMFA = async (user_id, token) => {
    const response = await api.post('/auth/mfa/verify', { user_id, token });
    if (response.data.success && response.data.token) {
        localStorage.setItem('inegi_token', response.data.token);
    }
    return response.data;
};

export const logout = () => {
    localStorage.removeItem('inegi_token');
};

export const getSectors = async () => {
    const response = await api.get('/sectors');
    return response.data;
};

export const getSeries = async () => {
    const response = await api.get('/series');
    return response.data;
};

export const getEconomicData = async (params) => {
    const response = await api.get('/economic-data', { params });
    return response.data;
};

export default api;
