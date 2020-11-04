import 'package:flutter/material.dart';

class TitleSearchBox extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Function callback;

  const TitleSearchBox({
    @required this.title,
    @required this.controller,
    @required this.callback
  }):assert(title!=null && controller!=null);
  @override
  _TitleSearchBoxState createState() => _TitleSearchBoxState();
}

class _TitleSearchBoxState extends State<TitleSearchBox> {
  bool typing = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(typing)...{
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 80),
              child: TextFormField(
                controller: widget.controller,
                
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                    )
                  )
                ),
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: (){
              setState(() {
                typing = !typing;
                widget.callback();
              });
            }
          )
        }
        else...{
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left:50),
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                typing = !typing;
              });
            }
          )
        }
      ],
    );
  }
}