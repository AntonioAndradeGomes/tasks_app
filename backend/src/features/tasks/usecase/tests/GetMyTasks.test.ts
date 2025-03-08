import { AppError } from '../../../../shared/errors/AppError';
import { TaskRepository } from '../../domain/interface/TaskRepository';
import { GetMyTasks } from '../GetMyTasks';

describe('GetMyTasks', () => {
    let getMyTasks: GetMyTasks;
    let mockTaskRepository: jest.Mocked<TaskRepository>;

    beforeEach(() => {
        // Mockando o repositório
        mockTaskRepository = {
            getTasksByUserId: jest.fn(),
            getTaskByUserIdAndTaskId: jest.fn(),
        } as unknown as jest.Mocked<TaskRepository>;

        // Instanciando o caso de uso
        getMyTasks = new GetMyTasks(mockTaskRepository);
    });

    it('deve retornar as tarefas de um usuário com sucesso', async () => {
        const userId = 'user-123';
        const mockTasks = [
            {
                id: 'task-1',
                title: 'Task 1',
                description: 'Description 1',
                hexColor: '#FF5733',
                user_id: userId,
                due_at: new Date(),
                completed_at: null,
            },
            {
                id: 'task-2',
                title: 'Task 2',
                description: 'Description 2',
                hexColor: '#33FF57',
                user_id: userId,
                due_at: new Date(),
                completed_at: null,
            },
        ];

        const expectedTasks = {
            tasks: mockTasks,
            filter: {
                orderBy: 'created_at',
                order: 'asc',
            },
        };

        // Mockando a resposta do repositório
        mockTaskRepository.getTasksByUserId.mockResolvedValue(expectedTasks);

        // Executando o caso de uso
        const tasks = await getMyTasks.execute({
            userId,
            orderBy: 'created_at',
            order: 'asc',
        });

        // Verificando o retorno
        expect(tasks).toEqual(expectedTasks);
    });

    it('deve retornar uma lista vazia se o usuário não tiver tarefas', async () => {
        const userId = 'user-123';

        const expectedTasks = {
            tasks: [],
            filter: {
                orderBy: 'created_at',
                order: 'asc',
            },
        };

        // Mockando o repositório para retornar uma lista vazia
        mockTaskRepository.getTasksByUserId.mockResolvedValue(expectedTasks);

        // Executando o caso de us
        const tasks = await getMyTasks.execute({ userId });

        // Verificando o retorno
        expect(tasks).toEqual(expectedTasks);
    });

    it('deve lançar um erro se o repositório lançar um erro', async () => {
        const userId = 'user-123';

        // Mockando o repositório para lançar um erro
        mockTaskRepository.getTasksByUserId.mockRejectedValue(
            new Error('Database error'),
        );

        // Verificando se o erro é lançado corretamente
        await expect(getMyTasks.execute({ userId })).rejects.toThrow(
            'Database error',
        );
    });

    it('deve retornar 404 se não encontrar a tarefa com taskId informado', async () => {
        mockTaskRepository.getTaskByUserIdAndTaskId.mockResolvedValue(null);

        const params = {
            userId: 'user-123',
            taskId: 'task-123',
        };

        await expect(getMyTasks.execute(params)).rejects.toThrow(AppError);
        await expect(getMyTasks.execute(params)).rejects.toThrow(
            'Task not found',
        );

        expect(
            mockTaskRepository.getTaskByUserIdAndTaskId,
        ).toHaveBeenCalledWith(params.userId, params.taskId);
    });

    it('deve retornar a tarefa com taskId informado', async () => {
        const task = {
            id: 'task-123',
            title: 'Task 1',
            description: 'Description 1',
            hexColor: '#FF0000',
            user_id: 'user-123',
            created_at: new Date(),
            updated_at: new Date(),
        };

        mockTaskRepository.getTaskByUserIdAndTaskId.mockResolvedValue(task);

        const params = {
            userId: 'user-123',
            taskId: 'task-123',
        };

        const result = await getMyTasks.execute(params);

        expect(result).toEqual(task);
    });
});
