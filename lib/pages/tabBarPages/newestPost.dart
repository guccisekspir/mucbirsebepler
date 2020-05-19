import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';



class NewestPost extends StatefulWidget {
  final User user;

  const NewestPost({Key key, this.user}) : super(key: key);
  @override
  _NewestPostState createState() => _NewestPostState();
}

class _NewestPostState extends State<NewestPost> {
  PostBloc _postBloc;
  DataBaseBloc _dataBaseBloc;
  bool _yuklendiMi=false;
  User finalUser;

  @override
  void initState() {
    // TODO: implement initState
    debugPrint(widget.user.toString());
    _postBloc= BlocProvider.of<PostBloc>(context);
    _dataBaseBloc=BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetUserr(userID: widget.user.userID));
    _postBloc.add(GetNewPost());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _postBloc.add(GetMoreNewPost());
        },
      ),
      body: Container(
        color: Colors.limeAccent,
        child: MultiBlocListener(
          listeners: [
            BlocListener<DataBaseBloc, DataBaseState>(
              listener: (context, state) {
                if (state is DataBaseLoadedState) {
                  setState(() {
                    _yuklendiMi=true;
                    finalUser = state.user;
                  });

                }
              },
            ),

          ],
          child: BlocBuilder(
            bloc: _postBloc,
            // ignore: missing_return
            builder: (context,state){
              if(state is PostLoadedState){
                List<Post> postList=state.listPost;
                if(_yuklendiMi){
                  return ListView.builder(itemBuilder:

                  // ignore: missing_return
                      (context,index){
                    if(state is MoreLoadingState) return _WaitingWidget();
                    else{
                      return postCoontainer(
                          gelenUser: finalUser,
                          bloc: _postBloc,
                          post: postList[index],
                          width: width,
                          height: height,
                          context: context);
                    }

                  },
                  itemCount: postList.length,

                  );

                }
                else return Center(child: CircularProgressIndicator(),);


              }
              else if(state is PostLoadingState){
                return Center(child: CircularProgressIndicator(),);
              }
             else if(state is PostErrorState){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Bir hata oluştu tospik"),backgroundColor: Colors.limeAccent,));
                return Container(color: Colors.redAccent,);
              }
             return Center(child: CircularProgressIndicator(),);


            },
          ) ,
        ),
      ),
    );
  }

  _WaitingWidget() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget yeniPostWidget(int index) {}
}
