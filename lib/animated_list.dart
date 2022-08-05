import 'package:flutter/material.dart';

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  List<String> items = [];
  GlobalKey<AnimatedListState> key = GlobalKey();
  _insertItem() {
    items.insert(0, 'Item ${items.length + 1}');
    key.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 850));
  }

  _removeItem(int index) {
    key.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: Container(
            color: Colors.red,
            margin: const EdgeInsets.all(10),
            child: const ListTile(
                title: Text(
              'Deleted',
              textAlign: TextAlign.center,
            )),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 500));
    items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: Column(children: [
        IconButton(onPressed: _insertItem, icon: const Icon(Icons.add)),
        Expanded(
          child: AnimatedList(
              key: key,
              initialItemCount: 0,
              itemBuilder: ((context, index, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.amber,
                        child: ListTile(
                          title: Text(
                            items[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: IconButton(
                              onPressed: () => _removeItem(index),
                              icon: const Icon(Icons.delete)),
                        ),
                      ),
                    ),
                  ),
                );
              })),
        )
      ]),
    );
  }
}
