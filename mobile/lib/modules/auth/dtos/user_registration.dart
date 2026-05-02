class UserRegistration {
  String name;
  String email;
  String password;

  UserRegistration({
    this.name = '',
    this.email = '',
    this.password = '',
  });

  void setName(String name) => this.name = name;
  void setEmail(String email) => this.email = email;
  void setPassword(String password) => this.password = password;

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
