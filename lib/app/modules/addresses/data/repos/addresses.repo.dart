import 'package:hessa_student/app/modules/addresses/data/models/address/address.dart';

abstract class AddressesRepo {
  Future<List<Address>> getAllMyAddresses({
    required int page,
    required int perPage,
  });
}
