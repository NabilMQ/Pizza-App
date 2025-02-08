import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/components/macro.dart';
import 'package:pizza_repository/pizza_repository.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.pizza, {super.key});

  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    pizza.picture,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return Stack(
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                            Center(
                              child: Text(
                                "${(loadingProgress.cumulativeBytesLoaded / 1000).toInt()}KB / ${(loadingProgress.expectedTotalBytes! / 1000).toInt()}KB",
                                style: TextStyle(
                                  fontSize: 3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                  
                      return child;
                    },
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 30),
        
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          pizza.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${pizza.price - pizza.discount * pizza.price / 100}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "\$${pizza.price}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      MyMacroWidget(
                        value: pizza.macros.calories,
                        title: "Calories",
                        icon: FontAwesomeIcons.fire,
                      ), 
                      SizedBox(width: 10),
                      MyMacroWidget(
                        value: pizza.macros.proteins,
                        title: "Protein",
                        icon: FontAwesomeIcons.dumbbell,
                      ),
                      SizedBox(width: 10),
                      MyMacroWidget(
                        value: pizza.macros.fat,
                        title: "Fat",
                        icon: FontAwesomeIcons.oilWell,
                      ), 
                      SizedBox(width: 10),
                      MyMacroWidget(
                        value: pizza.macros.carbs,
                        title: "Carbs",
                        icon: FontAwesomeIcons.breadSlice,
                      ), 
                    ],
                  ),
                  
                  const SizedBox(height: 40),

                  SizedBox(
                   width: MediaQuery.of(context).size.width,
                   height: 50,
                   child: TextButton(
                    onPressed: () {

                    },

                    style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),

                    child: Text(
                      "Buy Now!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                   ), 
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}