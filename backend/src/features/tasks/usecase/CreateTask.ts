import { inject, injectable } from "tsyringe";
import { TaskRepository } from "../domain/interface/TaskRepository";

interface TaskRequest{
    title: string;
    description: string;
    hexColor: string;
    user_id: string;
    due_at: Date | null;
    completed_at: Date | null;
}

@injectable()
export class CreateTask {
    constructor(
      @inject("TaskRepository")   private taskRepository: TaskRepository,
    ){}

    async execute(input: TaskRequest) {
        return this.taskRepository.createTask(input);
    }
}
