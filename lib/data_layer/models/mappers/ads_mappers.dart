import '/application_layer/extensions.dart';

import '../../../domain_layer/model/Ads_Model.dart';
import '../response_model/response.dart';

extension AdsResponseExtension on AdResponse {
  AdsModel toDomain() =>
         AdsModel(image.orEmpty());

}
extension AdsResponseExtensions on List<AdResponse> {
  List<AdsModel> toDomain() =>( map((e) => e.toDomain())).toList();

}
