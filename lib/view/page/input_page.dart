import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo/extension/focus_node_extension.dart';

class InputPage extends HookConsumerWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final doneVisible = useState(false);

    useEffect(() {
      return focusNode.addAndRemoveListener(() {
        doneVisible.value = focusNode.hasFocus;
      });
    }, [focusNode]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
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
            focusNode: focusNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
