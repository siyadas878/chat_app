import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../application/profile_data_provider/get_all_user.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<GetallUsersProvider>(context).searchController;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ChangeNotifierProvider<GetallUsersProvider>.value(
                value: Provider.of<GetallUsersProvider>(context, listen: false),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    Provider.of<GetallUsersProvider>(context, listen: false)
                        .searchlist(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        Provider.of<GetallUsersProvider>(context, listen: false)
                            .searchlist('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Expanded(
              child: Consumer<GetallUsersProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<void>(
                    future: value.getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      } else {
                        final userList = controller.text.isEmpty
                            ? value.allusers
                            : value.searchedlist;

                        if (userList.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: size.height*0.02,),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final user = userList[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user.imgpath.toString()),
                              ),
                              title: Text(user.name!),                              
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}