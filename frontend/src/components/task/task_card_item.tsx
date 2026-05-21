import type { Task } from "@/lib/models";
import { Card, CardContent } from "../ui/card";

import { Trash } from "lucide-react";

interface TaskCardItemProps {
    task: Task;
    onToggleComplete?: (task: Task) => void;
    onEdit?: (task: Task) => void;
    onRemove?: (task: Task) => void;
}

const TaskCardItem = ({
    task,
    onToggleComplete,
    onEdit,
    onRemove,
}: TaskCardItemProps) => {
    const isCompleted = !!task.completed_at;

    return (
        <Card
            onClick={() => onEdit?.(task)}
            className="cursor-pointer hover:shadow-md transition-shadow py-3"
            style={{
                background: `${task.hexColor}`,
            }}
        >
            <CardContent className="flex items-start gap-3 px-3">
                <button
                    type="button"
                    onClick={(e) => {
                        e.stopPropagation();
                        onToggleComplete?.(task);
                    }}
                    className="mt-0.5 shrink-0 w-5 h-5 rounded-full border-2 flex items-center justify-center transition-colors"
                    style={{
                        borderColor: "white",
                        backgroundColor: isCompleted ? "white" : "transparent",
                    }}
                >
                    {isCompleted && (
                        <svg
                            className="w-3 h-3"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                            strokeWidth={3}
                            style={{
                                color: `${task.hexColor}`,
                            }}
                        >
                            <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                d="M5 13l4 4L19 7"
                            />
                        </svg>
                    )}
                </button>

                <div className="flex-1 min-w-0">
                    <p
                        className={`font-medium line-clamp-2 ${isCompleted ? "line-through text-white" : "text-white"}`}
                    >
                        {task.title}
                    </p>
                    {task.description && (
                        <p className="text-sm line-clamp-2 text-white">
                            {task.description}
                        </p>
                    )}
                    {task.due_at && !isCompleted && (
                        <p className="text-xs text-gray-100 mt-1">
                            Prazo:{" "}
                            {new Date(task.due_at).toLocaleDateString("pt-BR")}
                        </p>
                    )}
                </div>
                <button
                    type="button"
                    onClick={(e) => {
                        e.stopPropagation();
                        onRemove?.(task);
                    }}
                    className="mt-0.5 shrink-0 w-5 h-5 transition-colors border-white text-white"
                >
                    <Trash size={16} />
                </button>
            </CardContent>
        </Card>
    );
};

export default TaskCardItem;
