//
//  ContentView.swift
//  Project_10_CupCake_Corner
//
//  Created by KARAN  on 18/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Picker("Select you cake type",selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes : \(order.quantity)",value: $order.quantity , in : 3...20)
                }
                
                Section{

                    Toggle("Any special requests?" , isOn: $order.specialRequestEnabled.animation())
                    
                    
                    
                    if order.specialRequestEnabled {
                        
                        Toggle("Add extra Frosting" , isOn: $order.extraFrosting)
                        Toggle("Add Sprinkles" , isOn: $order.addSprinkles)
                        
                        
                    }
                }
                
                Section {
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
                
            }
            .navigationTitle("Cup Cake")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
