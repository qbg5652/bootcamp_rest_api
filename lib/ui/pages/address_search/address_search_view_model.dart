import 'package:flutter_expert_rest_api_dangeun/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressSearchViewModel extends AutoDisposeNotifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  final vworldRepository = VworldRepository();

  void searchByName(String query) async {
    final result = await vworldRepository.findByName(query);
    state = result;
  }

  void searchByLocation(double lat, double lng) async {
    final result = await vworldRepository.findByLatLng(lat, lng);
    state = result;
  }
}

final addressSearchViewModelProvider =
    NotifierProvider.autoDispose<AddressSearchViewModel, List<String>>(() {
      return AddressSearchViewModel();
    });
