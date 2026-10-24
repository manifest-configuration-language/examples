import { copyFile, mkdir, readdir, readFile, writeFile } from "node:fs/promises";
import { dirname, join, relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const output = join(root, "packages/examples/examples.json");
const packageLicense = join(root, "packages/examples/LICENSE");
const categories = new Map([
	["adapters", "Integrations"],
	["composition", "Composition"],
	["language", "Language"],
	["modules", "Modules"],
	["projects", "Projects"],
	["references", "References"],
	["resources", "Kubernetes"],
	["types", "Types"],
	["validation", "Validation"],
]);
const decoder = new TextDecoder("utf-8", { fatal: true });

async function collectFiles(directory, sampleRoot, files) {
	for (const entry of await readdir(directory, { withFileTypes: true })) {
		if (entry.name === "expected.yaml") continue;
		const path = join(directory, entry.name);
		if (entry.isDirectory()) {
			await collectFiles(path, sampleRoot, files);
			continue;
		}
		if (!entry.isFile()) throw new Error(`Unsupported example input: ${relative(root, path)}`);
		const contents = await readFile(path);
		const relativePath = relative(sampleRoot, path).split(sep).join("/");
		try {
			files[relativePath] = decoder.decode(contents);
		} catch {
			throw new Error(`Example input must be UTF-8 text: ${relative(root, path)}`);
		}
	}
}

async function findEntrypoints(directory, matches = []) {
	for (const entry of await readdir(directory, { withFileTypes: true })) {
		if (!entry.isDirectory()) continue;
		if (directory === root && !categories.has(entry.name)) continue;
		const path = join(directory, entry.name);
		if ((await readdir(path)).includes("main.mcl")) matches.push(path);
		await findEntrypoints(path, matches);
	}
	return matches;
}

const samples = [];
for (const sampleRoot of (await findEntrypoints(root)).sort()) {
	const relativeRoot = relative(root, sampleRoot).split(sep).join("/");
	const [categoryKey, ...slugParts] = relativeRoot.split("/");
	const category = categories.get(categoryKey);
	if (!category) throw new Error(`Missing category for example directory: ${relativeRoot}`);
	const slug = slugParts.join("/");
	const title = slugParts.at(-1).split("-").map((part) => part[0].toUpperCase() + part.slice(1)).join(" ");
	const files = {};
	await collectFiles(sampleRoot, sampleRoot, files);
	if (!Object.hasOwn(files, "main.mcl")) throw new Error(`Example is missing main.mcl: ${relativeRoot}`);
	samples.push({ category, title, slug: `${categoryKey}/${slug}`, files });
}

if (samples.length === 0) throw new Error("No Playground examples were found.");
await mkdir(dirname(output), { recursive: true });
await writeFile(output, `${JSON.stringify(samples, null, 2)}\n`);
await copyFile(join(root, "LICENSE"), packageLicense);
console.log(`Generated ${samples.length} Playground examples.`);
