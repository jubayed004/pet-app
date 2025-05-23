class AppStrings {
  static RegExp passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.{8,}$)');
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String emailFieldCantBeEmpty = "Please enter your email";
  static const String passwordFieldCantBeEmpty = "Please enter your password";
  static const String checknetworkconnection = "Check network connection";
  static const String enterThe8Character = "Please Enter The 8 character";
  static const String passwordNotMatch = "Passwords do not match";
  static const String typeHere = "Type here....";
  static const String whatWillYouDoOnIBadi = "What will you do on CarVerify?";
  static const String thisDecisionIsNotFinal = "This decision is not final. You can later be both a client and a professional from the account if you wish.";

  static const String home = "Home";
  static const String report = "Report";
  static const String manageCar = "Manage Car";
  static const String profile = "Profile";
  static const String inspection = "Inspection";
  static const String employee = "Employee";

///============================  Auth =========================//
static const String email = "Email";
static const String password = "Password";
static const String forgotPassword = "Forgot password?";
static const String forgotPasswordTTitle = "Forgot Password";
static const String logIn = "Log in";
static const String dontHaveAnAccount  = "Don’t have an account ? ";
static const String signUpNow = "Sign up now";
static const String enterYourEmailTo = "Enter your email to reset your password.";
static const String submit = "Submit";
static const String verifyCodeVerify = "Verify CodeVerify Code";
static const String setNewPassword = "Set New PasswordSet New Password";
static const String newPassword = "New password";
static const String confirmPassword = "Confirm Password";
static const String createAccount = "Create Account";
static const String firstName = "First Name";
static const String lastName = "Last Name";
static const String emailAddress = "Email address";
static const String contact = "Contact";
static const String gender = "Gender";
static const String male = "Male";
static const String female = "Female";
static const String  nSIREN = " N°SIREN";
static const String address = "Address";
static const String streetNo = "Street no";
static const String streetName = "Street name";
static const String city = "City";
static const String postalCode = "Postal code";
static const String country = "Country";
static const String signUp = "Sign Up";
static const String alreadyHaveAnAccount  = "Already have an account? ";

///=============================Home Screen====================//
static const String welcomeBack  = "Welcome back ";
static const String manyStake = "Many Stake";
static const String profit = "Profit";
static const String intervention = "Intervention";
static const String income = "Income";
static const String expenses = "Expenses";
static const String todayHighlights = "Today Highlights";
static const String totalIntervention = "Total Intervention";
static const String totalPrice = "Total Price";
static const String createIntervention = "Create Interventionv";
static const String interventionId = "Intervention Id";
static const String selectCategory = "Select Category";
static const String afterSalesService = "After sales service";
static const String pLP = "PLP";
static const String price = "Price";
static const String note = "Note";
static const String status = "Status";
static const String paid = "Paid";
static const String unPaid = "Unpaid";
static const String addImage = "Add Image";
static const String takeImage = "Take image...";
static const String save = "Save";

///===================================Intervention========================////

static const String search = "Search...";
static const String filterByDate = "Filter by date";
static const String from = "From";
static const String to = "To";
static const String allIntervention = "All Intervention";
static const String addAnIntervention = "Add An Intervention";
static const String details = "Details";
static const String categoryColon  = "Category :";
static const String datColon = "Date :";
static const String priceColon = "Price :";
static const String noteColon = "Note :";
static const String allImages = "All Images";
static const String exportPDF = "Export PDF";
static const String editIntervention = "Edit Intervention";


///==========================Expenses=====================///

static const String allExpenses = "All Expenses";
static const String addAnExpenses = "Add An Expenses";
static const String equipment = "Equipment";
static const String fuel = "Fuel";
static const String addExpenses = "Add Expenses";
static const String expenseName = "Expense Name";
static const String vehicle = "Vehicle";
static const String editExpenses = "Edit Expenses";

///======================Invoice============================///

static const String invoice = "Invoice";
static const String allInvoices = "All Invoices";
static const String createInvoice = "Create Invoice";
static const String customerDetails  = "Customer Details ";
static const String addressColon = "Address :";
static const String contactColon = "Contact :";
static const String nameColon = "Name :";
static const String emailColon = "Email :";
static const String services = "Services";
static const String no = "No";
static const String name = "Name";
static const String quantity = "Quantity";
static const String addCustomerDetails  = "Add Customer Details ";
static const String addServiceDetails = "Add Service Details";
static const String searchToSelect = "Country";
static const String editServiceDetails = "Edit Service Details";
static const String editInvoice = "Edit Invoice";
static const String searchInvoice = "Search Invoice";

///============================Settings====================///

static const String settings = "Settings";
static const String editProfile = "Edit Profile";
static const String subscription = "Subscription";
static const String interventionCategory = "Intervention Category";
static const String contactSupport = "Contact Support";
static const String uploadLogo = "Upload Logo";
static const String changePassword = "Change Password";
static const String deleteAccount = "Delete Account";
static const String logOut = "Log Out";
static const String termsConditions = "Terms & Conditions";
static const String privacyPolicy = "Privacy Policy";
static const String saveChanges = "Save Changes";
static const String currentPassword = "Current Password";

///=======================Subscription=================///

static const String currentPlan = "Current Plan";
static const String freePlan  = "Free plan ";
static const String purchaseDate = "Purchase Date :";
static const String expirationDate = "Expiration Date :";
static const String CancelRequest  = "Cancel Request ";
static const String Active = "Active";
static const String availablePlan = "Available Plan";
static const String cancelAnyTime = "Cancel any time";
static const String monthly  = "Monthly ";
static const String annually = "Annually";
static const String upgradeNow = "Upgrade Now";
static const String confirmToPay = "Confirm To Pay";
static const String payment = "Payment";
static const String paymentDetails = "Payment Details";
static const String subscriptionPlan = "Subscription plan";
static const String subscriptionFee = "Subscription fee";
static const String additionalFee = "Additional Fee";
static const String totalFee = "Total Fee";
static const String enterCardDetails = "Enter Card Details";
static const String cardHolderName = "Card-holder's Name";
static const String cardNumber = "Card Number";
static const String expireDate = "Expire Date";
static const String cVC = "CVC";
static const String pay = "Pay";
static const String goBack = "Go Back";
static const String paymentSuccessful = "Payment Successful";


///=========================== Intervention Cat egory ==========================///

static const String allCategories = "All Categories";
static const String action = "Action";
static const String addNewCategory = "Add New Category";
static const String categoryName = "Category Name";
static const String categoryPrice = "Category Price";
static const String addNew = "Add New";
static const String editCategory = "Edit Category";

///=====================Support==========================//
static const String subject = "Subject";
static const String support = "Support";
static const String send = "Send";

///=========================Upload logo======================///

static const String Logo = "Logo";
static const String uploadYourBusinessLogo = "Upload Your  Business Logo";

// static const String service = 'Service';


}
