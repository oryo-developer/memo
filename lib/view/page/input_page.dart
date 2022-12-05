import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo/controller/memos_controller.dart';
import 'package:memo/extension/focus_node_extension.dart';
import 'package:memo/model/memo.dart';

class InputPage extends HookConsumerWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ModalRoute.of(context)!.settings.arguments as Memo;

    final memosController = ref.read(memosProvider.notifier);

    final textEditingController = useTextEditingController(text: memo.text);
    final focusNode = useFocusNode();
    final doneVisible = useState(false);

    useEffect(() {
      if (memo.text.isEmpty) focusNode.requestFocus();
      return focusNode.addAndRemoveListener(() {
        doneVisible.value = focusNode.hasFocus;
      });
    }, [focusNode]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              memosController.delete(memo: memo);
              Navigator.pop(context);
            },
          ),
          Visibility(
            visible: doneVisible.value,
            child: IconButton(
              onPressed: () => focusNode.unfocus(),
              icon: const Icon(Icons.done),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (text) => memosController.update(memo: memo, text: text),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
