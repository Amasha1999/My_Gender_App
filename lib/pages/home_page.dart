import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gender_app/api/models/rest_client.dart';


final genderProvider = StateProvider((ref) => "");

class HomePage extends HomePage {
  HomePage({super.key});

  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var gender = ref.watch(genderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guess the Gender"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please enter your name:"),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("You are a:"),
            Text(
              gender,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  final dio = Dio();
                  final client = RestClient(dio);
                  dio.interceptors.add(
                      LogInterceptor(responseBody: true, requestBody: true));

                  client.getAnswer(genderController.text, "US").then((answer) {
                    ref.read(genderProvider.notifier).state =
                        answer.gender ?? "-";
                  });
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }
}
