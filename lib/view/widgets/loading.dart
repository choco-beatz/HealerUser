import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: 
              Lottie.asset('asset/loading.json')
              // Lottie.network(
              //     "https://lottie.host/0c238b03-dff8-408b-9cb2-0584956f2144/hr7Oj5I9oY.json")
                  );
                  
  }
}