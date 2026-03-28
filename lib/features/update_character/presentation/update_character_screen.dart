import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pridesys_task/common_widget/custom_network_image.dart';
import 'package:pridesys_task/constants/text_font_style.dart';

import '../../../common_widget/custom_text_field.dart';
import '../../character_list/model/character_response.dart';
import '../widgets/update_character.dart';
import '../widgets/update_origin.dart';

class UpdateCharacterScreen extends StatefulWidget {
  final Result data;
  const UpdateCharacterScreen({super.key, required this.data});

  @override
  State<UpdateCharacterScreen> createState() => _UpdateCharacterScreenState();
}

class _UpdateCharacterScreenState extends State<UpdateCharacterScreen> {
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  final _specifyController = TextEditingController();
  final _genderController = TextEditingController();
  final _originController = TextEditingController();
  final _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data.name ?? "";
    _statusController.text = widget.data.status ?? "";
    _specifyController.text = widget.data.species ?? "";
    _genderController.text = widget.data.gender ?? "";
    _originController.text = widget.data.origin?.name ?? "";
    _locationController.text = widget.data.location?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19192d),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          _nameController.text,
          style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            // Back character screen
            context.pop();
          },
        ),

        actions: [
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Update Function
              }
            },
            child: Text("Save"),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image
              CustomCachedNetworkImage(
                imageUrl: widget.data.image ?? "",
                width: double.infinity,
                height: 300.h,
              ),

              SizedBox(height: 10.h),

              // Name
              Center(
                child: CustomTextField(
                  controller: _nameController,
                  align: TextAlign.center,
                ),
              ),

              // Status
              Center(
                child: CustomTextField(
                  controller: _statusController,
                  style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                    color: Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  align: TextAlign.center,
                ),
              ),

              SizedBox(height: 20.h),
              // Info
              UpdateCharacterInfo(
                specify: _specifyController,
                gender: _genderController,
              ),

              SizedBox(height: 20.h),
              // ORIGIN
              Text(
                "ORIGIN",
                style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 6.h),
              UpdateOrigin(originController: _originController),

              SizedBox(height: 20.h),

              // LAST LOCATION UNKNOWN
              Text(
                "LAST KNOWN LOCATION",
                style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 6.h),
              UpdateOrigin(originController: _locationController),

              SizedBox(height: 20.h),

              // LAST LOCATION UNKNOWN
              Text(
                "Episod(${widget.data.episode!.length.toString()})",
                style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 6.h),
              // OriginInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
