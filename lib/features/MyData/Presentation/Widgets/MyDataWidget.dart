import 'package:CWCFlutter/core/widgets/LoadingPage.dart';
import 'package:CWCFlutter/features/MyData/Presentation/bloc/mydata_bloc.dart';
import 'package:CWCFlutter/features/gmap/Domain/Entity/Poly.dart';
import 'package:CWCFlutter/features/signin/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyData extends StatefulWidget {
  final User user;
  // test
  final Poly poly;

  const MyData({Key key, this.user, this.poly}) : super(key: key);
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MydataBloc, MydataState>(builder: (context, state) {
      if (state is MydataInitial) {
        dispatchGetAllDataEvent();
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("My Data !!")));
      }
      if (state is MyDataLoading) {
        return LoadingPage();
      }
      if (state is MyDataLoadedSuccessfully) {
        return new ListView.builder(
            itemCount: state.listpoly.length,
            itemBuilder: (BuildContext ctxt, int index) =>
                buildBody(ctxt, state.listpoly[index]));
      }
      if (state is PolyDeleting)
      {
        return LoadingPage();
      }
      // if (state is PolyDeletedSuccessfully)
      // {
      //   dispatchDeletePolyEvent();
        
        
      // }
      return Container();
      
    });
  }

  Widget buildBody(BuildContext ctx, dynamic item) {
    return Card(
      child: Text(item.toString())
    );
  }

  void dispatchGetAllDataEvent() {
    BlocProvider.of<MydataBloc>(context)
        .dispatch(GetAllDataEvent(userID: widget.user.sId));
  }

  // test
  void dispatchDeletePolyEvent() {
    BlocProvider.of<MydataBloc>(context)
        .dispatch(DeletePolyEvent(poly: widget.poly));
  }
}
