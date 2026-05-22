import { useAuthStore } from "@/stores/auth.store";
import { Navigate, Outlet } from "react-router-dom";

const PublicRoute = () => {
    const token = useAuthStore((s) => s.token);
    return token ? <Navigate to="/" replace /> : <Outlet />;
};

export default PublicRoute;
