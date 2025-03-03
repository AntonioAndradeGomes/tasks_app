import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String? orderBy;
  final String? order;

  const FilterModel({
    this.orderBy,
    this.order,
  });

  factory FilterModel.empty() => const FilterModel();

  Map<String, dynamic> toQuery() {
    return {
      if (orderBy != null) 'orderBy': orderBy,
      if (order != null) 'order': order,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'orderBy': orderBy ?? '',
      'order': order ?? '',
    };
  }

  factory FilterModel.fromMap(Map<String, dynamic> json) {
    return FilterModel(
      order: json['order'],
      orderBy: json['orderBy'],
    );
  }

  @override
  List<Object?> get props => [order, orderBy];
}
