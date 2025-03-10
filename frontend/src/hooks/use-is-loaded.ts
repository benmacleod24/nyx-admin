import { useEffect, useState } from "react";

export default function useIsLoaded() {
	const [isLoaded, setIsLoaded] = useState<boolean>(false);

	useEffect(() => {
		setIsLoaded(true);
		return () => setIsLoaded(false);
	}, [setIsLoaded]);

	return isLoaded;
}
