class FilterInput {
  final int? storeId;

  FilterInput({this.storeId});

  FilterInput.fromJson(Map<String, dynamic> json)
      : storeId = json['storeId'] as int;

  Map<String, dynamic> toJson() => {'storeId': storeId};
}
