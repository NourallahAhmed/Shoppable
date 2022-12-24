
import 'package:json_annotation/json_annotation.dart';


/// commend line: flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);

  //formJson
  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone")
  String? phone;

  ContactsResponse(this.email, this.phone);

  //formJson
  factory ContactsResponse.fromJson(Map<String, dynamic> json) => _$ContactsResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}


@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse{
  @JsonKey(name: "support")
  String? support;

  ForgetPasswordResponse(this.support);

  //formJson
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgetPasswordResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}
@JsonSerializable()
class AuthenticationResponse extends BaseResponse{

  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  //fromJson
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}