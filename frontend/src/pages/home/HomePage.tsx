import Navbar from "@/components/navbar/navbar";
import TaskCardItem from "@/components/task/task_card_item";
import type { Task } from "@/lib/models";

const fakeTasks: Task[] = [
    {
        id: "1",
        title: "Comprar mantimentos",
        description: "Leite, ovos, pão e frutas",
        hexColor: "#3b82f6",
        user_id: "user-1",
        due_at: "2026-05-05T18:00:00.000Z",
        created_at: "2026-05-01T10:00:00.000Z",
        updated_at: "2026-05-01T10:00:00.000Z",
    },
    {
        id: "2",
        title: "Revisar pull request",
        description: "PR do módulo de autenticação",
        hexColor: "#8b5cf6",
        user_id: "user-1",
        completed_at: "2026-05-02T09:00:00.000Z",
        created_at: "2026-05-01T08:00:00.000Z",
        updated_at: "2026-05-02T09:00:00.000Z",
    },
    {
        id: "3",
        title: "Reunião com o time",
        hexColor: "#f59e0b",
        user_id: "user-1",
        due_at: "2026-05-03T14:00:00.000Z",
        created_at: "2026-05-01T07:00:00.000Z",
        updated_at: "2026-05-01T07:00:00.000Z",
    },
    {
        id: "4",
        title: "Estudar TypeScript",
        description: "Generics e utility types",
        hexColor: "#10b981",
        user_id: "user-1",
        created_at: "2026-04-30T20:00:00.000Z",
        updated_at: "2026-04-30T20:00:00.000Z",
    },
    {
        id: "5",
        title: "Fazer deploy do backend",
        description: "Subir nova versão para produção",
        hexColor: "#ef4444",
        user_id: "user-1",
        due_at: "2026-05-04T12:00:00.000Z",
        created_at: "2026-05-01T11:00:00.000Z",
        updated_at: "2026-05-01T11:00:00.000Z",
    },
    {
        id: "1",
        title: "Comprar mantimentos",
        description: "Leite, ovos, pão e frutas",
        hexColor: "#3b82f6",
        user_id: "user-1",
        due_at: "2026-05-05T18:00:00.000Z",
        created_at: "2026-05-01T10:00:00.000Z",
        updated_at: "2026-05-01T10:00:00.000Z",
    },
    {
        id: "2",
        title: "Revisar pull request",
        description: "PR do módulo de autenticação",
        hexColor: "#8b5cf6",
        user_id: "user-1",
        completed_at: "2026-05-02T09:00:00.000Z",
        created_at: "2026-05-01T08:00:00.000Z",
        updated_at: "2026-05-02T09:00:00.000Z",
    },
    {
        id: "3",
        title: "Reunião com o time",
        hexColor: "#f59e0b",
        user_id: "user-1",
        due_at: "2026-05-03T14:00:00.000Z",
        created_at: "2026-05-01T07:00:00.000Z",
        updated_at: "2026-05-01T07:00:00.000Z",
    },
    {
        id: "4",
        title: "Estudar TypeScript",
        description: "Generics e utility types",
        hexColor: "#10b981",
        user_id: "user-1",
        created_at: "2026-04-30T20:00:00.000Z",
        updated_at: "2026-04-30T20:00:00.000Z",
    },
    {
        id: "5",
        title: "Fazer deploy do backend",
        description: "Subir nova versão para produção",
        hexColor: "#ef4444",
        user_id: "user-1",
        due_at: "2026-05-04T12:00:00.000Z",
        created_at: "2026-05-01T11:00:00.000Z",
        updated_at: "2026-05-01T11:00:00.000Z",
    },
    {
        id: "1",
        title: "Comprar mantimentos",
        description: "Leite, ovos, pão e frutas",
        hexColor: "#3b82f6",
        user_id: "user-1",
        due_at: "2026-05-05T18:00:00.000Z",
        created_at: "2026-05-01T10:00:00.000Z",
        updated_at: "2026-05-01T10:00:00.000Z",
    },
    {
        id: "2",
        title: "Revisar pull request",
        description: "PR do módulo de autenticação",
        hexColor: "#8b5cf6",
        user_id: "user-1",
        completed_at: "2026-05-02T09:00:00.000Z",
        created_at: "2026-05-01T08:00:00.000Z",
        updated_at: "2026-05-02T09:00:00.000Z",
    },
    {
        id: "3",
        title: "Reunião com o time",
        hexColor: "#f59e0b",
        user_id: "user-1",
        due_at: "2026-05-03T14:00:00.000Z",
        created_at: "2026-05-01T07:00:00.000Z",
        updated_at: "2026-05-01T07:00:00.000Z",
    },
    {
        id: "4",
        title: "Estudar TypeScript",
        description: "Generics e utility types",
        hexColor: "#10b981",
        user_id: "user-1",
        created_at: "2026-04-30T20:00:00.000Z",
        updated_at: "2026-04-30T20:00:00.000Z",
    },
    {
        id: "5",
        title: "Fazer deploy do backend",
        description: "Subir nova versão para produção",
        hexColor: "#ef4444",
        user_id: "user-1",
        due_at: "2026-05-04T12:00:00.000Z",
        created_at: "2026-05-01T11:00:00.000Z",
        updated_at: "2026-05-01T11:00:00.000Z",
    },
];

const HomePage = () => {
    return (
        <>
            <Navbar />
            <div className="max-w-7xl mx-auto mt-10 px-4 sm:px-6 lg:px-10">
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
                    {fakeTasks.map((task) => (
                        <TaskCardItem key={task.id} task={task} />
                    ))}
                </div>
            </div>
        </>
    );
};

export default HomePage;
