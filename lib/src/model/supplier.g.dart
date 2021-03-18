// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplier _$SupplierFromJson(Map<String, dynamic> json) {
  return Supplier(
    isSupported: json['is_supported'] as bool,
    oaid: json['oaid'] as String?,
    vaid: json['vaid'] as String?,
    aaid: json['aaid'] as String?,
  );
}

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
      'is_supported': instance.isSupported,
      'oaid': instance.oaid,
      'vaid': instance.vaid,
      'aaid': instance.aaid,
    };
