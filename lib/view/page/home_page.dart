import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/input'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Dismissible(
            key: const Key('キー'),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => {},
            background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward_ios),
              title: Text(
                'タイトル',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                'サブタイトル',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }
}
