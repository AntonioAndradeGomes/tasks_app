import { useAuthStore } from "@/stores/auth.store";
import { Navigate, Outlet } from "react-router-dom";

const PrivateRoute = () => {
    const token = useAuthStore((s) => s.token);
    return token ? <Outlet /> : <Navigate to="/login" replace />;
};

export default PrivateRoute;
