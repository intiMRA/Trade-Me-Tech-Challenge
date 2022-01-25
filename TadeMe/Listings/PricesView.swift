//
//  PricesView.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 25/01/22.
//

import SwiftUI

struct PricesView: View {
    
    let item: ListResponse.ListItem
    
    var body: some View {
        HStack {
            let titleModel = TextModel(text: item.priceDisplay, font: .footnote, weight: .bold, color: .textDark)
            
            let messageModel = TextModel(text: item.isReserveMet == true ? "ReserveMet".localized : "ReserveNotMet".localized, font: .footnote, weight: .regular, color: .textLight)
            
            VerticalTextView(titleModel: titleModel, messageModel: messageModel)
            
            Spacer()
            
            if item.isClassified == false && item.buyNowPrice != nil {
                
                let titleModel = TextModel(text: "\(String(describing: item.buyNowPrice))", font: .footnote, weight: .bold, color: .textDark)
                
                let messageModel = TextModel(text: "BuyNow", font: .footnote, weight: .regular, color: .textLight)
                
                VerticalTextView(titleModel: titleModel, messageModel: messageModel)
            }
        }
    }
}
