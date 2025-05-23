// prettier.config.js
/** @type {import("prettier").Config} */
const config = {
    semi: true, // Add semicolons at the end of statements
    trailingComma: "all", // Add trailing commas wherever valid in ES5 (objects, arrays, etc.)
    singleQuote: true, // Use single quotes instead of double quotes
    printWidth: 80, // Specify the line length that Prettier will wrap on
    tabWidth: 2, // Specify the number of spaces per indentation-level
    useTabs: false, // Indent with spaces instead of tabs
};

export default config;