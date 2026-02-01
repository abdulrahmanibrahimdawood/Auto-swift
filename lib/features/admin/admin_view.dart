import 'package:auto_swift/core/widgets/custom_button.dart';
import 'package:auto_swift/core/widgets/custom_container.dart';
import 'package:auto_swift/core/widgets/custom_text_field.dart';
import 'package:auto_swift/features/admin/widgets/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final TextEditingController _model = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _engine = TextEditingController();
  final TextEditingController _speed = TextEditingController();
  final TextEditingController _seats = TextEditingController();
  List<String> availableColors = ['Black', 'Red', 'Blue'];
  List<String> brands = ['BMW', 'Mercedes', 'Audi'];
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Admin View'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  height: 40,
                  width: 40,
                  color: Colors.pink,
                  radius: 60,
                ),
                Icon(CupertinoIcons.share_up),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _engine,
                    hint: 'Car Engine',
                    type: TextInputType.text,
                  ),
                ),
                SizedBox(width: 12),

                Expanded(
                  child: CustomTextField(
                    controller: _speed,
                    hint: 'Car Speed',
                    type: TextInputType.number,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _seats,
                    hint: 'Car Seats',
                    type: TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            CustomTextField(
              controller: _model,
              hint: 'Car Model',
              type: TextInputType.text,
            ),

            SizedBox(height: 24),

            CustomTextField(
              controller: _price,
              hint: 'Car Price',
              type: TextInputType.number,
            ),
            SizedBox(height: 24),
            CustomDropdown(
              valid: 'Please select at Least one item',
              hint: 'Car Brand',
              value: selectedBrand,
              items: brands
                  .map(
                    (brand) =>
                        DropdownMenuItem(value: brand, child: Text(brand)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedBrand = value as String;
                });
              },
            ),
            SizedBox(height: 24),
            CustomButton(
              radius: 8,
              color: Colors.black87,
              height: 34,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Add Car',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
