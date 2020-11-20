// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Auth {
    internal static let btnGoActive = ImageAsset(name: "btn-go-active")
    internal static let btnGoInactive = ImageAsset(name: "btn-go-inactive")
  }
  internal enum Colors {
    internal static let appBlueDark = ColorAsset(name: "app_blue_dark")
    internal static let appBluePrimary = ColorAsset(name: "app_blue_primary")
    internal static let appError = ColorAsset(name: "app_error")
    internal static let appGreen = ColorAsset(name: "app_green")
    internal static let appGrey = ColorAsset(name: "app_grey")
    internal static let appGreyLight = ColorAsset(name: "app_grey_light")
    internal static let appGreyMedium = ColorAsset(name: "app_grey_medium")
    internal static let appGreyText = ColorAsset(name: "app_grey_text")
  }
  internal enum General {
    internal static let iconBackground = ImageAsset(name: "icon-background")
    internal static let iconCheck = ImageAsset(name: "icon-check")
    internal static let iconError = ImageAsset(name: "icon-error")
  }
  internal enum Images {
    internal enum AboutApp {
      internal static let dollar = ImageAsset(name: "dollar")
      internal static let lock = ImageAsset(name: "lock")
      internal static let shield = ImageAsset(name: "shield")
      internal static let user = ImageAsset(name: "user")
    }
    internal enum Actions {
      internal static let download = ImageAsset(name: "download")
      internal static let liked = ImageAsset(name: "liked")
      internal static let orangeBackground = ImageAsset(name: "orangeBackground")
      internal static let rightArrow = ImageAsset(name: "rightArrow")
      internal static let share = ImageAsset(name: "share")
      internal static let sort = ImageAsset(name: "sort")
      internal static let unliked = ImageAsset(name: "unliked")
      internal static let wishList = ImageAsset(name: "wishList")
      internal static let wishListSelected = ImageAsset(name: "wishListSelected")
    }
    internal enum Auth {
      internal static let apple = ImageAsset(name: "apple")
      internal static let applyRegion = ImageAsset(name: "applyRegion")
      internal static let applyRight = ImageAsset(name: "apply_right")
      internal static let confirmIcon = ImageAsset(name: "confirmIcon")
      internal static let edit = ImageAsset(name: "edit")
      internal static let faceId = ImageAsset(name: "faceId")
      internal static let facebook = ImageAsset(name: "facebook")
      internal static let google = ImageAsset(name: "google")
      internal static let leftArrowDark = ImageAsset(name: "leftArrowDark")
      internal static let logo = ImageAsset(name: "logo")
    }
    internal enum Button {
      internal static let buttonDefaultBg = ImageAsset(name: "button_default_bg")
      internal static let buttonDown = ImageAsset(name: "button_down")
      internal static let buttonMinus = ImageAsset(name: "button_minus")
      internal static let buttonPlus = ImageAsset(name: "button_plus")
      internal static let buttonPressedBg = ImageAsset(name: "button_pressed_bg")
      internal static let buttonRemove = ImageAsset(name: "button_remove")
      internal static let buttonWishlist = ImageAsset(name: "button_wishlist")
      internal static let buttonWishlistSelected = ImageAsset(name: "button_wishlist_selected")
    }
    internal enum Cart {
      internal static let iconBack = ImageAsset(name: "icon_back")
      internal static let iconCash = ImageAsset(name: "icon_cash")
      internal static let iconCaspy = ImageAsset(name: "icon_caspy")
      internal static let iconCelphone = ImageAsset(name: "icon_celphone")
      internal static let iconDelivery = ImageAsset(name: "icon_delivery")
      internal static let iconDoor = ImageAsset(name: "icon_door")
      internal static let iconHouse = ImageAsset(name: "icon_house")
      internal static let iconMailbox = ImageAsset(name: "icon_mailbox")
      internal static let iconMastercard = ImageAsset(name: "icon_mastercard")
      internal static let iconPhone = ImageAsset(name: "icon_phone")
      internal static let iconRadiobuttonEmpty = ImageAsset(name: "icon_radiobutton_empty")
      internal static let iconSelfdelivery = ImageAsset(name: "icon_selfdelivery")
      internal static let iconSmallcash = ImageAsset(name: "icon_smallcash")
      internal static let iconStar = ImageAsset(name: "icon_star")
      internal static let iconTruck = ImageAsset(name: "icon_truck")
    }
    internal enum Catalogs {
      internal static let addToBag = ImageAsset(name: "add_to_bag")
      internal static let backArrow = ImageAsset(name: "backArrow")
      internal static let cancelSearch = ImageAsset(name: "cancelSearch")
      internal static let farmacyExample = ImageAsset(name: "farmacyExample")
      internal static let leftArrow = ImageAsset(name: "leftArrow")
      internal static let medicineImageGrayscalePlaceholder = ImageAsset(name: "medicineImageGrayscalePlaceholder")
      internal static let medicineImagePlaceholder = ImageAsset(name: "medicineImagePlaceholder")
    }
    internal enum Category {
      internal static let mочеполовая = ImageAsset(name: "Mочеполовая")
      internal static let otherCategory = ImageAsset(name: "otherCategory")
      internal static let sensCategory = ImageAsset(name: "sensCategory")
      internal static let гормоны = ImageAsset(name: "Гормоны")
      internal static let дерматология = ImageAsset(name: "Дерматология")
      internal static let дыхательная = ImageAsset(name: "Дыхательная")
      internal static let костноМышечная = ImageAsset(name: "Костно-мышечная")
      internal static let кроветворение = ImageAsset(name: "Кроветворение")
      internal static let нервная = ImageAsset(name: "Нервная")
      internal static let пищеварительный = ImageAsset(name: "Пищеварительный")
      internal static let противомикробные = ImageAsset(name: "Противомикробные")
      internal static let противоопухолевые = ImageAsset(name: "Противоопухолевые")
      internal static let противопаразитарные = ImageAsset(name: "Противопаразитарные")
      internal static let сердечноСосудистая = ImageAsset(name: "Сердечно-сосудистая")
    }
    internal enum Chat {
      internal static let inputBarRectangle = ImageAsset(name: "InputBarRectangle")
      internal static let attachment = ImageAsset(name: "attachment")
      internal static let attachmentHighlighted = ImageAsset(name: "attachmentHighlighted")
      internal static let doctorChatIcon = ImageAsset(name: "doctor_chat_icon")
      internal static let pharmacistChatIcon = ImageAsset(name: "pharmacist_chat_icon")
      internal static let radiobuttonChecked = ImageAsset(name: "radiobutton_checked")
      internal static let send = ImageAsset(name: "send")
    }
    internal enum Common {
      internal static let crosshair = ImageAsset(name: "crosshair")
      internal static let navigationBar = ImageAsset(name: "navigationBar")
    }
    internal enum Examples {
      internal static let categoryExample = ImageAsset(name: "categoryExample")
      internal static let farmacyExampleHorizontal = ImageAsset(name: "farmacyExampleHorizontal")
    }
    internal enum Map {
      internal static let appleMaps = ImageAsset(name: "AppleMaps")
      internal static let googleMaps = ImageAsset(name: "Google_Maps")
      internal static let decreaseMap = ImageAsset(name: "decreaseMap")
      internal static let directionTriangle = ImageAsset(name: "directionTriangle")
      internal static let farmacyPin = ImageAsset(name: "farmacyPin")
      internal static let farmacyPlaceholder = ImageAsset(name: "farmacyPlaceholder")
      internal static let inscreaseMap = ImageAsset(name: "inscreaseMap")
      internal static let toMap = ImageAsset(name: "toMap")
      internal static let uber = ImageAsset(name: "uber")
    }
    internal enum NavigationBar {
      internal static let navigationBarCircles = ImageAsset(name: "navigationBarCircles")
    }
    internal enum Onboarding {
      internal static let illustrationLocation = ImageAsset(name: "illustration_location")
      internal static let illustrationOnboarding1 = ImageAsset(name: "illustration_onboarding_1")
      internal static let illustrationOnboarding2 = ImageAsset(name: "illustration_onboarding_2")
      internal static let illustrationOnboarding3 = ImageAsset(name: "illustration_onboarding_3")
      internal static let illustrationPurchase = ImageAsset(name: "illustration_purchase")
    }
    internal enum Product {
      internal static let masterCard = ImageAsset(name: "MasterCard")
      internal static let download = ImageAsset(name: "download")
      internal static let file = ImageAsset(name: "file")
      internal static let info = ImageAsset(name: "info")
      internal static let map = ImageAsset(name: "map")
      internal static let plus = ImageAsset(name: "plus")
      internal static let question = ImageAsset(name: "question")
      internal static let radiobutton = ImageAsset(name: "radiobutton")
      internal static let shoppingBag = ImageAsset(name: "shopping bag")
      internal static let truck = ImageAsset(name: "truck")
    }
    internal enum Profile {
      internal static let avatar = ImageAsset(name: "avatar")
      internal static let chooseLocation = ImageAsset(name: "chooseLocation")
      internal static let emptyAnalysis = ImageAsset(name: "emptyAnalysis")
      internal static let helpUsCashDiscipline = ImageAsset(name: "helpUsCashDiscipline")
      internal static let helpUsPrescription = ImageAsset(name: "helpUsPrescription")
      internal static let helpUsReturn = ImageAsset(name: "helpUsReturn")
      internal static let helpUsTechicalProblems = ImageAsset(name: "helpUsTechicalProblems")
      internal static let noResults = ImageAsset(name: "noResults")
      internal static let profileAddress = ImageAsset(name: "profileAddress")
      internal static let profileAnalize = ImageAsset(name: "profileAnalize")
      internal static let profileArrow = ImageAsset(name: "profileArrow")
      internal static let profileAttension = ImageAsset(name: "profileAttension")
      internal static let profileBellOn = ImageAsset(name: "profileBell on")
      internal static let profileCamera = ImageAsset(name: "profileCamera")
      internal static let profileEdit = ImageAsset(name: "profileEdit")
      internal static let profileOrder = ImageAsset(name: "profileOrder")
      internal static let profileOrders = ImageAsset(name: "profileOrders")
      internal static let profilePayment = ImageAsset(name: "profilePayment")
      internal static let profilePin = ImageAsset(name: "profilePin")
      internal static let profileQuestion = ImageAsset(name: "profileQuestion")
      internal static let profileQuit = ImageAsset(name: "profileQuit")
      internal static let profileRecipe = ImageAsset(name: "profileRecipe")
      internal static let profileSelected = ImageAsset(name: "profileSelected")
      internal static let profileStatistic = ImageAsset(name: "profileStatistic")
    }
    internal enum Scan {
      internal static let scan = ImageAsset(name: "SCAN")
      internal static let camera = ImageAsset(name: "camera")
      internal static let firstVector = ImageAsset(name: "firstVector")
      internal static let secondVector = ImageAsset(name: "secondVector")
    }
    internal enum Search {
      internal static let searchFieldActive = ImageAsset(name: "Search_Field_active")
      internal static let illustrationNoResults = ImageAsset(name: "illustrationNoResults")
    }
    internal enum TabBar {
      internal static let defaultProfilePhoto = ImageAsset(name: "defaultProfilePhoto")
      internal static let profileProxy = ImageAsset(name: "profileProxy")
      internal static let tabbarCatalogue = ImageAsset(name: "tabbarCatalogue")
      internal static let tabbarFavorite = ImageAsset(name: "tabbarFavorite")
      internal static let tabbarMain = ImageAsset(name: "tabbarMain")
      internal static let tabbarSearch = ImageAsset(name: "tabbarSearch")
      internal static let tabbarShopping = ImageAsset(name: "tabbarShopping")
    }
    internal enum Validation {
      internal static let validationClose = ImageAsset(name: "validationClose")
      internal static let validationError = ImageAsset(name: "validationError")
      internal static let validationSuccess = ImageAsset(name: "validationSuccess")
    }
    internal enum Welcome {
      internal static let barcode = ImageAsset(name: "barcode")
      internal static let welcomeBox = ImageAsset(name: "welcomeBox")
      internal static let welcomeCategory = ImageAsset(name: "welcomeCategory")
      internal static let welcomeDiagnostic = ImageAsset(name: "welcomeDiagnostic")
      internal static let welcomeMap = ImageAsset(name: "welcomeMap")
      internal static let welcomeMes = ImageAsset(name: "welcomeMes")
      internal static let welcomeReceipe = ImageAsset(name: "welcomeReceipe")
      internal static let welcomeSearch = ImageAsset(name: "welcomeSearch")
    }
    internal enum EmptyViews {
      internal static let emptyOrders = ImageAsset(name: "emptyOrders")
      internal static let emptyReciept = ImageAsset(name: "emptyReciept")
      internal static let emptyWishList = ImageAsset(name: "emptyWishList")
    }
  }
  internal enum LegacyColors {
    internal static let almostClear = ColorAsset(name: "almostClear")
    internal static let appleBlack = ColorAsset(name: "appleBlack")
    internal static let applyBlueGray = ColorAsset(name: "applyBlueGray")
    internal static let backgroundGray = ColorAsset(name: "backgroundGray")
    internal static let confirmCircleGray = ColorAsset(name: "confirmCircleGray")
    internal static let confirmLightGray = ColorAsset(name: "confirmLightGray")
    internal static let delivery = ColorAsset(name: "delivery")
    internal static let gray = ColorAsset(name: "gray")
    internal static let greyText = ColorAsset(name: "greyText")
    internal static let inputGray = ColorAsset(name: "inputGray")
    internal static let lightBlue = ColorAsset(name: "lightBlue")
    internal static let lightGray = ColorAsset(name: "lightGray")
    internal static let mediumGrey = ColorAsset(name: "mediumGrey")
    internal static let orange = ColorAsset(name: "orange")
    internal static let pickup = ColorAsset(name: "pickup")
    internal static let primaryColor2 = ColorAsset(name: "primaryColor2")
    internal static let shadowBlue = ColorAsset(name: "shadowBlue")
    internal static let shapeColor = ColorAsset(name: "shapeColor")
    internal static let textDarkBlue = ColorAsset(name: "textDarkBlue")
    internal static let textDarkGray = ColorAsset(name: "textDarkGray")
    internal static let validationBlue = ColorAsset(name: "validationBlue")
    internal static let validationGray = ColorAsset(name: "validationGray")
    internal static let validationGreen = ColorAsset(name: "validationGreen")
    internal static let validationRed = ColorAsset(name: "validationRed")
    internal static let violet = ColorAsset(name: "violet")
    internal static let welcomeBlue = ColorAsset(name: "welcomeBlue")
    internal static let welcomeGreen = ColorAsset(name: "welcomeGreen")
  }
  internal enum TabBar {
    internal static let tabbarChat = ImageAsset(name: "tabbar-chat")
    internal static let tabbarHome = ImageAsset(name: "tabbar-home")
    internal static let tabbarProfile = ImageAsset(name: "tabbar-profile")
  }
  internal static let iconLogo = ImageAsset(name: "icon_logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
