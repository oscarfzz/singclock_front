import fs from "node:fs";
import path from "node:path";
import readline from "node:readline";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(path.join(__dirname, ".."));

// Patrones comunes que suelen estar en .gitignore para proyectos JavaScript/React/Vite/Python
const commonIgnorePatterns = [
	// JavaScript/Node.js
	"node_modules",
	"dist",
	"build",
	"coverage",
	".cache",
	".parcel-cache",
	".next",
	".nuxt",
	".output",
	"storybook-static",
	".turbo",
	".vercel",
	".netlify",
	"npm-debug.log*",
	"yarn-debug.log*",
	"yarn-error.log*",
	"lerna-debug.log*",
	".pnpm-debug.log*",
	"pnpm-lock.yaml",
	"package-lock.json",
	"yarn.lock",

	// Python
	"__pycache__",
	"*.py[cod]",
	"*$py.class",
	".Python",
	"env/",
	"venv/",
	"ENV/",
	".env",
	".env.*",
	".venv",
	"pythonenv*",
	".pytest_cache",
	".coverage",
	"htmlcov/",
	".tox/",
	".nox/",
	".hypothesis/",
	".egg-info/",
	".installed.cfg",
	"*.egg",

	// Entornos de desarrollo
	".idea",
	".vscode",
	"*.swp",
	"*.swo",
	".DS_Store",
	"Thumbs.db",
	".git",
];

// Archivos específicos a excluir
const excludeFiles = new Set([path.join(rootDir, "scripts", "get_all_project.js")]);

// Función para verificar si una ruta debe ser ignorada
function shouldIgnore(filePath, baseDir) {
	// Verificar si el archivo está en la lista de exclusión específica
	if (excludeFiles.has(filePath)) {
		return true;
	}

	// Verificar el nombre del archivo directamente para casos específicos
	const fileName = path.basename(filePath);
	const fileExt = path.extname(filePath).toLowerCase();

	// Extensiones de archivos binarios e imágenes a excluir
	const binaryExtensions = [
		// Imágenes
		".jpg",
		".jpeg",
		".png",
		".gif",
		".bmp",
		".tiff",
		".webp",
		".ico",
		".svg",
		".avif",
		// Archivos binarios
		".pdf",
		".zip",
		".tar",
		".gz",
		".rar",
		".7z",
		// Audio/Video
		".mp3",
		".mp4",
		".avi",
		".mov",
		".wav",
		".ogg",
		".webm",
		".flac",
		".aac",
		// Fuentes
		".ttf",
		".otf",
		".woff",
		".woff2",
		".eot",
		// Otros binarios
		".exe",
		".dll",
		".so",
		".dylib",
		".bin",
		".dat",
	];

	// Excluir archivos binarios e imágenes
	if (binaryExtensions.includes(fileExt)) {
		console.log(`Excluyendo archivo binario/imagen: ${filePath}`);
		return true;
	}

	// Excluir pnpm-lock.yaml
	if (fileName === "pnpm-lock.yaml") {
		console.log(`Excluyendo archivo de bloqueo: ${filePath}`);
		return true;
	}

	// Excluir archivos markdown (.md)
	if (fileExt === ".md" || fileExt === ".markdown") {
		console.log(`Excluyendo archivo markdown: ${filePath}`);
		return true;
	}

	// Verificar patrones comunes de gitignore
	const relativePath = path.relative(baseDir, filePath);
	return commonIgnorePatterns.some((pattern) => {
		if (pattern.includes("*")) {
			const regexPattern = pattern.replace(/\./g, "\\.").replace(/\*/g, ".*");
			return new RegExp(regexPattern).test(fileName);
		}
		return (
			fileName === pattern ||
			relativePath.includes(`/${pattern}/`) ||
			relativePath.includes(`\\${pattern}\\`) ||
			relativePath.startsWith(`${pattern}/`) ||
			relativePath.startsWith(`${pattern}\\`)
		);
	});
}

// Función para crear un árbol de directorios en formato markdown
function createDirectoryTree(dir, baseDir, prefix = "", isLast = true, depth = 0) {
	const baseName = path.basename(dir);
	const newPrefix = prefix + (isLast ? "└── " : "├── ");
	const spacerPrefix = prefix + (isLast ? "    " : "│   ");

	let tree = depth === 0 ? "" : `${newPrefix + baseName}\n`;

	try {
		// Contar este directorio
		if (depth > 0) {
			totalDirectorios++;
		}

		const items = fs.readdirSync(dir);
		const dirs = [];
		const files = [];

		for (const item of items) {
			const itemPath = path.join(dir, item);
			if (shouldIgnore(itemPath, baseDir)) continue;

			const stats = fs.statSync(itemPath);
			if (stats.isDirectory()) {
				dirs.push(item);
			} else {
				files.push(item);
				// Contar los archivos en el árbol
				totalArchivos++;
			}
		}

		dirs.sort();
		files.sort();

		dirs.forEach((d, i) => {
			const isLastItem = i === dirs.length - 1 && files.length === 0;
			tree += createDirectoryTree(path.join(dir, d), baseDir, spacerPrefix, isLastItem, depth + 1);
		});

		files.forEach((f, i) => {
			const isLastItem = i === files.length - 1;
			tree += `${spacerPrefix + (isLastItem ? "└── " : "├── ") + f}\n`;
		});

		return tree;
	} catch (err) {
		return `${tree + spacerPrefix}Error al leer el directorio: ${err.message}\n`;
	}
}

// Función para recorrer recursivamente los directorios y obtener el contenido de los archivos
function processDirectory(dir, baseDir, contextContent) {
	try {
		const items = fs.readdirSync(dir);

		for (const item of items) {
			const itemPath = path.join(dir, item);

			if (shouldIgnore(itemPath, baseDir)) continue;

			const stats = fs.statSync(itemPath);

			if (stats.isDirectory()) {
				// Contar directorios procesados
				totalDirectorios++;
				processDirectory(itemPath, baseDir, contextContent);
			} else {
				try {
					// Contar archivos procesados
					totalArchivos++;

					// Obtener la ruta relativa desde la raíz del proyecto
					const relativePath = path.relative(rootDir, itemPath).replace(/\\/g, "/");

					// Determinar el tipo de archivo para la sintaxis markdown
					let syntax = "";
					const ext = path.extname(itemPath).toLowerCase();
					if (ext === ".js" || ext === ".ts" || ext === ".jsx" || ext === ".tsx") {
						syntax = "javascript";
					} else if (ext === ".py") {
						syntax = "python";
					} else if (ext === ".java") {
						syntax = "java";
					} else if (ext === ".json") {
						syntax = "json";
					} else if (ext === ".md" || ext === ".markdown") {
						syntax = "markdown";
					} else if (ext === ".html") {
						syntax = "html";
					} else if (ext === ".css") {
						syntax = "css";
					} else if (ext === ".sql") {
						syntax = "sql";
					} else if (ext === ".xml") {
						syntax = "xml";
					} else if (ext === ".sh" || ext === ".bash") {
						syntax = "bash";
					} else if (ext === ".yml" || ext === ".yaml") {
						syntax = "yaml";
					} else if (ext === ".c" || ext === ".cpp" || ext === ".h") {
						syntax = "cpp";
					} else if (ext === ".cs") {
						syntax = "csharp";
					} else if (ext === ".go") {
						syntax = "go";
					} else if (ext === ".rb") {
						syntax = "ruby";
					} else if (ext === ".php") {
						syntax = "php";
					} else if (ext === ".rs") {
						syntax = "rust";
					} else if (ext === ".swift") {
						syntax = "swift";
					} else if (ext === ".kt" || ext === ".kts") {
						syntax = "kotlin";
					} else {
						syntax = "";
					}

					// Leer el contenido del archivo
					const fileContent = fs.readFileSync(itemPath, "utf8");

					// Añadir el contenido al documento con la sintaxis adecuada
					contextContent.push(`${relativePath}: \`\`\`${syntax}\n${fileContent}\n\`\`\`\n\n`);

					console.log(`Procesado: ${relativePath}`);
				} catch (error) {
					console.error(`Error al procesar el archivo ${itemPath}: ${error.message}`);
				}
			}
		}
	} catch (error) {
		console.error(`Error al leer el directorio ${dir}: ${error.message}`);
	}
}

// Función para crear una interfaz de línea de comandos
function createInterface() {
	return readline.createInterface({
		input: process.stdin,
		output: process.stdout,
	});
}

// Función para preguntar al usuario
function preguntarAlUsuario(rl, pregunta) {
	return new Promise((resolve) => {
		rl.question(pregunta, (respuesta) => {
			resolve(respuesta);
		});
	});
}

// Función para contar archivos procesados
let totalArchivos = 0;
let totalDirectorios = 0;

// Función principal
async function main() {
	const rl = createInterface();

	console.log("=== Generador de Contexto del Proyecto ===");
	console.log("Este script generará un documento con el contenido de TODOS los archivos del proyecto.");

	const opcion = await preguntarAlUsuario(
		rl,
		"¿Deseas procesar todo el proyecto o solo una carpeta específica? (1: Todo el proyecto, 2: Carpeta específica): ",
	);

	let directorioBase = rootDir;
	let nombreArchivo = "context.md";

	if (opcion === "2") {
		const rutaRelativa = await preguntarAlUsuario(
			rl,
			"Introduce la ruta relativa de la carpeta (por ejemplo, libs/auth): ",
		);
		directorioBase = path.join(rootDir, rutaRelativa.replace(/\//g, path.sep));

		if (!fs.existsSync(directorioBase)) {
			console.error(`Error: La carpeta ${directorioBase} no existe.`);
			rl.close();
			return;
		}

		const nombreCarpeta = path.basename(directorioBase);
		nombreArchivo = `context-${nombreCarpeta}.md`;
	}

	const rutaArchivo = await preguntarAlUsuario(rl, `Nombre del archivo de salida (por defecto: ${nombreArchivo}): `);

	// Asegurar que la carpeta docs existe
	const docsDir = path.join(rootDir, "docs");
	if (!fs.existsSync(docsDir)) {
		fs.mkdirSync(docsDir, { recursive: true });
	}

	const contextFilePath = path.join(docsDir, rutaArchivo || nombreArchivo);

	console.log(`\nGenerando contexto para: ${path.relative(rootDir, directorioBase) || "Todo el proyecto"}`);
	console.log(`El resultado se guardará en: ${contextFilePath}\n`);
	console.log("Procesando archivos, esto puede tardar varios minutos dependiendo del tamaño del proyecto...");

	// Reiniciar contadores
	totalArchivos = 0;
	totalDirectorios = 0;

	// Array para almacenar el contenido del contexto
	const contextContent = [];

	// Procesar los archivos
	processDirectory(directorioBase, directorioBase, contextContent);

	// Generar el árbol de directorios
	const directoryTreeTitle = "# Estructura del Proyecto\n\n```\n";
	const directoryTreeContent = `${path.basename(directorioBase)}\n${createDirectoryTree(directorioBase, directorioBase)}\`\`\`\n\n`;

	// Información del proyecto
	const projectInfo = `# Información del Proyecto\n\n- **Total de archivos procesados:** ${totalArchivos}\n- **Total de directorios procesados:** ${totalDirectorios}\n- **Fecha de generación:** ${new Date().toLocaleString()}\n\n`;

	// Combinar el árbol y el contenido de los archivos
	const fullContent = `${projectInfo + directoryTreeTitle + directoryTreeContent}# Contenido de los Archivos\n\n${contextContent.join("")}`;

	// Escribir el resultado en el archivo de salida
	fs.writeFileSync(contextFilePath, fullContent, "utf8");

	console.log("\n¡Proceso completado!");
	console.log(`- Total de archivos procesados: ${totalArchivos}`);
	console.log(`- Total de directorios procesados: ${totalDirectorios}`);
	console.log(`- El contexto se ha guardado en: ${contextFilePath}`);

	rl.close();
}

// Ejecutar la función principal
main().catch((error) => {
	console.error("Error en el proceso principal:", error);
	process.exit(1);
});
