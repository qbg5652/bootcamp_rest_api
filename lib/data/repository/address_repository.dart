import 'package:flutter_expert_rest_api_dangeun/data/model/address.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/base_remote_repository.dart';

class AddressRepository extends BaseRemoteRepository {
  Future<List<Address>?> getMyAddressList() async {
    final response = await client.get('/api/address');
    if (response.statusCode == 200) {
      final content = response.data['content'];
      return List.from(content).map((e) {
        return Address.fromJson(e);
      }).toList();
    }
    return null;
  }
}
