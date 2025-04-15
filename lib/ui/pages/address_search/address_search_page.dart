import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/geolocator_helper.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/address_search/address_search_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/join/join_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          title: Consumer(
            builder: (context, ref, child) {
              return TextField(
                onSubmitted: (value) {
                  print('valus : $value');
                  if (value.trim().isNotEmpty) {
                    final viewModel = ref.read(
                      addressSearchViewModelProvider.notifier,
                    );
                    viewModel.searchByName(value);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  hintText: '동명(읍, 면)으로 검색 (ex. 서초동)',
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),

              Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        //1. GeolocatorHelper에서 위치 받아오기
                        final position = await GeolocatorHelper.getPosition();
                        if (position != null) {
                          //2. ViewModel에 요청하기
                          final viewModel = ref.read(
                            addressSearchViewModelProvider.notifier,
                          );
                          viewModel.searchByLocation(
                            position.latitude,
                            position.longitude,
                          );
                        }
                      },
                      child: Text('현재 위치로 찾기'),
                    ),
                  );
                },
              ),

              Consumer(
                builder: (context, ref, child) {
                  final addresses = ref.watch(addressSearchViewModelProvider);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final item = addresses[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return JoinPage(item);
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            child: Text(item, style: TextStyle(fontSize: 16)),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
