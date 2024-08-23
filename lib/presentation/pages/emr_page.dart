import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/emr_options.dart';
import 'package:hyella_telehealth/logic/bloc/emr_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class EmrPage extends StatefulWidget {
  const EmrPage({super.key});

  @override
  State<EmrPage> createState() => _EmrPageState();
}

class _EmrPageState extends State<EmrPage> {
  late List<EmrOptionsDatum?> emrOptions;
  @override
  void initState() {
    super.initState();
    context.read<EmrBloc>().add(FetchingEmrOptionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My EMR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        // centerTitle: true,
      ),
      body: BlocBuilder<EmrBloc, EmrState>(
        builder: (context, state) {
          emrOptions = state.emrOptions;
          return emrOptions.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors2.color1,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: emrOptions.length,
                      itemBuilder: (context, index) {
                        EmrOptionsDatum? option = emrOptions[index];
                        return option == null
                            ? const Text(
                                "Unable to get data at the moment,\nplease try again.")
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffFAF2E9),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.webView, arguments: {
                                      'url': option.url,
                                      'title': option.title
                                    });
                                  },
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffFACDCE),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Text(
                                      option.info!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xff5A88EC),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  title: Text(
                                    option.title!,
                                    maxLines: 3,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(option.subTitle!),
                                ),
                              );
                      }),
                );
        },
      ),
    );
  }
}
