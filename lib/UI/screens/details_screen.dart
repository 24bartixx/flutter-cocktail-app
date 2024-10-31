import 'package:cocktails/data/models/cocktail.dart';
import 'package:cocktails/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsScreen extends StatefulWidget{

  @override
  _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen> {

  late Map<String,dynamic> args;
  late Cocktail cocktail;

  final apiService = ApiService();
  Future<Cocktail> _fetchCocktailById() async {
    return await apiService.fetchCocktailById(cocktail);
  }

  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    cocktail = args['cocktail'];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detailsPageTitle)
      ),
      body: FutureBuilder<Cocktail> (
        future: _fetchCocktailById(),
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if(snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        snapshot.data!.name,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                      )
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      child: Image.network(snapshot.data!.imageUrl)
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 24, bottom: 12),
                      child: Text(
                        AppLocalizations.of(context)!.categoryDetails + (snapshot.data!.category), 
                        style: const TextStyle(fontSize: 16, color: Color.fromRGBO(100, 100, 100, 1))
                      )
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.glassDetails,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                text: snapshot.data!.glass,
                                style: const TextStyle(fontSize: 16)
                              )
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.alcoholDetails,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                text: snapshot.data!.alcoholic 
                                  ? AppLocalizations.of(context)!.yesText 
                                  : AppLocalizations.of(context)!.noText,
                                style: const TextStyle(fontSize: 16)
                              )
                            ]
                          )
                        ),
                        const SizedBox(height: 8),
                        Text(AppLocalizations.of(context)!.instructionsDetails, 
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.justify),
                        const SizedBox(height: 4),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(cocktail.instructions, style: const TextStyle(fontSize: 16), textAlign: TextAlign.justify,)
                        ),
                        const SizedBox(height: 4),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(AppLocalizations.of(context)!.ingredientsDetails, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                        ),
                        Column(
                          children: 
                            snapshot.data!.ingredients.map((ingredient) {
                              return Card(
                                elevation: 16,
                                margin: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1
                                  )
                                ),
                                child: ListTile(
                                  onTap: () {
                                    ingredient.description != null
                                      ? showDialog(
                                        context: context, 
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(AppLocalizations.of(context)!.descriptionDetails),
                                            content: SingleChildScrollView(child: Text(ingredient.description!, textAlign: TextAlign.justify)),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Back'), 
                                                child: Text(AppLocalizations.of(context)!.backText)
                                              )
                                            ]
                                          );
                                        }
                                      ) 
                                      : Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!.noDescriptionToast,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        fontSize: 18
                                      );
                                  },
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ingredient.imageUrl != null 
                                            ? Image.network(ingredient.imageUrl!, height: 64, width: 64) 
                                            : const SizedBox.shrink(),
                                          const SizedBox(width: 8),
                                          Text(ingredient.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                        ]
                                      ),
                                      const SizedBox(height: 8),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.alcoholDetails,
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                            ),
                                            TextSpan(
                                              text: (ingredient.alcohol 
                                                ? AppLocalizations.of(context)!.yesText
                                                : AppLocalizations.of(context)!.noText),
                                              style: const TextStyle(fontSize: 16)
                                            )
                                          ]
                                        )
                                      ),
                                      ingredient.alcohol
                                        ? Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.percentageDetails,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(
                                                text: ("${ingredient.percentage}%"),
                                                style: const TextStyle(fontSize: 16)
                                              )
                                            ]
                                          )
                                        )
                                        : const SizedBox.shrink(),
                                      ingredient.type != null 
                                        ? Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.typeDetails,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(
                                                text: ingredient.type,
                                                style: const TextStyle(fontSize: 16)
                                              ),
                                            ]
                                          )
                                        )
                                        : const SizedBox.shrink(),
                                      ingredient.measure != null
                                        ? Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: AppLocalizations.of(context)!.measureDetails,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(
                                                text: ingredient.measure,
                                                style: const TextStyle(fontSize: 16)
                                              ),
                                            ]
                                          )
                                        )
                                        : const SizedBox.shrink()
                                    ]
                                  )
                                )
                              );
                            }).toList()
                        )
                      ]
                    )
                  ]
                )
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
  
}