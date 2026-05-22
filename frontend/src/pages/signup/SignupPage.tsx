import PasswordInput from "@/components/input/password_input";
import Navbar from "@/components/navbar/navbar";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { type SignupFormData, signupSchema } from "@/schemas/signup.schema";
import authService from "@/services/auth.service";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { Link, useNavigate } from "react-router-dom";
import { toast } from "sonner";

export default function SignupPage() {
    const navigate = useNavigate();
    const {
        register,
        handleSubmit,
        formState: { errors, isSubmitting },
    } = useForm<SignupFormData>({
        resolver: zodResolver(signupSchema),
    });

    const onSubmit = async (data: SignupFormData) => {
        try {
            await authService.register(data);
            toast.success("Cadastro realizado!");
            navigate("/login", { replace: true });
        } catch {
            toast.error("Falha ao cadastrar");
        }
    };

    return (
        <>
            <Navbar />
            <div className="flex items-center justify-center mt-28 mb-28">
                <Card className="w-96">
                    <CardContent>
                        <h4 className="text-2xl mb-7 text-center font-bold">
                            Cadastre-se.
                        </h4>
                        <form
                            onSubmit={handleSubmit(onSubmit)}
                            className="flex flex-col gap-5"
                        >
                            <div className="flex flex-col gap-1">
                                <Input
                                    placeholder="Nome"
                                    {...register("name")}
                                />
                                {errors.name && (
                                    <p className="text-sm text-red-500">
                                        {errors.name.message}
                                    </p>
                                )}
                            </div>

                            <div className="flex flex-col gap-1">
                                <Input
                                    placeholder="Email"
                                    {...register("email")}
                                />
                                {errors.email && (
                                    <p className="text-sm text-red-500">
                                        {errors.email.message}
                                    </p>
                                )}
                            </div>

                            <div className="flex flex-col gap-1">
                                <PasswordInput
                                    placeholder="Senha"
                                    {...register("password")}
                                />
                                {errors.password && (
                                    <p className="text-sm text-red-500">
                                        {errors.password.message}
                                    </p>
                                )}
                            </div>

                            <div className="flex flex-col gap-1">
                                <PasswordInput
                                    placeholder="Confirmar senha"
                                    {...register("confirmPassword")}
                                />
                                {errors.confirmPassword && (
                                    <p className="text-sm text-red-500">
                                        {errors.confirmPassword.message}
                                    </p>
                                )}
                            </div>

                            {errors.root && (
                                <p className="text-sm text-red-500 text-center">
                                    {errors.root.message}
                                </p>
                            )}

                            <Button
                                type="submit"
                                className="w-full bg-black"
                                disabled={isSubmitting}
                            >
                                {isSubmitting
                                    ? "Cadastrando..."
                                    : "Cadastre-se"}
                            </Button>

                            <p className="text-sm text-center text-muted-foreground">
                                Já tem uma conta?{" "}
                                <Link
                                    to="/login"
                                    replace
                                    className="underline-offset-4 text-black font-bold"
                                >
                                    Login.
                                </Link>
                            </p>
                        </form>
                    </CardContent>
                </Card>
            </div>
        </>
    );
}
