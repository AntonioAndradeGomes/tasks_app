import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String? orderByField;
  final bool? orderByAsc;

  const FilterModel({
    this.orderByField,
    this.orderByAsc,
  });

  factory FilterModel.empty() => const FilterModel();

  FilterModel copyWith({
    String? orderByField,
    bool? orderByAsc,
  }) {
    return FilterModel(
      orderByField: orderByField ?? this.orderByField,
      orderByAsc: orderByAsc ?? this.orderByAsc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderBy': orderByField ?? 'created_at',
      'order': (orderByAsc ?? false) ? 'desc' : 'asc',
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'orderByField': orderByField,
      'orderByAsc': orderByAsc,
    };
  }

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      orderByField: json['orderByField'],
      orderByAsc: json['orderByAsc'],
    );
  }

  @override
  List<Object?> get props => [orderByField, orderByAsc];
}
