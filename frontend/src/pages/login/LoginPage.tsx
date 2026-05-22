import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";

import { Button } from "@/components/ui/button";
import Navbar from "../../components/navbar/navbar";
import { Link, useNavigate } from "react-router-dom";
import PasswordInput from "@/components/input/password_input";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { type LoginFormData, loginSchema } from "@/schemas/login.schema";
import authService from "@/services/auth.service";
import { toast } from "sonner";

export default function LoginPage() {
    const navigator = useNavigate();
    const {
        register,
        handleSubmit,
        formState: { errors, isSubmitting },
    } = useForm<LoginFormData>({
        resolver: zodResolver(loginSchema),
    });

    const onSubmit = async (data: LoginFormData) => {
        try {
            await authService.login(data);
            toast.success("Login realizado");
            navigator("/", { replace: true });
        } catch {
            toast.error("Falha ao tentar realizar login");
        }
    };

    return (
        <>
            <Navbar />
            <div className="flex items-center justify-center mt-28 mb-28">
                <Card className="w-96">
                    <CardContent>
                        <h4 className="text-2xl mb-7 text-center font-bold">
                            Entrar.
                        </h4>
                        <form
                            onSubmit={handleSubmit(onSubmit)}
                            className="flex flex-col gap-5"
                        >
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
                                <PasswordInput {...register("password")} />
                                {errors.password && (
                                    <p className="text-sm text-red-500">
                                        {errors.password.message}
                                    </p>
                                )}
                            </div>
                            <Button
                                type="submit"
                                className="w-full bg-black"
                                disabled={isSubmitting}
                            >
                                {isSubmitting ? "Entrando..." : "Entrar"}
                            </Button>
                            <p className="text-sm text-center text-muted-foreground">
                                Não tem uma conta?{" "}
                                <Link
                                    to="/signup"
                                    className="underline-offset-4 text-black font-bold"
                                >
                                    Cadastre-se.
                                </Link>
                            </p>
                        </form>
                    </CardContent>
                </Card>
            </div>
        </>
    );
}
