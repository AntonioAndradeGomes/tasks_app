import { Router } from 'express';
import { AuthController } from '../controllers/AuthController';
import { container } from 'tsyringe';
import { authMiddleware } from '../../../../shared/middlewares/auth.middleware';
import {
    loginUserValidator,
    signupUserValidator,
} from '../validators/UserValidators';

const authRouter = Router();
const authController = container.resolve<AuthController>('AuthController');

authRouter.post('/signup', signupUserValidator, async (req, res) =>
    authController.signup(req, res),
);
authRouter.post('/login', loginUserValidator, async (req, res) =>
    authController.login(req, res),
);
authRouter.post('/tokenIsValid', async (req, res) =>
    authController.verifyTokenFunction(req, res),
);
authRouter.get('/me', authMiddleware, async (req, res) =>
    authController.getLoggedInUser(req, res),
);

export { authRouter };
