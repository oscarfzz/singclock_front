/* eslint-disable @typescript-eslint/no-var-requires */
const { generatorHandler } = require('@prisma/generator-helper');

const { moveFiles } = require('./move-files');

generatorHandler({
  /**
   * @param {import('@prisma/generator-helper').GeneratorOptions} options
   */
  async onGenerate(options) {
    try {
      const folder_names = options.dmmf.datamodel.models.map((model) =>
        model.dbName.toLowerCase().replaceAll('_', '-'),
      );

      await moveFiles(folder_names);
    } catch (error) {
      console.error(error);
    }
  },
  onManifest() {
    return {
      defaultOutput: '.',
      prettyName: 'Custom',
    };
  },
});
