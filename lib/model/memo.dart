import 'package:isar/isar.dart';

part 'memo.g.dart';

@Collection()
class Memo {
  Id id = Isar.autoIncrement;
  String text = '';
  String trimText = '';
  DateTime updatedAt = DateTime.now();
}
