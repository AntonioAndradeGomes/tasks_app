import { z } from "zod";

export const COLORS = [
    "#6495ED",
    "#7B68EE",
    "#8A2BE2",
    "#4169E1",
    "#4682B4",
    "#1E90FF",
    "#6A5ACD",
    "#4B0082",
    "#FF00FF",
    "#FF7F50",
    "#FF8C00",
    "#FF4500",
    "#B22222",
    "#228B22",
    "#008B8B",
    "#6B8E23",
    "#BDB76B",
    "#8B4512",
] as const;

export const taskSchema = z.object({
    title: z.string().min(1, "Título é obrigatório"),
    description: z.string().optional(),
    due_at: z.string().optional(),
    completed_at: z.string().optional(),
    hexColor: z.enum(COLORS, { message: "Cor inválida" }),
});

export type TaskFormData = z.infer<typeof taskSchema>;
