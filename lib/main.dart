import 'dart:convert';

import 'package:flutter/material.dart';
import "package:galaxeus_lib/galaxeus_lib.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController jsonTextEditingController = TextEditingController();
  TextEditingController resultTextEditingController = TextEditingController();
  late JsonToDartSetting jsonToDartSetting = JsonToDartSetting(
    className: "JsonDataDart",
    isMain: true,
    isUseClassName: false,
    comment: "// comment",
    isStatic: true,
  );

  Widget onOff({
    required bool is_on,
    required Widget title,
    void Function()? onPressed,
  }) {
    return Row(
      children: [
        title,
        MaterialButton(
          shape: const CircleBorder(),
          minWidth: 0,
          onPressed: onPressed,
          child: Icon(
            (is_on) ? Icons.toggle_on : Icons.toggle_off,
            size: 50,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json to Dart Code"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            onOff(
                              is_on: jsonToDartSetting.isStatic,
                              title: const Text("IS STATIC"),
                              onPressed: () {
                                setState(() {
                                  jsonToDartSetting.isStatic = !jsonToDartSetting.isStatic;
                                });
                              },
                            ),
                            onOff(
                              is_on: jsonToDartSetting.isUseClassName,
                              title: const Text("IS USE CLASS NAME"),
                              onPressed: () {
                                setState(() {
                                  jsonToDartSetting.isUseClassName = !jsonToDartSetting.isUseClassName;
                                });
                              },
                            ),
                            onOff(
                              is_on: jsonToDartSetting.isMain,
                              title: const Text("IS MAIN"),
                              onPressed: () {
                                setState(() {
                                  jsonToDartSetting.isMain = !jsonToDartSetting.isMain;
                                });
                              },
                            ), 
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: jsonTextEditingController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (String? text) {
                                  try {
                                    json.decode(jsonTextEditingController.text);
                                  } catch (e) {
                                    return "Failed parse json";
                                  }
                                  return null;
                                },
                                onChanged: (String? text) {
                                  try {
                                    Map jsonData = json.decode(jsonTextEditingController.text);
                                    setState(() {
                                      resultTextEditingController.text = jsonToDart(
                                        jsonData.cast<String, dynamic>(),
                                        className: jsonToDartSetting.className,
                                        isMain: jsonToDartSetting.isMain,
                                        isUseClassName: jsonToDartSetting.isUseClassName,
                                        comment: jsonToDartSetting.comment,
                                        isStatic: jsonToDartSetting.isStatic,
                                      );
                                    });
                                  } catch (e) {}
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20.0),
                                  hintText: 'username',
                                  labelText: "JSON",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: resultTextEditingController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20.0),
                                  hintText: '',
                                  labelText: "Result dart code",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JsonToDartSetting {
  late String className;
  late bool isMain;
  late bool isUseClassName;
  late String? comment;
  late bool isStatic;
  JsonToDartSetting({
    required this.className,
    required this.isMain,
    required this.isUseClassName,
    required this.comment,
    required this.isStatic,
  });
}
