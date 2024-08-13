import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/form_builder/form_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/logic/controllers/profile_controller.dart';

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
        print("${formData} In init state");
        profileController.updateUserProfile(url: url, formData: formData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editForm.title!,
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: formBuilder == null
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/1.jpg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
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
}
