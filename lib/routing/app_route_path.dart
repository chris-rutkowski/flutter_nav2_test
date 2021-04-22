import 'child_section.dart';
import 'main_section.dart';

class AppRoutePath {
  final MainSection? mainSection;
  final int? resourceId;
  final ChildSection? childSection;

  AppRoutePath({required this.mainSection, this.resourceId, this.childSection});

  @override
  String toString() => 'AppRoutePath mainSection=$mainSection resourceId=$resourceId childSection=$childSection';
}
