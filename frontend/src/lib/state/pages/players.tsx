import { PlayersDefaultColumns } from "@/pages/Dashboard/Players/players-table/players-default-columns";
import { TPlayer } from "@/types";
import { ColumnDef } from "@tanstack/react-table";
import { atom } from "jotai";

export const playersAtom = atom<TPlayer[]>([]);

export const totalPlayerPagesAtom = atom<number>(0);

export const playersTableColumnsAtom = atom<ColumnDef<TPlayer>[]>(PlayersDefaultColumns);
