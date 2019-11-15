//
//  Toast.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit
import SwiftEntryKit

class Toast {
    
    static let shared = Toast()
    
    func showAlert(type: AlertType, message: String) {
        var attributes = EKAttributes()
        attributes.windowLevel = .statusBar
        attributes.position = .top
        attributes.displayDuration = 1.0
        attributes.entryBackground = .color(color: EKColor.init(light: R.color.colorViewBg() ?? .white, dark: R.color.colorViewBg() ?? .white))
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        let title = EKProperty.LabelContent.init(text: type.title, style: .init(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: EKColor.init(light: .white, dark: R.color.colorText() ?? .white)))
        let description = EKProperty.LabelContent.init(text: message, style: .init(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: EKColor.init(light: .white, dark:  .white) ))
        let simpleMessage = EKSimpleMessage.init(title: title, description: description)
        let notificationMessage = EKNotificationMessage.init(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
