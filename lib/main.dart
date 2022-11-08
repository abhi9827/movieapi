import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movieapi/view/home_page.dart';
import 'provider/counter_provider.dart';

Future getData() async {
  final dio = Dio();
  final response = await dio.get('https://api.themoviedb.org/3/movie/popular',
      queryParameters: {'api_key': '2a0f926961d00c667e191a21c14461f8'});
  return response.data['results'];
}

void main() async {
  runApp(ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class TodoPage extends StatelessWidget {
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(builder: (context, ref, child) {
              final todoData = ref.watch(todoProvider);
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: todoController,
                    onFieldSubmitted: (val) {
                      ref.read(todoProvider.notifier).addTodo(
                          Todo(todo: val, dateTime: DateTime.now().toString()));
                      todoController.clear();
                    },
                    decoration: InputDecoration(
                        hintText: 'add some todo',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: todoData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(todoData[index].todo),
                                subtitle: Text(todoData[index].dateTime),
                                trailing: Container(
                                  width: 129,
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();

                                            // Get.defaultDialog(
                                            //   title: 'Update',
                                            //   content: Text('sd;lfkld')
                                            // );
                                            Get.defaultDialog(
                                                title: 'update',
                                                content: TextFormField(
                                                  onFieldSubmitted: (val) {
                                                    Navigator.of(context).pop();
                                                    ref
                                                        .read(todoProvider
                                                            .notifier)
                                                        .updateTodo(
                                                            todoData[index],
                                                            val);
                                                  },
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('cancel')),
                                                ]);
                                          },
                                          child: Icon(Icons.edit)),
                                      TextButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title: 'Are you sure',
                                                content: Text(
                                                    'You want to remove this todo'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        ref
                                                            .read(todoProvider
                                                                .notifier)
                                                            .removeTodo(index);
                                                      },
                                                      child: Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('No')),
                                                ]);
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(
      child: Consumer(builder: (context, ref, child) {
        //    final number = ref.watch(counterProvider).number;
        final number = ref.watch(countStateProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: TextStyle(fontSize: 50),
            ),
            TextButton(
                onPressed: () {
                  // ref.read(counterProvider).increment();
                  ref.read(countStateProvider.notifier).state++;
                },
                child: Text('Increment')),
            TextButton(
                onPressed: () {
                  ref.read(countStateProvider.notifier).state--;
                  //ref.read(counterProvider).decrement();
                },
                child: Text('Decrement')),
          ],
        );
      }),
    )));
  }
}
