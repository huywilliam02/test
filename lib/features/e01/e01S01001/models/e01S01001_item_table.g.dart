// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e01S01001_item_table.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$E01S01001ItemTableCWProxy {
  E01S01001ItemTable isCheck(bool? isCheck);

  E01S01001ItemTable patientCode(String? patientCode);

  E01S01001ItemTable accountCode(String? accountCode);

  E01S01001ItemTable accountName(String? accountName);

  E01S01001ItemTable roleGroup(String? roleGroup);

  E01S01001ItemTable department(String? department);

  E01S01001ItemTable status(int? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `E01S01001ItemTable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// E01S01001ItemTable(...).copyWith(id: 12, name: "My name")
  /// ````
  E01S01001ItemTable call({
    bool? isCheck,
    String? patientCode,
    String? accountCode,
    String? accountName,
    String? roleGroup,
    String? department,
    int? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfE01S01001ItemTable.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfE01S01001ItemTable.copyWith.fieldName(...)`
class _$E01S01001ItemTableCWProxyImpl implements _$E01S01001ItemTableCWProxy {
  const _$E01S01001ItemTableCWProxyImpl(this._value);

  final E01S01001ItemTable _value;

  @override
  E01S01001ItemTable isCheck(bool? isCheck) => this(isCheck: isCheck);

  @override
  E01S01001ItemTable patientCode(String? patientCode) =>
      this(patientCode: patientCode);

  @override
  E01S01001ItemTable accountCode(String? accountCode) =>
      this(accountCode: accountCode);

  @override
  E01S01001ItemTable accountName(String? accountName) =>
      this(accountName: accountName);

  @override
  E01S01001ItemTable roleGroup(String? roleGroup) => this(roleGroup: roleGroup);

  @override
  E01S01001ItemTable department(String? department) =>
      this(department: department);

  @override
  E01S01001ItemTable status(int? status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `E01S01001ItemTable(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// E01S01001ItemTable(...).copyWith(id: 12, name: "My name")
  /// ````
  E01S01001ItemTable call({
    Object? isCheck = const $CopyWithPlaceholder(),
    Object? patientCode = const $CopyWithPlaceholder(),
    Object? accountCode = const $CopyWithPlaceholder(),
    Object? accountName = const $CopyWithPlaceholder(),
    Object? roleGroup = const $CopyWithPlaceholder(),
    Object? department = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return E01S01001ItemTable(
      isCheck: isCheck == const $CopyWithPlaceholder()
          ? _value.isCheck
          // ignore: cast_nullable_to_non_nullable
          : isCheck as bool?,
      patientCode: patientCode == const $CopyWithPlaceholder()
          ? _value.patientCode
          // ignore: cast_nullable_to_non_nullable
          : patientCode as String?,
      accountCode: accountCode == const $CopyWithPlaceholder()
          ? _value.accountCode
          // ignore: cast_nullable_to_non_nullable
          : accountCode as String?,
      accountName: accountName == const $CopyWithPlaceholder()
          ? _value.accountName
          // ignore: cast_nullable_to_non_nullable
          : accountName as String?,
      roleGroup: roleGroup == const $CopyWithPlaceholder()
          ? _value.roleGroup
          // ignore: cast_nullable_to_non_nullable
          : roleGroup as String?,
      department: department == const $CopyWithPlaceholder()
          ? _value.department
          // ignore: cast_nullable_to_non_nullable
          : department as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
    );
  }
}

extension $E01S01001ItemTableCopyWith on E01S01001ItemTable {
  /// Returns a callable class that can be used as follows: `instanceOfE01S01001ItemTable.copyWith(...)` or like so:`instanceOfE01S01001ItemTable.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$E01S01001ItemTableCWProxy get copyWith =>
      _$E01S01001ItemTableCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

E01S01001ItemTable _$E01S01001ItemTableFromJson(Map<String, dynamic> json) =>
    E01S01001ItemTable(
      isCheck: json['isCheck'] as bool? ?? false,
      patientCode: json['Id'] as String?,
      accountCode: json['StaffCode'] as String?,
      accountName: json['FullName'] as String?,
      roleGroup: json['OrganizationName'] as String?,
      department: json['JobPositionName'] as String?,
      status: (json['TrangThaiCongViec'] as num?)?.toInt(),
    );

Map<String, dynamic> _$E01S01001ItemTableToJson(E01S01001ItemTable instance) =>
    <String, dynamic>{
      'isCheck': instance.isCheck,
      'Id': instance.patientCode,
      'StaffCode': instance.accountCode,
      'FullName': instance.accountName,
      'OrganizationName': instance.roleGroup,
      'JobPositionName': instance.department,
      'TrangThaiCongViec': instance.status,
    };
