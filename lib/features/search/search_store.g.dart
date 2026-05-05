// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  late final _$resultsAtom = Atom(
    name: '_SearchStore.results',
    context: context,
  );

  @override
  ObservableList<SearchResult> get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(ObservableList<SearchResult> value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_SearchStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_SearchStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$queryAtom = Atom(name: '_SearchStore.query', context: context);

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  late final _$searchAsyncAction = AsyncAction(
    '_SearchStore.search',
    context: context,
  );

  @override
  Future<void> search(String keyword) {
    return _$searchAsyncAction.run(() => super.search(keyword));
  }

  late final _$_SearchStoreActionController = ActionController(
    name: '_SearchStore',
    context: context,
  );

  @override
  void setQuery(String value) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
      name: '_SearchStore.setQuery',
    );
    try {
      return super.setQuery(value);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
      name: '_SearchStore.clear',
    );
    try {
      return super.clear();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
results: ${results},
isLoading: ${isLoading},
error: ${error},
query: ${query}
    ''';
  }
}
