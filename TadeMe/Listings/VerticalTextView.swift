//
//  PriceView.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 25/01/22.
//
import SwiftUI

struct TextModel {
    let text: String
    let font: Font
    let weight: Font.Weight
    let color: Color
}
struct VerticalTextView: View {
    let titleModel: TextModel
    let messageModel: TextModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(titleModel.text)
                .foregroundColor(titleModel.color)
                .font(titleModel.font)
                .fontWeight(titleModel.weight)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            Text(messageModel.text)
                .foregroundColor(messageModel.color)
                .font(messageModel.font)
                .fontWeight(messageModel.weight)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
        }
    }
}
