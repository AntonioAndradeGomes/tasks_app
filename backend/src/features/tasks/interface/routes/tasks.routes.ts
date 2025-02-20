import { Router } from 'express';
import { authMiddleware } from '../../../../shared/middlewares/auth.middleware';
import {
    createTaskValidator,
    deleteTaskValidator,
    getTaskByIdValidator,
    updateTaskValidator,
} from '../validators/TaskValidators';
import { container } from 'tsyringe';
import { TasksController } from '../controllers/TasksController';

const taskRoutes = Router();

const controller = container.resolve<TasksController>('TasksController');

taskRoutes.post('/', authMiddleware, createTaskValidator, async (req, res) =>
    controller.createTask(req, res),
);
taskRoutes.get('/', authMiddleware, getTaskByIdValidator, async (req, res) =>
    controller.getMyTasks(req, res),
);
taskRoutes.delete(
    '/:id',
    authMiddleware,
    deleteTaskValidator,
    async (req, res) => controller.deleteTask(req, res),
);
taskRoutes.put('/:id', authMiddleware, updateTaskValidator, async (req, res) =>
    controller.updateTask(req, res),
);

export { taskRoutes };
