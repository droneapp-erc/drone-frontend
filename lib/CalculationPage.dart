import 'package:flutter/material.dart';
import 'RESTService.dart';
import 'calculation_data.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  _CalculationPageState createState() => _CalculationPageState();
}

final List<String> names = [
  '촬영 속도',
  '촬영 거리',
  '조도',
  '셔터 스피드',
  'F수',
  'ISO',
  'Pixel',
  '최소 오차',
];

class _CalculationPageState extends State<CalculationPage> {
  TextEditingController illuminanceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  List<CalculationData> calculationDataList = [];
  bool isLoading = false;

  void sendDataToBackend() async {
    setState(() {
      isLoading = true;
      calculationDataList.clear();
    });

    var response = await RESTService.sendData(
      illuminanceController.text,
      areaController.text,
    );

    if (response is List<dynamic>) {
      if (response.length == names.length) {
        for (int i = 0; i < response.length; i++) {
          Map<String, dynamic> item = response[i] as Map<String, dynamic>;
          CalculationData data = CalculationData.fromJson({
            'name': names[i],
            'value': item['value'].toString(),
          });
          calculationDataList.add(data);
        }

        setState(() {
          isLoading = false;
        });
      } else {
        // Handle invalid response format
        setState(() {
          isLoading = false;
        });
        // Show an error message or handle the incorrect response format in a way appropriate for your application
      }
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle the case when the response is false or null
      // Show an error message or handle the response failure in a way appropriate for your application
    }
  }

  @override
  void dispose() {
    illuminanceController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('촬영값 도출'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              '조도',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: illuminanceController,
              decoration: const InputDecoration(
                hintText: 'Enter illuminance',
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '촬영 면적',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: areaController,
              decoration: const InputDecoration(
                hintText: 'Enter area',
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: sendDataToBackend,
              child: const Text('done'),
            ),
            const SizedBox(height: 40),
            const Text(
              '촬영 조건:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isLoading
                ? const CircularProgressIndicator() // Display a loading indicator while waiting for the result
                : Expanded(
                    child: ListView.builder(
                      itemCount: calculationDataList.length,
                      itemBuilder: (context, index) {
                        CalculationData data = calculationDataList[index];
                        String name = names[index];
                        String value = data.value;

                        return ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            value,
                            style: const TextStyle(fontSize: 18),
                          ),
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
