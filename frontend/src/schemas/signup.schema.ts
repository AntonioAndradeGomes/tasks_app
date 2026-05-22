import { z } from "zod";

export const signupSchema = z
    .object({
        name: z.string().min(1, "Nome é obrigatório"),
        email: z.email("E-mail inválido"),
        password: z.string().min(6, "Mínimo 6 caracteres"),
        confirmPassword: z.string().min(1, "Confirme a senha"),
    })
    .refine((data) => data.password === data.confirmPassword, {
        message: "As senhas não coincidem",
        path: ["confirmPassword"],
    });

export type SignupFormData = z.infer<typeof signupSchema>;
