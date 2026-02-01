import 'dart:io';

import 'package:auto_swift/core/widgets/custom_button.dart';
import 'package:auto_swift/core/widgets/custom_container.dart';
import 'package:auto_swift/core/widgets/custom_text_field.dart';
import 'package:auto_swift/features/admin/widgets/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 🔹 ADDED: اختيار صورة
import 'package:supabase_flutter/supabase_flutter.dart'; // 🔹 ADDED: Supabase

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
  final supabase = Supabase.instance.client;
  File? carImage;
  List<String> brands = ['BMW', 'Mercedes', 'Audi'];
  String? selectedBrand;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        carImage = File(image.path);
      });
    }
  }

  Future addCar() async {
    if (carImage == null) return;

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage.from('cars').upload(fileName, carImage!);
    final imageUrl = supabase.storage.from('cars').getPublicUrl(fileName);

    await supabase.from('cars').insert({
      'model': _model.text,
      'price': _price.text,
      'engine': _engine.text,
      'speed': _speed.text,
      'seats': _seats.text,
      'brand': selectedBrand,
      'image_url': imageUrl,
    });
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CustomContainer(
                    height: 40,
                    width: 40,
                    color: Colors.pink,
                    radius: 60,
                    child: carImage != null
                        ? ClipOval(
                            child: Image.file(carImage!, fit: BoxFit.cover),
                          )
                        : null,
                  ),
                ),
                const Icon(CupertinoIcons.share_up),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _engine,
                    hint: 'Car Engine',
                    type: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _speed,
                    hint: 'Car Speed',
                    type: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _seats,
                    hint: 'Car Seats',
                    type: TextInputType.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _model,
              hint: 'Car Model',
              type: TextInputType.text,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _price,
              hint: 'Car Price',
              type: TextInputType.number,
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: carImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo, size: 32, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Tap to upload car image',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          carImage!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              radius: 8,
              color: Colors.black87,
              height: 34,
              width: double.infinity,
              onTap: addCar,
              child: const Center(
                child: Text(
                  'Add Car',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ), //
            ),
          ],
        ),
      ),
    );
  }
}
