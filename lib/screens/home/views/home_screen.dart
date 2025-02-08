import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pizza_app/blocs/authenticationBloc/authentication_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
// import 'package:pizza_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/views/details_screen.dart';


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: BlocListener<SignInBloc, SignInState> (
//           listener: (context, state) { 
//             return; 
//           },
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 context.read<SignInBloc>().add(
//                   SignOutRequired()
//                 );
//               });																			
              
//             },
//             style: TextButton.styleFrom(
//               elevation: 3.0,
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(60)
//               )
//             ),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//               child: Text(
//                 'Sign Up',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600
//                 ),
//               ),
//             )
//           ),
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Image.asset(
              "assets/8.png", 
              scale: 14,
            ),
            const SizedBox(width: 8,),
            const Text(
              "PIZZA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder <GetPizzaBloc, GetPizzaState> (
          builder: (context, state) {
            if (state is GetPizzalSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 9/18,
                ),
                itemCount: state.pizzas.length,
                itemBuilder: (context, int i) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(state.pizzas[i]),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image.network(
                                state.pizzas[i].picture,
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
                                      
                          SizedBox(height: 12),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: state.pizzas[i].isVeg 
                                    ? Colors.green
                                    : Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    state.pizzas[i].isVeg 
                                    ? "VEG" 
                                    : "NON-VEG",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: 
                                    state.pizzas[i].spicy == 0 
                                      ? Colors.grey.shade300.withValues(alpha: 0.2) 
                                      : state.pizzas[i].spicy == 1 
                                        ? Colors.green.shade100.withValues(alpha: 0.2) 
                                        : Colors.red.shade200.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    state.pizzas[i].spicy == 0 
                                      ? "NOT SPICY" 
                                      : state.pizzas[i].spicy == 1 
                                        ? "🌶️ BALANCE" 
                                        : "🌶️🌶️ SPICY",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                                      
                          SizedBox(height: 8),
                                      
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              state.pizzas[i].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                                      
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              state.pizzas[i].description,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                                      
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$${state.pizzas[i].price - state.pizzas[i].discount * state.pizzas[i].price / 100}",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "\$${state.pizzas[i].price}",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                IconButton(
                                  style: const ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, 
                                  ),
                                  onPressed: () {
                            
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else if (state is GetPizzalProcess) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text(
                "An error has occured...",
              ),
            );
          },
        ),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
// 	bool signInRequired = false;
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener <SignInBloc, SignInState> (
//       listener: (context, state) {
//       },
//       child: Scaffold(
//         body: Center(
//           child: TextButton(
//             onPressed: () {
//               setState(() {
//                 context.read<SignInBloc>().add(
//                   SignOutRequired()
//                 );
//               });																			
              
//             },
//             style: TextButton.styleFrom(
//               elevation: 3.0,
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(60)
//               )
//             ),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//               child: Text(
//                 'Authenticated! Click To LogOut!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600
//                 ),
//               ),
//             )
//           ),
//         ),
//       ),
//     );
//   }
// }