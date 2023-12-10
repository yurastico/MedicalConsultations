//
//  String+convertDateStringToReadableDate.swift
//  MedicalConsultations
//
//  Created by Yuri Cunha on 02/11/23.
//

import Foundation

extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = inputFormatter.date(from: self) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
                return dateFormatter.string(from: date)
            }
        return ""
    }
}
