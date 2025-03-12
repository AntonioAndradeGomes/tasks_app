import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum OrderBy {
  title(
    icon: Icons.format_size_rounded,
  ),
  createdAt(
    icon: Icons.edit_calendar_rounded,
  ),
  dueAt(
    icon: Icons.calendar_today,
  ),
  completedAt(
    icon: Icons.fact_check_rounded,
  ),
  updatedAt(
    icon: Icons.update_rounded,
  );

  final IconData icon;

  const OrderBy({required this.icon});

  static OrderBy fromBackendString(String backendString) {
    switch (backendString) {
      case 'created_at':
        return OrderBy.createdAt;
      case 'due_at':
        return OrderBy.dueAt;
      case 'completed_at':
        return OrderBy.completedAt;
      case 'updated_at':
        return OrderBy.updatedAt;
      default:
        throw ArgumentError('Unknown backend string: $backendString');
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case OrderBy.title:
        return AppLocalizations.of(context)!.alphabetical_order;
      case OrderBy.createdAt:
        return AppLocalizations.of(context)!.created_date;
      case OrderBy.completedAt:
        return AppLocalizations.of(context)!.completion_date;
      default:
        return '';
    }
  }

  String toBackendString() {
    switch (this) {
      case OrderBy.createdAt:
        return 'created_at';
      case OrderBy.dueAt:
        return 'due_at';
      case OrderBy.completedAt:
        return 'completed_at';
      case OrderBy.updatedAt:
        return 'updated_at';
      case OrderBy.title:
        return 'title';
    }
  }
}

enum Order {
  asc,
  desc;

  String toBackendString() {
    switch (this) {
      case Order.asc:
        return 'asc';
      case Order.desc:
        return 'desc';
    }
  }
}

class FilterModel extends Equatable {
  final OrderBy? orderBy;
  final Order? order;

  const FilterModel({
    this.orderBy,
    this.order,
  });

  factory FilterModel.empty() => const FilterModel();

  Map<String, dynamic> toQuery() {
    return {
      if (orderBy != null) 'orderBy': orderBy?.toBackendString(),
      if (order != null) 'order': order?.toBackendString(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'orderBy': orderBy?.toBackendString(),
      'order': order?.toBackendString(),
    };
  }

  factory FilterModel.fromMap(Map<String, dynamic> json) {
    return FilterModel(
      order: json['order'] != null
          ? Order.values.firstWhere((e) => e.name == json['order'])
          : null,
      orderBy: json['orderBy'] != null
          ? OrderBy.fromBackendString(json['orderBy'])
          : null,
    );
  }

  bool get isNotFilter => orderBy == null && order == null;

  FilterModel copyWith({
    OrderBy? orderBy,
    Order? order,
    bool reset = false,
  }) {
    return FilterModel(
      orderBy: reset ? null : orderBy ?? this.orderBy,
      order: reset ? null : order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [order, orderBy];
}
