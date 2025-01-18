import { AppError } from "../../../../shared/errors/AppError";
import { TaskEntity } from "../../domain/entities/TaskEntity";
import { TaskRepository } from "../../domain/interface/TaskRepository";
import { UpdateTask } from "../UpdateTask";


describe("UpdateTask", () => {
    let updateTask: UpdateTask;
    let mockTaskRepository: jest.Mocked<TaskRepository>;

    beforeEach(() => {
        // Mockando o repositório
        mockTaskRepository = {
        getTaskById: jest.fn(),
        updateTask: jest.fn(),
        } as unknown as jest.Mocked<TaskRepository>;

        // Instanciando o caso de uso
        updateTask = new UpdateTask(mockTaskRepository);
    });

    it("deve atualizar uma tarefa com sucesso", async () => {
        const userId = "user-123";
        const taskId = "task-456";
        const existingTask: TaskEntity = {
        id: taskId,
        title: "Old Title",
        description: "Old Description",
        hexColor: "#FFFFFF",
        user_id: userId,
        due_at: new Date(),
        completed_at: null,
        };
        const updateData = {
        title: "New Title",
        description: "New Description",
        };
        const updatedTask = {
        ...existingTask,
        ...updateData,
        };

        // Mockando as respostas do repositório
        mockTaskRepository.getTaskById.mockResolvedValue(existingTask);
        mockTaskRepository.updateTask.mockResolvedValue(updatedTask);

        // Executando o caso de uso
        const result = await updateTask.execute(userId, taskId, updateData);

        // Verificando o resultado
        expect(result).toEqual(updatedTask);
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.updateTask).toHaveBeenCalledWith(updatedTask);
    });

    it("deve lançar um erro se a tarefa não for encontrada", async () => {
        const userId = "user-123";
        const taskId = "task-456";
        const updateData = {
        title: "New Title",
        };

        // Mockando para retornar null
        mockTaskRepository.getTaskById.mockResolvedValue(null);

        // Verificando se o erro é lançado
        await expect(updateTask.execute(userId, taskId, updateData)).rejects.toThrow(
        new AppError("Task not found", 404)
        );
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.updateTask).not.toHaveBeenCalled();
    });

    it("deve lançar um erro se o usuário não tiver permissão para atualizar a tarefa", async () => {
        const userId = "user-123";
        const taskId = "task-456";
        const existingTask: TaskEntity = {
        id: taskId,
        title: "Old Title",
        description: "Old Description",
        hexColor: "#FFFFFF",
        user_id: "different-user",
        due_at: new Date(),
        completed_at: null,
        };
        const updateData = {
        title: "New Title",
        };

        // Mockando a tarefa
        mockTaskRepository.getTaskById.mockResolvedValue(existingTask);

        // Verificando se o erro é lançado
        await expect(updateTask.execute(userId, taskId, updateData)).rejects.toThrow(
        new AppError("You are not authorized to update this task", 403)
        );
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.updateTask).not.toHaveBeenCalled();
    });
});
