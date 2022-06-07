import 'package:Awoshe/components/product_care/CareOption.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:flutter/material.dart';


typedef OnItemSelectionChange = void Function(ProductCareType previous,  ProductCareType current);

class CareOptionSection extends StatefulWidget {
  final String sectionTitle;
  final Axis orientation;

  final List<ProductCareType> types;
  final ProductCareType selectedType;
  final OnItemSelectionChange itemSelectionChange;

  const CareOptionSection(
      {Key key,
      this.sectionTitle = '',
      this.selectedType,
      @required this.types,
      this.orientation = Axis.vertical, this.itemSelectionChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CareOptionSectionState();
}

class _CareOptionSectionState extends State<CareOptionSection> {
  ProductCareType selectedType;

  @override
  void initState() {
    selectedType = widget.selectedType;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        (widget.orientation == Axis.horizontal)
            ? _buildHorizontal()
            : _buildVertical(),
      ],
    );
  }

  Widget _buildHorizontal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _createOptionsItems(),
    );
  }

  Widget _buildSectionTitle() => Flexible(
        child: Container(
          child: Text(
            widget.sectionTitle ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _buildVertical() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [_buildSectionTitle()]..addAll(_createOptionsItems()),
        ),
      ],
    );
  }

  List<Widget> _createOptionsItems() => widget.types
      .map<Widget>(
        (type) => CareOption(
          type: type,
          title: getProductCareTypeTitle(type),
          isSelected: (type == selectedType) ? true : false,
      iconSize: 42.0,
          onTap: (typeSelected) {
            var previous;

            if (typeSelected == selectedType) {
              selectedType = null;
              previous = typeSelected;
            }

            else{
              previous = selectedType;
              selectedType = typeSelected;
            }

            setState(() {});

            if (widget.itemSelectionChange != null)
              widget.itemSelectionChange(previous, selectedType);
          },
        ),
      )
      .toList();
}
