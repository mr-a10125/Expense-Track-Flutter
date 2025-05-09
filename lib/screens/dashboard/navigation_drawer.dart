import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerDesign extends StatelessWidget {
  const NavigationDrawerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final usersDetails = Provider.of<AuthProvider>(context).currentUser;

    return NavigationDrawer(
        backgroundColor: primaryThemeColor,
        indicatorColor: Colors.white,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: primaryThemeColor,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 22),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                Container(
                  color: backgroundColor,
                  height: height,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                   children: [
                     Center(
                       child: Container(
                           width: 100,
                           height: 100,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50),
                               color: Colors.black26
                           ),
                           child: Center(
                             child: usersDetails?.photoURL != null ?
                             Image(image: NetworkImage(usersDetails!.photoURL.toString()))
                                 : Text(
                               '${usersDetails?.displayName?[0]}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 30,
                                   fontFamily: 'Poppins',
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           )
                       ),
                     ),
                  
                     SizedBox(height: 30),
                     Icon(Icons.person),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16),
                       child: Text(
                         '${usersDetails?.displayName}',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                  
                     SizedBox(height: 20),
                     Icon(Icons.email),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16),
                       child: Text(
                         '${usersDetails?.email}',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                   ],
                  ),
                )
              ],
            ),
          )
        ]
    );
  }
}
