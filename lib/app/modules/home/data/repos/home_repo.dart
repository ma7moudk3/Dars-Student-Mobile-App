abstract class HomeRepo {
  Future<bool> orderNewHessa({
    required int targetedGender,
    required String notes,
    required String preferredStartData,
    required int sessionType,
    required int productId,
  });
}
