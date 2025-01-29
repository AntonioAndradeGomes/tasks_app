import 'package:frontend/domain/dtos/user_registration.dart';
import 'package:lucid_validation/lucid_validation.dart';

class UserRegistrationValidator extends LucidValidator<UserRegistration> {
  UserRegistrationValidator() {
    ruleFor((credentials) => credentials.name, key: 'name')
        .notEmpty(message: 'Campo obrigatório')
        .minLength(3, message: 'Nome muito curto');

    ruleFor((credentials) => credentials.email, key: 'email')
        .notEmpty(message: 'Campo obrigatório')
        .validEmail(message: 'E-mail inválido');

    ruleFor((credentials) => credentials.password, key: 'password')
        .notEmpty(message: 'Campo obrigatório')
        .minLength(6, message: 'Senha muito curta');
  }
}
