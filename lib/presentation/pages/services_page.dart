import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/services_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class ServicesPage extends StatefulWidget {
  final List<Service> services;
  const ServicesPage({super.key, required this.services});
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late final Data? appData;
  // late final Home appServices;
  late List<Service> services;
  String query = '';
  @override
  void initState() {
    super.initState();
    /* appData = context.read<AppBloc>().state.appData;
    if (appData?.menu?.home != null) {
      appServices = appData!.menu!.home!;
    } */
    services = widget.services;
    services.removeAt(0);
    context.read<ServicesBloc>().add(SetServicesEvent(services: services));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Services",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.read<AppScreenBloc>().add(SwitchScreen(index: 0));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      // ignore: unnecessary_null_comparison
      body: services == null
          ? const Center(child: CircularProgressIndicator())
          : BlocBuilder<ServicesBloc, ServicesState>(
              builder: (context, state) {
                if (state is ServicesLoadedState) {
                  services = state.services;
                  query = state.query;
                }

                return Column(children: [
                  Container(
                    color: AppColors2.color1,
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      autocorrect: true,
                      initialValue: query,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        context
                            .read<ServicesBloc>()
                            .add(FetchServicesEvent(query: value));
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        hintText: "Search Services",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Builder(
                        builder: <ServicesState>(context) {
                          if (services.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                Service itemService = services[index];

                                return ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.service,
                                        arguments: {
                                          'service': itemService,
                                        });
                                  },
                                  style: ListTileStyle.drawer,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 0,
                                  ),
                                  leading: Image.network(
                                    itemService.picture!,
                                    width: 30,
                                    height: 30,
                                    color: AppColors2.color1,
                                  ),
                                  title: Text(
                                    itemService.title!,
                                    style: TextStyle(
                                      color: AppColors2.color1,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, int) => Divider(),
                              itemCount: services.length,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          // return const Center(child: Text("Could not load services"));
                        },
                      ),
                    ),
                  ),
                ]);
              },
            ),
    );
  }
}
