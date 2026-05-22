import { BrowserRouter, Routes, Route } from "react-router-dom";
import { Toaster } from "sonner";
import PrivateRoute from "./components/auth/PrivateRoute";
import PublicRoute from "./components/auth/PublicRoute";
import HomePage from "./pages/home/HomePage";
import LoginPage from "./pages/login/LoginPage";
import SignupPage from "./pages/signup/SignupPage";

export default function App() {
    return (
        <BrowserRouter>
            <Toaster richColors position="bottom-right" />
            <Routes>
                <Route element={<PrivateRoute />}>
                    <Route path="/" element={<HomePage />} />
                </Route>

                <Route element={<PublicRoute />}>
                    <Route path="/login" element={<LoginPage />} />
                    <Route path="/signup" element={<SignupPage />} />
                </Route>
            </Routes>
        </BrowserRouter>
    );
}
