import 'package:tut_advanced_clean_arch/application_layer/extensions.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import '../response_model/response.dart';

extension CustomerResponseExtension on CustomerResponse{
  Customer toDomain() => Customer(id.orEmpty(), name.orEmpty(), numOfNotifications.notZero());
}

extension ContactsResponseExtension on ContactsResponse{
  Contacts toDomain() => Contacts(email.orEmpty(), phone.orEmpty());
}

extension AuthenticationResponseExtension on AuthenticationResponse{
  Authentication toDomain() => Authentication(customer?.toDomain() , contacts?.toDomain());
}