import type { Task } from "@/lib/models";
import TaskCardItem from "./task_card_item";

interface TaskGridProps {
    tasks: Task[];
    onEdit?: (task: Task) => void;
    onRemove?: (task: Task) => void;
    onToggleComplete?: (task: Task) => void;
}

const TaskGrid = ({ tasks, onEdit, onRemove, onToggleComplete }: TaskGridProps) => {
    return (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
            {tasks.map((task) => (
                <TaskCardItem
                    key={task.id}
                    task={task}
                    onEdit={onEdit}
                    onRemove={onRemove}
                    onToggleComplete={onToggleComplete}
                />
            ))}
        </div>
    );
};

export default TaskGrid;
