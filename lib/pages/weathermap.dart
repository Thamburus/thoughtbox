import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughtbox/bloc/weather_bloc.dart';
import 'package:thoughtbox/bloc/weather_event.dart';
import 'package:thoughtbox/bloc/weather_state.dart';
import 'package:thoughtbox/pages/loginpage.dart';
import 'package:thoughtbox/repository/api.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Weather Map  '),
        actions: [
        GestureDetector(
          onTap: (() {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
            
          }),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Center(child: Text('Logout')),
                // icon: Icon(Icons.add),
               
              ),
            ),
          ),
        ],
      ),
          
          
          
           body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            
            return  Center(child: Text('error'));
          }
          if (state is UserLoadedState) {
             dynamic userList = state.users;

            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width/1.1,
                color: Color.fromARGB(255, 197, 43, 43).withOpacity(0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height/12,
                         width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                        // color: Colors.black,
                        child: Center(child: Text('Temperature:  ${userList['current']['temp_c'].toString()}',style: TextStyle(fontSize: 20,color: Colors.white),))),
                    ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                      height:  MediaQuery.of(context).size.height/12,
                         width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                      // color: Colors.black,
                      child: Center(child: Text('Weathertype:  ${userList['current']['condition']['text'].toString()}',style: TextStyle(fontSize: 20,color: Colors.white),))),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                      height:  MediaQuery.of(context).size.height/12,
                         width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                      // color: Colors.black,
                      child: Center(child: Text('Humidity:  ${userList['current']['humidity'].toString()}',style: TextStyle(fontSize: 20,color: Colors.white),))),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                      height:  MediaQuery.of(context).size.height/12,
                         width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                      // color: Colors.black,
                      child: Center(child: Text('WindSpeed:   ${userList['current']['wind_kph'].toString()}',style: TextStyle(fontSize: 20,color: Colors.white),))),
                       ),
                  
                  
                  
                  
                       
                      
                   
                  ],
                ),
              ),
            );
            // return ListView.builder(
            //     itemCount: 1,
            //     itemBuilder: (_, index) {
            //       return Padding(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            //         child: Card(
            //             color: Theme.of(context).primaryColor,
            //             child: ListTile(
            //                 title: Text(
            //                   '${userList.location.name}  ${userList.location.name}',
            //                   style: const TextStyle(color: Colors.white),
            //                 ),

            //                 subtitle: Text(
            //                   '${userList.location.name}',
            //                   style: const TextStyle(color: Colors.white),
            //                 ),

            //                 // leading: CircleAvatar(
            //                 //   backgroundImage: NetworkImage(
            //                 //       userList[index].avatar.toString()),
            //                 // )
            //                 )),
            //       );
            //     });
          }

          return Container(
            color: Colors.amber,
          );
        },
      ),
    );
  }
}
