// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Auth: StoryboardType {
    internal static let storyboardName = "Auth"

    internal static let signInViewController = SceneType<Pharmacy_Manager.SignInViewController>(storyboard: Auth.self, identifier: "SignInViewController")
  }
  internal enum Catalogue: StoryboardType {
    internal static let storyboardName = "Catalogue"

    internal static let initialScene = InitialSceneType<Pharmacy_Manager.CatalogueViewController>(storyboard: Catalogue.self)

    internal static let catalogueViewController = SceneType<Pharmacy_Manager.CatalogueViewController>(storyboard: Catalogue.self, identifier: "CatalogueViewController")

    internal static let medicineListViewController = SceneType<Pharmacy_Manager.MedicineListViewController>(storyboard: Catalogue.self, identifier: "MedicineListViewController")

    internal static let subcategoryViewController = SceneType<Pharmacy_Manager.SubcategoryViewController>(storyboard: Catalogue.self, identifier: "SubcategoryViewController")
  }
  internal enum Chat: StoryboardType {
    internal static let storyboardName = "Chat"

    internal static let chatsViewController = SceneType<Pharmacy_Manager.ChatsViewController>(storyboard: Chat.self, identifier: "ChatsViewController")
  }
  internal enum Home: StoryboardType {
    internal static let storyboardName = "Home"

    internal static let homeViewController = SceneType<Pharmacy_Manager.HomeViewController>(storyboard: Home.self, identifier: "HomeViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Product: StoryboardType {
    internal static let storyboardName = "Product"

    internal static let initialScene = InitialSceneType<Pharmacy_Manager.ProductViewController>(storyboard: Product.self)

    internal static let searchViewController = SceneType<Pharmacy_Manager.SearchViewController>(storyboard: Product.self, identifier: "SearchViewController")
  }
  internal enum Profile: StoryboardType {
    internal static let storyboardName = "Profile"

    internal static let profileViewController = SceneType<Pharmacy_Manager.ProfileViewController>(storyboard: Profile.self, identifier: "ProfileViewController")
  }
  internal enum Scan: StoryboardType {
    internal static let storyboardName = "Scan"

    internal static let initialScene = InitialSceneType<Pharmacy_Manager.ScanViewController>(storyboard: Scan.self)
  }
  internal enum Search: StoryboardType {
    internal static let storyboardName = "Search"

    internal static let searchViewController = SceneType<Pharmacy_Manager.SearchViewController>(storyboard: Search.self, identifier: "SearchViewController")
  }
  internal enum Tabbar: StoryboardType {
    internal static let storyboardName = "Tabbar"

    internal static let initialScene = InitialSceneType<Pharmacy_Manager.TabBarController>(storyboard: Tabbar.self)

    internal static let tabBarController = SceneType<Pharmacy_Manager.TabBarController>(storyboard: Tabbar.self, identifier: "TabBarController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
