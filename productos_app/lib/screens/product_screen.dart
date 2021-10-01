import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(url: productService.selectedProduct.picture),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop())),
                  Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            final picker = new ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 100);
                            if (pickedFile == null) {
                              print("No seeleccionó nada");
                              return;
                            }
                            print('Tenemos imagen ${pickedFile.path}');
                            productService
                                .updateSelectedProductImage(pickedFile.path);
                          }))
                ],
              ),
              _ProductForm(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!formProvider.isValidForm()) return;

                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) formProvider.product.picture = imageUrl;

                await productService.saveOrCreateProduct(formProvider.product);
              },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    final product = formProvider.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: formProvider.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: product.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return "El nombre es obligatorio";
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: "Nombre del producto", labelText: "Nombre:"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) =>
                    product.price = double.tryParse(value) ?? 0,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "\$150", labelText: "Precio:"),
              ),
              SizedBox(
                height: 30,
              ),
              SwitchListTile.adaptive(
                  value: product.available,
                  title: Text("Disponible"),
                  activeColor: Colors.indigo,
                  onChanged: formProvider.updateAvailability),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
