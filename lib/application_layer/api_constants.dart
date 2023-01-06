class ApiConstants{
  static const String baseUrl = "https://shoppable.mocklab.io/";
  static const String storeBaseUrl = "https://fakestoreapi.com/";
  static const String ads = "ads";

  static const String allProducts = "products";
  static const String sortDesc = "/products?sort=desc";
  static const String sortAsec = "/products?sort=asec";
  static const String categories = "/products/categories";
  static String specificCategory(String category) => "$storeBaseUrl$categories/$category";

  static const String loginEndPoint = "/customers/login";
  static const String forgetPasswordEndPoint = "/customer/forgetPassword";
  static const String registerEndPoint = "/customers/register";
  static const int apiTime = 60000;
  static const String token = "Send Token Here";


}


class Categories{
 static String electronics = "electronics";
 static String jewelery = "jewelery";
 static String men = "men's clothing";
 static String women = "women's clothing";
}