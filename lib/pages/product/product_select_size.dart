import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

typedef OnSizeSelected = void Function(int indexSelected, String sizeText);

class SelectSize extends StatefulWidget {
  final int indexSelected;
  final List<String> sizesAvailable;
  final OnSizeSelected onSizeSelected;

  SelectSize(
      {this.indexSelected = -1,
      this.sizesAvailable = const [],
      this.onSizeSelected});

  @override
  State<StatefulWidget> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {

  int currentIndexSelected;
  bool isSelected;

  @override
  void initState() {
    currentIndexSelected = widget.indexSelected;
    if (currentIndexSelected > -1)
      isSelected = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              height: 40.0,
              child: (widget.sizesAvailable == null || widget.sizesAvailable.isEmpty)
                  ? Center(
                child: Text("No sizes available"),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.sizesAvailable.length,
                itemBuilder: (context, int index) {

                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Material(
                      color: currentIndexSelected == index
                          ? awLightColor
                          : Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (widget.onSizeSelected != null) {
                            if (currentIndexSelected == index && isSelected){
                              currentIndexSelected = -1;
                              isSelected = false;
                              widget.onSizeSelected(currentIndexSelected,
                                null,);
                            }

                            else{
                              currentIndexSelected = index;
                              isSelected = true;
                              widget.onSizeSelected(currentIndexSelected,
                                  widget.sizesAvailable[currentIndexSelected]
                              );
                            }



                            setState(() {});
                          }
                        },
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          child: Center(
                              child: Text(widget.sizesAvailable[index])
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: awLightColor)
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
