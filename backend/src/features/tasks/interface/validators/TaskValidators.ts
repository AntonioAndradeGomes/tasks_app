import { celebrate, Joi, Segments } from 'celebrate';

const createTaskValidator = celebrate({
    [Segments.BODY]: Joi.object({
        title: Joi.string().required(),
        description: Joi.string().optional().allow(null),
        hexColor: Joi.string()
            .required()
            .regex(/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/)
            .messages({
                'string.pattern.base': 'hexColor must be a valid hex code.',
                'string.empty': 'hexColor is required.',
                'any.required': 'hexColor is required.',
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
                'string.pattern.base': 'hexColor must be a valid hex code.',
                'string.empty': 'hexColor is required.',
                'any.required': 'hexColor is required.',
            }),
        due_at: Joi.date().optional().allow(null),
        completed_at: Joi.date().optional().allow(null),
    }).min(1),
});

const getTaskByIdValidator = celebrate({
    [Segments.QUERY]: Joi.object({
        taskId: Joi.string().uuid().optional().messages({
            'string.taskId': 'The taskId must be a valid uuid',
        }),
        orderBy: Joi.string()
            .valid(
                'created_at',
                'due_at',
                'completed_at',
                'updated_at',
                'title',
            )
            .optional()
            .messages({
                'any.only':
                    'The orderBy must be one of created_at, due_at, completed_at, updated_at, title',
            }),
        order: Joi.string().valid('asc', 'desc').optional().messages({
            'any.only': 'The order must be one of asc, desc',
        }),
    }),
});

export {
    createTaskValidator,
    deleteTaskValidator,
    updateTaskValidator,
    getTaskByIdValidator,
};
