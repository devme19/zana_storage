import 'package:get/get.dart';
import 'package:zana_storage/features/presentation/pages/add_customer_page.dart';
import 'package:zana_storage/features/presentation/pages/add_invoice_page.dart';
import 'package:zana_storage/features/presentation/pages/add_product_page.dart';
import 'package:zana_storage/features/presentation/pages/bindings/add_product_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/customer_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/detail_product_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/home_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/invoice_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/login_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/main_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/product_binding.dart';
import 'package:zana_storage/features/presentation/pages/bindings/setting_binding.dart';
import 'package:zana_storage/features/presentation/pages/customer_detail_page.dart';
import 'package:zana_storage/features/presentation/pages/home_page.dart';
import 'package:zana_storage/features/presentation/pages/invoice_detail_page.dart';
import 'package:zana_storage/features/presentation/pages/invoices_page.dart';
import 'package:zana_storage/features/presentation/pages/login_page.dart';
import 'package:zana_storage/features/presentation/pages/manage_product_page.dart';
import 'package:zana_storage/features/presentation/pages/pick_image_page.dart';
import 'package:zana_storage/features/presentation/pages/product_detail_page.dart';
import 'package:zana_storage/features/presentation/pages/products_page.dart';
import 'package:zana_storage/features/presentation/pages/setting_page.dart';
import 'package:zana_storage/features/presentation/pages/splash_page.dart';
import 'package:zana_storage/features/presentation/pages/customers_page.dart';

class ZanaStorageRoutes{
  static final String splashPage ="/splashPage";
  static final String loginPage ="/loginPage";
  static final String homePage ="/homePage";
  static final String settingPage ="/settingPage";
  static final String customerPage ="/customerPage";
  static final String addCustomerPage ="/addCustomerPage";
  static final String customerDetailPage ="/customerDetailPage";
  static final String invoicesPage ="/invoicesPage";
  static final String invoiceDetailPage ="/invoiceDetailPage";
  static final String productsPage ="/productsPage";
  static final String manageProductPage ="/manageProductPage";
  static final String addInvoicePage ="/addInvoicePage";
  static final String listProducts ="/listProducts";
  static final String addProduct ="/addProduct";
  static final String detailProductPage ="/detailProduct";
  static final String pickImage ="/pickImage";
}

class ZanaStorage{
  static final pages = [
    GetPage(name: ZanaStorageRoutes.splashPage, page: () => SplashPage(),binding: MainBinding()),
    GetPage(name: ZanaStorageRoutes.loginPage, page: () => LoginPage(),bindings: [LoginBinding(),SettingBinding()]),
    GetPage(name: ZanaStorageRoutes.homePage, page: () => HomePage(),binding: HomeBinding()),
    GetPage(name: ZanaStorageRoutes.settingPage, page: () => SettingPage(),binding: SettingBinding()),
    GetPage(name: ZanaStorageRoutes.customerPage, page: () => CustomerPage(),binding: CustomerBinding()),
    GetPage(name: ZanaStorageRoutes.addCustomerPage, page: () => AddCustomerPage(),binding: CustomerBinding()),
    GetPage(name: ZanaStorageRoutes.customerDetailPage, page: () => CustomerDetailPage(),binding: CustomerBinding()),
    GetPage(name: ZanaStorageRoutes.invoicesPage, page: () => InvoicesPage(),binding: InvoiceBinding()),
    GetPage(name: ZanaStorageRoutes.invoiceDetailPage, page: () => InvoiceDetailPage(),bindings: [InvoiceBinding()]),
    GetPage(name: ZanaStorageRoutes.productsPage, page: () => ProductsPage(),binding: ProductBiding()),
    GetPage(name: ZanaStorageRoutes.addProduct, page: () => AddProductPage(),binding:AddProductBinding()),
    GetPage(name: ZanaStorageRoutes.pickImage, page: () => PickImagePage()),
    GetPage(name: ZanaStorageRoutes.manageProductPage, page: () => ManageProductPage(),binding: ProductBiding()),
    GetPage(name: ZanaStorageRoutes.addInvoicePage, page: () => AddInvoicePage(),bindings: [InvoiceBinding(),ProductBiding(),CustomerBinding()]),
    GetPage(name: ZanaStorageRoutes.detailProductPage, page: () => ProductDetailPage(),binding:DetailProductBinding()),
  ];
}