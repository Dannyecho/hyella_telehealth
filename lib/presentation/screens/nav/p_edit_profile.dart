import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/form_builder/form_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/profile_edit_bloc.dart';
import 'package:hyella_telehealth/logic/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class PEditProfile extends StatefulWidget {
  const PEditProfile({super.key});

  @override
  State<PEditProfile> createState() => _PEditProfileState();
}

class _PEditProfileState extends State<PEditProfile> {
  late final User userDetails;
  late EndPointEntityDataFormsProfileUpdate editForm;
  late FormBuilder formBuilder;
  @override
  void initState() {
    super.initState();
    userDetails = context.read<AppBloc>().state.appData!.user!;
    editForm = context
        .read<EndpointBloc>()
        .state
        .endPointEntity!
        .data!
        .forms!
        .profileUpdate!;

    formBuilder = FormBuilder(
      context,
      formObject: editForm,
      initialValues: userDetails.toJson(),
      onSubmit: (url, formData) {
        ProfileController profileController = ProfileController();
        // print("${url} In init state");
        // print("${formData} In init state");
        profileController.updateUserProfile(url: url, formData: formData);
      },
    );

    if (userDetails.dp != null && userDetails.dp!.isNotEmpty) {
      context.read<ProfileEditBloc>().add(
            SetProfileImageEvent(
              imagePath: userDetails.dp!,
              source: ProfileImageSource.web,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editForm.title!,
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<ProfileEditBloc, ProfileEditState>(
              listener: (context, state) {
                if (state.refreshApp) {
                  print("Refreshing App...........................");
                  context.read<AppBloc>().add(UpdateUserInfoEvent());
                }
              },
              builder: (context, state) {
                final profileEditBloc = context.read<ProfileEditBloc>();
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors2.color1,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: const Text("Take a Photo"),
                              leading: const Icon(Icons.camera_alt),
                              onTap: () async {
                                var file = await takePhoto(
                                  ImageSource.camera,
                                  maxWidth: 100,
                                  maxHeight: 100,
                                );
                                if (file != null && context.mounted) {
                                  profileEditBloc.add(
                                    UpdateProfileImageEvent(
                                      imagePath: file.path,
                                      source: ProfileImageSource.file,
                                      currentImgUrl: context
                                          .read<AppBloc>()
                                          .state
                                          .appData!
                                          .user!
                                          .dp!,
                                    ),
                                  );
                                }

                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            ListTile(
                              title: const Text("Choose from Gallery"),
                              leading: const Icon(Icons.photo),
                              onTap: () async {
                                var file = await takePhoto(ImageSource.gallery);
                                if (file != null && context.mounted) {
                                  profileEditBloc.add(
                                    UpdateProfileImageEvent(
                                      imagePath: file.path,
                                      source: ProfileImageSource.file,
                                      currentImgUrl: context
                                          .read<AppBloc>()
                                          .state
                                          .appData!
                                          .user!
                                          .dp!,
                                    ),
                                  );
                                }

                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60)),
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      color: Colors.white,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: state.source == ProfileImageSource.none
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.grey[300],
                                          size: 90,
                                        ),
                                      )
                                    : (state.source == ProfileImageSource.web
                                        ? BlocBuilder<AppBloc, AppBlocState>(
                                            builder: (context, state) {
                                              return CircleAvatar(
                                                radius: 50,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  state.appData?.user?.dp ?? '',
                                                ),
                                              );
                                            },
                                          )
                                        : Image.file(
                                            File(state.profileImage),
                                            fit: BoxFit.cover,
                                          )),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              state.isLoading
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<FormBuilderBloc, FormBuilderState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: formBuilder.buildForm(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  Future<XFile?> takePhoto(ImageSource source,
      {double? maxWidth, double? maxHeight}) async {
    return await _picker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }
}
