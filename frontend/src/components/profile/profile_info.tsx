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
    onLogout: () => void;
}

const ProfileInfo = ({ onLogout }: ProfileInfoProps) => {
    return (
        <DropdownMenu>
            <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="rounded-full p-0">
                    <Avatar className="items-center justify-center bg-black text-white">
                        {getInitials("Antonio Andrade")}
                    </Avatar>
                    <p className="text-sm font-medium">Antonio Andrade</p>
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
