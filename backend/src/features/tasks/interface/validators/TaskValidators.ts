import { celebrate, Joi, Segments } from "celebrate";

const createTaskValidator = celebrate({
    [Segments.BODY]: Joi.object({
        title: Joi.string().required(),
        description: Joi.string().optional().allow(null),
        hexColor: Joi.string()
        .required()
        .regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
        .messages({
            "string.pattern.base": "hexColor must be a valid hex code.",
            "string.empty": "hexColor is required.",
            "any.required": "hexColor is required."
        }),
        due_at: Joi.date().optional().allow(null),
        completed_at: Joi.date().optional().allow(null),
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
        description: Joi.string().optional().allow(null),
        hexColor: Joi.string()
        .optional()
        .regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
        .messages({
            "string.pattern.base": "hexColor must be a valid hex code.",
            "string.empty": "hexColor is required.",
            "any.required": "hexColor is required."
        }),
        due_at: Joi.date().optional().allow(null),
        completed_at: Joi.date().optional().allow(null),
    }).min(1),
});

export {createTaskValidator, deleteTaskValidator, updateTaskValidator};
