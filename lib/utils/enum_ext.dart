import '../model/asianwiki_type.dart';
import '../model/detail_show.dart';

extension EnumType on ShowType? {
  AsianwikiType get toAsianWikiType => switch (this) {
    ShowType.drama => AsianwikiType.drama,
    ShowType.movie => AsianwikiType.movie,
    _ => AsianwikiType.unknown,
  };
}
