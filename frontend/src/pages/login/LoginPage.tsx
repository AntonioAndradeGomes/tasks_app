import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";

import { Button } from "@/components/ui/button";
import Navbar from "../../components/navbar/navbar";
import { Link, useNavigate } from "react-router-dom";
import PasswordInput from "@/components/input/password_input";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { type LoginFormData, loginSchema } from "@/schemas/login.schema";

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
        console.log(data);
        // await authService.login(data)
        navigator("/", { replace: true });
    };

    return (
        <>
            <Navbar />
            <div className="flex items-center justify-center mt-28 mb-28">
                <Card className="w-96">
                    <CardContent>
                        <h4 className="text-2xl mb-7 text-center font-bold">
                            Login.
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
                                {isSubmitting ? "Entrando..." : "Login"}
                            </Button>
                            <p className="text-sm text-center text-muted-foreground">
                                Don't have an account?{" "}
                                <Link
                                    to="/signup"
                                    className="underline-offset-4 text-black font-bold"
                                >
                                    Sign up.
                                </Link>
                            </p>
                        </form>
                    </CardContent>
                </Card>
            </div>
        </>
    );
}
