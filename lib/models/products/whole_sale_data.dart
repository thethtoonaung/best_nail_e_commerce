class WholeSaleData {
  final String? id;
  final int unit;
  final int price;

  const WholeSaleData({
    this.id,
    required this.unit,
    required this.price,
  });

  WholeSaleData copyWith({
    String? id,
    int? unit,
    int? price,
  }) {
    return WholeSaleData(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'unit': unit,
      'price': price,
    };
  }

  factory WholeSaleData.fromJson(Map<String, dynamic> map) {
    return WholeSaleData(
      id: map['id'] != null ? map['id'] as String : null,
      unit: map['unit'] as int,
      price: map['price'] as int,
    );
  }

  @override
  String toString() => 'WholeSaleData(id: $id, unit: $unit, price: $price)';

  @override
  bool operator ==(covariant WholeSaleData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.unit == unit && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ unit.hashCode ^ price.hashCode;
}

class WholeSaleData2 {
  final String? id;
  final int unit;
  final int price;

  const WholeSaleData2({
    this.id,
    required this.unit,
    required this.price,
  });

  WholeSaleData2 copyWith({
    String? id,
    int? unit,
    int? price,
  }) {
    return WholeSaleData2(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'unit': unit,
      'price': price,
    };
  }

  factory WholeSaleData2.fromJson(Map<String, dynamic> map) {
    return WholeSaleData2(
      id: map['id'] != null ? map['id'] as String : null,
      unit: map['unit'] as int,
      price: map['price'] as int,
    );
  }

  @override
  String toString() => 'WholeSaleData(id: $id, unit: $unit, price: $price)';

  @override
  bool operator ==(covariant WholeSaleData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.unit == unit && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ unit.hashCode ^ price.hashCode;
}
