import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:tut_advanced_clean_arch/application_layer/extensions.dart';

import '../response_model/store_response.dart';

extension ProductResponseExtension on ProductResponse {
  Product toDomain() => Product(
      this.id.notZero(),
      this.title.orEmpty(),
      this.price.notZero(),
      this.category.orEmpty(),
      this.description.orEmpty(),
      this.image.orEmpty(),
      this.rating!.toDomain()
  );
}
extension RatingResponseExtension on RatingResponse{
  Rating toDomain() => Rating(this.rate.notZero() , this.count.notZero()
  );
}
extension AllProductResponseExtension on List<ProductResponse>? {
  List<Product> toDomain() =>
      (this?.map((product) => product.toDomain())??
              const Iterable.empty())
          .cast<Product>()
          .toList();
}
