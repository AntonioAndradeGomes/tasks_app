import type { Task } from "@/lib/models";
import {
    Accordion,
    AccordionContent,
    AccordionItem,
    AccordionTrigger,
} from "../ui/accordion";
import TaskGrid from "./task_grid";

interface AccordionTasksProps {
    title: string;
    tasks: Task[];
    onEdit?: (task: Task) => void;
    onRemove?: (task: Task) => void;
    onToggleComplete?: (task: Task) => void;
}

const AccordionTasks = ({ title, tasks }: AccordionTasksProps) => {
    return (
        <Accordion type="single" collapsible defaultValue="completed">
            <AccordionItem value="completed">
                <AccordionTrigger>
                    {title} ({tasks.length})
                </AccordionTrigger>
                <AccordionContent>
                    <TaskGrid tasks={tasks} />
                </AccordionContent>
            </AccordionItem>
        </Accordion>
    );
};

export default AccordionTasks;
