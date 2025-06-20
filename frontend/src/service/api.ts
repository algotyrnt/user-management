import axios from "axios";
import type { newUser, User } from "../types/user";

const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL,
    headers: {
        'Content-Type': 'application/json'
    }
});

// Users API endpoints
export const userApi = {
    // Get user by user id
    getUserById: (id: number) => api.get<User>(`/users/${id}`),

    // Get all the users
    getUsers: () => api.get<User[]>(`/users`),

    // Search user by name
    searchUserByName: (name: string) => api.get<User[]>(`/users/search?name=${name}`),

    // Create a user
    createUser: (newUser: newUser) => api.post<User>(`/users`, newUser),

    // Update a user
    updateUser: (updatesUser: User) => api.put(`/users`, updatesUser),

    // Delete user by Id
    deleteUser: (id: number) => api.delete(`/users/${id}`)
};