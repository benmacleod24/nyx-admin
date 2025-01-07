import { TRole } from "@/types";
import { atom } from "jotai";

export const shouldAniamteUnsaveChangesAtom = atom<boolean>(false);

// Determine the role currently being edited.
export const editingRoleAtom = atom<TRole | undefined>(undefined);

// Determine if there are any unsaved role changes.
export const unsavedRoleChangesAtom = atom<boolean>(false);
