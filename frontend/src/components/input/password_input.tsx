import { useState } from "react";
import { Input } from "../ui/input";

import { Eye, EyeOff } from "lucide-react";

interface PasswordInputProps {
    value?: string;
    placeholder?: string;
    onChange?: (value: string) => void;
}

const PasswordInput = ({
    value,
    placeholder,
    onChange,
}: PasswordInputProps) => {
    const [showPassword, setShowPassword] = useState(false);
    return (
        <div className="relative">
            <Input
                value={value}
                onChange={(e) => onChange?.(e.target.value)}
                type={showPassword ? "text" : "password"}
                placeholder={placeholder || "Password"}
                className="pr-10"
            />
            <button
                type="button"
                onClick={() => setShowPassword((v) => !v)}
                className="absolute inset-y-0 right-3 flex items-center text-muted-foreground hover:text-foreground"
                aria-label={showPassword ? "Hide password" : "Show password"}
            >
                {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
            </button>
        </div>
    );
};

export default PasswordInput;
