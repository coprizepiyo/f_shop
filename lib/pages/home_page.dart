import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 TextEditingController typeController =TextEditingController();
  var defaultText = '还没选择美女';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('美好人间'),
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '美女类型',
                helperText: '请你输入你喜欢的类型'
              ),
              // autofocus: false,
            ),
            RaisedButton(
              onPressed: (){
                print('开始选择你喜欢的类型。。。。。。。');
                var typeText = typeController.text.toString().trim();
                if(typeText == ''){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(title: Text('美女类型不能为空'),)
                  );
                } else {
                  _getHttp(typeText).then(
                    (val){
                      setState((){
                        print(val);
                        defaultText = val['name'];
                      });
                    }
                  );
                }
              },
              child: Text('选择完毕'),
            ),
            Text(
              defaultText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      )
    );
}

// class HomePage extends StatelessWidget {
//   TextEditingController typeController =TextEditingController();
//   var defaultText = '还没选择美女';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('美好人间'),
//       ),
//       body:Container(
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: typeController,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 labelText: '美女类型',
//                 helperText: '请你输入你喜欢的类型'
//               ),
//               // autofocus: false,
//             ),
//             RaisedButton(
//               onPressed: (){
//                 print('开始选择你喜欢的类型。。。。。。。');
//                 var typeText = typeController.text.toString().trim();
//                 if(typeText == ''){
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(title: Text('美女类型不能为空'),)
//                   );
//                 } else {
//                   _getHttp(typeText).then(
//                     (val){
//                       setState((){
//                         defaultText = val;
//                       });
//                     }
//                   );
//                 }
//               },
//               child: Text('选择完毕'),
//             ),
//             Text(
//               defaultText,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             )
//           ],
//         ),
//       )
//     );
//   }

  Future _getHttp(String typeText)async{
    try{
      Response response;
      var data={'name': typeText};
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: data
      );
      return response.data['data'];
    }catch(e){
      return print(e);
    }
  }
}