import { inject, injectable } from "tsyringe";
import { AppError } from "../../../shared/errors/AppError";
import { TaskRepository } from "../domain/interface/TaskRepository";

@injectable()
export class DeleteTask {
    constructor(
        @inject("TaskRepository") private taskRepository: TaskRepository
    ){}

    async execute(taskId: string, userId: string) {
        const task = await this.taskRepository.getTaskById(taskId);
        if(!task){
            throw new AppError("Task not found", 404);
        }

        if(task.user_id !== userId){
            throw new AppError("You are not authorized to delete this task", 403);
        }
        await this.taskRepository.deleteTask(taskId);
        return;
    }
}
