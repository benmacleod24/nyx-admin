import { TUser } from "@/types";
import { atom } from "jotai";

// The user that is currently being edited.
export const editingUserAtom = atom<TUser | null>(null);
