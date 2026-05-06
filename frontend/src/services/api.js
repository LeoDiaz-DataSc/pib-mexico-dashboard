import axios from 'axios';

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL || 'http://localhost:3000/api',
    timeout: 10000,
});

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
