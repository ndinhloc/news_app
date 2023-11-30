import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String gCountry = lCountry.first;
  String gCategory = lCategory.first;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              newsBloc.add(FetchTopHeadlineNewsEvent(
                  country: gCountry, category: gCategory));
            } else if (state is NewsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadedState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          hintText: "Search...",
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchController.clear();
                                newsBloc.add(FetchTopHeadlineNewsEvent(
                                    country: gCountry, category: gCategory));
                              },
                              icon: const Icon(Icons.clear))),
                      onSubmitted: (value) {
                        newsBloc.add(FetchEverythingNewsEvent(search: value));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Showing top " +
                            gCategory.toString() +
                            " news in " +
                            gCountry.toString() +
                            "."),
                        //Text button to show setting dialog that user will use to change country and category.
                        TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  //use StatefulBuilder because showDialog does not share context.
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Text("Settings"),
                                        content: Column(children: [
                                          DropdownButton(
                                              value: gCountry,
                                              items: countryDropdownItems(),
                                              onChanged: (value) {
                                                gCountry = value!;
                                                setState(() {});
                                              }),
                                          DropdownButton(
                                              value: gCategory,
                                              items: categoryDropdownItems(),
                                              onChanged: (value) {
                                                setState(() {
                                                  gCategory = value!;
                                                });
                                              })
                                        ]),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                newsBloc.add(
                                                    ChangeNewsPropertiesEvent(
                                                        selectedCountry:
                                                            gCountry,
                                                        selectedCategory:
                                                            gCategory));
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Done'))
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Change",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.news.articles.length,
                        itemBuilder: (context, index) {
                          if (state.news.articles.length != 0) {
                            return GestureDetector(
                              onTap: () {
                                newsBloc.add(ViewArticleDetailEvent(
                                    news: state.news, index: index));
                              },
                              child: NewsCard(
                                  imgUrl: state.news.articles[index]
                                              .urlToImage !=
                                          null
                                      ? state.news.articles[index].urlToImage!
                                      : "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/NULL.jpg/800px-NULL.jpg",
                                  desc: state.news.articles[index]
                                              .description !=
                                          null
                                      ? state.news.articles[index].description!
                                      : "No description",
                                  title: state.news.articles[index].title!,
                                  postUrl:
                                      state.news.articles[index].url != null
                                          ? state.news.articles[index].url!
                                          : ""),
                            );
                          } else {
                            return Center(child: Text("No article found"));
                          }
                        }),
                  ),
                ],
              );
            }
            return const Center(child: Text("error"));
          },
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imgUrl, title, desc, postUrl;

  const NewsCard(
      {super.key,
      required this.imgUrl,
      required this.desc,
      required this.title,
      required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                imgUrl,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                // if the image is null
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Icon(Icons.broken_image_outlined),
                    ),
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              desc,
              maxLines: 2,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
