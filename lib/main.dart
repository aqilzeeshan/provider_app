//https://medium.com/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:providerapp/pages/provider_base_example_problem.dart';
import 'package:providerapp/pages/provider_base_example_solution.dart';

void main() {
  runApp(MyAnotherApp());
}

/*Provider
As you might imagine, Provider is the most basic of the Provider widget types.
You can use it to provide a value (usually a data model object) to anywhere in the widget tree.
However, it won’t help you update the widget tree when that value changes.*/
class MyAnotherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*You can provide that model to the widget tree by wrapping the top of the tree with the Provider widget.
      You can get a reference to the model object by using the Consumer widget.*/
      home: ChangeNotifierProvider(
        create: (context) => MyModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Using Provider'),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.lightBlue,
                child: MyButton(),
              ),
              Container(
                padding: const EdgeInsets.all(37),
                color: Colors.lightGreen,
                child: Consumer<MyModel>(
                  builder: (context, myModel, child) {
                    print('something changed!!!');
                    /*Notes:
1. The UI was built with the “Hello” text that came from the model.
2. Pressing the “Do something” button will cause an event to happen on the model. However, even though the model’s data got changed, the UI wasn’t rebuilt because the Provider widget doesn’t listen for changes in the values it provides.*/
                    return Text(myModel.someValue);
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

/*Notes:
In most apps your model class will be in its own file and you’ll need to import flutter/foundation.dart in order to use ChangeNotifier. I’m not really a fan of that because that means your business logic now has a dependency on the framework, and the framework is a detail. But I’m willing to live with it for now.
The Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called. The button doesn’t need to get updated, though, so rather than using a Consumer, you can use Provider.of and set the listener to false. That way the button won’t be rebuilt when there are changes. Here is the button extracted into its own widget:
*/
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    return RaisedButton(
      child: Text('Do Something'),
      onPressed: () => {
        myModel.doSomething(),
      },
    );
  }
}

/*ChangeNotifierProvider
Unlike the basic Provider widget, ChangeNotifierProvider listens for changes in the model object. When there are changes, it will rebuild any widgets under the Consumer.

In the code, change Provider to ChangeNotifierProvider. The model class needs to use the ChangeNotifier mixin (or extend it). This gives you access to notifyListeners() and any time you call that, the ChangeNotifierProvider will be notified and the Consumers will rebuild their widgets.

For reasons when to use with/extend check https://stackoverflow.com/questions/56680226/should-you-use-extends-or-with-keyword-for-changenotifier-flutter/58569642#58569642
*/
class MyModel with ChangeNotifier {
  String someValue = 'Hello';

  void doSomething() {
    someValue = 'Good Bye';
    print(someValue);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final SomeModel someModel = SomeModel(
      name: "Milano Academy",
      address: "3243 Heath Terrace",
      features: ['Natural', '40x70m'],
      rating: 4.5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Provider demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: ProviderBaseExampleProblem(model: someModel),
      home: Provider(
        create: (_) => someModel,
        child: ProviderBaseExampleSolution(),
      ),
    );
  }
}

class SomeModel {
  final String name;
  final String address;
  final List features;
  final double rating;

  SomeModel({this.name, this.address, this.features, this.rating});
}
