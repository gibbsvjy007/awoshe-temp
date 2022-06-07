import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class AwosheDropdown extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onChange;
  final Color color;
  final double height;
  final TextStyle textStyle, hintStyle;
  final double radius;
  final bool isExpanded;
  final String disableHint;

  AwosheDropdown(
      {this.hintText,
      this.color,
      this.radius,
      this.height,
      this.onChange,
      this.hintStyle,
      this.textStyle,
      this.options,
      this.disableHint,
      this.isExpanded = false,
      this.selectedValue});

  Widget buildDropDownRow() {
    return Row(
      children: <Widget>[

        Expanded(
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: color),
                borderRadius: BorderRadius.circular(radius ?? 50.0),
              ),
            ),
            child: Container(
              height: height ?? 50.0,
              padding: EdgeInsets.only(left: .0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
                  hintText != null ? Expanded(
                    child: Text(
                      hintText.length > 40
                          ? hintText.substring(0, 30) + "..."
                          : hintText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: hintStyle,
                    ),
                  ) : Container(),

                  Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        disabledHint: Text( disableHint ?? ''),
                        value: selectedValue,
                        isDense: true,
                        iconEnabledColor: awLightColor,
                        onChanged: onChange,

                        items: options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(_parseText(value), overflow: TextOverflow.ellipsis, maxLines: 1,),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _parseText(String text){
    if (text.length <= 10)
      return text;
    
    return text.substring(0, 9) + '...';
  }
  @override
  Widget build(BuildContext context) {
    return buildDropDownRow();
  }
}
