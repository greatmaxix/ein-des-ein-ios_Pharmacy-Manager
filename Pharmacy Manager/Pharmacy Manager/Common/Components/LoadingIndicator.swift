//
//  LoadingIndicator.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 02.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

struct LoadingIndicator {
    enum Constants {
        static let restorationIdentifier = "LoadingIndicatorRestorationIdentifier"
        static let cornerRadius: CGFloat = 8.0
        static let backgroundColor: UIColor = UIColor(white: 1.0, alpha: 1.0)
        static let containerBackgroundColor: UIColor = UIColor(white: 1.0, alpha: 0.0)
        static let size = CGSize(width: 60.0, height: 60.0)
        static let color = UIColor(named: "red_primary")
        static let padding: CGFloat = 15.0
        static let activityData = ActivityData(size: Constants.size,
                                               type: .ballPulseSync,
                                               color: Constants.color,
                                               padding: Constants.padding,
                                               backgroundColor: Constants.containerBackgroundColor)
    }

    static func start() {
        let presenter = NVActivityIndicatorPresenter.sharedInstance
        presenter.startAnimating(Constants.activityData, { view in
            fadeInAnimation(view: view)
        })
    }

    static func stop() {
        let presenter = NVActivityIndicatorPresenter.sharedInstance
        presenter.stopAnimating(fadeOutAnimation)
    }

    // MARK: Animations
    static func fadeInAnimation(view: UIView, backgrpundColor: UIColor = Constants.containerBackgroundColor) {
        view.alpha = 0.0

        let backgroundView = UIView(frame: CGRect(origin: .zero,
                                                  size: Constants.size))
        backgroundView.backgroundColor = backgrpundColor
        backgroundView.layer.cornerRadius = Constants.cornerRadius
        backgroundView.center = view.center
        view.insertSubview(backgroundView, at: 0)

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: {
                        view.alpha = 1.0
        }, completion: nil)
    }

    static func fadeOutAnimation(view: UIView, complete: @escaping () -> Void) {
        view.alpha = 1.0
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: {
                        view.alpha = 0.0
        }, completion: { completed in
            if completed {
                complete()
            }
        })
    }

    // MARK: - Helpers
    static func show(in mainView: UIView, backgrpundColor: UIColor = Constants.backgroundColor) {
        let containerView = UIView(frame: mainView.bounds)

        containerView.backgroundColor = Constants.containerBackgroundColor
        containerView.restorationIdentifier = Constants.restorationIdentifier
        fadeInAnimation(view: containerView, backgrpundColor: backgrpundColor)

        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(origin: .zero, size: Constants.size),
            type: .ballPulseSync,
            color: Constants.color,
            padding: Constants.padding)

        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicatorView)

        // Add constraints for `activityIndicatorView`.
        ({
            let xConstraint = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerX, multiplier: 1, constant: 0)
            let yConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerY, multiplier: 1, constant: 0)

            containerView.addConstraints([xConstraint, yConstraint])
            }())

        containerView.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        mainView.addSubview(containerView)
    }

    static func hide(in mainView: UIView) {
        for item in mainView.subviews
            where item.restorationIdentifier == Constants.restorationIdentifier {
                fadeOutAnimation(view: item) {
                    item.removeFromSuperview()
                }
        }
    }
}

extension UIViewController {
    func startLoadingIndicator() {
        LoadingIndicator.show(in: self.view)
    }

    func stopLoadingIndicator() {
        LoadingIndicator.hide(in: self.view)
    }
}

