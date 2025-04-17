import 'package:flutter_expert_rest_api_dangeun/data/model/address.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product_summary.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/address_repository.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabState {
  List<Address> addresses;
  List<ProductSummary> products;
  HomeTabState({required this.addresses, required this.products});
}

class HomeTabViewModel extends AutoDisposeNotifier<HomeTabState> {
  @override
  build() {
    fetchAddresses().then((_) {
      fetchProducts();
    });
    return HomeTabState(addresses: [], products: []);
  }

  final addressRepository = AddressRepository();
  final productRepository = ProductRepository();

  Future<void> fetchAddresses() async {
    final address = await addressRepository.getMyAddressList();
    state = HomeTabState(addresses: address ?? [], products: []);
  }

  Future<void> fetchProducts() async {
    final addresses = state.addresses;
    final target = addresses.where((element) {
      return element.defaultYn ?? false;
    });
    if (target.isEmpty) {
      return;
    }
    final products = await productRepository.getProductSummaryList(
      target.first.id,
    );
    state = HomeTabState(addresses: addresses, products: products ?? []);
  }
}

final HomeTabViewModelProvider =
    NotifierProvider.autoDispose<HomeTabViewModel, HomeTabState>(() {
      return HomeTabViewModel();
    });
