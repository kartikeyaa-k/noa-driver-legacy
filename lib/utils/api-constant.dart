class ApiConstant {
  //static String SERVER = "http://g2.okommerce.com/";
  static String SERVER = "https://admin.noa.market/";
  static String STORE_LIST = "api/v1/Stores";
  static String ALL_COUNTRY_LIST = "api/v1/country";
  static String REGISTRATION_POST = "api/v1/customer-register";
  static String LOGIN = "api/v1/customer-login";
  static String PRODUCT_PARENT_CATEGORY = "api/v1/ParentCategory";
  static String PRODUCT_PARENT_CATEGORY_BY_CATEGORYID = "api/v1/Category";
  static String PRODUCT_LIST = "api/v1/Products";
  static String PRODUCT_DETAILS = "api/v1/Product-Details";
  static String ADD_TO_CARD = "api/v1/add-to-cart";
  static String ADD_TO_CARD_LIST = "api/v1/cart-items";
  static String ORDER_CHECKOUT = "api/v1/order";
  static String REMOVE_SINGLE_CART = "api/v1/remove-from-cart/";
  static String ADD_ADDRESS = "api/v1/delivery-address";
  static String CUSTOMER_DELIVERY_ADDRESS = "api/v1/delivery-address";
  static String MY_ORDER_LIST = "api/v1/order";
  static String RELATED_PRODUCT_YOU_MAY_LIKE = "api/v1/related-products";
  static String TRENDING_BANNER = "api/v1/banners";
  static String RECENTLY_ORDERED_ITEMS = "api/v1/Recent-order-products";
  static String SUB_CATEGORY_ITEMLIST = "api/v1/Category";
  //static String PREVIOUS_ORDEREDITEMS= "api/v1/driver-previous-orders";
  // static String PREVIOUS_ORDEREDITEMS = "api/v1/supplier-previous-orders";
  static String PREVIOUS_ORDEREDITEMS = "api/v1/store-previous-orders";
  static String UPLOAD_IMAGE = "api/v1/upload-customers-profile-picture";
  static String UPLOAD_SERVICE_IMAGE = "api/v1/upload-Images";
  static String USER_PROFILE = "api/v1/user-profile";
  static String REMOVE_ALL_CART = "api/v1/remove-all-from-cart";
  static String NOA_SERVICE = "api/v1/add-custom-input-field";
  static String SERVICE_LIST = "api/v1/custom-input-field-get";
  static String COUNTRY = "api/v1/country";
  static String STATE = "api/v1/state/";
  static String CITY = "api/v1/city";
  // static String DRIVER_LOGIN= "api/v1/driver-login";
  // static String DRIVER_LOGIN = "api/v1/supplier-login";
  static String DRIVER_LOGIN = "api/v1/store-login";
  //static String DRIVER_CURRENT_ORDER= "api/v1/driver-current-orders";
  // static String DRIVER_CURRENT_ORDER = "api/v1/supplier-current-orders";
  static String DRIVER_CURRENT_ORDER = "api/v1/store-current-orders";
  static String ORDER_DETAILS = "api/v2/order-details";
//  static String DRIVER_PROFILE= "api/v1/driver";
  static String DRIVER_PROFILE = "api/v1/supplier";
  static String DRIVER_LOCATIONINPUT = "api/v1/store-location-update";
  static String UPDATE_ORDER_STATUS = "api/v1/update-order-status";

  static String PRODUCT_FILTER = "api/v1/Products-filter";

  static String DRIVER_NOTIFICATION =
      "api/v1/send-notification-for-near-by-Stores";

  // LATEST K
  static String GET_COMMUNITIES = 'api/v1/communities';
  static String GET_SUBCOMMUNITIES = '/api/v1/subCommunities';
  static String SENT_NOTITIFICATION_ALL_SUBCOMMUNITIES =
      '/api/v1/send-notification-for-stores-in-subcommunity';
  static String GET_ALL_ORDERS_FOR_CUSTOMER = '/api/v1/order';
  static String UPDATE_ORDER = "api/v1/update-order";
}
