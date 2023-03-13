import 'package:barbershop/models/barbershop_model.dart';
import 'package:barbershop/service/home_service.dart';
import 'package:barbershop/screen/detail_barbershop/detail_list_screen.dart';
import 'package:barbershop/screen/detail_barbershop/detail_ recommendation_screen.dart';
import 'package:barbershop/screen/home/widgets/list_card.dart';
import 'package:barbershop/screen/home/widgets/recommendation_card.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HomeProvider homeProvider =
    //     Provider.of<HomeProvider>(context, listen: false);

    HomeService homeService = HomeService();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Hair Magicians\nIn City Are Here!',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Find the barbershop of your choice !!!',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommendation',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeService.streamRecommendation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if(snapshot.hasData){
                        var data = snapshot.data!.docs;
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final dataRecommend =
                              data[index].data() as Map<String, dynamic>;
                              return RecommendationCard(
                                BarbershopModel(
                                  name: dataRecommend['name'],
                                  city: dataRecommend['city'],
                                  image1: dataRecommend['image1'],
                                ),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailRecommendScreen(
                                            idDoc: data[index].id,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'List Barbers',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeService.streamList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final dataRecommend =
                            data[index].data() as Map<String, dynamic>;
                            return ListCard(
                              BarbershopModel(
                                name: dataRecommend['name'],
                                city: dataRecommend['city'],
                                image1: dataRecommend['image1'],
                              ),
                                  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailListScreen(
                                          idDoc: data[index].id,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return  Center(
                          child: Container(),
                        );
                      }
                    }else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
