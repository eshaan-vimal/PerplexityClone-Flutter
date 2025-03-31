import 'package:flutter/material.dart';

import 'package:frontend/core/themes/colours.dart';
import 'package:frontend/home/pages/search_page.dart';


class HomePage extends StatefulWidget
{
  static MaterialPageRoute route() => MaterialPageRoute(builder: (context) => const HomePage()); 


  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
{
  

  @override
  void initState ()
  {
    super.initState();
  }

  @override
  void dispose ()
  {
    super.dispose();
  }


  @override
  Widget build (BuildContext context)
  {
    return Stack(

      children: [

        Positioned.fill(
          child: Image(
            image: AssetImage('assets/images/bg_image.png'),
            fit: BoxFit.cover, 
          ),
        ),

        Scaffold(
          
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            title: Text(
              'perplexity',
              // style: TextStyle(
              //   color: AppColors.whiteColor,
              // ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.person_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.share_rounded),
              ),
            ],
          ),
        
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: const SizedBox(),
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Where'
                  //     ),
                  //     Text(
                  //       'knowledge'
                  //     ),
                  //     Text(
                  //       'begins'
                  //     ),
                  //   ],
                  // ),
                ),
                ListTile(
                  tileColor: AppColors.searchBarBorder,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  leading: Icon(Icons.image_search_outlined),
                  trailing: Icon(Icons.multitrack_audio_rounded),
                  title: Text(
                    "Ask me anything...",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(SearchPage.route());
                  },
                )
              ],
            ),
          ),
        
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            selectedIconTheme: IconThemeData(
              color: AppColors.submitButton,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.space_dashboard),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_library_rounded),
                label: '',
              ),
            ]
          ),
        ),

      ]
    );
  }
}