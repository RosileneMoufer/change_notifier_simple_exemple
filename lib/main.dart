import 'package:change_notifier_simple_example/provider/background_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BackgroundStateProvider>(
      create: (context) => BackgroundStateProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<BackgroundStateProvider>(
        builder: ((context, backgroundProvider, _) => SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        backgroundProvider.changeBackground(
                            const Color.fromARGB(255, 98, 255, 237));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const Text(
                            "Clique aqui para mudar a cor do Container abaixo e do background da próxima página para a cor verde"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      alignment: Alignment.center,
                      color: backgroundProvider.background.backgroundColor,
                      child: const Text(
                          "Clique no botão abaixo para ir à próxima página."),
                    ),
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 3,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NextPage(),
            ),
          );
        },
        child: const Icon(
          Icons.pages,
          color: Color.fromARGB(255, 255, 170, 234),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<BackgroundStateProvider>(
        builder: (context, backgroundContext, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SecondPage"),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: backgroundContext.background.backgroundColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24.0),
          child: const Text(
              "Clique no botão abaixo para mudar a cor do background desta página e a cor do container da página anterior."),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => backgroundContext
              .changeBackground(const Color.fromARGB(255, 255, 151, 255))),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.color_lens,
            color: Colors.amber,
          ),
        ),
      );
    });
  }
}
