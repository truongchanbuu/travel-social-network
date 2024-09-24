import '../../generated/l10n.dart';

class ClassificationUtils {
  static String classificationRating(double rating) => switch (rating) {
        >= 4.9 => S.current.classificationOutstanding,
        >= 4.5 && < 4.9 => S.current.classificationWonderful,
        >= 4.0 && < 4.5 => S.current.classificationGood,
        >= 3.0 && < 4.0 => S.current.classificationPleasant,
        >= 2.0 && < 3.0 => S.current.classificationNotVeryGood,
        >= 1.0 && < 2.0 => S.current.classificationDisappointing,
        < 1.0 => S.current.classificationTerrible,
        _ => throw Exception(S.current.classificationError),
      };
}
