import { TLog } from "@/types/api/logs";
import { TSearchFilter } from "@/types/logs";
import { ColumnDef } from "@tanstack/react-table";
import { logColumns as _logColumns } from "@/pages/Dashboard/Logs/log-table/columns";
import { atom } from "jotai";
import { DateRange } from "react-aria-components";

export const logSearchFilterAtom = atom<TSearchFilter[]>([]);

export const logColumnsAtom = atom<ColumnDef<TLog>[]>(_logColumns);

export const logsAtom = atom<TLog[]>([]);

export const logTimerangeFilterAtom = atom<DateRange | null>(null);
