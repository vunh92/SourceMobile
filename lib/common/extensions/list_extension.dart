extension IterableHelper<T> on Iterable<T?> {
  Iterable<T> nonNullFilter() {
    // ignore: unnecessary_null_checks
    return where((element) => element != null).map((e) => e!);
  }
}

extension ListHelper<T> on List<T?> {
  T? firstOrNull() {
    if (isEmpty) {
      return null;
    }
    return first;
  }

  T? get(int index) {
    if (index >= length) {
      return null;
    }
    return this[index];
  }

  T? lastOrNull() {
    if (isEmpty) {
      return null;
    }
    return last;
  }
}
