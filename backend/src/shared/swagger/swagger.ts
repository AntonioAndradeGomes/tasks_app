import swaggerJSDoc from "swagger-jsdoc";
import { Express } from "express";
import swaggerUi from "swagger-ui-express";

const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "API de Tarefas",
            version: "1.0.0",
            description: "API para gerenciamento de tarefas",
        },
        components: {
            schemas: {
                Task: {
                    type: "object",
                    properties: {
                        id: { type: "string", description: "Unique identifier for the task" },
                        title: { type: "string", description: "Title of the task" },
                        description: { type: "string", description: "Description of the task" },
                        hexColor: { type: "string", description: "Hex color code for the task" },
                        user_id: { type: "string", description: "User ID associated with the task" },
                        due_at: { type: "string", format: "date-time", description: "Date on which the user believes he will complete the task" },
                        completed_at: { type: "string", format: "date-time", description: "Date on which the user completed the task" },
                        created_at: { type: "string", format: "date-time", description: "Date on which the task was created" },
                        updated_at: { type: "string", format: "date-time", description: "Date on which the task was last updated" },
                    },
                },
                Credentials: {
                    type: "object",
                    properties: {
                        email: {
                            type: "string",
                            description: "Email address of the user",
                            format: "email"
                        },
                        password: {
                            type: "string",
                            format: "password"
                        }
                    }
                },
                SignupUserRequest: {
                    type: "object",
                    properties: {
                        name: {
                            type: "string",
                            description: "Name of the user"
                        },
                        email: {
                            type: "string",
                            description: "Email address of the user",
                            format: "email"
                        },
                        password: {
                            type: "string",
                            format: "password"
                        }
                    }
                },
                AuthResponse: {
                    type: "object",
                    properties: {
                        user: {
                            type: "object",
                            $ref: "#/components/schemas/User"
                        },
                        token: {
                            type: "string",
                            format: "JWT"
                        }
                    }
                },
                User:{
                    type: "object",
                    properties: {
                        id: { type: "string", description: "Unique identifier for the user", format: "uuid" },
                        name: { type: "string", description: "Name of the user" },
                        email: { type: "string", description: "Email address of the user", format: "email" },
                        created_at: { type: "string", format: "date-time", description: "Date on which the user was created" },
                        updated_at: { type: "string", format: "date-time", description: "Date on which the user was last updated" },
                    }
                },
                ErrorResponse: {
                    type: "object",
                    properties: {
                        message: { type: "string", description: "Error message" },
                        errors: { type: "array", items: { type: "string" }, description: "List of validation errors" },
                        status: { type: "string", description: "Status code" },
                    },
                }
            }
        },
        servers: [
            {
                url: `http://localhost:${process.env.PORT || 3000}`,
                description: "Servidor local",
            },
        ],

        paths:{
            "/auth/login": {
                post: {
                    tags: ["Authentication"],
                    description: "Login user",
                    requestBody: {
                        content: {
                            "application/json": {
                                schema: {
                                    "$ref": "#/components/schemas/Credentials"
                                },
                                exemple: {
                                    email: "teste@gmail.com",
                                    password: "123456"
                                },
                            }
                        },
                        
                    },
                    responses: {
                        201: {
                            description: "User logged in successfully",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/AuthResponse"
                                    }
                                }
                            }
                        },
                        400: {
                            description: "Bad request - Invalid credentials or user not found",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/ErrorResponse"
                                    }
                                }
                            }
                        },
                        500: {
                            description: "Internal server error",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/ErrorResponse"
                                    }
                                }
                            }
                        }
                    }
                    
                }
            },
            "/auth/signup": {
                post: {
                    description: "Sign up user",
                    tags: ["Authentication"],
                    requestBody: {
                        content: {
                            "application/json": {
                                schema: {
                                    "$ref": "#/components/schemas/SignupUserRequest"
                                }
                            }
                        },
                    },
                    responses: {
                        201: {
                            description: "User signed up successfully",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/User"
                                    }
                                }
                            }
                        },
                        400: {
                            description: "Bad request - Invalid credentials or user already exists",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/ErrorResponse"
                                    }
                                }
                            }
                        },
                        500: {
                            description: "Internal server error",
                            content: {
                                "application/json": {
                                    schema: {
                                        "$ref": "#/components/schemas/ErrorResponse"
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
    },
    apis: [
        "./src/features/user/interface/routes/auth.routes.ts", 
        "./src/features/tasks/interface/routes/tasks.routes.ts"
    ],
};

const swaggerSpec = swaggerJSDoc(options);

function setupSwagger(app: Express, PORT: string) {
    app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

    app.get("/docs.json", (req, res) => {
        res.setHeader("Content-Type", "application/json");
        res.send(swaggerSpec);
    });

    console.log(`Swagger documentation available at http://localhost:${PORT}/docs`);
}

export { setupSwagger };
