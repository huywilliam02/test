import 'package:account/features/e01/e01S01001/models/e01S01001_item_table.dart';
import 'package:account/features/e01/e01S01001/models/item_base_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
part 'e01S01001_state.g.dart';

@CopyWith()
class E01S01001State {
  final bool isLoading;
  final List<E01S01001ItemTable>? dataList;
  final int limit;
  final int currentPage;
  final int? numberPages;
  final bool isCheckAll;
  final List<String> checkList;
  final bool isCheckSelect;
  //
  final List<ItemBaseModel> departmentList;
  final List<ItemBaseModel> statusList;
  // header filer
  final ItemBaseModel? departmentHeaderFilter;
  final String? accountNameHeaderFilter;
  final ItemBaseModel? statusHeaderFilter;
  //
  final ItemBaseModel? departmentFilter;
  final String? accountNameFilter;
  final ItemBaseModel? statusFilter;
  final String? patientCodeFilter;
  final String? accountCodeFilter;
  final String? roleGroupFilter;

  const E01S01001State({
    this.isLoading = false,
    this.dataList,
    this.limit = 20,
    this.currentPage = 1,
    this.numberPages,
    this.isCheckAll = false,
    this.checkList = const [],
    this.isCheckSelect = false,
    this.departmentList = const [],
    this.statusList = const [],
    this.departmentHeaderFilter,
    this.accountNameHeaderFilter,
    this.statusHeaderFilter,
    this.departmentFilter,
    this.accountNameFilter,
    this.statusFilter,
    this.patientCodeFilter,
    this.accountCodeFilter,
    this.roleGroupFilter,
  });
}
