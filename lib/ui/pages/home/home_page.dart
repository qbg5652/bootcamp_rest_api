import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/widgets/home_flating_action_button.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/widgets/home_indexed_stack.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeIndexedStack(),
      floatingActionButton: HomeFlatingActionButton(),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}
