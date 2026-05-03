import { useNavigate } from "react-router-dom";
import ProfileInfo from "../profile/profile_info";

const Navbar = () => {
    const navigator = useNavigate();

    const onLogout = () => {
        navigator("/login");
    };
    return (
        <div className="sticky top-0 z-10 bg-white flex items-center justify-between px-6 py-2 drop-shadow">
            <h2 className="text-xl font-medium text-black py-2">My tasks</h2>
            <ProfileInfo onLogout={onLogout} />
        </div>
    );
};

export default Navbar;
