import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/services/cache_helper.dart';
import '../../data/models/call_model.dart';
import '../bloc/register_call/register_call_cubit.dart';

class HistoryCallScreen extends StatelessWidget {
  final List<CallModel> callHistory;

  HistoryCallScreen({Key? key, required this.callHistory}) : super(key: key);
  final String callModelId = 'call_${UniqueKey().hashCode.toString()}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 20, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
            size: 18,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.callHistory,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            // Duration? timeDifference;
            // if (callHistory[index].createAt != null) {
            //   DateTime now = DateTime.now();
            //
            //   DateTime parsedDateTimeFromDB = DateFormat('yyyy-MM-dd HH:mm')
            //       .parse(callHistory[index].createAt ?? '');
            //   timeDifference = now.difference(parsedDateTimeFromDB);
            // }

            //////////////////
            String? callHourMinute;
            String? callFormattedDateTime;
            if(callHistory[index].createAt != null){
              DateTime now = DateTime.now();


              DateTime parsedCallDateTime = DateFormat('yyyy-MM-dd HH:mm').parse(callHistory[index].createAt!);
              DateTime today = DateTime(now.year, now.month, now.day);
              DateTime yesterday = DateTime(now.year, now.month, now.day - 1);



              if (parsedCallDateTime.isAfter(today)) {
                callFormattedDateTime = 'Today';
              } else if (parsedCallDateTime.isAfter(yesterday)) {
                callFormattedDateTime = 'Yesterday';
              } else {
                callFormattedDateTime = DateFormat('MMMM d').format(parsedCallDateTime);
              }

              callHourMinute = DateFormat('hh:mm a').format(parsedCallDateTime).toLowerCase();
            }




            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: SizedBox(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                child:
                                    callHistory[index].receiverAvatar == null ||
                                            callHistory[index]
                                                .receiverAvatar!
                                                .isEmpty
                                        ? Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.asset(
                                                'assets/images/empty.png',
                                                fit: BoxFit.cover,
                                              ),
                                              const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'No Avatar',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Image.network(
                                            callHistory[index].receiverAvatar!,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  callHistory[index].receiverName!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${callFormattedDateTime ?? ''}, ${callHourMinute ?? 0}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            iconSize: 60,
                            onPressed: () {DateTime now = DateTime.now();
                            String formattedDateTime =
                            DateFormat('yyyy-MM-dd HH:mm').format(now);

                              context.read<RegisterCallCubit>().makeCall(
                                      callModel: CallModel(
                                    id: '${CacheHelper.getString(key: 'uId')}+${callHistory[index].receiverId}',
                                    callerId: CacheHelper.getString(key: 'uId'),
                                    callerAvatar:
                                        callHistory[index].callerAvatar,
                                    callerName: callHistory[index].callerName,
                                    receiverId: callHistory[index].receiverId,
                                    receiverAvatar:
                                        callHistory[index].receiverAvatar,
                                    receiverName:
                                        callHistory[index].receiverName,
                                    status: CallStatus.ringing.name,
                                        createAt: formattedDateTime,
                                    current: true,
                                  ));
                            },
                            icon: Image.asset(
                              'assets/icons/video.png',
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: callHistory.length),
    );
  }
}
