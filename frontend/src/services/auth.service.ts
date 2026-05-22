import type { User } from "@/lib/models";
import type { LoginFormData } from "@/schemas/login.schema";
import type { SignupFormData } from "@/schemas/signup.schema";
import { useAuthStore } from "@/stores/auth.store";
import { api } from "./api";

interface AuthResponse {
    token: string;
    user: User;
}

const authService = {
    async register(data: SignupFormData): Promise<AuthResponse> {
        const response = await api.post<AuthResponse>("/auth/signup", {
            name: data.name,
            email: data.email,
            password: data.password,
        });
        useAuthStore.getState().setAuth(response.user, response.token);
        return response;
    },

    async login(data: LoginFormData): Promise<AuthResponse> {
        const response = await api.post<AuthResponse>("/auth/login", data);
        useAuthStore.getState().setAuth(response.user, response.token);
        return response;
    },

    async getMe(): Promise<User> {
        return api.get<User>("/auth/me");
    },

    logout(): void {
        useAuthStore.getState().clearAuth();
    },
};

export default authService;
