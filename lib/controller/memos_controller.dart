import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo/model/memo.dart';
import 'package:memo/service/memo_service.dart';

final memosProvider = StateNotifierProvider<MemosController, List<Memo>>((ref) {
  final memoService = ref.watch(memoServiceProvider);
  return MemosController(memoService: memoService);
});

class MemosController extends StateNotifier<List<Memo>> {
  MemosController({required this.memoService}) : super([]) {
    Future(() async {
      state = await findAll();
    });
    memoService.stream.listen((memos) {
      state = memos;
    });
  }

  final MemoService memoService;

  Future<List<Memo>> findAll() => memoService.findAll();

  void update({required String text}) {
    final memo = Memo()
      ..text = text
      ..updatedAt = DateTime.now();
    memoService.put(memo: memo);
  }

  void delete({required Memo memo}) async {
    final id = memo.id;
    memoService.delete(id: id);
  }
}
