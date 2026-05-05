import 'package:mobx/mobx.dart';
import '../../data/models/search_result.dart';
import '../../data/sources/source_registry.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final SourceRegistry _registry;

  _SearchStore(this._registry);

  @observable
  ObservableList<SearchResult> results = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  String query = '';

  @action
  void setQuery(String value) {
    query = value;
  }

  @action
  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) return;

    query = keyword;
    isLoading = true;
    error = null;
    results.clear();

    try {
      final items = await _registry.searchAll(keyword);
      results.addAll(items);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void clear() {
    results.clear();
    query = '';
    error = null;
  }
}
