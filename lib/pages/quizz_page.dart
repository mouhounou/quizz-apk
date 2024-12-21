import 'package:correction_flutter/datas/app_datas.dart';
import 'package:correction_flutter/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class QuizzPage extends StatefulWidget {
   QuizzPage({super.key});


  @override
  State<QuizzPage> createState() {
    return _QuizzPage();
  }
}

class _QuizzPage extends State<QuizzPage>{

  int _score = 0;
  int _index = 0;


  final List<Question> _questions = AppDatas().listeQuestions;
  final EdgeInsets _insets = const EdgeInsets.all(16);


  void answerQuestion (){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: Column(
              mainAxisSize:   MainAxisSize.min,
              children: [
                Padding(
                    padding: _insets,
                  child: Text(
                      " Ma reponse  :" ,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),

                answerRow(text: "c'est vrai", icondata: Icons.check, color: Colors.green, isTrue:  true),
                answerRow(text: "c'est faux", icondata: Icons.cancel_outlined, color: Colors.red, isTrue: false),
                answerRow(text: "je ne sais pas", icondata: Icons.question_mark, color: Colors.blueGrey, isTrue: null),
              ],
            ),
          );
        }
    );
  }

  InkWell answerRow ({required String text, required  IconData icondata, required Color color,required  bool? isTrue}){
    return  InkWell(
      onTap: (){
        _checkAnswer(isTrue);
      },
      child: Padding(
        padding: _insets,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icondata,
              color: color,
            ),
           const SizedBox(width: 32),
            Text(text)
          ],
        ),
      )
    );

  }


  void _checkAnswer(bool? isTrue){
    Navigator.pop(context);
    if( isTrue == null){
      return;
    }
    final question = _questions[_index];
    final answer = question.reponse;
    final myAnswer = isTrue! == answer;

    if(myAnswer == true){
      setState(() {
        _score++;
      });
    }

    showAnswer(myAnswer, question);
  }

  void showAnswer (bool isSuccess, Question question){
    String title  = (isSuccess) ? "c'est gagne" : "Oups dommage";
    String img = (isSuccess)? 'vrai.jpg' : "faux.jpg";
    String imageUrl = "assets/images/$img";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imageUrl) ,
                Text(question.explication)
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    toNextQuestion();
                  },
                  child: Text("Ok")
              )
            ],
          );
        }
    );
  }

  void toNextQuestion (){
    if (_index < _questions.length){
      setState(() {
        _index++;
      });
    } else {
      finalPop();
    }
  }

  void finalPop() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Cest fini"),
            content: Text("votre score est de $_score"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Ok")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    Question  question = _questions[_index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Score : $_score"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Column(
        children: [
            Text(
              "Question numero : ${_index  + 1} / ${_questions.length  } ",
              style: Theme.of(context).textTheme.titleLarge
            ),

          Card(
            clipBehavior: Clip.antiAlias,
            margin: _insets,
            elevation: 7,
            child: Column(
              children: [
                Image.asset(question.getImage()),
                Padding(padding: _insets,
                  child: Text(
                      question.question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),

                )
              ],
            ),
          ),

          OutlinedButton(
              onPressed: (){
                answerQuestion();
              },
              child: Text("Repondre")
          )
        ],
      ),
    );
  }


}