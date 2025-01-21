import { inject, injectable } from "tsyringe";
import { TaskRepository } from "../domain/interface/TaskRepository";
import { AppError } from "../../../shared/errors/AppError";

@injectable()
export class GetMyTasks {
    constructor(
        @inject("TaskRepository")   private taskRepository: TaskRepository,
    ){}
    async execute(userId: string, taskId?: string) {
        if(!taskId){
            return this.taskRepository.getTasksByUserId(userId);
        }

        const  task = await this.taskRepository.getTaskByUserIdAndTaskId(userId, taskId);
        if(!task){
            throw new AppError("Task not found", 404);
        }
        return task;
    }
}  
