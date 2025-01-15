import { inject, injectable } from "tsyringe";
import { TaskRepository } from "../domain/interface/TaskRepository";

@injectable()
export class GetMyTasks {
    constructor(
        @inject("TaskRepository")   private taskRepository: TaskRepository,
    ){}
  
    async execute(userId: string) {
        return this.taskRepository.getTasksByUserId(userId);
    }
}  
