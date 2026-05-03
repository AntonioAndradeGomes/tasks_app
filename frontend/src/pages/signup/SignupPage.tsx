import PasswordInput from "@/components/input/password_input";
import Navbar from "@/components/navbar/navbar";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Link } from "react-router-dom";

export default function SignupPage() {
    return (
        <>
            <Navbar />
            <div className="flex items-center justify-center mt-28">
                <Card className="w-96">
                    <CardContent>
                        <h4 className="text-2xl mb-7 text-center font-bold">
                            Signup.
                        </h4>
                        <form className="flex flex-col gap-5">
                            <Input placeholder="Nome" />
                            <Input placeholder="Email" />
                            <PasswordInput />
                            <Button type="submit" className="w-full bg-black">
                                Sign up
                            </Button>

                            <p className="text-sm text-center text-muted-foreground">
                                Don't have an account?{" "}
                                <Link
                                    to="/login"
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
