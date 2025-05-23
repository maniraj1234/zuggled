/**
 * @description
 * Swagger configuration for API documentation.
 * - Uses swagger-jsdoc to generate OpenAPI definitions from JSDoc comments.
 * - Uses swagger-ui-express to serve the Swagger UI.
 * usage:
 *  - define in your routes using JSDoc comments
 *  - use swaggerUi.serve and swaggerUi.setup in your main app via a middleware
 *  - access the Swagger UI at /api-docs
 */
import swaggerJsdoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';
import dotenv from 'dotenv';
dotenv.config();
const appPort: string = process.env.PORT || '3000';
const options = {
  // Definition for the Swagger API
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Zuggled API', // Title of API
      version: '1.0.0',
      description: 'An API for sending a simple message.',
    },
    servers: [
      {
        url: `http://localhost:${appPort}`, // sAPI's base URL
        description: 'Development server',
      },
    ],
  },
  // Paths to files containing OpenAPI definitions (JSDoc comments)
  apis: [
    './src/*.ts', // Scans files like 'src/app.ts' if they have Swagger comments
    './src/routes/**/*.ts',
  ], // Point to your main application file where routes are defined
};

const swaggerSpec = swaggerJsdoc(options);

export { swaggerUi, swaggerSpec };
