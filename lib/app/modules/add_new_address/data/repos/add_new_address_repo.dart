import 'package:hessa_student/app/data/models/localities/localities.dart';

import '../../../../data/models/countries/countries.dart';
import '../../../../data/models/governorates/governorates.dart';

abstract class AddNewAddressRepo {
  Future<Countries> getCountries();
  Future<Governorates> getGovernorates({required int countryId});
  Future<Localities> getLocalities({required int governorateId});
}
