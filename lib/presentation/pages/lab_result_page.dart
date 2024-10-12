import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/lab_result_entity.dart';
import 'package:hyella_telehealth/logic/bloc/lab_result_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/shedule_shimmer.dart';

class LabResultPage extends StatefulWidget {
  final String title;

  LabResultPage({required this.title});
  @override
  _LabResultPageState createState() => _LabResultPageState();
}

class _LabResultPageState extends State<LabResultPage> {
  late List<LabResultEntityDatum> labResults;
  bool loading = true;
  bool errorEncountered = false;
  @override
  void initState() {
    super.initState();
    context.read<LabResultBloc>().add(FetchLabResultsEvent());
    /* Timer.run(() {
      getDetails();
    }); */
  }

  /*  void getDetails() {
    setState(() {
      loading = true;
    });
    Provider.of<CardDetailProvider>(context, listen: false)
        .getOnlineConsultation()
        .then(
          (value) => value.fold(
            (l) {
              showSnackbar(l, false);
              setState(() {
                if (l != "No Records Found") {
                  errorEncountered = true;
                }
                loading = false;
              });
            },
            (r) {
              errorEncountered = false;
              labResults = r.data!.data!;
              loading = false;

              setState(() {});
            },
          ),
        );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body:
          BlocBuilder<LabResultBloc, LabResultState>(builder: (context, state) {
        if (context.read<LabResultBloc>().state is LabResultLoadedState) {
          labResults =
              (context.read<LabResultBloc>().state as LabResultLoadedState)
                  .labResults!;
        }
        return state is LabResultInitial
            ? const ScheduleShimmer()
            : labResults.isEmpty
                ? const Center(
                    child:
                        Text("No results found!", textAlign: TextAlign.center),
                  )
                : ListView.builder(
                    itemCount: labResults.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFAF2E9),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.webView,
                              arguments: {
                                'url': labResults[index].url!,
                                'title': labResults[index].title!
                              });
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFACDCE),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            labResults[index].info!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff5A88EC),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          labResults[index].title!,
                          maxLines: 3,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(labResults[index].subTitle!),
                      ),
                    ),
                  );
      }),
    );
  }
}
