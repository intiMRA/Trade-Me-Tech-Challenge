//
//  ListResponse.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 21/01/22.
//

import Foundation

struct ListResponse: Codable {
    
    struct ListItem: Codable, Identifiable {
        let title: String
        let region: String
        let pictureHref: String?
        let priceDisplay: String
        let buyNowPrice: Float?
        let isClassified: Bool?
        let isReserveMet: Bool?
        let id: Int
        
        init(title: String,
             region: String,
             pictureHref: String?,
             priceDisplay: String,
             buyNowPrice: Float?,
             isClassified: Bool?,
             isReserveMet: Bool?,
             id: Int) {
            self.title = title
            self.region = region
            self.pictureHref = pictureHref
            self.priceDisplay = priceDisplay
            self.buyNowPrice = buyNowPrice
            self.isClassified = isClassified
            self.isReserveMet = isReserveMet
            self.id = id
        }
        
        private enum ListItemKeys: String, CodingKey {
            case Title, Region, PictureHref, PriceDisplay, BuyNowPrice, IsClassified, ListingId, IsReserveMet
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: ListItemKeys.self)
            try container.encode(title, forKey: .Title)
            try container.encode(region, forKey: .Region)
            try container.encode(pictureHref, forKey: .PictureHref)
            try container.encode(priceDisplay, forKey: .PriceDisplay)
            try container.encode(buyNowPrice, forKey: .BuyNowPrice)
            try container.encode(isClassified, forKey: .IsClassified)
            try container.encode(id, forKey: .ListingId)
            try container.encode(isReserveMet, forKey: .IsReserveMet)
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: ListItemKeys.self)
            self.title = try values.decode(String.self, forKey: .Title)
            self.id = try values.decode(Int.self, forKey: .ListingId)
            self.region = try values.decode(String.self, forKey: .Region)
            self.pictureHref = try? values.decode(String?.self, forKey: .PictureHref) ?? nil
            let priceDispayed = try? values.decode(String?.self, forKey: .PriceDisplay) ?? nil
            self.priceDisplay = priceDispayed != nil ? "\(priceDispayed!)" : "PriceNotAvailable".localized
            self.buyNowPrice = try? values.decode(Float?.self, forKey: .BuyNowPrice) ?? nil
            self.isClassified = try? values.decode(Bool?.self, forKey: .IsClassified) ?? nil
            self.isReserveMet = try? values.decode(Bool?.self, forKey: .IsReserveMet) ?? nil
            
        }
        
    }
    
    let list: [ListItem]?
    
    init(list: [ListItem]?) {
        self.list = list
    }
    
    private enum CodingKeys: String, CodingKey {
        case List
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(list, forKey: .List)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try values.decode([ListItem]?.self, forKey: .List)
    }
}


