import { AppError } from "../../../../shared/errors/AppError";
import { TaskRepository } from "../../domain/interface/TaskRepository";
import { DeleteTask } from "../DeleteTask";

describe('DeleteTask', () => {
    let deleteTask: DeleteTask;
    let mockTaskRepository: jest.Mocked<TaskRepository>;

    beforeEach(() => {
        // Mockando o repositório
        mockTaskRepository = {
            getTaskById: jest.fn(),
            deleteTask: jest.fn(),
        } as unknown as jest.Mocked<TaskRepository>;

        // Instanciando o caso de uso
        deleteTask = new DeleteTask(mockTaskRepository);
    });

    it('deve deletar uma tarefa', async () => {
        const taskId = 'task123';
        const userId = 'user123';

        const mockTask = {
            id: taskId,
            user_id: userId,
            title: "Test Task",
            description: "This is a test task",
            hexColor: "#FF5733",
            due_at: new Date(),
            completed_at: null,
        };

        mockTaskRepository.getTaskById.mockResolvedValue(mockTask);
        mockTaskRepository.deleteTask.mockResolvedValue();

        await deleteTask.execute(taskId, userId);

        // Verificando se os métodos foram chamados corretamente
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.deleteTask).toHaveBeenCalledWith(taskId);
    });


    it('deve lançar um erro se a tarefa não for encontrada', async () => {
        const taskId = "task-123";
        const userId = "user-123";

        // Mockando a tarefa como inexistente
        mockTaskRepository.getTaskById.mockResolvedValue(null);

        // Executando o caso de uso e verificando o erro
        await expect(deleteTask.execute(taskId, userId)).rejects.toThrow(AppError);
        await expect(deleteTask.execute(taskId, userId)).rejects.toThrow("Task not found");

        // Verificando se o método `getTaskById` foi chamado
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.deleteTask).not.toHaveBeenCalled();
    });

    it('deve lançar um erro se o user nao for autorizado', async () => {
        const taskId = "task-123";
        const userId = "user-123";
        const anotherUserId = "user-456";

        // Mockando a tarefa existente com outro usuário
        const mockTask = {
            id: taskId,
            user_id: anotherUserId,
            title: "Test Task",
            description: "This is a test task",
            hexColor: "#FF5733",
            due_at: new Date(),
            completed_at: null,
        };

        mockTaskRepository.getTaskById.mockResolvedValue(mockTask);

        // Executando o caso de uso e verificando o erro
        await expect(deleteTask.execute(taskId, userId)).rejects.toThrow(AppError);
        await expect(deleteTask.execute(taskId, userId)).rejects.toThrow("You are not authorized to delete this task");

        // Verificando se o método `getTaskById` foi chamado
        expect(mockTaskRepository.getTaskById).toHaveBeenCalledWith(taskId);
        expect(mockTaskRepository.deleteTask).not.toHaveBeenCalled();
    })
})
