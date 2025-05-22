import js from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";
import { defineConfig } from "eslint/config";


export default defineConfig([
  {
    files: ["**/*.{js,mjs,cjs,ts,mts,cts}"],
    plugins: { js },
    rules: {
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    },
    extends: ["js/recommended"]
  },
  {
    files: ["**/*.{js,mjs,cjs,ts,mts,cts}"],
    languageOptions: {
      globals: globals.node
    }
  },
  tseslint.configs.recommended,
]);
