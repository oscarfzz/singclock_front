# Scripts

## 1. Descripción General
El módulo Scripts proporciona utilidades de automatización para tareas de desarrollo, generación de documentación y migraciones de base de datos. Es fundamental para optimizar el flujo de trabajo, gestionar los archivos generados por Prisma y mantener la documentación técnica actualizada.

## 2. Arquitectura
```
scripts/
  ├── generator/
  │    ├── index.js         # Punto de entrada para el generador personalizado de Prisma
  │    └── move-files.js    # Utilidad para mover archivos generados
  ├── generate-explain-docs.js  # Genera documentación técnica consolidada
  └── apply-dynamic-vector.js   # Aplica migraciones a vectores en la BD
```

## 3. Funcionalidades Principales
- **Generación de documentación**: Recopila archivos EXPLAIN.md y genera ia_explain.md
- **Generador personalizado Prisma**: Reorganiza archivos generados según la estructura de módulos
- **Migraciones manuales**: Ejecuta SQL personalizado para vectores dinámicos en PostgreSQL

**Tecnologías**: Node.js, Prisma Client, @prisma/generator-helper, sistema de archivos (fs)

**Código clave**:
```javascript
// Generador personalizado (generator/index.js)
generatorHandler({
  async onGenerate(options) {
    const folder_names = options.dmmf.datamodel.models.map((model) =>
      model.dbName.toLowerCase().replaceAll('_', '-'),
    );
    await moveFiles(folder_names);
  }
});

// Migración manual (apply-dynamic-vector.js)
await prisma.$executeRawUnsafe(`
  ALTER TABLE "community_post" 
  ALTER COLUMN "embedding" TYPE vector USING embedding::vector;
`);
```

## 4. Flujos de Ejecución
1. **Generate Explain Docs**: Busca EXPLAIN.md recursivamente → Lee contenido → Genera ia_explain.md
2. **Generador Personalizado**: Se activa con `prisma generate` → Reorganiza archivos generados
3. **Apply Dynamic Vector**: Conecta con Prisma → Ejecuta SQL → Desconecta

## 5. Casos de Uso
- **Documentación**: `npm run generate:docs` - Genera documentación centralizada
- **Código**: `npm run generate` - Genera y organiza archivos Prisma
- **Migraciones**: `node scripts/apply-dynamic-vector.js` - Modifica columnas de vectores

**Interacciones**: Integrado con Prisma, recorre todos los módulos, habilita búsquedas semánticas.

## 6. Importancia y Recomendaciones
- **Beneficios**: Automatización, consistencia, documentación centralizada, flexibilidad
- **Consejos**: Ejecutar `generate:docs` periódicamente, usar el generador personalizado de Prisma, documentar las migraciones manuales

## 7. Consideraciones Técnicas
- No requiere variables de entorno específicas
- Configurado en `prisma/social/social.prisma`
- **Posibles mejoras**: CLI unificada, integración con CI/CD
- Sigue convenciones de JavaScript con JSDoc y mensajes claros con emojis

## 8. Conclusión
El módulo Scripts automatiza tareas esenciales para mantener la coherencia del proyecto, documentación actualizada y permitir operaciones avanzadas con la base de datos. Su diseño modular facilita su mantenimiento y extensión. 