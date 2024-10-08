import 'package:cached_network_image/cached_network_image.dart';
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
    // services.removeAt(0);
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
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 10, left: 20, right: 20),
                    // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      initialValue: query,
                      onChanged: (value) {
                        context
                            .read<ServicesBloc>()
                            .add(FetchServicesEvent(query: value));
                      },
                      cursorColor: const Color(0XF757575),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        fillColor: Colors.white,
                        labelText: "Search",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Theme.of(context).primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Builder(
                        builder: <ServicesState>(context) {
                          if (services.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                Service itemService = services[index];

                                return ListTile(
                                  onTap: () {
                                    if (itemService.endpoint != null &&
                                        itemService.endpoint!.isNotEmpty) {
                                      Navigator.pushNamed(
                                          context, AppRoute.webView,
                                          arguments: {
                                            'title': itemService.title,
                                            'url': itemService.endpoint!
                                          });
                                      return;
                                    }
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
                                  leading: CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    imageUrl: itemService.picture!,
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
