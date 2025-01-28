import { celebrate, Joi, Segments } from 'celebrate';

const loginUserValidator = celebrate({
    [Segments.BODY]: Joi.object({
        email: Joi.string().email().required(),
        password: Joi.string().required(),
    }),
});

const signupUserValidator = celebrate({
    [Segments.BODY]: Joi.object({
        name: Joi.string().required(),
        email: Joi.string().email().required(),
        password: Joi.string().required().min(6),
    }),
});

export { loginUserValidator, signupUserValidator };
