import { TaskRepository } from "../../domain/interface/TaskRepository";
import { GetMyTasks } from "../GetMyTasks";

describe('GetMyTasks', () => {
    let getMyTasks: GetMyTasks;
    let mockTaskRepository: jest.Mocked<TaskRepository>;

    beforeEach(() => {
        // Mockando o repositório
        mockTaskRepository = {
        getTasksByUserId: jest.fn(),
        } as unknown as jest.Mocked<TaskRepository>;

        // Instanciando o caso de uso
        getMyTasks = new GetMyTasks(mockTaskRepository);
    });

    it("deve retornar as tarefas de um usuário com sucesso", async () => {
        const userId = "user-123";
        const mockTasks = [
        {
            id: "task-1",
            title: "Task 1",
            description: "Description 1",
            hexColor: "#FF5733",
            user_id: userId,
            due_at: new Date(),
            completed_at: null,
        },
        {
            id: "task-2",
            title: "Task 2",
            description: "Description 2",
            hexColor: "#33FF57",
            user_id: userId,
            due_at: new Date(),
            completed_at: null,
        },
        ];

        // Mockando a resposta do repositório
        mockTaskRepository.getTasksByUserId.mockResolvedValue(mockTasks);

        // Executando o caso de uso
        const tasks = await getMyTasks.execute(userId);

        // Verificando o retorno
        expect(tasks).toEqual(mockTasks);
        expect(mockTaskRepository.getTasksByUserId).toHaveBeenCalledWith(userId);
    });

    it("deve retornar uma lista vazia se o usuário não tiver tarefas", async () => {
        const userId = "user-123";
    
        // Mockando o repositório para retornar uma lista vazia
        mockTaskRepository.getTasksByUserId.mockResolvedValue([]);
    
        // Executando o caso de uso
        const tasks = await getMyTasks.execute(userId);
    
        // Verificando o retorno
        expect(tasks).toEqual([]);
        expect(mockTaskRepository.getTasksByUserId).toHaveBeenCalledWith(userId);
    });

    it("deve lançar um erro se o repositório lançar um erro", async () => {
        const userId = "user-123";
    
        // Mockando o repositório para lançar um erro
        mockTaskRepository.getTasksByUserId.mockRejectedValue(new Error("Database error"));
    
        // Verificando se o erro é lançado corretamente
        await expect(getMyTasks.execute(userId)).rejects.toThrow("Database error");
        expect(mockTaskRepository.getTasksByUserId).toHaveBeenCalledWith(userId);
    });
});
