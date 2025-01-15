
import { Request, Response, NextFunction } from "express";
import { JWTServiceInterface } from "../../features/user/infrastructure/services/JWTService";
import { container } from "tsyringe";
import { UserRepository } from "../../features/user/domain/interfaces/UserRepository";

export interface AuthRequest extends Request {
    user?: string;
    token?: string;
}

export const authMiddleware = async(req: AuthRequest, res: Response, next: NextFunction) => {
    const token = req.header("x-auth-token");
    if(!token){
        res.status(401).json({message: "No auth token, access denied!"});
        return;
    }
    const jwtService = container.resolve<JWTServiceInterface>('JWTService');
    const verified = jwtService.verify(token);
    if(!verified){            
        res.status(401).json({message: "Token is not valid!"});
        return;
    }
    const userRepository = container.resolve<UserRepository>('UserRepository');
    const user = await userRepository.findById(verified);
    if(!user){
        res.status(401).json({message: "User not found!"});
        return;
    }
    req.user = verified;
    req.token = token;
    next();
}
