import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pridesys_task/common_widget/custom_text_field.dart';
import 'package:pridesys_task/features/character_list/provider/character_list_provider.dart';
import 'package:pridesys_task/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../widget/character_widget.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CharacterListProvider>().fetchMore();
      }
    });
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool _showSearch = false;
  void _onClearAndCloseSearch() {
    setState(() {
      _showSearch = false;
      _searchController.clear();
    });
    context.read<CharacterListProvider>().searchCharacter("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: _showSearch
            ? Consumer<CharacterListProvider>(
                builder: (context, provider, child) {
                  return CustomTextField(
                    controller: _searchController,
                    hintText: "Search.....",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      provider.searchCharacter(value);
                    },

                    suffixIcon: IconButton(
                      onPressed: () {
                        _onClearAndCloseSearch();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  );
                },
              )
            : Text("Character"),
        centerTitle: false,
        titleTextStyle: TextFontStyle.headLine18CFFFFFFW700,
        backgroundColor: Colors.black,
        actions: [
          IconButton.outlined(
            onPressed: () {
              context.push(AppRoutes.favoriteScreen);
            },
            tooltip: "All Favorites",
            icon: Icon(Icons.favorite),
            color: Colors.red,
          ),

          IconButton.outlined(
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
              });
            },
            tooltip: "Search Character",
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),

      body: Consumer<CharacterListProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.results.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.results.isEmpty) {
            return Center(
              child: Text(
                "Data is not available!",
                style: TextFontStyle.headLine18CFFFFFFW700,
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    itemCount: provider.results.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (_, index) {
                      if (index == provider.results.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      var data = provider.results[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            AppRoutes.characterDetailsScreen,
                            extra: data,
                          );
                        },
                        child: CharacterWidget(data: data),
                      );
                    },
                  ),
                ),

                if (provider.isFetchingMore)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
