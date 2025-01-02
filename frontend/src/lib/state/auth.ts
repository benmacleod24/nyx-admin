import { atom } from "jotai";

export const authLoadingAtom = atom<boolean>(true);

export const authTokenAtom = atom<string | undefined>(undefined);
