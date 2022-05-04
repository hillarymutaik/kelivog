import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }
}

class LoadingScreen {
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoadingCustom(child: child!));
      } else {
        return LoadingCustom(child: child!);
      }
    };
  }
}

class LoadingCustom extends StatelessWidget {
  final Widget child;
  const LoadingCustom({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoadingProvider>(
        create: (context) => LoadingProvider(),
        builder: (context, _) {
          return Stack(
            children: [
              child,
              Consumer<LoadingProvider>(
                builder: (context, provider, child) {
                  return provider.loading
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
