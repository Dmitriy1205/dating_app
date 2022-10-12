import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 8, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Connections',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          const Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('319 Connections',
                style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 18),),
              Icon(Icons.search),
            ],),
          ),
          Container(
            color: Colors.grey.shade200,
            height: 120,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: Content.hobbiesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height:70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(Content.hobbiesList[index],fit: BoxFit.fill,),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Name'),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: Content.hobbiesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MessengerScreen()));
                    },
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    right: 15,
                                  ),
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        Content.hobbiesList[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 35),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Name Surname',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Message',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 0.3,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
