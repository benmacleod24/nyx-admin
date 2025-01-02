import { TUser } from "@/types";
import { atom } from "jotai";

export const userAtom = atom<TUser | undefined>(undefined);
