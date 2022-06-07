import 'package:Awoshe/components/size/SizeSelectableItem.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:flutter/material.dart';

typedef OnSizeSelected = void Function(String sizeType, int indexDataSelected);

class SizeListWidget extends StatelessWidget {
  final SizeMeasure sizeMeasure;
  final List<int> selectedIndexes;
  final OnSizeSelected onSizeSelected;
  final OnSizeSelected onSizeUnselected;

  SizeListWidget(this.sizeMeasure, {this.selectedIndexes = const [],
    this.onSizeSelected, this.onSizeUnselected});

  @override
  Widget build(BuildContext context) {

    if (sizeMeasure == null)
      return Container();

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sizeMeasure.nonmetricValues.length,
        itemBuilder: (context, int indexValue) {
          return Container(
            width: 250,
            margin: EdgeInsets.only(right: 8.0),
            child: SizeSelectableItem(
              headers: sizeMeasure.noMetricHeaders,
              isSelected: selectedIndexes.contains( indexValue ),
              values: sizeMeasure.nonmetricValues[indexValue],

              onPressed: () {
                if( selectedIndexes.contains( indexValue ) ){
                  if (onSizeUnselected != null)
                    onSizeUnselected(sizeMeasure.name, indexValue);
                }

                else {
                  if (onSizeSelected != null)
                    onSizeSelected(sizeMeasure.name, indexValue);
                }

              },
            ),
          );
        }
    );
  }
}
