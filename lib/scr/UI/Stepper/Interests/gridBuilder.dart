
import 'package:bera/scr/Blocs/interests/interest_state.dart';
import 'package:bera/scr/Blocs/interests/interests_bloc.dart';
import 'package:bera/scr/Blocs/interests/interests_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Item.dart';
import 'gridItem.dart';

class GridBuilder extends StatefulWidget {
  @override
  _GridBuilderState createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  List<Item> itemList;
  List<Item> selectedList;
  @override
  void initState() {
    loadList();
    super.initState();
  }

  loadList() {
    itemList = List();
    itemList.add(Item("Engineering", 1));
    itemList.add(Item("Retail", 2));
    itemList.add(Item("Construction", 3));
    itemList.add(Item("Education", 4));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestBloc, InterestState>(
      builder: (context, state) {
        if(state is InterestUpdated) {
          selectedList = state.interests;
        }
        return Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 90.0),
            child: Padding(
              padding: const EdgeInsets.only(left:55.0, right: 55.0),
              child: new Column(
                  children: <Widget>[
                    Center(
                      child: Text('What domains do you have experience and interest in?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 13
                        ),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return GridItem(
                              isSelected: (bool value) {
                                  if(value) {
                                    BlocProvider.of<InterestBloc>(context).add(AddInterest(itemList[index]));
                                  } else {
                                    BlocProvider.of<InterestBloc>(context).add(RemoveInterest(itemList[index]));
                                  }
                              },
                              item: itemList[index],
                              key: Key(itemList[index].rank.toString())
                          );
                        }
                    ),
                  ]
              ),
            ),
          ),
        );
      },

    );
  }
}