
import '../models/address_result/address_result.dart';

abstract class AddressesRepo {
  Future<List<AddressResult>> getAllMyAddresses({
    required int page,
    required int perPage,
  });
}
