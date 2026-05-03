export function isValidEmail(email: string): boolean {
    return /^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/.test(email);
}