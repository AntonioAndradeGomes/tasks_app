import { celebrate, Joi, Segments } from "celebrate";

const createTaskValidator = celebrate({
    [Segments.BODY]: Joi.object({
        title: Joi.string().required(),
        description: Joi.string().required(),
        hexColor: Joi.string()
        .required()
        .regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
        .messages({
            "string.pattern.base": "hexColor must be a valid hex code.",
            "string.empty": "hexColor is required.",
            "any.required": "hexColor is required."
        }),
        due_at: Joi.date().optional(),
        completed_at: Joi.date().optional(),
    }),
});

const deleteTaskValidator = celebrate({
    [Segments.PARAMS]: Joi.object({
        id: Joi.string().uuid().required(),
    }),
});

const updateTaskValidator = celebrate({
    [Segments.PARAMS]: Joi.object({
        id: Joi.string().uuid().required(),
    }),
    [Segments.BODY]: Joi.object({
        title: Joi.string().optional(),
        description: Joi.string().optional(),
        hexColor: Joi.string()
        .optional()
        .regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
        .messages({
            "string.pattern.base": "hexColor must be a valid hex code.",
            "string.empty": "hexColor is required.",
            "any.required": "hexColor is required."
        }),
        due_at: Joi.date().optional(),
        completed_at: Joi.date().optional(),
    }).min(1),
});

export {createTaskValidator, deleteTaskValidator, updateTaskValidator};
