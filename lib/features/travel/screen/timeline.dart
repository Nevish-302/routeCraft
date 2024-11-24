import 'package:ai_travel_planner/data/model/DayWiseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/Repository/itenary.dart';
import '../../../data/model/itenaryModel.dart';

class TimeLine extends StatelessWidget {
   TimeLine({super.key});
   DayWiseModel itenary = DayWiseModel();
  Future req() async {
    ItenaryRepo repo = ItenaryRepo();
    itenary = await repo.DayWise("jaipur for 4 number of days");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: "TimeLine".text.make(),
          backgroundColor: Colors.transparent,
          excludeHeaderSemantics: true,
        ),
        body: FutureBuilder(
          future: req(),
    builder: (BuildContext, AsyncSnapshot) {
    if (AsyncSnapshot.connectionState ==ConnectionState.done) {
      return Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            // color: Colors.white,
            child: Image.asset(
              "asset/sky1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.18,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, x) {
                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Mon".text.make(),
                          "01".text.minFontSize(25).make()
                        ],
                      ),
                    ).pLTRB(20, 60, 0, 0);
                  })),
          ///completee tile
          GlassContainer(
          opacity: 0.01,
            width: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: ListView.builder(
                itemCount: itenary.items!.length,
                itemBuilder: (context, index) {

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      itenary.items![index].time!.text.white.size(8).make(),
                      SizedBox(width: 5,),
                      // Container(height: MediaQuery.of(context).size.height*0.1,
                      // width: MediaQuery.of(context).size.width*0.1,child:
                      // Image.asset("lib/assets/Line 10.png")),
                      ///tiles
                      Container(

                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.77,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(66, 104, 103, 103),
                            borderRadius: BorderRadius.circular(20)
                        ),

                        child: ListTile(
                          title: itenary.items![index].name!.text.white.bold.make().p(8),
                          leading: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                color: Colors.red,

                                borderRadius: BorderRadius.circular(10),),
                              child: Container(

                                width: 50,
                                child: Image.network(
                                  height: 80,
                                  itenary.items![index].imageLink!,
                                  fit: BoxFit.cover,),
                              )),
                          trailing: IconButton(
                            icon: Icon(Icons.more_horiz), onPressed: () {},),
                        ),
                      )
                    ],
                  ).p(6);
                }),
          ).pLTRB(0, 200, 0, 0),
        ],
      );
    }
    else{
      return CircularProgressIndicator().centered();
    }
    }
        ),
      ),
    );
  }
}
