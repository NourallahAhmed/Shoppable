
import 'package:json_annotation/json_annotation.dart';

part 'store_response.g.dart';

@JsonSerializable()
class ProductResponse{

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "description")
  String? description;


  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "image")
  String? image;


  @JsonKey(name: "rating")
  RatingResponse? rating;


  ProductResponse(this.id, this.title, this.price, this.description,
      this.category, this.image, this.rating);
  //fromJson
  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class RatingResponse {

  @JsonKey(name: "count")
  int? count;


  @JsonKey(name: "rate")
  double? rate;

  RatingResponse(this.count, this.rate); //fromJson
  factory RatingResponse.fromJson(Map<String, dynamic> json) => _$RatingResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}



