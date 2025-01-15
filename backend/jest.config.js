/** @type {import('ts-jest').JestConfigWithTsJest} **/
module.exports = {
    preset: "ts-jest", 
    testEnvironment: "node",
    transform: {
        "^.+\\.(ts|tsx)$": "ts-jest",  // Isso permite que o Jest entenda arquivos TypeScript
    },
    testMatch: [
        "**/?(*.)+(spec|test).ts",  // Arquivos de teste com sufixos .test.ts ou .spec.ts
    ],
    setupFilesAfterEnv: ["./src/jest.setup.ts"],
    
};
