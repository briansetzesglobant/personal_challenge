abstract class UseCaseInterface<T> {
  Future<T> call({
    String? nameMovie,
    int? id,
  });
}
