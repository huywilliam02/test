import 'dart:developer';
import 'package:account/features/e01/e01S01001/models/e01S01001_filter_table_request.dart';
import 'package:account/features/e01/e01S01001/models/e01S01001_item_table.dart';
import 'package:account/features/e01/e01S01001/models/item_base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'e01S01001_state.dart';

class E01S01001Bloc extends Cubit<E01S01001State> {
  E01S01001Bloc() : super(const E01S01001State());

  final dio = Dio();

  onStart() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      var departmentList = <ItemBaseModel>[];
      Response responseDepartments =
          await dio.get('https://apihrm.issvn.net/apimobile/countryList');
      if (responseDepartments.statusCode == 200) {
        departmentList = ItemBaseModel.fromJsonArray(responseDepartments.data);
      }

      final statusList = [
        ItemBaseModel(id: 0, name: 'Tất cả'),
        ItemBaseModel(id: 1, name: 'Sử dụng'),
        ItemBaseModel(id: 2, name: 'Không sử dụng'),
      ];

      emit(state.copyWith(
        departmentList: departmentList,
        statusList: statusList,
        statusHeaderFilter: statusList[1],
        statusFilter: statusList[1],
      ));

      await onFetch();
    } catch (e) {
      log(e.toString());
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }

  onFetch({
    int? limitChange,
    int? currentPageChange,
    ItemBaseModel? departmentFilterChange,
    String? accountNameFilterChange,
    ItemBaseModel? statusFilterChange,
    String? patientCodeFilterChange,
    String? accountCodeFilterChange,
    String? roleGroupFilterChange,
  }) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final _limitChange = limitChange ?? state.limit;
    final _currentPageChange = currentPageChange ?? state.currentPage;
    final _departmentHeaderFilterChange = state.departmentHeaderFilter;
    final _accountNameHeaderFilterChange = state.accountNameHeaderFilter;
    final _statusHeaderFilterChange = state.statusHeaderFilter;
    final _departmentFilterChange =
        departmentFilterChange ?? state.departmentFilter;
    final _accountNameFilterChange =
        accountNameFilterChange ?? state.accountNameFilter;
    final _statusFilterChange = statusFilterChange ?? state.statusFilter;
    final _patientCodeFilterChange =
        patientCodeFilterChange ?? state.patientCodeFilter;
    final _accountCodeFilterChange =
        accountCodeFilterChange ?? state.accountCodeFilter;
    final _roleGroupFilterChange =
        roleGroupFilterChange ?? state.roleGroupFilter;

    try {
      final request = E01S01001FilterTableRequest(
        limit: _limitChange,
        page: _currentPageChange,
        keyword: _accountNameHeaderFilterChange,
        hascount: true,
      );

      Response response = await dio.get(
        'https://apihrm.issvn.net/apiMobile/EmployeeSuggestionViewListMany',
        queryParameters: request.toJson(),
      );

      var dataList = <E01S01001ItemTable>[];
      var numberPages = 1;
      if (response.statusCode == 200) {
        dataList = E01S01001ItemTable.fromJsonArray(response.data['Many']);
        final count = response.data['Count'];
        numberPages = (count / _limitChange).floor();
      }

      if (state.isCheckAll) {
        dataList = dataList.map((e) => e.copyWith(isCheck: true)).toList();
      } else if (state.checkList.isNotEmpty) {
        dataList = dataList.map((e) {
          if (state.checkList.contains(e.patientCode)) {
            return e.copyWith(isCheck: true);
          }
          return e;
        }).toList();
      }

      emit(state.copyWith(
        dataList: dataList,
        numberPages: numberPages,
        limit: _limitChange,
        currentPage: _currentPageChange,
        departmentFilter: _departmentFilterChange,
        accountNameFilter: _accountNameFilterChange,
        statusFilter: _statusFilterChange,
        patientCodeFilter: _patientCodeFilterChange,
        accountCodeFilter: _accountCodeFilterChange,
        roleGroupFilter: _roleGroupFilterChange,
      ));
    } catch (e) {
      log(e.toString());
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }

  onCheck({
    required String patientCode,
    required bool valueCheck,
  }) {
    final dataList = List<E01S01001ItemTable>.from(state.dataList ?? []);
    final checkList = List<String>.from(state.checkList);

    final index = dataList.indexWhere(
      (element) => element.patientCode == patientCode,
    );

    if (valueCheck == true) {
      checkList.add(patientCode);
      dataList[index] = dataList[index].copyWith(isCheck: true);
    } else {
      checkList.removeWhere((element) => element == patientCode);
      dataList[index] = dataList[index].copyWith(isCheck: false);
    }

    emit(state.copyWith(
      dataList: dataList,
      checkList: checkList,
    ));
  }

  onCheckAll(bool valueCheck) {
    var dataList = List<E01S01001ItemTable>.from(state.dataList ?? []);

    if (valueCheck == true) {
      dataList = dataList.map((e) => e.copyWith(isCheck: true)).toList();
    } else {
      dataList = dataList.map((e) => e.copyWith(isCheck: false)).toList();
    }

    emit(state.copyWith(
      isCheckAll: valueCheck,
      dataList: dataList,
      checkList: [],
    ));
  }

  onCheckSelect() {
    emit(state.copyWith(
      isCheckSelect: !state.isCheckSelect,
    ));
  }

  onDepartmentHeaderFilterChange(ItemBaseModel? data) {
    emit(state.copyWith(
      departmentHeaderFilter: data,
    ));
  }

  onAccountNameHeaderFilterChange(String? data) {
    emit(state.copyWith(
      accountNameHeaderFilter: data,
    ));
  }

  onStatusHeaderFilterChange(ItemBaseModel? data) {
    emit(state.copyWith(
      statusHeaderFilter: data,
    ));
  }
}
