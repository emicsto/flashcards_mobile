import 'package:flashcards/blocs/flashcards/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFlashcardScreen extends StatefulWidget {
  const CreateFlashcardScreen({Key key}) : super(key: key);

  @override
  CreateFlashcardScreenState createState() => CreateFlashcardScreenState();
}

class CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();

  void _handleSaveDeck(BuildContext context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<FlashcardsBloc>(context).add(AddFlashcard("1", "2", "3"));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2025),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
        backgroundColor: Color(0xFF1F2025),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.send,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.only(
              left: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_bold),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_align_center),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_align_justify),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(22),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      controller: _frontController,
                      autofocus: true,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        hintText: "Front",
                        hintStyle: TextStyle(fontSize: 22),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(focus);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 13,
                      maxLines: null,
                      focusNode: focus,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Back",
                        hintStyle: TextStyle(fontSize: 16),
                        border: InputBorder.none,
                      ),
                      controller: _backController,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
