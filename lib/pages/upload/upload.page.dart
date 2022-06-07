import 'dart:io';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/pages/upload/design/upload_design_details_page.dart';
import 'package:Awoshe/pages/upload/upload_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Upload extends StatelessWidget {
  Upload(
      {this.productType,
      this.uploadMode,
      this.designImages,
      this.productId,
      Key key})
      : super(key: key);

  final ProductType productType;
  final UploadMode uploadMode;
  final String productId;
  final List<File> designImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Provider<UploadDesignBlocV2>(
        builder: (context) => UploadDesignBlocV2(),
        dispose: (_, bloc) => bloc.dispose(),
        child: (uploadMode == UploadMode.ADD)
            ? UploadForm(productType: productType, uploadMode: uploadMode)
            : UploadDesignDetailsPage(
                productId: productId,
                uploadType: productType,
                uploadMode: uploadMode,
                designImages: designImages,
              ),
      ),
    );
  }
}
