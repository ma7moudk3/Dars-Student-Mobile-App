import 'package:hessa_student/app/modules/home/data/repos/home_repo.dart';

class HomeRepoImplement extends HomeRepo {
  @override
  Future<bool> orderNewHessa({
    required int targetedGender,
    required String notes,
    required String preferredStartData,
    required int sessionType,
    required int productId,
  }) {
    throw UnimplementedError();
  }
}
