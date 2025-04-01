import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:frontend/core/services/chat_service.dart';
import 'package:frontend/core/themes/colours.dart';
import 'package:frontend/home/pages/webview_page.dart';


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
  bool didSubmit = false;
  String answer = "";


  @override
  void initState ()
  {
    super.initState();
    ChatService().connect();
  }

  @override
  void dispose ()
  {
    // ChatService().dispose();
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      readOnly: didSubmit,
                      controller: queryController,
                      autofocus: true,
                      cursorColor: AppColors.submitButton,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 25,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 15.0, top: 8),
                        hintText: 'Ask anything...',
                        hintStyle: TextStyle(
                          color: AppColors.textGrey,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.2,
                            color: didSubmit ? Colors.transparent : AppColors.textGrey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.2,
                            color: didSubmit ? Colors.transparent : AppColors.textGrey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.2,
                            color: didSubmit ? Colors.transparent : AppColors.textGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7,),
                    
                    Row(
                      children: [
                        didSubmit ? const Icon(Icons.source_rounded) : const SizedBox(),
                        const SizedBox(width: 10,),
                        didSubmit ? const Text(
                          'Sources',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    StreamBuilder<Map<String,dynamic>>(
                      stream: ChatService().sourcesStream, 
                      initialData: null,
                      builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.waiting && didSubmit)
                        {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        if(snapshot.hasData && snapshot.data != null)
                        {
                          List<dynamic> sources = snapshot.data!['data'];

                          return SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sources.length,
                              itemBuilder: (context, index) {
                            
                                final source = sources[index];
                            
                                return SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: ListTile(
                                      
                                      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      tileColor: AppColors.cardColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      leading: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${index+1}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        source['title'],
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      subtitle: Text(
                                        source['content'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),

                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => WebviewPage(uri: source['url']))
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            ),
                          );
                        }

                        return const SizedBox();

                      },
                    ),
                    const SizedBox(height: 25,),

                    Row(
                      children: [
                        didSubmit ? const Icon(Icons.format_align_left_rounded) : const SizedBox(),
                        const SizedBox(width: 10,),
                        didSubmit ? const Text(
                          'Answer',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ) : const SizedBox(),
                      ],
                    ),

                    StreamBuilder(
                      stream: ChatService().responseStream, 
                      initialData: null,
                      builder: (context, snapshot) {
                        
                        if (snapshot.connectionState == ConnectionState.waiting && didSubmit)
                        {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        if (snapshot.hasData && snapshot.data != null)
                        {
                          final answerChunks = snapshot.data!['data'];
                          answer += answerChunks;

                          return Column(
                            children: [
                              Markdown(
                                data: answer,
                                selectable: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // styleSheet: MarkdownStyleSheet.fromTheme(ThemeData.dark()),
                              ),
                            ],
                          );
                        }

                        return const SizedBox();
                      },
                    ),

                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.add),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.submitButton,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        didSubmit = true;
                        ChatService().chat(queryController.text.trim());
                      });
                    },
                    icon: const Icon(Icons.send_rounded),
                    color: AppColors.background,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}