class CategoryModel {
  final String id;
  final String nameBn;
  final String icon; // Icon identifier or asset path
  final String color; // Hex color
  final int order;
  final bool isQuickAccess;
  final bool isSos;
  final List<String> items;

  CategoryModel({
    required this.id,
    required this.nameBn,
    required this.icon,
    required this.color,
    required this.order,
    this.isQuickAccess = false,
    this.isSos = false,
    this.items = const [],
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      nameBn: map['name_bn'] ?? '',
      icon: map['icon'] ?? '',
      color: map['color'] ?? '#C0392B',
      order: map['order'] ?? 0,
      isQuickAccess: map['isQuickAccess'] ?? false,
      isSos: map['isSos'] ?? false,
      items: (map['items'] as List?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }
}
