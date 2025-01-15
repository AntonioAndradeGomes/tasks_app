import { HashService, HashServiceInterface } from "../HashService";

describe('HashService', () => {
    let hashService: HashServiceInterface;

    beforeEach(() => {
        hashService = new HashService();
    });

    describe('hash', () => {
        it('deve hashar uma senha corretamente', async () => {
            const password = 'any_password';
            const hashedPassword = await hashService.hash(password);
            expect(hashedPassword).not.toBe(password);
            // Verifica se o hash é gerado e tem um formato válido (começa com '$2a$')
            expect(hashedPassword).toMatch(/^\$2a\$/);
        });
    });

    describe('compare', () => {
        it('deve comparar uma senha corretamente', async () => {
            const password = 'any_password';
            const hashedPassword = await hashService.hash(password);
            const result = await hashService.compare(password, hashedPassword);
            expect(result).toBe(true);
        });

        it('deve retornar false se as senhas forem diferentes', async () => {
            const password = 'any_password';
            const wrongPassword = "wrongPassword";
            // Gera o hash da senha original
            const hashedPassword = await hashService.hash(password);
            // Compara a senha errada com o hash
            const isMatch = await hashService.compare(wrongPassword, hashedPassword);
            expect(isMatch).toBe(false); // A senha errada não deve coincidir com o hash
        });
    });
});
