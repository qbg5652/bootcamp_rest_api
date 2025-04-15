import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/join/join_page.dart';

class AddressSearchPage extends StatelessWidget {
  const AddressSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (value) {
              print('valus : $value');
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              hintText: '동명(읍, 면)으로 검색 (ex. 서초동)',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('현재 위치로 찾기'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return JoinPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Text('부천시 중동', style: TextStyle(fontSize: 16)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
