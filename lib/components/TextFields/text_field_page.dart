import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


enum FieldDecoration{FLAT, ROUNDED}

class TextFieldPage extends StatefulWidget {
  final String initialText;
  //final TextEditingController controller;
  final String hint;
  final Object heroTag;
  final int maxLines;
  final TextInputType inputType;
  final String title;
  final FieldDecoration fieldDecoration;
  final double radius;
  final ValueChanged<String> onDone;

  const TextFieldPage({Key key,
    this.inputType,
    this.title,
    this.hint,
    this.onDone,
    this.fieldDecoration,
    this.heroTag,
    this.maxLines,
    this.radius,
    this.initialText}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final FocusNode focusNode = FocusNode();
  TextEditingController controller;
  TextInputType inputType;

  String currentText;

  @override
  void initState() {

    inputType = widget.inputType ?? TextInputType.number;

    if (inputType == TextInputType.number)
      controller = MoneyMaskedTextController(
          initialValue: PriceUtils.formatPriceToDouble(widget.initialText ?? '0'),
          decimalSeparator: '.',
          thousandSeparator: ','
      );

    else
      controller = TextEditingController( text: widget.initialText,);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        title: Text(widget.title ?? '', style: TextStyle(color: awBlack),),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear, color: Colors.black,),
        ),

        actions: <Widget>[
          FlatButton(
            child: Text('Clear'),
            onPressed: (){
              setState(() {
                controller.text = '';
              });
            },
          ),
        ],
      ),

      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: size.width,
        height: size.height - kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.heroTag ?? UniqueKey().toString(),
              transitionOnUserGestures: true,
              child: TextFormField(
                autofocus: true,
                keyboardType: widget.inputType ?? TextInputType.number,
                maxLines: widget.maxLines ?? 1,
                controller: controller,
                onFieldSubmitted: (data){
                  if (widget.onDone != null)
                    widget.onDone(data);
                },
                textInputAction: TextInputAction.done,
                decoration: _decoration(),

              ),
            ),

            (widget.inputType == TextInputType.number) ? Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: RoundedButton(
                  buttonColor: primaryColor,
                  height: 30,
                  width: 80,
                  buttonName: 'Done',
                  onTap: (){
                    if (widget.onDone != null)
                      widget.onDone(controller.text);
                  },
                ),
              ),
            ) : Container(),
          ],
        ),
      ),

    );
  }

  InputDecoration _decoration() {
    if (widget.fieldDecoration == FieldDecoration.ROUNDED)
      return InputDecoration(
        hintText: widget.hint ?? '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular( widget.radius ?? 12.0 ),
        ),
      ),
    );

    return InputDecoration(
      hintText: widget.hint ?? '',
    );

  }
}
