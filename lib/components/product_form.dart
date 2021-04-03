import 'package:flutter/material.dart';
import 'package:inventory/adaptatives/adaptative_button.dart';
import 'package:inventory/adaptatives/adaptative_date_picker.dart';
import 'package:inventory/adaptatives/adaptative_text_field.dart';

class ProductForm extends StatefulWidget {
  final void Function(String, int, double, double, double, DateTime) onSubmit;

  ProductForm(this.onSubmit);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _productController = TextEditingController();
  final _amountController = TextEditingController();
  final _purchaseValueController = TextEditingController();
  final _saleValueController = TextEditingController();
  final _profitController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final product = _productController.text;
    final amount = int.tryParse(_amountController.text) ?? 0.0;
    final purchase = double.tryParse(_purchaseValueController.text) ?? 0.0;
    final sale = double.tryParse(_saleValueController.text) ?? 0.0;
    final profit = double.tryParse(_profitController.text) ?? 0.0;

    if (product.isEmpty ||
        amount <= 0 ||
        purchase <= 0 ||
        sale <= 0 ||
        profit <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.onSubmit(product, amount, purchase, sale, profit, _selectedDate);
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
                controller: _amountController,
                onSubmitted: (value) => _submitForm(),
                label: 'Quantidade',
              ),
              AdaptativeTextField(
                controller: _purchaseValueController,
                onSubmitted: (value) => _submitForm(),
                label: 'Valor de compra',
              ),
              AdaptativeTextField(
                controller: _saleValueController,
                onSubmitted: (value) => _submitForm(),
                label: 'Valor de venda',
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
                    label: 'Nova produto',
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
