import 'package:tut_advanced_clean_arch/application_layer/extensions.dart';
import 'package:tut_advanced_clean_arch/data_layer/response_model/response.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';

extension CustomerResponseExtension on CustomerResponse{
  Customer toDomain() => Customer(id.orEmpty(), name.orEmpty(), numOfNotifications.notZero());
}

extension ContactsResponseExtension on ContactsResponse{
  Contacts toDomain() => Contacts(email.orEmpty(), phone.notZero());
}

extension AuthenticationResponseExtension on AuthenticationResponse{
  Authentication toDomain() => Authentication(customer?.toDomain() , contacts?.toDomain());
}