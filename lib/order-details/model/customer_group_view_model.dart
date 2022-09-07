class CustomerGroupViewModel {
  final int? customerGroupId;
  final String? groupName;
  final dynamic taxClass;
  final dynamic isDeleted;
  final String? createdAt;
  final dynamic updatedAt;

  CustomerGroupViewModel({
    this.customerGroupId,
    this.groupName,
    this.taxClass,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  CustomerGroupViewModel.fromJson(Map<String, dynamic> json)
      : customerGroupId = json['customerGroupId'] as int?,
        groupName = json['groupName'] as String?,
        taxClass = json['taxClass'],
        isDeleted = json['isDeleted'],
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
    'customerGroupId' : customerGroupId,
    'groupName' : groupName,
    'taxClass' : taxClass,
    'isDeleted' : isDeleted,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}