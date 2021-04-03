import 'package:flutter/material.dart';
import 'package:inventory/adaptatives/adaptative_button.dart';
import 'package:inventory/adaptatives/adaptative_date_picker.dart';
import 'package:inventory/adaptatives/adaptative_text_field.dart';

class SaleForm extends StatefulWidget {
  final void Function(String, double, double, DateTime) onSubmit;

  SaleForm(this.onSubmit);

  @override
  _SaleFormState createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  final _productController = TextEditingController();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final product = _productController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (product.isEmpty || amount <= 0 || price <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(product, amount, price, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                controller: _productController,
                onSubmitted: (value) => _submitForm(),
                label: 'Produto',
              ),
              AdaptativeTextField(
                controller: _priceController,
                onSubmitted: (value) => _submitForm(),
                label: 'Preço',
              ),
              AdaptativeTextField(
                controller: _amountController,
                onSubmitted: (value) => _submitForm(),
                label: 'Quantidade',
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) => {
                  setState(() {
                    _selectedDate = newDate;
                  })
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova venda',
                    onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
