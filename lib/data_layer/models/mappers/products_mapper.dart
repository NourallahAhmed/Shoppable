import '/domain_layer/model/product_model.dart';
import '/application_layer/extensions.dart';

import '../response_model/store_response.dart';

extension ProductResponseExtension on ProductResponse {
  Product toDomain() => Product(
      id.notZero(),
      title.orEmpty(),
      price.notZero(),
      category.orEmpty(),
      description.orEmpty(),
      image.orEmpty(),
      rating!.toDomain()
  );


}
extension ProductExtension on Product {
  ProductResponse toData() => ProductResponse(
      id.notZero(),
      title.orEmpty(),
      price.notZero(),
      category.orEmpty(),
      description.orEmpty(),
      image.orEmpty(),
      rating.toData()
  );


}
extension RatingExtension on Rating{
  RatingResponse toData() => RatingResponse( count.notZero() , rate.notZero());
}
extension RatingResponseExtension on RatingResponse{
  Rating toDomain() => Rating(rate.notZero() , count.notZero()
  );
}
extension AllProductResponseExtension on List<ProductResponse>? {
  List<Product> toDomain() =>
      (this?.map((product) => product.toDomain())??
              const Iterable.empty())
          .cast<Product>()
          .toList();
}
