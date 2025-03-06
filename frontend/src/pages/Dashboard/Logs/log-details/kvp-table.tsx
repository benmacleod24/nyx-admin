import {
	Table,
	TableBody,
	TableCaption,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { toFlatCase } from "@/lib/utils";

export default function LogKvpTable({ metadata }: { metadata: Record<string, any> }) {
	if (JSON.stringify(metadata) === "{}") return;

	return (
		<div>
			<h4 className="mb-1 font-semibold text-lg">Metadata</h4>
			<Table className="grid border-separate border-spacing-0 border rounded-lg">
				<TableHeader className="grid">
					<TableRow className="flex" style={{ borderBottom: "none" }}>
						<TableHead className="flex w-1/2 border-b bg-muted/50 border-r h-fit py-2">
							Key
						</TableHead>
						<TableHead className=" flex w-1/2 border-b bg-muted/50 h-fit py-2">
							Value
						</TableHead>
					</TableRow>
				</TableHeader>
				<TableBody className="grid">
					{Object.keys(metadata).map((key) => {
						const value = metadata[key];

						if (typeof value === "object") {
							return Object.keys(value).map((key2) => {
								const value2 = value[key2];

								return (
									<TableRow className="flex">
										<TableCell className="flex border-r w-[50%] h-fit py-3 capitalize text-sm">
											{toFlatCase(key2)}
										</TableCell>
										<TableCell className="flex h-fit py-3 w-[50%] text-sm">
											{JSON.stringify(value2)}
										</TableCell>
									</TableRow>
								);
							});
						}

						return (
							<TableRow className="flex">
								<TableCell className="flex border-r w-[50%] h-fit py-3 capitalize text-sm">
									{toFlatCase(key)}
								</TableCell>
								<TableCell className="flex h-fit py-3 w-[50%] text-sm">
									{value}
								</TableCell>
							</TableRow>
						);
					})}
				</TableBody>
			</Table>
		</div>
	);
}
