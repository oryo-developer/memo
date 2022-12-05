import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:memo/model/memo.dart';
import 'package:path_provider/path_provider.dart';

final isarProvider = FutureProvider((ref) async {
  final directory = await getApplicationSupportDirectory();
  return Isar.open([MemoSchema], directory: directory.path);
});

final memoServiceProvider = Provider((ref) => MemoService(ref: ref));

class MemoService {
  MemoService({required this.ref}) {
    Future(() async {
      final isar = await ref.watch(isarProvider.future);
      isar.memos.watchLazy().listen((event) async {
        streamController.sink.add(await findAll());
      });
    });
  }

  final Ref ref;

  final streamController = StreamController<List<Memo>>();

  Stream<List<Memo>> get stream => streamController.stream;

  Future<List<Memo>> findAll() async {
    final isar = await ref.watch(isarProvider.future);
    return isar.memos.where().sortByUpdatedAtDesc().findAll();
  }

  void put({required Memo memo}) async {
    final isar = await ref.watch(isarProvider.future);
    isar.writeTxn(() async {
      await isar.memos.put(memo);
    });
  }

  void delete({required Id id}) async {
    final isar = await ref.watch(isarProvider.future);
    isar.writeTxn(() async {
      await isar.memos.delete(id);
    });
  }
}
