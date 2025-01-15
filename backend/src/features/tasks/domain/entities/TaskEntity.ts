export interface TaskEntity {
    id?: string
    title: string
    description: string
    hexColor: string
    user_id: string
    due_at?: Date | null
    completed_at?: Date | null
    created_at?: Date | null
    updated_at?: Date | null

}
