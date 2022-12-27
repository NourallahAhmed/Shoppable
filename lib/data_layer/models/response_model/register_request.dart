import 'dart:html';

class RegisterRequest {
  String email;
  String password;
  String userName;
  String phone;
  String countryCode;
  File picture;

  RegisterRequest(
      this.email, this.password, this.userName, this.phone, this.countryCode, this.picture);
}
