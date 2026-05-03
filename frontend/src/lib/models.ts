export interface User {
    id: string;
    name: string;
    email: string;
    created_at: string;
    updated_at: string;
}

export interface Task {
    id: string;
    title: string;
    description?: string;
    hexColor: string;
    user_id: string;
    due_at?: string;
    completed_at?: string;
    created_at: string;
    updated_at: string;
}
