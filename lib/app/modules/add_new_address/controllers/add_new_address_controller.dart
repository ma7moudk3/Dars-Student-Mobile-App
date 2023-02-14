import 'package:hessa_student/app/core/helper_functions.dart';
import 'package:hessa_student/app/data/models/governorates/governorates.dart';
import 'package:hessa_student/app/modules/add_new_address/data/repos/add_new_address_repo.dart';
import 'package:hessa_student/app/modules/add_new_address/data/repos/add_new_address_repo_implement.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/exports.dart';
import '../../../data/models/countries/countries.dart';
import '../../../data/models/countries/result.dart' as country;
import '../../../data/models/governorates/result.dart' as governorate;
import '../../../data/models/localities/result.dart' as locality;
import '../../../data/models/localities/localities.dart';

class AddNewAddressController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController areaController, addressDescriptionController;
  FocusNode areaFocusNode = FocusNode(),
      addressDescriptionFocusNode = FocusNode();
  Countries countries = Countries();
  Governorates governorates = Governorates();
  Localities localities = Localities();
  country.Result selectedCountry = country.Result();
  governorate.Result selectedGovernorate = governorate.Result();
  locality.Result selectedLocality = locality.Result();
  RxBool isInternetConnected = true.obs, isLoading = true.obs;
  bool isGovernorateDropDownLoading = false, isLocalityDropDownLoading = false;
  final AddNewAddressRepo _addNewAddressRepo = AddNewAddressRepoImplement();

  @override
  void onInit() async {
    areaController = TextEditingController();
    addressDescriptionController = TextEditingController();
    areaFocusNode.addListener(() => update());
    addressDescriptionFocusNode.addListener(() => update());
    await checkInternet();
    super.onInit();
  }

  Future changeCountry(String? result) async {
    isGovernorateDropDownLoading = true;
    isLocalityDropDownLoading = true;
    update();
    if (countries.result != null && result != null) {
      for (var country in countries.result ?? <country.Result>[]) {
        if (country.displayName != null &&
            country.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedCountry = country;
        }
      }
    }
    if (selectedCountry.id != null && selectedCountry.id != -1) {
      await _getGovernorate(countryId: selectedCountry.id!).then((value) {
        selectedGovernorate = governorate.Result();
        selectedLocality = locality.Result();
        update();
      });
    } else {
      isGovernorateDropDownLoading = true;
      isLocalityDropDownLoading = true;
      update();
      Future.delayed(const Duration(milliseconds: 500), () {
        governorates = Governorates();
        localities = Localities();
        selectedGovernorate = governorate.Result();
        selectedLocality = locality.Result();
        isGovernorateDropDownLoading = false;
        isLocalityDropDownLoading = false;
        update();
      });
    }
  }

  Future changeGovernorate(String? result) async {
    isLocalityDropDownLoading = true;
    update();
    if (governorates.result != null && result != null) {
      for (var governorate in governorates.result ?? <governorate.Result>[]) {
        if (governorate.displayName != null &&
            governorate.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedGovernorate = governorate;
        }
      }
    }
    if (selectedGovernorate.id != null && selectedGovernorate.id != -1) {
      await _getLocalities(governorateId: selectedGovernorate.id!)
          .then((value) {
        selectedLocality = locality.Result();
        update();
      });
    } else {
      isLocalityDropDownLoading = true;
      update();
      Future.delayed(const Duration(milliseconds: 500), () {
        localities = Localities();
        selectedLocality = locality.Result();
        isLocalityDropDownLoading = false;
        update();
      });
    }
  }

  Future changeLocality(String? result) async {
    if (localities.result != null && result != null) {
      for (var locality in localities.result ?? <locality.Result>[]) {
        if (locality.displayName != null &&
            locality.displayName!.toLowerCase() == result.toLowerCase()) {
          selectedLocality = locality;
        }
      }
    }
    update();
  }

  Future checkInternet() async {
    await checkInternetConnection(timeout: 10)
        .then((bool internetStatus) async {
      isInternetConnected.value = internetStatus;
      if (isInternetConnected.value) {
        await Future.wait([
          _getCountries(),
        ]).then((value) => isLoading.value = false);
      }
    });
  }

  @override
  void dispose() {
    areaController.dispose();
    addressDescriptionController.dispose();
    areaFocusNode.dispose();
    addressDescriptionFocusNode.dispose();
    super.dispose();
  }

  Future _getCountries() async {
    countries = await _addNewAddressRepo.getCountries();
    if (countries.result != null) {
      countries.result!.insert(
        0,
        country.Result(
          id: -1,
          displayName: LocaleKeys.choose_country.tr,
        ),
      );
    }
    update();
  }

  Future _getLocalities({required int governorateId}) async {
    await _addNewAddressRepo
        .getLocalities(
          governorateId: governorateId,
        )
        .then((Localities localities) => {
              this.localities = localities,
              isLocalityDropDownLoading = false,
            });
    if (localities.result != null) {
      localities.result!.insert(
        0,
        locality.Result(
          id: -1,
          displayName: LocaleKeys.choose_locality.tr,
        ),
      );
    }
    update();
  }

  Future _getGovernorate({required int countryId}) async {
    await _addNewAddressRepo
        .getGovernorates(
          countryId: countryId,
        )
        .then((Governorates governorates) => {
              this.governorates = governorates,
              isGovernorateDropDownLoading = false,
              isLocalityDropDownLoading = false,
            });
    if (governorates.result != null) {
      governorates.result!.insert(
        0,
        governorate.Result(
          id: -1,
          displayName: LocaleKeys.choose_city.tr,
        ),
      );
    }
    update();
  }

  String? validateAddressDescription(String? addressDescription) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = RegExp(pattern);
    if (addressDescription == null || addressDescription.isEmpty) {
      return LocaleKeys.please_enter_address_description.tr;
    } else if (regExp.hasMatch(addressDescription)) {
      return LocaleKeys.check_address_description.tr;
    }
    update();
    return null;
  }

  void clearData() {
    areaController.clear();
    addressDescriptionController.clear();
    areaFocusNode.unfocus();
    addressDescriptionFocusNode.unfocus();
    update();
  }
}
