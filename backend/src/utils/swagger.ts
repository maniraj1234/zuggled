// src/swagger.ts
import swaggerJsdoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';

const options = {
    // Definition for the OpenAPI Specification (Swagger)
    definition: {
        openapi: '3.0.0', 
        info: {
            title: 'Zuggled API', // Title of API
            version: '1.0.0', // Version of API
            description: 'An API for sending a simple message.', // Description
        },
        servers: [
            {
                url: 'http://localhost:3000', // Your API's base URL
                description: 'Development server',
            },
        ],
    },
    // Paths to files containing OpenAPI definitions (JSDoc comments)
    apis: [
        './src/*.ts',// Scans files like 'src/app.ts' if they have Swagger comments
        './src/routes/**/*.ts'
    ], // Point to your main application file where routes are defined
    // You can also point to specific route files like:
    // apis: ['./src/routes/*.ts', './src/controllers/*.ts'],
};

const swaggerSpec = swaggerJsdoc(options);

export { swaggerUi, swaggerSpec };