import '../models/content_management.dart';

abstract class StaticPageRepo {
  Future<ContentManagement> getStaticPage({
    required int staticPageId,
  });
}
