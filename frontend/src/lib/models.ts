export interface User {
    id: string;
    name: string;
    email: string;
    created_at: string;
    updated_at: string;
}

export interface Task {
    id: string;
    title: string;
    description?: string;
    hexColor: string;
    user_id: string;
    due_at?: string;
    completed_at?: string;
    created_at: string;
    updated_at: string;
}

export const fakeTasks: Task[] = [
    {
        id: "1",
        title: "Comprar mantimentos",
        description: "Leite, ovos, pão e frutas",
        hexColor: "#4682B4",
        user_id: "user-1",
        due_at: "2026-05-05T18:00:00.000Z",
        created_at: "2026-05-01T10:00:00.000Z",
        updated_at: "2026-05-01T10:00:00.000Z",
    },
    {
        id: "2",
        title: "Revisar pull request",
        description: "PR do módulo de autenticação",
        hexColor: "#7B68EE",
        user_id: "user-1",
        completed_at: "2026-05-02T09:00:00.000Z",
        created_at: "2026-05-01T08:00:00.000Z",
        updated_at: "2026-05-02T09:00:00.000Z",
    },
    {
        id: "3",
        title: "Reunião com o time",
        hexColor: "#FF8C00",
        user_id: "user-1",
        due_at: "2026-05-03T14:00:00.000Z",
        created_at: "2026-05-01T07:00:00.000Z",
        updated_at: "2026-05-01T07:00:00.000Z",
    },
    {
        id: "4",
        title: "Estudar TypeScript",
        description: "Generics e utility types",
        hexColor: "#228B22",
        user_id: "user-1",
        created_at: "2026-04-30T20:00:00.000Z",
        updated_at: "2026-04-30T20:00:00.000Z",
    },
    {
        id: "5",
        title: "Fazer deploy do backend",
        description: "Subir nova versão para produção",
        hexColor: "#B22222",
        user_id: "user-1",
        due_at: "2026-05-04T12:00:00.000Z",
        created_at: "2026-05-01T11:00:00.000Z",
        updated_at: "2026-05-01T11:00:00.000Z",
    },
    {
        id: "6",
        title: "Atualizar documentação",
        description: "README e endpoints da API",
        hexColor: "#008B8B",
        user_id: "user-1",
        due_at: "2026-05-06T10:00:00.000Z",
        created_at: "2026-05-01T12:00:00.000Z",
        updated_at: "2026-05-01T12:00:00.000Z",
    },
    {
        id: "7",
        title: "Revisar testes unitários",
        description: "Cobertura mínima de 80%",
        hexColor: "#6A5ACD",
        user_id: "user-1",
        completed_at: "2026-05-01T15:00:00.000Z",
        created_at: "2026-04-30T09:00:00.000Z",
        updated_at: "2026-05-01T15:00:00.000Z",
    },
    {
        id: "8",
        title: "Configurar CI/CD",
        description: "Pipeline no GitHub Actions",
        hexColor: "#4169E1",
        user_id: "user-1",
        due_at: "2026-05-07T12:00:00.000Z",
        created_at: "2026-05-01T13:00:00.000Z",
        updated_at: "2026-05-01T13:00:00.000Z",
    },
    {
        id: "9",
        title: "Design da landing page",
        description: "Criar mockup no Figma",
        hexColor: "#FF7F50",
        user_id: "user-1",
        due_at: "2026-05-08T17:00:00.000Z",
        created_at: "2026-05-01T14:00:00.000Z",
        updated_at: "2026-05-01T14:00:00.000Z",
    },
    {
        id: "10",
        title: "Otimizar queries do banco",
        description: "Índices nas tabelas principais",
        hexColor: "#6B8E23",
        user_id: "user-1",
        created_at: "2026-05-01T15:00:00.000Z",
        updated_at: "2026-05-01T15:00:00.000Z",
    },
    {
        id: "11",
        title: "Implementar autenticação OAuth",
        description: "Login com Google e GitHub",
        hexColor: "#8A2BE2",
        user_id: "user-1",
        due_at: "2026-05-09T10:00:00.000Z",
        created_at: "2026-05-01T16:00:00.000Z",
        updated_at: "2026-05-01T16:00:00.000Z",
    },
    {
        id: "12",
        title: "Monitoramento com Sentry",
        hexColor: "#FF4500",
        user_id: "user-1",
        completed_at: "2026-05-02T11:00:00.000Z",
        created_at: "2026-05-01T17:00:00.000Z",
        updated_at: "2026-05-02T11:00:00.000Z",
    },
    {
        id: "13",
        title: "Migração para PostgreSQL",
        description: "Migrar dados do SQLite",
        hexColor: "#BDB76B",
        user_id: "user-1",
        due_at: "2026-05-10T09:00:00.000Z",
        created_at: "2026-05-01T18:00:00.000Z",
        updated_at: "2026-05-01T18:00:00.000Z",
    },
    {
        id: "14",
        title: "Code review geral",
        description: "Revisar PRs pendentes do time",
        hexColor: "#4B0082",
        user_id: "user-1",
        due_at: "2026-05-05T16:00:00.000Z",
        created_at: "2026-05-01T19:00:00.000Z",
        updated_at: "2026-05-01T19:00:00.000Z",
    },
    {
        id: "15",
        title: "Refatorar módulo de pagamento",
        description: "Separar responsabilidades",
        hexColor: "#8B4512",
        user_id: "user-1",
        created_at: "2026-05-01T20:00:00.000Z",
        updated_at: "2026-05-01T20:00:00.000Z",
    },
];
