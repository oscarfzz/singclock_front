import fs from "node:fs";
import path from "node:path";
import readline from "node:readline";

// Directorio raíz del proyecto
import { fileURLToPath } from "node:url";
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(path.join(__dirname, ".."));

// Extensiones de archivos de documentación a incluir
const docExtensions = [".md", ".markdown", ".mdown", ".mdwn", ".mkd", ".mkdn"];

// Archivos específicos a excluir (si hay alguno)
const excludeFiles = new Set([
	path.join(rootDir, "docs", "context_docs.md"), // Excluir el archivo de salida para evitar recursión
]);

// Variables para contar archivos procesados
let totalArchivos = 0;
let totalDirectorios = 0;

// Función para verificar si un archivo es un documento markdown
function isDocFile(filePath) {
	const ext = path.extname(filePath).toLowerCase();
	return docExtensions.includes(ext);
}

// Función para verificar si una ruta debe ser ignorada
function shouldIgnore(filePath) {
	// Verificar si el archivo está en la lista de exclusión específica
	if (excludeFiles.has(filePath)) {
		console.log(`Excluyendo archivo específico: ${filePath}`);
		return true;
	}

	// Patrones comunes a ignorar
	const ignoredPatterns = ["node_modules", "dist", "build", ".git", "__pycache__", "venv", ".env", "coverage"];

	const relativePath = path.relative(rootDir, filePath);
	return ignoredPatterns.some(
		(pattern) =>
			relativePath.includes(`/${pattern}/`) ||
			relativePath.includes(`\\${pattern}\\`) ||
			relativePath.startsWith(`${pattern}/`) ||
			relativePath.startsWith(`${pattern}\\`),
	);
}

// Función para crear un árbol de directorios en formato markdown
function createDirectoryTree(dir, prefix = "", isLast = true, depth = 0, onlyDocs = true) {
	const baseName = path.basename(dir);
	const newPrefix = prefix + (isLast ? "└── " : "├── ");
	const spacerPrefix = prefix + (isLast ? "    " : "│   ");

	let tree = depth === 0 ? "" : `${newPrefix + baseName}\n`;

	try {
		// Contar este directorio si contiene documentos
		let hasDocuments = false;

		const items = fs.readdirSync(dir);
		const dirs = [];
		const files = [];

		for (const item of items) {
			const itemPath = path.join(dir, item);
			if (shouldIgnore(itemPath)) continue;

			const stats = fs.statSync(itemPath);
			if (stats.isDirectory()) {
				dirs.push(item);
			} else if (!onlyDocs || isDocFile(itemPath)) {
				files.push(item);
				hasDocuments = true;
			}
		}

		if (depth > 0 && hasDocuments) {
			totalDirectorios++;
		}

		dirs.sort();
		files.sort();

		// Procesar subdirectorios
		for (let i = 0; i < dirs.length; i++) {
			const d = dirs[i];
			const isLastItem = i === dirs.length - 1 && files.length === 0;
			const subTree = createDirectoryTree(path.join(dir, d), spacerPrefix, isLastItem, depth + 1, onlyDocs);

			// Solo añadir el subdirectorio si contiene documentos
			if (subTree && (!onlyDocs || subTree.includes("."))) {
				tree += subTree;
			}
		}

		// Procesar archivos
		for (let i = 0; i < files.length; i++) {
			const f = files[i];
			if (onlyDocs && !isDocFile(path.join(dir, f))) continue;

			const isLastItem = i === files.length - 1;
			tree += `${spacerPrefix + (isLastItem ? "└── " : "├── ") + f}\n`;

			// Contar archivos en el árbol
			totalArchivos++;
		}

		return tree;
	} catch (err) {
		return `${tree + spacerPrefix}Error al leer el directorio: ${err.message}\n`;
	}
}

// Función para recorrer recursivamente los directorios y obtener el contenido de los archivos markdown
function processDocuments(dir, contextContent) {
	try {
		const items = fs.readdirSync(dir);

		for (const item of items) {
			const itemPath = path.join(dir, item);

			if (shouldIgnore(itemPath)) continue;

			const stats = fs.statSync(itemPath);

			if (stats.isDirectory()) {
				// Procesar subdirectorios
				processDocuments(itemPath, contextContent);
			} else if (isDocFile(itemPath)) {
				try {
					// Contar archivos procesados
					totalArchivos++;

					// Obtener la ruta relativa desde la raíz del proyecto
					const relativePath = path.relative(rootDir, itemPath).replace(/\\/g, "/");

					// Leer el contenido del archivo
					const fileContent = fs.readFileSync(itemPath, "utf8");

					// Añadir el contenido al documento
					contextContent.push(`# ${relativePath}\n\n${fileContent}\n\n---\n\n`);

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

// Función principal
async function main() {
	const rl = createInterface();

	console.log("=== Generador de Contexto de Documentación ===");
	console.log("Este script generará un documento con el contenido de TODOS los archivos markdown del proyecto.");

	// Reiniciar contadores
	totalArchivos = 0;
	totalDirectorios = 0;

	// Asegurar que la carpeta docs existe
	const docsDir = path.join(rootDir, "docs");
	if (!fs.existsSync(docsDir)) {
		fs.mkdirSync(docsDir, { recursive: true });
	}

	const nombreArchivo = "context_docs.md";
	const contextFilePath = path.join(docsDir, nombreArchivo);

	console.log("\nGenerando contexto de documentación para todo el proyecto");
	console.log(`El resultado se guardará en: ${contextFilePath}\n`);
	console.log("Procesando archivos markdown, esto puede tardar unos momentos...");

	// Array para almacenar el contenido del contexto
	const contextContent = [];

	// Procesar los archivos markdown
	processDocuments(rootDir, contextContent);

	// Generar el árbol de directorios (solo con archivos markdown)
	const directoryTreeTitle = "# Estructura de Documentación\n\n```\n";
	const directoryTreeContent = `${path.basename(rootDir)}\n${createDirectoryTree(rootDir, "", true, 0, true)}\`\`\`\n\n`;

	// Información del proyecto
	const projectInfo = `# Información de la Documentación\n\n- **Total de archivos markdown procesados:** ${totalArchivos}\n- **Total de directorios con documentación:** ${totalDirectorios}\n- **Fecha de generación:** ${new Date().toLocaleString()}\n\n`;

	// Combinar el árbol y el contenido de los archivos
	const fullContent = `${projectInfo + directoryTreeTitle + directoryTreeContent}# Contenido de la Documentación\n\n${contextContent.join("")}`;

	// Escribir el resultado en el archivo de salida
	fs.writeFileSync(contextFilePath, fullContent, "utf8");

	console.log("\n¡Proceso completado!");
	console.log(`- Total de archivos markdown procesados: ${totalArchivos}`);
	console.log(`- Total de directorios con documentación: ${totalDirectorios}`);
	console.log(`- El contexto de documentación se ha guardado en: ${contextFilePath}`);

	rl.close();
}

// Ejecutar la función principal
main().catch((error) => {
	console.error("Error en el proceso principal:", error);
	process.exit(1);
});
