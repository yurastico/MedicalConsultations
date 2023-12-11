//
//  UIApplication+getKeyWindow.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 11/12/23.
//

import UIKit

extension UIApplication {
    var getKeyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
