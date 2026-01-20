import 'package:stream4videos/features/home/data/model/common_model/sub_cat_data_model.dart';

class GetSubCategoriesModel {
  GetSubCategoriesModel({
    required this.success,
    required this.data,
  });

  final bool? success;
  final List<SubCatDataModel> data;

  factory GetSubCategoriesModel.fromJson(Map<String, dynamic> json){
    return GetSubCategoriesModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<SubCatDataModel>.from(json["data"]!.map((x) => SubCatDataModel.fromJson(x))),
    );
  }

}


