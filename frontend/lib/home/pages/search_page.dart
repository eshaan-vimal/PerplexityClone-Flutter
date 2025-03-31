import 'package:flutter/material.dart';
import 'package:frontend/core/themes/colours.dart';


class SearchPage extends StatefulWidget
{
  static MaterialPageRoute route() => MaterialPageRoute(builder: (context) => const SearchPage());


  const SearchPage ({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage>
{
  final queryController = TextEditingController();


  @override
  void initState ()
  {
    super.initState();
  }

  @override
  void dispose ()
  {
    queryController.dispose();
    super.dispose();
  }


  @override
  Widget build (BuildContext context)
  {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.cancel)),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.sort),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: queryController,
              autofocus: true,
              cursorColor: AppColors.submitButton,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 25,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15.0, top: 8),
                hintText: 'Ask anything...',
                hintStyle: TextStyle(
                  color: AppColors.textGrey,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.2,
                    color: AppColors.textGrey,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.2,
                    color: AppColors.textGrey,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.2,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}