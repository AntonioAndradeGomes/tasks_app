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
        due_at: Joi.date(),
        completed_at: Joi.date(),
    }),
});

const deleteTaskValidator = celebrate({
    [Segments.PARAMS]: Joi.object({
        id: Joi.string().uuid().required(),
    }),
});

export {createTaskValidator, deleteTaskValidator};
