import { cn } from "@/lib/utils";
import { Button } from "../ui/button";
import { Popover, PopoverContent, PopoverTrigger } from "../ui/popover";
import { CalendarIcon, X } from "lucide-react";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import { Calendar } from "../ui/calendar";
import { useState } from "react";

interface DatePickerProps {
    value?: Date;
    onChange?: (date: Date | undefined) => void;
    placeholder?: string;
}

const DatePickerInput = ({ value, onChange, placeholder }: DatePickerProps) => {
    const [open, setOpen] = useState(false);

    return (
        <div className="relative w-full">
            <Popover open={open} onOpenChange={setOpen}>
                <PopoverTrigger asChild>
                    <Button
                        variant="outline"
                        className={cn(
                            "w-full justify-start font-normal",
                            !value && "text-muted-foreground",
                            value && "pr-8",
                        )}
                    >
                        <CalendarIcon className="mr-2 h-4 w-4 shrink-0" />
                        {value
                            ? format(value, "dd/MM/yyyy", { locale: ptBR })
                            : (placeholder ?? "Selecione uma data")}
                    </Button>
                </PopoverTrigger>
                <PopoverContent className="w-auto p-0" align="start">
                    <Calendar
                        mode="single"
                        selected={value}
                        onSelect={(date) => {
                            onChange?.(date);
                            setOpen(false);
                        }}
                        defaultMonth={value}
                        locale={ptBR}
                        disabled={{ before: new Date() }}
                    />
                </PopoverContent>
            </Popover>
            {value && (
                <button
                    type="button"
                    onClick={() => onChange?.(undefined)}
                    className="absolute right-2 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                    aria-label="Limpar data"
                >
                    <X size={14} />
                </button>
            )}
        </div>
    );
};

export default DatePickerInput;
