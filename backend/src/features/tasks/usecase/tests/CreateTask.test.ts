import { TaskRepository } from '../../domain/interface/TaskRepository';
import { CreateTask } from '../CreateTask';

describe('CreateTask', () => {
    const taskRepository = {
        createTask: jest.fn(),
    } as unknown as jest.Mocked<TaskRepository>;

    const createTask = new CreateTask(taskRepository);

    it('deve criar uma nova tarefa', async () => {
        const task = {
            title: 'Test Task',
            description: 'Test Description',
            hexColor: '#FF0000',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: null,
        };

        taskRepository.createTask.mockResolvedValue(task);

        const result = await createTask.execute(task);

        expect(result).toEqual(task);
        expect(taskRepository.createTask).toHaveBeenCalledWith(task);
    });

    it('deve lançar um erro se o repositório falhar', async () => {
        const task = {
            title: 'Test Task',
            description: 'Test Description',
            hexColor: '#FF0000',
            user_id: 'user123',
            due_at: new Date(),
            completed_at: null,
        };

        taskRepository.createTask.mockRejectedValue(
            new Error('Failed to create task'),
        );

        await expect(createTask.execute(task)).rejects.toThrow(
            'Failed to create task',
        );

        expect(taskRepository.createTask).toHaveBeenCalledWith(task);
    });
});
