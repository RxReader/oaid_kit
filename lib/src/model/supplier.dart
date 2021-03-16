import 'package:json_annotation/json_annotation.dart';

part 'supplier.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class Supplier {
  const Supplier({
    this.isSupported,
    this.oaid,
    this.vaid,
    this.aaid,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);

  final bool isSupported;

  /// 华为设备上开启限制广告跟踪，oaid 为 00000000-0000-0000-0000-000000000000
  final String oaid;
  final String vaid;
  final String aaid;

  Map<String, dynamic> toJson() => _$SupplierToJson(this);
}
