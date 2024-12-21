import 'package:correction_flutter/pages/quizz_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Quizz flutter"),
       centerTitle: true,
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     ),
     body: Center(
       child: Card(
         elevation: 7,
         color: Theme.of(context).colorScheme.inversePrimary,
         margin: const EdgeInsets.all(32),
         clipBehavior: Clip.antiAlias,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Image.asset("assets/images/cover.jpg"),
             const Padding(
                 padding: const EdgeInsets.all(16),
               child: Text(
                 "Quand un philosophe me repnds, je ne comprends plus ma question",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                   fontStyle: FontStyle.italic
                 ),
               ),
             ),
             
             ElevatedButton(
                 onPressed: () {
                   final page = QuizzPage();
                   final route = MaterialPageRoute(builder: ((ctx) => page));
                   Navigator.push(context, route);
                 },

                 child: const Text("Commencer")
             )
           ],
         ),
       ),
     ),
   );
  }
}