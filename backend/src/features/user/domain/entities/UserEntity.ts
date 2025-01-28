export interface UserEntity {
    id?: string;
    name: string;
    email: string;
    password: string;
    created_at?: Date | null;
    updated_at?: Date | null;
}
