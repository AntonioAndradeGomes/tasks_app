import 'reflect-metadata';
import './config/dependency-container';
import express from 'express';
import 'express-async-errors';
import 'dotenv/config';
import { authRouter } from './features/user/interface/routes/auth.routes';
import { errorHandler } from './shared/middlewares/error.middleware';
import { taskRoutes } from './features/tasks/interface/routes/tasks.routes';
import swaggerUi from 'swagger-ui-express';
import swaggerJsDoc from 'swagger-jsdoc';

const app = express();

const swaggerOptions = {
    swaggerDefinition: {
        openapi: '3.0.0',
        info: {
            title: 'Task Manager API',
            version: '1.0.0',
            description: 'API documentation for the Task Manager application',
        },
        servers: [
            {
                url: 'http://localhost:8000',
                description: 'Development server',
            },
        ],
    },
    apis: ['./src/features/**/*.ts'],
};

app.use(express.urlencoded({ extended: true }));

const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));


app.use(express.json());
app.use('/auth', authRouter);
app.use('/tasks', taskRoutes);
app.use(errorHandler);

const PORT = process.env.PORT || 8000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}!`);
});


