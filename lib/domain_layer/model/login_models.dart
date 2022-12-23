class Customer{
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts{
  String email;
  String phone;

  Contacts(this.email, this.phone);
}

class Authentication{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class ForgetPassword{
  String email;

  ForgetPassword(this.email);
}