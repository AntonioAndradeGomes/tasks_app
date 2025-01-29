import 'package:frontend/domain/dtos/credentials.dart';
import 'package:lucid_validation/lucid_validation.dart';

class CredentialsValidator extends LucidValidator<Credentials> {
  CredentialsValidator() {
    ruleFor((credentials) => credentials.email, key: 'email')
        .notEmpty(
          message: 'Campo obrigatório',
        )
        .validEmail(
          message: 'Email inválido',
        );

    ruleFor((credentials) => credentials.password, key: 'password')
        .notEmpty(
          message: 'Campo obrigatório',
        )
        .minLength(6, message: 'Senha muito curta');
  }
}
