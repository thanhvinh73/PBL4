extension ListExt<T> on List<T>? {
  T? firstWhereOrNull(bool Function(T) condition) {
    if (this == null || this!.every((element) => !condition(element))) {
      return null;
    }
    return this!.firstWhere((element) => condition(element));
  }

  List<T> toggle(T data, String Function(T) identify) {
    if ((this ?? []).any((element) => identify(element) == identify(data))) {
      return this!
          .where((element) => identify(element) != identify(data))
          .toList();
    } else {
      return [...(this ?? []), data];
    }
  }

  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isOnlyEmpty => this != null && this!.isEmpty;
  List<T> reverseWithCondition({bool reverse = true}) {
    if (reverse) {
      return (this ?? []).reversed.toList();
    }
    return this ?? [];
  }

  List<T> insertList(List<T> newList) {
    return [...(this ?? []), ...newList];
  }

  T? elementAtIndexOrNull(int index) {
    if (this == null || this!.length < index + 1) return null;
    return this![index];
  }

  List<T> insertFirst(T data) {
    return [data, ...(this ?? [])];
  }

  List<T>? deleteAt(int? index, {bool Function(T)? condition}) {
    if (this.isNullOrEmpty) return null;
    if (index != null && index >= 0 && index < this!.length) {
      List<T> newList = [...this!];
      newList.removeAt(index);
      return newList;
    }
    if (condition != null) {
      return this!.where((element) => !condition(element)).toList();
    }
    return null;
  }

  List<T> update(T Function(T item) onUpdate, bool Function(T item) condition) {
    return <T>[...(this ?? [])].map((e) {
      if (condition(e)) {
        return onUpdate(e);
      }
      return e;
    }).toList();
  }

  List<T>? updateAt(T Function(T) onUpdateData, int index) {
    if (this.isNotNullOrEmpty && (index >= 0 && index < this!.length)) {
      List<T> newList = [...this!].asMap().entries.map((e) {
        if (e.key == index) {
          return onUpdateData(e.value);
        }
        return e.value;
      }).toList();
      return newList;
    }
    return null;
  }
}
