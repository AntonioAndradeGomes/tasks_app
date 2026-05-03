import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";

import { Button } from "@/components/ui/button";
import Navbar from "../../components/navbar/navbar";
import { Link } from "react-router-dom";
import PasswordInput from "@/components/input/password_input";
import { useState } from "react";
import { isValidEmail } from "@/lib/validators";

export default function LoginPage() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");

    const handleSubmit = (e: { preventDefault: () => void }) => {
        e.preventDefault();
        console.log({ email, password });
        if (!isValidEmail(email)) {
            setError("Please enter a valid email address.");
            return;
        }

        if (!password) {
            setError("Please enter your password.");
            return;
        }

        setError("");
    };

    return (
        <>
            <Navbar />
            <div className="flex items-center justify-center mt-28">
                <Card className="w-96">
                    <CardContent>
                        <h4 className="text-2xl mb-7 text-center font-bold">
                            Login.
                        </h4>
                        <form
                            onSubmit={handleSubmit}
                            className="flex flex-col gap-5"
                        >
                            <Input
                                placeholder="Email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />

                            <PasswordInput
                                value={password}
                                onChange={setPassword}
                            />

                            {error && (
                                <p className="text-sm text-red-500 pb-1">
                                    {error}
                                </p>
                            )}
                            <Button type="submit" className="w-full bg-black">
                                Login
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
