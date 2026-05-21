import Navbar from "@/components/navbar/navbar";
import AccordionTasks from "@/components/task/accordion_tasks";
import TaskGrid from "@/components/task/task_grid";
import TaskDialog from "@/components/task/task_dialog";

import { Button } from "@/components/ui/button";
import { fakeTasks, type Task } from "@/lib/models";
import type { TaskFormData } from "@/schemas/task.schema";
import { Plus } from "lucide-react";
import { useState } from "react";

const HomePage = () => {
    const [dialogOpen, setDialogOpen] = useState(false);
    const [selectedTask, setSelectedTask] = useState<Task | undefined>();

    const pendingTasks = fakeTasks.filter((t) => !t.completed_at);
    const completedTasks = fakeTasks.filter((t) => !!t.completed_at);

    const handleCreate = () => {
        setSelectedTask(undefined);
        setDialogOpen(true);
    };

    const handleEdit = (task: Task) => {
        setSelectedTask(task);
        setDialogOpen(true);
    };

    const handleSubmit = (data: TaskFormData) => {
        if (selectedTask) {
            console.log("Editando:", { ...selectedTask, ...data });
        } else {
            console.log("Criando:", data);
        }
    };

    return (
        <>
            <Navbar />
            <div className="max-w-7xl mx-auto mt-10 mb-16 px-4 sm:px-6 lg:px-10 flex flex-col gap-6">
                <TaskGrid tasks={pendingTasks} onEdit={handleEdit} />
                {completedTasks.length > 0 && (
                    <AccordionTasks tasks={completedTasks} title="Concluídas" />
                )}
            </div>

            <Button
                onClick={handleCreate}
                size="icon"
                className="fixed bottom-6 right-6 w-14 h-14 rounded-full shadow-lg bg-blue-500"
                aria-label="Nova tarefa"
            >
                <Plus size={24} />
            </Button>
            <TaskDialog
                open={dialogOpen}
                onOpenChange={setDialogOpen}
                task={selectedTask}
                onSubmit={handleSubmit}
            />
        </>
    );
};

export default HomePage;
