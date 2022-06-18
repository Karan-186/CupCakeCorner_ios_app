//
//  Order.swift
//  Project_10_CupCake_Corner
//
//  Created by KARAN  on 18/06/22.
//

import SwiftUI

class Order: ObservableObject , Codable {
    
    enum codingKey : CodingKey {
        case type , quantity , extraFrosting , addSprinkles , name , streetAddress , city , zip
    }
    
    static let types = ["Vanilla" , "strawberry "," Chocolate ", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var validAddress : Bool {
        if name.isEmpty || city.isEmpty || zip.isEmpty || streetAddress.isEmpty || whiteCheck(name) || whiteCheck(city) || whiteCheck(zip) || whiteCheck(streetAddress)  {
            return false
        }
        return true
    }
    
    
    func whiteCheck(_ name: String) -> Bool {
    let trimmedString = name.trimmingCharacters(in: .whitespaces)
        if trimmedString.isEmpty{
            return true
        } else {
            return false
        }
    
    }

    
    var cost : Double {
        
        //2$ FOR CAKE
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost+=Double(quantity)
        }
        
        if addSprinkles{
            cost+=Double(quantity)
        }
        
        return cost
    }
    
    init(){ }
    
    func encode (to encoder : Encoder )throws {
        var container = encoder.container(keyedBy: codingKey.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(zip, forKey: .zip)
        try container.encode(city, forKey: .city)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKey.self)
        
         type = try container.decode(Int.self, forKey: .type)
         quantity = try  container.decode(Int.self, forKey: .quantity)
        
         extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
         addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
         name = try container.decode(String.self, forKey: .name)
         city = try container.decode(String.self, forKey: .city)
         streetAddress = try container.decode(String.self, forKey: .streetAddress)
         zip = try container.decode(String.self, forKey: .zip)

        
        
        
    }
}

