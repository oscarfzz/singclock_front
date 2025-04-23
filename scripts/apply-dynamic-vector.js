// Script para aplicar la migración manual de vectores dinámicos
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('Aplicando migración para vectores dinámicos...');
  
  try {
    // Ejecutar la consulta SQL directamente
    await prisma.$executeRawUnsafe(`
      -- Modificar la columna embedding para usar vector sin dimensión fija
      ALTER TABLE "community_post" 
      ALTER COLUMN "embedding" TYPE vector USING embedding::vector;
    `);
    
    console.log('Migración aplicada correctamente');
  } catch (error) {
    console.error('Error al aplicar la migración:', error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });
