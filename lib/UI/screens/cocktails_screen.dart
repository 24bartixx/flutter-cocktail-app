import 'package:cocktails/data/models/cocktail.dart';
import 'package:cocktails/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CocktailsScreen extends StatefulWidget {

  @override
  _CocktailsScreenState createState() => _CocktailsScreenState();

}

class _CocktailsScreenState extends State<CocktailsScreen> {

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int nextPage = 1;

  List<Cocktail> cocktails = [];
  List<Cocktail> searchCocktails = [];

  bool isLoading = false;

  final apiService = ApiService();
  void _fetchNextCocktailsPage() async {

    if(isLoading) return;

    setState((){ isLoading = true; });
    
    var (pagesCount, fetchedCocktails) = await apiService.fetchCocktailsPage(nextPage);

    if(nextPage <= pagesCount) {
      setState(() {
        nextPage++;
        cocktails += fetchedCocktails;
        if(searchController.text.isNotEmpty) filterCocktails();
        isLoading = false;
      });
    }
    
    setState(() { isLoading = false; });

  }

  @override
  void initState() {
    super.initState();
    _fetchNextCocktailsPage();
    searchController.addListener(filterCocktails);
  }

  void onScroll() {
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      _fetchNextCocktailsPage();
    }
  }

  void filterCocktails() {
    String query = searchController.text.toLowerCase();
    setState(() =>
      searchCocktails = cocktails.where((cocktail) =>
        cocktail.name.toLowerCase().contains(query)
          || cocktail.category.toLowerCase().contains(query)
          || cocktail.glass.toLowerCase().contains(query)
      ).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cocktailPageTitle)
      ),      
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1
                )
              )
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child:TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.searchCocktailsTextField,
                icon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                suffixIcon: searchController.text.isNotEmpty 
                  ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      searchController.clear();
                      filterCocktails();
                    }
                  )
                  : null
              )
            )
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController..addListener(onScroll),
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              itemCount: searchController.text.isNotEmpty ? searchCocktails.length : cocktails.length,
              itemBuilder: (context, index) {
                Cocktail cocktail = searchController.text.isNotEmpty 
                  ? searchCocktails.elementAt(index) 
                  : cocktails.elementAt(index);
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1
                    )
                  ),
                  child: ListTile(
                    title: Column(
                      children: [
                        Text(cocktail.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 36, right: 36, bottom: 12),
                          child: Image.network(
                            cocktail.imageUrl
                          )
                        )
                      ]
                    ),
                    // leading: Image.network(cocktail.imageUrl),
                    onTap: () => Navigator.pushNamed(context, '/details', arguments: {"cocktail": cocktail})
                
                  )
                );
              }
            )
          )
        ],
      )
    );
  }
  
  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}