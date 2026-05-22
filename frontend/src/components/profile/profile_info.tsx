import type { User } from "@/lib/models";
import { getInitials } from "@/lib/utils";
import { Avatar } from "../ui/avatar";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuGroup,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "../ui/dropdown-menu";
import { Button } from "../ui/button";
import { LogOutIcon } from "lucide-react";

interface ProfileInfoProps {
    user: User;
    onLogout: () => void;
}

const ProfileInfo = ({ user, onLogout }: ProfileInfoProps) => {
    return (
        <DropdownMenu>
            <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="rounded-full p-0">
                    <Avatar className="items-center justify-center bg-black text-white">
                        {getInitials(user.name)}
                    </Avatar>
                    <p className="hidden min-[425px]:block text-sm font-medium max-w-30 truncate">
                        {user.name.split(" ").slice(0, 2).join(" ")}
                    </p>
                </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
                <DropdownMenuGroup>
                    <DropdownMenuItem variant="destructive" onClick={onLogout}>
                        <LogOutIcon />
                        Log out
                    </DropdownMenuItem>
                </DropdownMenuGroup>
            </DropdownMenuContent>
        </DropdownMenu>
    );
};

export default ProfileInfo;
