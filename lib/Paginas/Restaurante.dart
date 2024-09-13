import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receita_front/Paginas/Curtidas.dart';
import 'package:receita_front/all.dart';
import '/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Restaurante extends StatefulWidget {
  @override
  State<Restaurante> createState() => _RestauranteState();
}

class _RestauranteState extends State<Restaurante> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();

  late Future<List<Map<String, String>>> dataFuture;
  //late int likes;
  //late Future<bool> likeOrNot;
  //late Icon LikeIcon; // = Icon(Icons.favorite_outline)
  late Future<double> initRating;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    LoggedUser restaurante = appState.restauranteAtual;
    var Nome = restaurante.nome;
//---------------------------------------------------------------------------------------------Pegar do Back! ^^^-----------------------------------------------------------
    /*likeAndDislike() {
      if (appState.liked) {
        setState(() {
          LikeIcon = Icon(Icons.favorite_outline);
        });
      } else {
        setState(() {
          LikeIcon = Icon(Icons.favorite);
        });
      }
    }*/

    int rating = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Nome,
              style: TextStyle(fontSize: 25),
            ),
            RatingBar(
              ignoreGestures: true,
              initialRating: getNota(list[index].id, notas), //initRating,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 25,
              ratingWidget: RatingWidget(
                full: Icon(Icons.star),
                half: Icon(Icons.star_half_outlined),
                empty: Icon(Icons.star_border),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                //print(rating);
                avaliar(rating, appState.logged.id, appState.receitaAtual.id);
              },
            ),
          ],
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: Receitas(),
    );
  }
}

/*Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Olá, $Nome',
                          style: TextStyle(fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              tooltip: "Criar Receita",
                              onPressed: (
                                  //-------------------------------------------------------------------Func p criar receita------------------------------------------------------
                                  ) {},
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //---------------------------------------------------------------------Direcionar p cadastro update---------------------------------------------
                              },
                              child: Text('Atualizar\nCadastro'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    /*Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 238, 169, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(255, 238, 169, 1),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              child:
                            ),
                          ],
                        ),
                      )
                    */
                    //bar(),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          AppBar(
                            bottom: const TabBar(
                              tabs: [
                                Tab(icon: Icon(Icons.directions_car)),
                                Tab(icon: Icon(Icons.directions_transit)),
                              ],
                            ),
                            title: const Text('Tabs Demo'),
                          ),
                          TabBarView(
                            children: [
                              Icon(Icons.directions_car),
                              Icon(Icons.directions_transit),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        */
/*Container(
                            padding: EdgeInsets.all(12.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 238, 169, 1),
                              border: Border.all(
                                color: Color.fromRGBO(255, 238, 169, 1),
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),*/

