import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo/controller/memos_controller.dart';
import 'package:memo/extension/date_time_extension.dart';
import 'package:memo/extension/string_extension.dart';
import 'package:memo/model/memo.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memos = ref.watch(memosProvider);
    final memosController = ref.read(memosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(
              '/input',
              arguments: Memo(),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => const Divider(height: 1),
        itemCount: memos.length,
        itemBuilder: (_, index) => Dismissible(
          key: Key(memos[index].id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => memosController.delete(memo: memos[index]),
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            title: Text(
              memos[index].text.replaceLineBrakeWithSpace,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(_).textTheme.bodyMedium,
            ),
            subtitle: Text(
              memos[index].updatedAt.toFormatString,
              style: Theme.of(_).textTheme.bodySmall,
            ),
            onTap: () => Navigator.of(_).pushNamed(
              '/input',
              arguments: memos[index],
            ),
          ),
        ),
      ),
    );
  }
}
