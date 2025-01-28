import { PrismaClient } from '@prisma/client';
import { TaskRepository } from '../../../domain/interface/TaskRepository';
import { TaskRepositoryPrisma } from '../TaskRepositoryPrisma';

// Mock do Prisma Client
jest.mock('@prisma/client', () => {
    const mPrismaClient = {
        task: {
            findUnique: jest.fn(),
            create: jest.fn(),
            findMany: jest.fn(),
            delete: jest.fn(),
            update: jest.fn(),
        },
    };
    return { PrismaClient: jest.fn(() => mPrismaClient) };
});

describe('TaskRepositoryPrisma', () => {
    let repository: TaskRepository;
    let prisma: PrismaClient;

    beforeEach(() => {
        prisma = new PrismaClient();
        repository = new TaskRepositoryPrisma(prisma);
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    it('deve retornar uma tarefa por ID', async () => {
        const taskId = 'task123';
        const task = {
            id: taskId,
            title: 'Test Task',
            description: 'Test Description',
            hexColor: '#FF0000',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: null,
        };

        (prisma.task.findUnique as jest.Mock).mockResolvedValue(task);

        const result = await repository.getTaskById(taskId);

        expect(result).toEqual(task);
        expect(prisma.task.findUnique).toHaveBeenCalledWith({
            where: { id: taskId },
        });
    });

    it('deve criar uma nova tarefa', async () => {
        const task = {
            title: 'Test Task',
            description: 'Test Description',
            hexColor: '#FF0000',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: null,
        };

        const createdTask = {
            id: 'task123',
            ...task,
            created_at: new Date(),
            updated_at: new Date(),
        };

        (prisma.task.create as jest.Mock).mockResolvedValue(createdTask);

        const result = await repository.createTask(task);

        expect(result).toEqual(createdTask);
        expect(prisma.task.create).toHaveBeenCalledWith({ data: task });
    });

    it('deve retornar todas as tarefas', async () => {
        const tasks = [
            {
                id: 'task1',
                title: 'Task 1',
                description: 'Description 1',
                hexColor: '#FF0000',
                user_id: 'user123',
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id: 'task2',
                title: 'Task 2',
                description: 'Description 2',
                hexColor: '#00FF00',
                user_id: 'user456',
                created_at: new Date(),
                updated_at: new Date(),
            },
        ];

        (prisma.task.findMany as jest.Mock).mockResolvedValue(tasks);

        const result = await repository.getAllTasks();

        expect(result).toEqual(tasks);
        expect(prisma.task.findMany).toHaveBeenCalled();
    });

    it('deve retornar as tarefas de um usuário', async () => {
        const userId = 'user123';
        const tasks = [
            {
                id: 'task1',
                title: 'Task 1',
                description: 'Description 1',
                hexColor: '#FF0000',
                user_id: 'user123',
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id: 'task2',
                title: 'Task 2',
                description: 'Description 2',
                hexColor: '#00FF00',
                user_id: 'user123',
                created_at: new Date(),
                updated_at: new Date(),
            },
        ];

        (prisma.task.findMany as jest.Mock).mockResolvedValue(tasks);

        const result = await repository.getTasksByUserId(userId);

        expect(result).toEqual(tasks);
        expect(prisma.task.findMany).toHaveBeenCalledWith({
            where: { user_id: userId },
        });
    });

    it('deve atualizar uma tarefa', async () => {
        const task = {
            id: 'task123',
            title: 'Updated Task',
            description: 'Updated Description',
            hexColor: '#00FF00',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: null,
        };

        const updatedTask = {
            id: 'task123',
            title: 'Updated Task',
            description: 'Updated Description',
            hexColor: '#00FF00',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: new Date(),
            created_at: new Date(),
            updated_at: new Date(),
        };

        (prisma.task.update as jest.Mock).mockResolvedValue(updatedTask);

        const result = await repository.updateTask(task);

        expect(result).toEqual(updatedTask);
    });

    it('deve deletar uma tarefa', async () => {
        const taskId = 'task123';

        await repository.deleteTask(taskId);

        expect(prisma.task.delete).toHaveBeenCalledWith({
            where: { id: taskId },
        });
    });
});
