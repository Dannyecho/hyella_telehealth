import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/emr_options.dart';
import 'package:hyella_telehealth/logic/bloc/emr_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/shedule_shimmer.dart';

class EmrPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const EmrPage({super.key, required this.data});

  @override
  State<EmrPage> createState() => _EmrPageState();
}

class _EmrPageState extends State<EmrPage> {
  late List<EmrOptionsDatum?> emrOptions;

  @override
  void initState() {
    super.initState();
    if (context.read<EmrBloc>().allEmrOptions.containsKey(widget.data['key']) &&
        context.read<EmrBloc>().allEmrOptions[widget.data['key']]!.isNotEmpty) {
      context.read<EmrBloc>().add(SetEmrOptionsEvent(
          options: context.read<EmrBloc>().allEmrOptions[widget.data['key']]!));
    } else {
      context
          .read<EmrBloc>()
          .add(FetchingEmrOptionsEvent(pageKey: widget.data['key']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data['title'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        // centerTitle: true,
      ),
      body: BlocBuilder<EmrBloc, EmrState>(
        builder: (context, state) {
          emrOptions = state.emrOptions;

          return state.loading
              ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ScheduleShimmer(),
                )
              : emrOptions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No records found",
                            style: TextStyle(color: AppColors2.color1),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<EmrBloc>().add(
                                  FetchingEmrOptionsEvent(
                                      pageKey: widget.data['key']));
                            },
                            child: const Text('Refresh'),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<EmrBloc>().add(FetchingEmrOptionsEvent(
                            pageKey: widget.data['key']));
                      },
                      child: Container(
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
                                        color: const Color(0xffFAF2E9),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoute.webView,
                                              arguments: {
                                                'url': option.url,
                                                'title': option.title
                                              });
                                        },
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffFACDCE),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            option.info!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Color(0xff5A88EC),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        title: Text(
                                          option.title!,
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(option.subTitle!),
                                      ),
                                    );
                            }),
                      ),
                    );
        },
      ),
    );
  }
}
