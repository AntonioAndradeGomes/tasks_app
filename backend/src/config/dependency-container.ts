import {container} from "tsyringe";
import { UserRepository } from "../features/user/domain/interfaces/UserRepository";
import { PrismaClient } from "@prisma/client";
import { HashService, HashServiceInterface } from "../features/user/infrastructure/services/HashService";
import { JWTService, JWTServiceInterface } from "../features/user/infrastructure/services/JWTService";
import { GetUser } from "../features/user/use-cases/GetUser";
import { AuthController } from "../features/user/interface/controllers/AuthController";
import { UserRepositoryPrisma } from "../features/user/infrastructure/repositories/UserRepositoryPrisma";
import { SignupUser } from "../features/user/use-cases/SignupUser";
import { LoginUser } from "../features/user/use-cases/LoginUser";
import { VerifyToken } from "../features/user/use-cases/VerifyToken";
import { TaskRepository } from "../features/tasks/domain/interface/TaskRepository";
import { TaskRepositoryPrisma } from "../features/tasks/infrastructure/repositories/TaskRepositoryPrisma";
import { CreateTask } from "../features/tasks/usecase/CreateTask";
import { TasksController } from "../features/tasks/intreface/controllers/TasksController";
import { GetMyTasks } from "../features/tasks/usecase/GetMyTasks";
import { DeleteTask } from "../features/tasks/usecase/DeleteTask";


// Registra PrismaClient
container.register<PrismaClient>('PrismaClient', {
    useFactory: () => new PrismaClient()
});

// Registra as dependências referentes ao user
container.registerSingleton<UserRepository>('UserRepository', UserRepositoryPrisma);
container.registerSingleton<HashServiceInterface>('HashService', HashService);
container.registerSingleton<JWTServiceInterface>('JWTService', JWTService);
container.registerSingleton<SignupUser>('SignupUser', SignupUser);
container.registerSingleton<LoginUser>('LoginUser', LoginUser);
container.registerSingleton<VerifyToken>('VerifyToken', VerifyToken);
container.registerSingleton<GetUser>('GetUser', GetUser);
container.registerSingleton<AuthController>('AuthController', AuthController);

container.registerSingleton<TaskRepository>('TaskRepository', TaskRepositoryPrisma);
container.registerSingleton<CreateTask>('CreateTask', CreateTask);
container.registerSingleton<GetMyTasks>('GetMyTasks', GetMyTasks);
container.registerSingleton<DeleteTask>('DeleteTask', DeleteTask);
container.registerSingleton<TasksController>('TasksController', TasksController);
