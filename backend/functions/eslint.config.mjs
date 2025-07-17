import js from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';
import { defineConfig } from 'eslint/config';
import jsdoc from 'eslint-plugin-jsdoc';
import prettierPlugin from 'eslint-plugin-prettier';
import prettierConfig from 'eslint-config-prettier';

export default defineConfig([
  {
    files: ['**/*.{js,mjs,cjs,ts,mts,cts}'],
    plugins: {
      jsdoc: jsdoc,
      prettier: prettierPlugin,
    },
    rules: {
      '@typescript-eslint/no-unused-vars': [
        'warn',
        { argsIgnorePattern: '^_' },
      ],
      //custom rules for jsdoc
      'jsdoc/check-tag-names': [
        'warn',
        {
          // Add your custom tags you want to ignore here
          definedTags: ['route', 'swagger'], // neglecting route and swagger tags
        },
      ],
      'prettier/prettier': 'error',
    },
    extends: [
      js.configs.recommended, //  @eslint/js recommended rule
      ...tseslint.configs.recommended, // typescript-eslint recommended rule
      jsdoc.configs['flat/recommended-typescript'],
      prettierConfig, // prettier config
    ],
  },
  {
    files: ['**/*.{js,mjs,cjs,ts,mts,cts}'],
    languageOptions: {
      globals: globals.node,
      parser: tseslint.parser,
    },
  },
  tseslint.configs.recommended,
]);
