# Example

Sample application to demonstrate usage of `DottedBorder` package.

### Running the sample application

Fetch dependencies

```shell
flutter packages get
```

Run the application with 

```shell
flutter run
```

### Sample Code

```dart
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Dotted Border'),
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    container1,
                    Spacer(),
                    container2,
                    Spacer(),
                    container3,
                    Spacer(),
                    container4,
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget get container1 {
    return DottedBorder(
      padding: EdgeInsets.all(4),
      dashPattern: [9, 5],
      child: Container(
        height: 110,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xff994444),
        ),
      ),
    );
  }

  Widget get container2 {
    return DottedBorder(
      padding: EdgeInsets.all(8),
      dashPattern: [6],
      borderType: BorderType.Circle,
      child: Container(
        height: 210,
        width: double.maxFinite,
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: Color(0xff444499),
        ),
      ),
    );
  }

  Widget get container3 {
    return DottedBorder(
      padding: EdgeInsets.all(4),
      borderType: BorderType.RRect,
      radius: Radius.circular(20),
      child: Container(
        height: 120,
        width: double.maxFinite,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Color(0xff994444),
        ),
      ),
    );
  }

  Widget get container4 {
    return DottedBorder(
      borderType: BorderType.Oval,
      dashPattern: [8,4,2,4],
      child: Container(
        height: 180,
        width: double.maxFinite,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0x22888888),
        ),
      ),
    );
  }
}

```

### Output

![Flutter dotted border image](assets/image.png?raw=true "Flutter Dotted Border Image" )