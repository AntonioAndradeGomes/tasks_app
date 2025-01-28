import { inject, injectable } from 'tsyringe';
import { GetUser } from '../../use-cases/GetUser';
import { LoginUser } from '../../use-cases/LoginUser';
import { Request, Response } from 'express';
import { VerifyToken } from '../../use-cases/VerifyToken';
import { AuthRequest } from '../../../../shared/middlewares/auth.middleware';
import { AppError } from '../../../../shared/errors/AppError';
import { SignupUser } from '../../use-cases/SignupUser';

@injectable()
export class AuthController {
    constructor(
        @inject('SignupUser') private signupUser: SignupUser,
        @inject('LoginUser') private loginUser: LoginUser,
        @inject('VerifyToken') private verifyToken: VerifyToken,
        @inject('GetUser') private getUser: GetUser,
    ) {}

    async signup(req: Request, res: Response) {
        const { name, email, password } = req.body;
        const user = await this.signupUser.execute({ name, email, password });
        res.status(201).json(user);
    }

    async login(req: Request, res: Response) {
        const { email, password } = req.body;
        const result = await this.loginUser.execute({ email, password });
        res.status(201).json(result);
    }

    async verifyTokenFunction(req: Request, res: Response): Promise<void> {
        const token = req.header('x-auth-token');
        if (!token) {
            throw new AppError('No auth token, access denied!', 401);
        }
        await this.verifyToken.execute(token);
        res.status(200).json({ message: 'Token is valid' });
    }

    async getLoggedInUser(req: AuthRequest, res: Response) {
        const id = req.user as string;
        const user = await this.getUser.execute(id);
        res.status(200).json(user);
    }
}
