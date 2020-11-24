// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum HomeScreen {
    /// Ожидается в разработке
    internal static let inDevelopment = L10n.tr("Localizable", "homeScreen.inDevelopment")
    /// Новых запросов
    internal static let newRequestTitle = L10n.tr("Localizable", "homeScreen.newRequestTitle")
    /// Вы недавно рекомендовали
    internal static let recentRecommendation = L10n.tr("Localizable", "homeScreen.recentRecommendation")
  }

  internal enum ProfileScreen {
    /// Выйти из аккаунта
    internal static let exit = L10n.tr("Localizable", "profileScreen.exit")
    /// Нужна помощь?
    internal static let needHelp = L10n.tr("Localizable", "profileScreen.needHelp")
    /// Статистика
    internal static let statistic = L10n.tr("Localizable", "profileScreen.statistic")
    /// Профиль
    internal static let title = L10n.tr("Localizable", "profileScreen.title")
    internal enum AboutApp {
      /// Про кешбек
      internal static let cashBack = L10n.tr("Localizable", "profileScreen.aboutApp.cashBack")
      /// О Персональных данных
      internal static let personalData = L10n.tr("Localizable", "profileScreen.aboutApp.personalData")
      /// Пользовательское соглашение
      internal static let profileArrangement = L10n.tr("Localizable", "profileScreen.aboutApp.profileArrangement")
      /// Условия использования данных
      internal static let termsDataUse = L10n.tr("Localizable", "profileScreen.aboutApp.termsDataUse")
      /// О приложении
      internal static let title = L10n.tr("Localizable", "profileScreen.aboutApp.title")
    }
    internal enum HaveQuestions {
      /// Возврат
      internal static let back = L10n.tr("Localizable", "profileScreen.haveQuestions.back")
      /// Кассовая дисциплина
      internal static let cashDiscipline = L10n.tr("Localizable", "profileScreen.haveQuestions.cashDiscipline")
      /// Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet rutrum vel non volutpat. Sagittis aliquam mattis tortorLorem ipsum dolor sit amet, consectetur adipiscing elit. Amet rutrum vel non volutpat. Sagittis aliquam mattis tortor
      internal static let cashDisciplineBodyText = L10n.tr("Localizable", "profileScreen.haveQuestions.cashDisciplineBodyText")
      /// Доставка
      internal static let delivery = L10n.tr("Localizable", "profileScreen.haveQuestions.delivery")
      /// Рецептурные товары
      internal static let receiptGoods = L10n.tr("Localizable", "profileScreen.haveQuestions.receiptGoods")
      /// Проблемы с оборудованием
      internal static let techicalProblems = L10n.tr("Localizable", "profileScreen.haveQuestions.techicalProblems")
      /// Есть вопросы?
      internal static let title = L10n.tr("Localizable", "profileScreen.haveQuestions.title")
    }
    internal enum Notifications {
      /// Email рассылка
      internal static let mailing = L10n.tr("Localizable", "profileScreen.notifications.mailing")
      /// Новый запрос в чате
      internal static let newChatRequest = L10n.tr("Localizable", "profileScreen.notifications.newChatRequest")
      /// Push уведомления
      internal static let pushNotification = L10n.tr("Localizable", "profileScreen.notifications.pushNotification")
      /// Обновление рейтинга
      internal static let ratingUpdate = L10n.tr("Localizable", "profileScreen.notifications.ratingUpdate   ")
      /// Уведомления
      internal static let title = L10n.tr("Localizable", "profileScreen.notifications.title")
    }
  }

  internal enum Tabbar {
    /// 
    internal static let chat = L10n.tr("Localizable", "tabbar.chat")
    /// Home
    internal static let home = L10n.tr("Localizable", "tabbar.home")
    /// Profile
    internal static let profile = L10n.tr("Localizable", "tabbar.profile")
    /// Что необходимо найти?
    internal static let searchPlaceholder = L10n.tr("Localizable", "tabbar.searchPlaceholder")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
