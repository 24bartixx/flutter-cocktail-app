import 'package:cocktails/data/models/cocktail.dart';
import 'package:cocktails/data/network/api_service.dart';
import 'package:flutter/material.dart';

class CocktailsScreen extends StatefulWidget {

  @override
  _CocktailsScreenState createState() => _CocktailsScreenState();

}

class _CocktailsScreenState extends State<CocktailsScreen> {

  final TextEditingController searchController = TextEditingController();
  late Future<List<Cocktail>> cocktailsFuture;
  int currentPage = 1;
  List<Cocktail> cocktails = [];
  List<Cocktail> filteredCocktails = [];

  final apiService = ApiService();
  Future<List<Cocktail>> _fetchCocktails() async {
    return await apiService.fetchCocktails();
  }

  @override
  void initState() {
    super.initState();
    cocktailsFuture = _fetchCocktails();
    searchController.addListener(searchCocktail);
  }

  void searchCocktail() {
    print('search cocktail method');
    String query = searchController.text.toLowerCase();
    setState(() {
      print('========\n=========\n=============');
      filteredCocktails = cocktails.where((cocktail) => 
        cocktail.name.toLowerCase().contains(query) 
          || cocktail.category.contains(query)
          || cocktail.glass.contains(query)
      ).toList();
      print('Size${filteredCocktails.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktails')
      ),      
      body: FutureBuilder<List<Cocktail>> (
        future: cocktailsFuture,
        builder: (context, AsyncSnapshot<List<Cocktail>> snapshot) {
          if(snapshot.hasData) {

            cocktails = snapshot.data!;

            return Column(
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
                      labelText: 'Search cocktails',
                      icon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    )
                  )
                ),
                Expanded(child: 
                  ListView.builder(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    itemCount: searchController.text.isNotEmpty ? filteredCocktails.length : cocktails.length,
                    itemBuilder: (context, index) {
                      Cocktail cocktail = searchController.text.isNotEmpty 
                        ? filteredCocktails.elementAt(index) 
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
              ]
            );
          } else if(snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 96
              )
            );
          } 

          return const Center(
            child: CircularProgressIndicator()
          );

        }
      
      )
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  
}
