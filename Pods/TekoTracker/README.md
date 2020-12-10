# TekoTracker

[![CircleCI](https://circleci.com/gh/teko-vn/tracker-ios.svg?style=svg&circle-token=3034ab21117db65d381f0034b5cf74271732e69c)](https://app.circleci.com/pipelines/github/teko-vn/tracker-ios)
<!---
[![Version](https://img.shields.io/cocoapods/v/TekoTracker.svg?style=flat)](https://cocoapods.org/pods/TekoTracker)
[![License](https://img.shields.io/cocoapods/l/TekoTracker.svg?style=flat)](https://cocoapods.org/pods/TekoTracker)
[![Platform](https://img.shields.io/cocoapods/p/TekoTracker.svg?style=flat)](https://cocoapods.org/pods/TekoTracker)
--->

iOS version of tracker

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
  - [Framework](#framework)
  - [CocoaPods](#cocoapods)
- [Usage](#usage)
  - [Init tracker](#init-tracker)
    - [Configure](#configure)
    - [Tracking Protocol](#tracking-protocol)
    - [Testing](#testing)
  - [Set a user ID](#set-a-user-id)
  - [How to send an event](#how-to-send-an-event)
    - [Automatic](#automatic)
    - [Manual](#manual)
  - [Core events](#core-events)
    - [Alert Event](#alert-event)
    - [Custom Event](#custom-event)
    - [Error Event](#error-event)
    - [Interaction Event](#interaction-event)
    - [Performance Timing Event](#performance-timing-event)
    - [Screen View Event](#screen-view-event)
    - [Visible Content Event](#visible-content-event)
  - [Ecommerce events](#ecommerce-events)
    - [Cart Event](#cart-event)
    - [Checkout Event](#checkout-event)
    - [Payment Event](#payment-view)
    - [Product View Event](#product-view-event)
    - [Search Event](#search-event)
- [Example](#example)
- [Author](#author)
- [License](#license)

## Requirements

Ensure that you have at least the following software:

- XCode 11.1 or later
- macOS 10.15 or later

You might need:

- CocoaPods 1.7 or later

And development environment as following:

- Swift 5.1 or later
- iOS 9.1 or later

## Installation

### Framework

Drag and drop `TekoTracker.framework` into your project.<br/>
Ensure that you have `TekoTracker.framework` in the section **Frameworks, Libraries, and Embedded Content** at your project **Target Membership**'s **General** tab.

### CocoaPods

TekoTracker is not currently available through [CocoaPods](https://cocoapods.org) yet. You have to add the following line to your Podfile:

```ruby
# stable version
pod 'TekoTracker', :git => 'https://github.com/teko-vn/tracker-ios.git'

# latest version
pod 'TekoTracker', :git => 'https://github.com/teko-vn/tracker-ios.git', :branch => 'develop'
```

Run `pod install` you will have TekoTracker core module<br/>
In case you want Ecommerce module of Tracker, just modify as below:

```ruby
# stable version
pod 'TekoTracker/Ecommerce', :git => 'https://github.com/teko-vn/tracker-ios.git'

# latest version
pod 'TekoTracker/Ecommerce', :git => 'https://github.com/teko-vn/tracker-ios.git', :branch => 'develop'
```

[Up to table content](#Table-of-Contents)

## Usage

### Init Tracker

#### Configure
You should add `TekoTracker-Info.plist` in your project. <br/>
We have a full copy of the file in the Example project. You can reuse.

Open `TekoTracker-Info.plist`, you will see<br/>
| Property                     | Required | Description                                                                     | Type    |
| ---------------------------- | -------- | ------------------------------------------------------------------------------- | ------- |
| APP_ID                       | YES      | App ID you registered to track                                                  | String  |
| SCHEMA_VERSION               | YES      | Event schema version **(Do not modify)**                                        | String  |
| ENVIRONMENT                  | YES      | `development` or `production`                                                   | String  |
| LOG_SERVER_URL               | NO       | Tracker server domain                                                           | String  |
| MANUALLY_LOG_VIEW_CONTROLLER | NO       | You want to manually track your view controllers, set its value to true         | Boolean |
| RETRY_WHEN_FAILED            | NO       | Determine how many times to retry to send unsuccessful events                   | Boolean |
| SCHEDULE_RETRY_FAILURE       | NO       | Determine whether `Tracker` schedules to resend unsuccessful events             | Number  |
| LOG_DEBUG                    | NO       | Determine whether `Tracker` shows log in console                                | Boolean |
| MANUALLY_LOG_TRACKING_NAMES  | NO       | List of view controller tracking names that should not be tracked automatically | Array   |
| BLACKLIST_URL                | NO       | List of URLs which `Tracker` is not allowed to track                            | Array   |
| WHITELIST_URL                | NO       | List of URLs which `Tracker` is allowed to track                                | Array   |

Configure a `Tracker` shared instance in your app's `application:didFinishLaunchingWithOptions:` method:

```swift
import TekoTracker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Tracker.configure()

    return true
  }

  ...
}
```

You could follow this code in case you're not interested in creating your own `TekoTracker-Info.plist`:

```swift
import TekoTracker

class TrackerConfigure: TrackerConfigurable {
  let appID: String
  let schemaVersion: String
  let logServerURL: String
  let environment: String
  let manuallyLogViewController: Bool
  let retryWhenFailed: Int
  let manuallyLogTrackingNames: [String]
  let blacklistURL: [String]
  let whitelistURL: [String]
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Tracker.configure(TrackerConfigure(
      appID: "sample-app",
      schemaVersion: "2.0.0",
      logServerURL: "http://api.tracker.com/",
      environment: "development",
      manuallyLogViewController: false,
      retryWhenFailed: 3,
      manuallyLogTrackingNames: [],
      blacklistURL: [],
      whitelistURL: []
    ))

    return true
  }
  ...
}
```
**Note:**
- `schemaVersion` must be `2.0.0`<br/>
- Forget configuring Tracker will lead to crash when `Tracker.shared` is called

#### Tracking Protocol

`Tracker` conforms to `TrackingProtocol`, it requires these methods:
```swift
func use(userID: String, phoneNumber: String?)
func send(eventType: EventType, eventName: EventName, data: EventDataProtocol, isImmediate: Bool)
func sendAny(eventType: EventTypeProtocol, eventName: StringIdentifier, data: EventDataProtocol, isImmediate: Bool)
func sendGroup(_ events: [EventParameter], isImmediate: Bool)
```

`TrackingProtocol` implements several convenient methods besides that:
```swift
// Core module
public func sendAlertEvent(data: AlertEventData, isImmediate: Bool = false)
public func sendCustomEvent(name: EventName, data: CustomEventData, isImmediate: Bool = false)
public func sendCustomEvent(name: StringIdentifier, data: CustomEventData, isImmediate: Bool = false)
public func sendEnterScreenEvent(data: ScreenViewEventData, isImmediate: Bool = false)
public func sendExitScreenEvent(data: ScreenViewEventData, isImmediate: Bool = false)
public func sendErrorEvent(data: ErrorEventData, isImmediate: Bool = false)
public func sendInteractionContentEvent(data: InteractionEventData, isImmediate: Bool = false)
public func sendPerformanceTimingEvent(data: PerformanceTimingEventData, isImmediate: Bool = false)
public func sendVisibleContentEvent(data: [VisibleContentEventData], isImmediate: Bool = false)

// Ecommerce submodule
public func sendCartEvent(name: EventName, data: CartEventData, isImmediate: Bool = false)
public func sendCheckoutEvent(data: CheckoutEventData, isImmediate: Bool = false)
public func sendPaymentEvent(data: PaymentEventData, isImmediate: Bool = false)
public func sendSearchEvent(data: SearchEventData, isImmediate: Bool = false)
```

#### Testing
You might need to do unit testing, so we highly recommend to declare `Tracker.shared` as a `TrackingProtocol` property in your own class.
```swift
import TekoTracker

class MyClass {
  lazy var tracker: TrackingProtocol = Tracker.shared

  func doSomethingToTrack() {
    tracker.sendCustomEvent(data: CustomEventData(...))
  }
}
```
So you can do mock testing like this
```swift
import TekoTracker

class MyTests {
  let sut: MyClass!

  override func setUp() {
    sut = MyClass()
    sut.tracker = MockTracker()
  }
}

class MockTracker: TrackingProtocol {
  ...
}
```

[Up to table content](#Table-of-Contents)

### Set a user ID

`Tracker` supports to store a userID for the individual using your app. **Wait for users to sign in to your app successfully, you should provide userID (required) and user's phone number (if needed) as below:**

```swift
func userDidLogInSuccessfully() {
  let userID = "0123456789abcdef"
  let phoneNumber = "0123456789"
  Tracker.shared.use(userID: userID, phoneNumber: phoneNumber)
}
```

[Up to table content](#Table-of-Contents)

### How to send an event

#### Automatic

Once you call `Tracker.configure()`<br/>
`Tracker` will try to capture user and network activities automatically.
- User activities<br/>
  `Tracker` will capture all your touches on view and recognize every view controller transition.

  ***Alert Event***<br/>
  `Tracker` will automatically track this event if it satisfies one of these conditions below:
  - The current view controller presents a `UIAlertController` whose `shouldTrackAsAlert` returns `true`.<br/>
  **Note:** `UIAlertController`'s `shouldTrackAsAlert` is `false` by default.
  - The current view controller presents a view controller whose type conforms to `AlertTrackable`.

  ***Interaction Event***<br/>
  You have to set value for these properties `trackingContentName`, `trackingRegionName` of view to help `Tracker` recognize the view as a trackable view.
  Remember it should not be null or empty.
  <br/>
  You must set `cancelsTouchesInView` to `false` for every `UIGestureRecognizer` you added to view. Otherwise, the view will be unable to track<br/>
  **Note:** `Tracker` will have no idea to track `UIControl`'s superview even if both its `trackingRegionName` and its `trackingContentName` are nonnull values.

  ***Visible Content Event***<br/>
  Everytime users finish scrolling down/up a `UITableView` or a `UICollectionView` with a low velocity (maximum value is 1.2 for two both dimensions), `Tracker` automatically tracks `visibleCells` info based on `trackingRegionName`, `trackingContentName`, `trackingIndex` you set to cells. You can set value for `trackingIndex` or not, if not, `trackingIndex` must return value of `tag` by default.

  ***Screen View Event***<br/>
  `Tracker` automatically tracks view controller info when a view controller transition occurs as long as you set value for `trackingName` to a nonnull value of the view controller. It generates a **Screen View Event** based on `trackingName` (required), `trackingContentType` (optional), `trackingTitle` (optional) and `trackingHref` (optional - if the view controller is webview-based).

  `Tracker` sends a **Screen View Event** with name `enterScreenView` when the view controller is presented and sends a **Screen View Event** with name `exitScreenView` when the view controller is dismissed.

  Remember `Tracker`'s configuration you've set up before? If you set `manuallyLogViewController` to true or your view controller's `trackingName` is one of `manuallyLogTrackingNames` values, `Tracker` will skip tracking your view controller. In this case, you should do this manually.

  ***Product View Event***</br>
  It is only available in `Ecommerce` submodule. `ProductViewEventData` inherits from `ScreenViewEventData`. It contains ecommerce properties such as `sku`, `productName`, `channel`, `terminal` besides base properties.<br/>
  If your view controller class conforms to `ProductViewTrackable`, `Tracker` will generate a **Product View Event** instead of **Screen View Event** and track when the view controller is presented/dismissed.

- Networking<br/>
  `Tracker` will inject one networking interceptor to capture all requests from your app and all coresponding responses automatically.<br/>
  However, not all of requests are handled. We have `blacklistURL` and `whitelistURL` in the configuration to filter out request URLs before generating an `Error` event if request errors occur.<br/>
  **Note:** `blacklistURL` is more prior than `whitelistURL`. Therefore, one URL which appears in both `blacklistURL` and `whitelistURL` is unaccepted to handle

#### UIViewController
This section mentions some additional features that is related to `UIViewController`. `UIViewController` has an instance Boolean property `shouldHoldToTrackOnLoad` that defines whether a view controller needs to track when its view is available for users to interact.</br>
However, you must call `logDidEndLoadingTime` in your callback to help detect the time.

```swift
class MyViewController {
  // Callback of network loader
  func myTaskDidComplete() {
    tracker.logDidEndLoadingTime()
  }
}
```

#### Manual

```swift
let eventType: EventType = // some event type
let eventName: EventName = // event name you want
let data: EventDataProtocol = // an instance of data structure
Tracker.shared.send(eventType: eventType, eventName: eventName, data: data, isImmediate: true)
```
We have
- eventType: `EventType`

```swift
// Core module
public struct EventType {
  static public let alert
  static public let custom
  static public let error
  static public let interaction
  static public let screenView
  static public let timing
  static public let visibleContent
}

// Ecommerce submodule
extension EventType {
  static public let cart
  static public let checkout
  static public let payment
  static public let search
}

```
- eventName: `EventName`

```swift
// Core module
public struct EventName {
  /// Alert
  static public let userAlert
  /// Content
  static public let click
  /// Content
  static public let visibleContent
  /// Screen view
  static public let enterScreenView
  /// Screen view
  static public let exitScreenView
  /// Error
  static public let error
}

// Ecommerce submodule
extension EventName {
  /// Cart
  static public let addToCart
  /// Cart
  static public let removeFromCart
  /// Cart
  static public let selectProduct
  /// Cart
  static public let unselectProduct
  /// Cart
  static public let revertProductToCart
  /// Cart
  static public let increaseQuantityProduct
  /// Cart
  static public let decreaseQuantityProduct
  /// Ecommerce
  static public let checkout
  /// Ecommerce
  static public let payment
  /// Search
  static public let search
}
```

- data: `EventDataProtocol`

Classes comform to `EventDataProtocol`:
```swift
// Core module
public class AlertEventData {}
public class CustomEventData {}
public class ErrorEventData {}
public class InteractionEventData {}
public class ScreenViewEventData {}
public class TimingEventData {}
public class VisibleContentEventData {}

// Ecommerce submodule
public class CartEventData {}
public class CheckoutEventData {}
public class PaymentEventData {}
public class ProductViewEventData {}
public class SearchEventData {}
```

### Core Events

#### Alert Event

Should be tracked automatically. (See [Automatic events](#automatic))

| Field          | Not falsy? | Description                             | Type                  |
| -------------- | ---------- | --------------------------------------- | --------------------- |
| channel        | false      |                                         | String                |
| terminal       | false      |                                         | String                |
| alertType      | true       | Type of alert (alertDialog, toast, ...) | String                |
| alertMessage   | true       | Presenting alert message                | String                |
| extra          | false      | Extra values                            | FlattenExtraAttribute |

For example:
```swift
let data = AlertEventData(
  alertType: "alertDialog",
  alertMessage: "Something went wrong",
  extra: FlattenExtraAttribute(first: "something")
)
Tracker.shared.sendAlertEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Error Event

Tracking when app receives any error response.<br/>
Should be tracked automatically. (See [Automatic events](#automatic))

| Field            | Not falsy? | Description                                           | Type        |
| ---------------- | ---------- | ----------------------------------------------------- | ----------- |
| errorSource      | true       | .client, .http, .webSocket                            | ErrorSource |
| apiCall          | true       | Request URL                                           | String      |
| apiPayload       | true       | Dictionary representation of request body             | [AnyHashable: Any] |
| httpResponseCode | true       | HTTP status code                                      | Int         |
| responseJson     | true       | String representation of response                     | String      |
| errorCode        | true       | Value of key "code" of error response body            | String      |
| errorMessage     | true       | Value of key "message" of error response body         | String      |
| extra            | false      | Extra values                                          | FlattenExtraAttribute |

For example:
```swift
let eventData = ErrorEventData(
  errorSource: .http,
  apiCall: url.absoluteString,
  apiPayload: body ?? [:],
  httpResponseCode: httpCode,
  responseJson: String(data: data, encoding: .utf8),
  errorCode: errorCode ?? "",
  errorMessage: errorMessage ?? ""
)
Tracker.shared.sendErorEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Interaction Event

Measuring a UITouch handler.<br/>
Should be tracked automatically. (See [Automatic events](#automatic))

| Field            | Not falsy? | Description                                | Type            |
| ---------------- | ---------- | ------------------------------------------ | --------------- |
| interaction      | true       | .click                                     | String          |
| regionName       | true       | Region name of view                        | String          |
| contentName      | true       | Content name of view                       | String          |
| target           | true       | Target of view when touches occur          | String          |
| payload          | false      | Payload of view                            | Any (Encodable) |
| relativePosition | false      | Relative position of view to its superview | CGPoint         |
| absolutePosition | false      | Absolute position of view to its window    | CGPoint         |

For example:
```swift
let data = InteractionEventData(
  interaction: .click,
  regionName: "buttonContainer",
  contentName: "button",
  target: "somewhere",
  payload: "something",
  relativePosition: .zero,
  absolutePosition: .zero
)
Tracker.shared.sendInteractionContentEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Performance Timing Event

Measuring task performance<br/>

| Field         | Not falsy? | Description                                | Type                  |
| ------------- | ---------- | ------------------------------------------ | --------------------- |
| channel       | false      |                                            | String                |
| terminal      | false      |                                            | String                |
| category      | true       |                                            | String                |
| action        | true       |                                            | String                |
| actionParam   | false      | Action payload                             | Any (Encodable)       |
| actionStartAt | false      | Time for action starts                     | TimeInterval          |
| actionEndAt   | false      | Time for action finishes                   | TimeInterval          |
| extra         | false      | Extra values                               | FlattenExtraAttribute |

For example:
```swift
let data = PerformanceTimingEventData(
  channel: "channel",
  terminal: "terminal",
  category: "category",
  action: "action",
  actionParam: "any action",
  actionStartAt: Date().timeIntervalSince1970,
  actionEndAt: Date().timeIntervalSince1970 + 30,
  extra: nil
)
Tracker.shared.sendPerformanceTimingEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Screen View Event

Measuring a view controller being presented/dismissed.<br/>
Should be tracked automatically. (See [Automatic events](#automatic))

 Field               | Not falsy? | Description                                           | Type            |
| ------------------ | ---------- | ----------------------------------------------------- | --------------- |
| referrerScreenName | true       | The visible screen's name                             | String          |
| screenName         | true       | Screen's name                                         | String          |
| contentType        | true       | Content type                                          | String          |
| title              | false      | Title                                                 | String          |
| href               | false      | Relavant URL representation to the screen             | String          |
| extra              | false      | Extra values                                          | FlattenExtraAttribute |
| navigationStart    | false      | Time for view begins to appear in the view hierachy   | TimeInterval    |
| loadEventEnd       | false      | Time for view is ready to interact after loading data | TimeInterval    |

For example:
```swift
// Manually
override func viewDidAppear() {
  super.viewDidAppear()
  let data = ScreenViewEventData(screenName: "SearchBooking", contentType: "others")
  Tracker.shared.sendEnterScreenViewEvent(data: data)
}

override func viewWillDisappear() {
  super.viewWillDisappear()
  let data = ScreenViewEventData(screenName: "SearchBooking", contentType: "others")
  Tracker.shared.sendExitScreenViewEvent(data: data)
}
```

[Up to table content](#Table-of-Contents)

#### Visible Content Event

Measuring `UITableView`/`UICollectionView`'s visible cells being displayed.<br/>
Should be tracked automatically. (See [Automatic events](#automatic))

| Field            | Not falsy? | Description                                | Type            |
| ---------------- | ---------- | ------------------------------------------ | --------------- |
| index            | true       | View index in superview subviews           | Int             |
| regionName       | true       | Region name of view                        | String          |
| contentName      | true       | Content name of view                       | String          |

For example:
```swift
let data = VisibleContentEventData(
  index: 0,
  regionName: "buttonContainer",
  contentName: "button"
)
Tracker.shared.sendVisibleContentEvent(data: [data])
```

[Up to table content](#Table-of-Contents)

### Ecommerce Events

Ecommerce events allows measurements of user activities with cart, searching, payment flow across users' shopping experience. All of them must be tracked manually.

#### Cart Event

Measure a product being added to a cart.

| Field          | Not falsy? | Description                                           | Type            |
| -------------- | ---------- | ----------------------------------------------------- | --------------- |
| cartID         | true       | Cart ID                                               | String          |
| sku            | true       | SKU of product                                        | String          |
| name           | false      | Name of product                                       | String          |
| price          | true       | Price of product                                      | Double          |
| promotionPrice | true       | Final price                                           | Double          |
| quantity       | false      | Quantity added, removed, increase, decrease from cart | Int             |
| promotions     | false      | Promotion ids                                         | [String]        |
| coupon         | false      | Applied coupon                                        | String          |
| status         | false      | Accepted values: `.success, .failed`                  | CartEventStatus |
| extra          | false      | Extra values                                          | FlattenExtraAttribute |

There are **6** event names of `Cart Event`:
- addToCart
- removeFromCart
- selectProduct
- unselectProduct
- revertProductToCart
- increaseQuantityProduct
- decreaseQuantityProduct

For example:
```swift
let eventName: EventName = .addToCart
let data = CartEventData(
  cartID: "",
  sku: "",
  name: "",
  price: 1,
  promotionPrice: 1,
  quantity: 1,
  promotions: [],
  coupon: "coupon1,coupn2",
  status: .success
)
Tracker.shared.sendCartEvent(eventName: eventName, data: data)
```

[Up to table content](#Table-of-Contents)

#### Checkout Event

Measure an order being confirmed.

| Field                | Not falsy? | Description                                           | Type   |
| -------------------- | ---------- | ----------------------------------------------------- | ------ |
| orderID              | true       |                                                       | String |
| grandTotal           | false      |                                                       | Double |
| amountBeforeDiscount | false      |                                                       | Double |
| tax                  | false      |                                                       | Double |
| discountAmount       | false      |                                                       | Double |
| products             | true       |                                                       | [CheckoutEventData.Product] |
| note                 | false      |                                                       | String |
| shippingFee          | false      |                                                       | String |
| shippingPartner      | false      |                                                       | String |
| shippingAddressCode  | false      |                                                       | String |
| shippingProvince     | false      |                                                       | String |
| shippingDistrict     | false      |                                                       | String |
| shippingWard         | false      |                                                       | String |
| shippingStreet       | false      |                                                       | String |
| shippingAddress      | false      |                                                       | String |
| paymentMethod        | false      | Accepted values: `.cash, .jcb, .visa, .masterCard, .internetBanking, .eWallet, .vnpayQR, .paymentGW` | PaymentMethod |
| paymentBank          | false      | Payment bank                                          | String |
| status               | true       | Accepted values: `.success, .failed, .timeout`        | EcommerceEventStatus |
| extra                | false      | Extra values                                          | FlattenExtraAttribute |

`
CheckoutEventData.Product
`

| Field          | Not falsy? | Description                                           | Type   |
| -------------- | ---------- | ----------------------------------------------------- | ------ |
| sku            | true       | Product SKU                                           | String |
| name           | false      | Product name                                          | String |
| price          | true       | Price                                                 | Double |
| promotionPrice | false      | Final price                                           | Double |
| quantity       | true       | Current product quantity in the cart                  | Int    |

For example:
```swift
let productEventData = CheckoutEventData.Product(
  sku: "abc",
  name: "ABC",
  price: 1,
  quantity: 1
)
let data = CheckoutEventData(
  orderID: id,
  grandTotal: grandTotal,
  amountBeforeDiscount: total,
  tax: tax,
  discountAmount: totalDiscount,
  products: [productEventData],
  paymentMethod: .cash,
  paymentBank: nil,
  shippingFee: shippingFee,
  shippingPartner: nil,
  shippingAddressCode: nil,
  shippingProvince: shippingInfo?.provinceId,
  shippingDistrict: shippingInfo?.districtId,
  shippingWard: shippingInfo?.wardId,
  shippingStreet: nil,
  shippingAddress: shippingInfo?.fullAddress,
  note: note, status: status
)
Tracker.shared.sendCheckoutEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Payment Event

Measuring a purchase.

| Field         | Not falsy? | Description                                           | Type   |
| ------------- | ---------- | ----------------------------------------------------- | ------ |
| orderID       | true       | Order ID                                              | String |
| referral      | false      | Order referral                                        | String |
| amount        | false      | Order's grand total                                   | Double |
| paymentMethod | false      | Accepted values: `.cash, .jcb, .visa, .masterCard, .internetBanking, .eWallet, .vnpayQR, .paymentGW` | PaymentMethod |
| paymentBank   | false      | Payment bank                                          | String |
| status        | true       | Accepted values: `.success, .failed, .timeout`        | EcommerceEventStatus |
| statusCode    | false      | Status code                                           | Int    |

For example:
```swift
let data = PaymentEventData(
  orderID: id,
  referral: referralCode,
  amount: grandTotal,
  paymentMethod: .cash,
  paymentBank: paymentBank,
  status: .success
)
Tracker.shared.sendPaymentEvent(data: data)
```

[Up to table content](#Table-of-Contents)

#### Search Event

Measuring search criterias being applied.

| Field        | Not falsy? | Description              | Type                   |
| ------------ | ---------- | ------------------------ | ---------------------- |
| params       | true       | Params of search request | SearchEventData.Params |
| keywords     | true       | List of search keywords  | [String]               |
| sort         | true       | List of sort values      | String                 |
| order        | false      | List of order values     | String                 |

For example:
```swift
let params = SearchEventData.Params(
  channel: "someChannel",
  terminal: "someTerminal",
  keyword: "keyword",
  page: 0,
  limit: 10,
  minPrice: 1,
  maxPrice: nil,
  categories: ["1", "2"],
  attributeSets: ["attr1", "attr2"],
  hasPromotions: true
)
let data = SearchEventData(
  params: params,
  keywords: ["keyword1"],
  sort: ["sortValue1", "sortValue2"],
  order: ["orderValue1"]
)
Tracker.shared.sendSearchEvent(data: data)
```

[Up to table content](#Table-of-Contents)

## Example

- Clone this repository
- Open `Example`
- Open `Terminal` then `cd` to the `Example` folder
- Run `pod install`

Enjoy!

## Author

Dũng Nguyễn, dung.ntm1@teko.vn<br/>
TEKO Vietnam

## License

TekoTracker is available under the MIT license. See the LICENSE file for more info.
