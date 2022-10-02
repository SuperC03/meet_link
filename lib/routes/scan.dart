import 'package:flutter/material.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:motor_flutter/motor_flutter.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        print(_selectedIndex);
      });
    }

    return Scaffold(
      //
      body: _selectedIndex == 1 ? Center(
        child: ScanCode(),
      ) : Center(
        child: DisplayCode(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Scan'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Code'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ScanCode extends StatefulWidget {
  const ScanCode({Key? key}) : super(key: key);

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {

  void _createRecord(String code) async {
    final String link = MotorFlutter.to.toString() + ", " + code;
    final doc = Get.find<SchemaDefinition>(tag: 'meetLinkSchema').newDocument()
    doc.set<String>('link', link);
    SchemaDocument? resp = await doc.upload(task);
    if (resp != null) {
      Get.snackbar('Success', 'Item added');
      print(resp.did);
    } else {
      Get.snackbar('Error', 'Item not added');
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            Get.snackbar('Error', 'Item not added');
          } else {
            final String code = barcode.rawValue!;
            _createRector(code);
          }
        }
    );
  }
}

class DisplayCode extends StatefulWidget {
  const DisplayCode({Key? key}) : super(key: key);

  @override
  State<DisplayCode> createState() => _DisplayCodeState();
}

class _DisplayCodeState extends State<DisplayCode> {

  final image = Image(600,350);

  @override
  void initState(String code) {
    fill(image, getColor(255,255,255));
    drawBarcode(image, Barcode.code128(), code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image,
    );
  }
}
