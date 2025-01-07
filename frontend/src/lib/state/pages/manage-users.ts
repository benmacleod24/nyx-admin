import { TUser } from "@/types";
import { atom } from "jotai";

// The user that is currently being edited.
export const editingUserAtom = atom<TUser | undefined>();

// Determine if there are any unsaved role changes.
export const unsavedUserChangesAtom = atom<boolean>(false);
export const shouldAniamteUnsavedUserChangesAtom = atom<boolean>(false);
