import { TaskEntity } from '../entities/TaskEntity';

export interface TaskRepository {
    createTask(task: TaskEntity): Promise<TaskEntity>;
    getTasksByUserId(
        userId: string,
        orderBy: string | undefined,
        order: string | undefined,
    ): Promise<TaskEntity[]>;
    getTaskByUserIdAndTaskId(
        userId: string,
        taskId: string,
    ): Promise<TaskEntity | null>;
    updateTask(task: TaskEntity): Promise<TaskEntity>;
    deleteTask(taskId: string): Promise<void>;
    getAllTasks(): Promise<TaskEntity[]>;
    getTaskById(taskId: string): Promise<TaskEntity | null>;
}
