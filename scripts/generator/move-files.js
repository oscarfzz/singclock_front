/* eslint-disable @typescript-eslint/no-var-requires */
const fs = require('fs');
const path = require('path');

const BASE_PATH = path.join(__dirname, '../../');
const APP_PATH = path.join(BASE_PATH, 'apps/social/src/modules');
const GENERATED_PATH = path.join(BASE_PATH, 'libs/prisma-client/src/generated');
const PRISMA_PATH = path.join(BASE_PATH, 'libs/prisma-client/src');
const SUFIX = 'generated';

// Define which files should be moved to which folders
const fileMappings = [
  {
    from: [`${GENERATED_PATH}/user-client/${SUFIX}`],
    to: `${APP_PATH}/user-client/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/user-admin/${SUFIX}`],
    to: `${APP_PATH}/user-admin/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/client-profile/${SUFIX}`],
    to: `${APP_PATH}/client-profile/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/credential/${SUFIX}`],
    to: `${APP_PATH}/credential/${SUFIX}`,
  },
  {
    from: [
      `${GENERATED_PATH}/multimedia/${SUFIX}`,
      `${GENERATED_PATH}/multimedia-on-post/${SUFIX}`,
    ],
    to: `${APP_PATH}/multimedia/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/organization/${SUFIX}`],
    to: `${APP_PATH}/organization/${SUFIX}`,
  },
  {
    from: [
      `${GENERATED_PATH}/post/${SUFIX}`,
      `${GENERATED_PATH}/post-on-social-network/${SUFIX}`,
    ],
    to: `${APP_PATH}/post/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/social-network/${SUFIX}`],
    to: `${APP_PATH}/social-network/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/template/${SUFIX}`],
    to: `${APP_PATH}/template/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/carrousel-content/${SUFIX}`],
    to: `${APP_PATH}/carrousel-content/${SUFIX}`,
  },
  {
    from: [`${GENERATED_PATH}/prisma/${SUFIX}`],
    to: `${PRISMA_PATH}/prisma/${SUFIX}`,
  },
];
// Function to move a file
const moveFile = async (source, destination) => {
  try {
    await fs.promises.rename(source, destination);
    console.log(`Moved ${source} to ${destination}`);
  } catch (err) {
    throw err;
  }
};

// Function to remove empty directories
const removeEmptyDirectories = async (folderPaths) => {
  for (const folderPath of folderPaths) {
    if (fs.existsSync(folderPath)) {
      try {
        fs.promises.rm(folderPath, { recursive: true, force: true });
      } catch (err) {
        console.error(`Error removing empty directory: ${folderPath}`);
        throw err;
      }
    }
  }
};
/**
 * Go through the fileMappings object and move the files to the corresponding folders
 * @param {string[]} folderNames
 *
 */
const moveFiles = async (folderNames) => {
  console.log(folderNames);
  const formated_folder_names = folderNames
    .map((folder) => {
      return `${GENERATED_PATH}/${folder}/${SUFIX}`;
    })
    .concat([`${GENERATED_PATH}/prisma/${SUFIX}`]);

  const formated_folder_base_names = folderNames
    .map((folder) => {
      return `${GENERATED_PATH}/${folder}`;
    })
    .concat([`${GENERATED_PATH}`]);

  try {
    for (const mapping of fileMappings) {
      for (const folderName of formated_folder_names) {
        if (mapping.from.includes(folderName)) {
          const sourcePath = folderName;
          const destinationPath = mapping.to;
          // Check if destination folder exists, if not create it
          if (!fs.existsSync(destinationPath)) {
            fs.mkdirSync(destinationPath, { recursive: true });
          }
          // Move all files from sourcePath to destinationPath
          const files = fs.readdirSync(sourcePath);
          for (const file of files) {
            await moveFile(
              path.join(sourcePath, file),
              path.join(destinationPath, file),
            );
          }
        }
      }
    }
    // Remove empty directories
    await removeEmptyDirectories(formated_folder_base_names);
  } catch (error) {
    console.error(error);
  }
};

module.exports = { moveFiles };
