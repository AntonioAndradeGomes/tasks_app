import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs));
}

export const getInitials = (name: string) => {
    if (name.length === 0) return "";
    const words = name.trim().split(" ");
    if (words.length === 1) {
        return words[0].charAt(0).toUpperCase();
    }
    return words[0].charAt(0).toUpperCase() + words[1].charAt(0).toUpperCase();
};
