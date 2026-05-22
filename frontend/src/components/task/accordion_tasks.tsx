import type { Task } from "@/lib/models";
import {
    Accordion,
    AccordionContent,
    AccordionItem,
    AccordionTrigger,
} from "../ui/accordion";
import TaskGrid from "./task_grid";
import { useState } from "react";

interface AccordionTasksProps {
    title: string;
    tasks: Task[];
    onEdit?: (task: Task) => void;
    onRemove?: (task: Task) => void;
    onToggleComplete?: (task: Task) => void;
}

const AccordionTasks = ({ title, tasks, onEdit }: AccordionTasksProps) => {
    const [accordionOpen, setAccordionOpen] = useState("open");
    return (
        <Accordion
            type="single"
            collapsible
            value={accordionOpen}
            onValueChange={setAccordionOpen}
        >
            <AccordionItem value="open">
                <AccordionTrigger>
                    {title} ({tasks.length})
                </AccordionTrigger>
                <AccordionContent className="mt-2">
                    <TaskGrid tasks={tasks} onEdit={onEdit} />
                </AccordionContent>
            </AccordionItem>
        </Accordion>
    );
};

export default AccordionTasks;
