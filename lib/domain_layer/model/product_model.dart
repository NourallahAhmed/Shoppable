class Product{
  int id;
  String title;
  double price;
  String category;
  String description;
  String image;
  Rating rating;

  Product(this.id, this.title, this.price, this.category, this.description,
      this.image, this.rating);
}
class Rating{
  double rate;
  int count;

  Rating(this.rate, this.count);
}