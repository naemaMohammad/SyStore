import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_delivery_zones_model.g.dart';

@JsonSerializable()
class cart_delivery_zones_model {
  String? message;
  @JsonKey(name: "delivery_zones")
  List<DeliveryZones>? deliveryZones;

  cart_delivery_zones_model({this.message, this.deliveryZones});

  factory cart_delivery_zones_model.fromJson(Map<String, dynamic> json) =>
      _$cart_delivery_zones_modelFromJson(json);
  Map<String, dynamic> toJson() => _$cart_delivery_zones_modelToJson(this);
}

@JsonSerializable()
class DeliveryZones {
  int? id;
  @JsonKey(name: "sector_name_ar")
  String? sectorNameAr;
  @JsonKey(name: "sector_name_en")
  String? sectorNameEn;
  @JsonKey(name: "regions_ar")
  String? regionsAr;
  @JsonKey(name: "regions_en")
  String? regionsEn;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  Pivot? pivot;

  DeliveryZones({
    this.id,
    this.sectorNameAr,
    this.sectorNameEn,
    this.regionsAr,
    this.regionsEn,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  
  String get sectorName {
    final isArabic = Get.locale?.languageCode == 'ar';
    final name = isArabic ? sectorNameAr : sectorNameEn;
    return (name != null && name.trim().isNotEmpty)
        ? name
        : (sectorNameEn ?? sectorNameAr ?? "");
  }

  
  List<String> get regionsList {
    final isArabic = Get.locale?.languageCode == 'ar';
    final raw = isArabic ? regionsAr : regionsEn;
    final source = (raw != null && raw.trim().isNotEmpty)
        ? raw
        : (regionsEn ?? regionsAr ?? "");

    if (source.isEmpty) return [];
    
    return source
        .split(RegExp(r'[,،]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  factory DeliveryZones.fromJson(Map<String, dynamic> json) =>
      _$DeliveryZonesFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryZonesToJson(this);
}

@JsonSerializable()
class Pivot {
  @JsonKey(name: "store_id")
  int? storeId;
  @JsonKey(name: "delivery_zone_id")
  int? deliveryZoneId;
  String? price;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Pivot({
    this.storeId,
    this.deliveryZoneId,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);
  Map<String, dynamic> toJson() => _$PivotToJson(this);
}