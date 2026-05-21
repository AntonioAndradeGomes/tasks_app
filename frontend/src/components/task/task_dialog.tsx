import type { Task } from "@/lib/models";
import {
    Dialog,
    DialogClose,
    DialogContent,
    DialogHeader,
    DialogTitle,
} from "../ui/dialog";
import { COLORS, taskSchema, type TaskFormData } from "@/schemas/task.schema";
import { Input } from "../ui/input";
import { Textarea } from "../ui/textarea";
import { X } from "lucide-react";
import { Button } from "../ui/button";
import DatePickerInput from "../input/date_picker_input";
import { Controller, useForm, useWatch } from "react-hook-form";

import { zodResolver } from "@hookform/resolvers/zod";
import { useEffect } from "react";

interface TaskDialogProps {
    open: boolean;
    onOpenChange: (open: boolean) => void;
    task?: Task;
    onSubmit: (data: TaskFormData) => void;
}

const TaskDialog = ({
    open,
    onOpenChange,
    task,
    onSubmit,
}: TaskDialogProps) => {
    const {
        register,
        handleSubmit,
        control,
        reset,
        formState: { errors, isDirty },
    } = useForm<TaskFormData>({
        resolver: zodResolver(taskSchema),
        defaultValues: {
            title: "",
            description: "",
            hexColor: COLORS[0],
        },
    });

    useEffect(() => {
        if (open) {
            reset({
                title: task?.title ?? "",
                description: task?.description ?? "",
                due_at: task?.due_at,
                hexColor:
                    (task?.hexColor as (typeof COLORS)[number]) ?? COLORS[0],
            });
        }
    }, [open, task, reset]);

    const selectedColor = useWatch({ control, name: "hexColor" });

    return (
        <Dialog open={open} onOpenChange={onOpenChange}>
            <DialogContent
                showCloseButton={false}
                onOpenAutoFocus={(e) => e.preventDefault()}
            >
                <form
                    className="flex flex-col gap-4"
                    onSubmit={handleSubmit(onSubmit)}
                >
                    <DialogHeader>
                        <DialogTitle>
                            <div className="flex items-center gap-2">
                                <div
                                    className="mt-0.5 shrink-0 w-5 h-5 rounded-full border-2 flex items-center justify-center transition-colors"
                                    style={{
                                        borderColor: selectedColor,
                                        backgroundColor: selectedColor,
                                    }}
                                >
                                    <svg
                                        className="w-3 h-3"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                        strokeWidth={3}
                                        style={{ color: "white" }}
                                    >
                                        <path
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                            d="M5 13l4 4L19 7"
                                        />
                                    </svg>
                                </div>
                                <Input
                                    placeholder="Título da tarefa"
                                    {...register("title")}
                                    className="border-none shadow-none focus-visible:ring-0 p-0 text-base font-semibold"
                                />
                                <DialogClose asChild>
                                    <Button
                                        type="button"
                                        variant="ghost"
                                        size="icon"
                                    >
                                        <X size={16} />
                                    </Button>
                                </DialogClose>
                            </div>
                            {errors.title && (
                                <p className="text-xs text-destructive font-normal mt-1 ml-7">
                                    {errors.title.message}
                                </p>
                            )}
                        </DialogTitle>
                    </DialogHeader>

                    <Textarea
                        placeholder="Descrição (opcional)"
                        className="resize-none"
                        {...register("description")}
                    />

                    <Controller
                        name="due_at"
                        control={control}
                        render={({ field }) => (
                            <DatePickerInput
                                placeholder="Adicionar uma data de conclusão"
                                value={
                                    field.value
                                        ? new Date(field.value)
                                        : undefined
                                }
                                onChange={(date) => {
                                    console.log(date);
                                    if (!date) {
                                        field.onChange(null);
                                    } else {
                                        field.onChange(date?.toISOString());
                                    }
                                }}
                            />
                        )}
                    />

                    <Controller
                        name="hexColor"
                        control={control}
                        render={({ field }) => (
                            <div className="flex flex-wrap gap-1">
                                {COLORS.map((color) => (
                                    <Button
                                        key={color}
                                        type="button"
                                        size="icon"
                                        onClick={() => field.onChange(color)}
                                        className="w-10 h-10 rounded-full transition-transform hover:scale-110"
                                        style={{
                                            backgroundColor: color,
                                        }}
                                        aria-label={color}
                                    >
                                        {field.value === color && (
                                            <svg
                                                className="w-5 h-5"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                stroke="white"
                                                strokeWidth={3}
                                            >
                                                <path
                                                    strokeLinecap="round"
                                                    strokeLinejoin="round"
                                                    d="M5 13l4 4L19 7"
                                                />
                                            </svg>
                                        )}
                                    </Button>
                                ))}
                            </div>
                        )}
                    />

                    {isDirty && (
                        <div className="flex justify-end gap-2">
                            <Button
                                className="h-10"
                                style={{
                                    backgroundColor: selectedColor,
                                }}
                                type="submit"
                            >
                                Salvar Alterações
                            </Button>
                        </div>
                    )}
                </form>
            </DialogContent>
        </Dialog>
    );
};

export default TaskDialog;
