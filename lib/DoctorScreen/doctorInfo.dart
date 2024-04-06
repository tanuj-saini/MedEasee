import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_ease/DoctorScreen/DoctorModifyScreen.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/Utils/button.dart';
import 'package:med_ease/bloc/user_moduel_bloc.dart';

class DoctorInfo extends StatefulWidget {
  DoctorInfo({super.key});

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Additional controllers for other fields
  final TextEditingController bioController = TextEditingController();
  final TextEditingController timeSlotController = TextEditingController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController registerNumberController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  File? images;

  void pickImagesFile() async {
    var res = await pickImage(context: context);
    setState(() {
      images = res;
    });
  }

  Future<File?> pickImage({required BuildContext context}) async {
    File? image;

    try {
      var pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        var filePath = pickedFile.files.first.path;
        if (filePath != null) {
          image = File(filePath);
        }
      } else {
        showSnackBar("No file picked", context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    final sendDoctorModule = BlocProvider.of<UserModuelBloc>(context);
    return BlocConsumer<UserModuelBloc, UserModuelState>(
      listener: (context, state) {
        if (state is userModulefaliure) {
          showSnackBar(state.error, context);
        }
        if (state is doctorModuleSuccess) {
          final doctorBloc = context.read<DoctorBloc>();
          doctorBloc.updateDoctor(state.doctorModule);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => DoctorScreen()));
        }
      },
      builder: (context, state) {
        if (state is userModuleLoding) {
          return Loder();
        }
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SvgPicture.asset(
                                'assets/a.svg',
                                color: Colors.white,
                                height: 150,
                              ),

                              Center(
                                child: Stack(
                                  children: [
                                    images != null
                                        ? CircleAvatar(
                                            radius: 64,
                                            backgroundColor: Colors.red,
                                            backgroundImage: FileImage(images!),
                                          )
                                        : const CircleAvatar(
                                            radius: 64,
                                            backgroundImage:
                                                AssetImage('assets/img1.png'),
                                          ),
                                    Positioned(
                                      bottom: -10,
                                      left: 80,
                                      child: IconButton(
                                        onPressed: () {
                                          pickImagesFile();
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.person_2_outlined),
                                controller: nameController,
                                hintText: 'Enter your Name',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.location_city_outlined),
                                controller: addressController,
                                hintText: 'Enter your Address',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.email_outlined),
                                controller: emailController,
                                hintText: 'Enter your Email Address',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.phone_android_outlined),
                                controller: phoneNumberController,
                                hintText: 'Enter your Phone Number',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: ageController,
                                hintText: 'Enter your age',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // Additional custom text fields
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: bioController,
                                hintText: 'Enter your Bio',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: timeSlotController,
                                hintText: 'Enter your Time Slot',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: specialistController,
                                hintText: 'Enter your Specialist',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: hospitalController,
                                hintText: 'Enter your Current Working Hospital',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // Add more text fields as needed

                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: registerNumberController,
                                hintText: 'Enter your Register Number',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                iconButton: Icon(Icons.add_outlined),
                                controller: experienceController,
                                hintText: 'Enter your Experience',
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              CustomizableElevatedButton(
                                onPressed: () async {
                                  String photoUrlCLo = '';
                                  final cloudinary =
                                      CloudinaryPublic("dix3jqg7w", 'aqox8ip4');
                                  CloudinaryResponse response =
                                      await cloudinary.uploadFile(
                                          CloudinaryFile.fromFile(images!.path,
                                              folder: bioController.text));
                                  photoUrlCLo = response.secureUrl;

                                  sendDoctorModule.add(doctorModuleEvent(
                                      context: context,
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phoneNumber: phoneNumberController.text,
                                      specialist: specialistController.text,
                                      currentWorkingHospital:
                                          hospitalController.text,
                                      profilePic: photoUrlCLo,
                                      registerNumbers:
                                          registerNumberController.text,
                                      experience: experienceController.text,
                                      emailAddress: emailController.text,
                                      age: ageController.text));
                                },
                                buttonColor: Colors.blue,
                                buttonText: 'Submit',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
