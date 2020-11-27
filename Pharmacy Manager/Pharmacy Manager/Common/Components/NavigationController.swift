//
//  NavigationController.swift
//  Pharmacy
//
//  Created by Egor Bozko on 02.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit

final class RoundedNavigationBar: UINavigationBar {
 
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.saveGState()
        defer { context.restoreGState() }
        let cornerRaii = 10.0
        let path = UIBezierPath(
          roundedRect: rect,
          byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRaii, height: cornerRaii)
        )

        context.addPath(path.cgPath)
        context.closePath()
        context.setFillColor(Asset.LegacyColors.welcomeBlue.color.cgColor)
        context.fillPath()
    }
}

class NavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: RoundedNavigationBar.self, toolbarClass: nil)
        if #available(iOS 14.0, *) {
            rootViewController.navigationItem.backButtonDisplayMode = .default
        } else {
          let backItem = UIBarButtonItem()
          backItem.title = " "
          rootViewController.navigationItem.backBarButtonItem = backItem
        }
        viewControllers = [rootViewController]
      }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if #available(iOS 14.0, *) {
          viewController.navigationItem.backButtonDisplayMode = .minimal
        } else {
          let backItem = UIBarButtonItem()
          backItem.title = " "
          viewController.navigationItem.backBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
      }
    
    private func setupNavigationBar() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.tintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        setStatusBar(backgroundColor: Asset.LegacyColors.welcomeBlue.color)
    }
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? UIApplication.shared.statusBarFrame
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
