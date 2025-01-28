import bcrypt from 'bcryptjs';
import { injectable } from 'tsyringe';

export interface HashServiceInterface {
    hash(password: string): Promise<string>;
    compare(password: string, hash: string): Promise<boolean>;
}

@injectable()
export class HashService implements HashServiceInterface {
    async hash(password: string): Promise<string> {
        return bcrypt.hash(password, 8);
    }

    async compare(password: string, hash: string): Promise<boolean> {
        return bcrypt.compare(password, hash);
    }
}
