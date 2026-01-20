class PlanAddOnModel {
  PlanAddOnModel({
    required this.status,
    required this.addons,
  });

  final bool? status;
  final List<Addon> addons;

  factory PlanAddOnModel.fromJson(Map<String, dynamic> json){
    return PlanAddOnModel(
      status: json["status"],
      addons: json["addons"] == null ? [] : List<Addon>.from(json["addons"]!.map((x) => Addon.fromJson(x))),
    );
  }

}

class Addon {
  Addon({
    required this.id,
    required this.name,
    required this.addonKey,
    required this.addonValue,
    required this.price,
  });

  final int? id;
  final String? name;
  final String? addonKey;
  final String? addonValue;
  final String? price;

  factory Addon.fromJson(Map<String, dynamic> json){
    return Addon(
      id: json["id"],
      name: json["name"],
      addonKey: json["addon_key"],
      addonValue: json["addon_value"],
      price: json["price"],
    );
  }

}
