//
//  Listings.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 21/01/22.
//

import SwiftUI

struct ListingsView: View {
    @StateObject private var vm = ListingsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(vm.list) { item in
                    VStack {
                        Button(action: {
                            vm.alertContent = (title: "TappedOn", message: item.title)
                            vm.showAlert = true
                            
                        }) {
                            HStack {
                                AsyncImage(url: URL(string: item.pictureHref ?? ""),
                                           content: { image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                },
                                           placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 100)
                                })
                                
                                VStack(alignment: .leading) {
                                    let titleModel = TextModel(text: item.region, font: .footnote, weight: .regular, color: .textLight)
                                    
                                    let messageModel = TextModel(text: item.title, font: .footnote, weight: .bold, color: .textDark)
                                    
                                    VerticalTextView(titleModel: titleModel, messageModel: messageModel)
                                    
                                    Spacer()
                                    
                                    PricesView(item: item)
                                }
                                
                            }
                            .frame(maxWidth: .infinity)
                        }
                        Rectangle()
                            .fill(Color.textLight)
                            .opacity(0.3)
                            .frame(height: 1)
                            .padding(.top, 2)
                        
                    }
                    
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: vm.populateList)
        .navigationBarTitle(Text("LatestListings"))
        .toolbar {
            toolBar
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text(vm.alertContent.title.localized), message: Text(vm.alertContent.message.localized))
        }
    }
    
    @ViewBuilder
    var toolBar: some View {
        HStack {
            Button(action: {
                vm.alertContent = (title: "TrolleyTitle", message: "TrolleyMessage")
                vm.showAlert = true
                
            }) {
                Image(iconName: .trolley)
                    .renderingMode(.template)
                    .foregroundColor(.tasman)
            }
            
            Button(action: {
                vm.alertContent = (title: "SearchTitle", message: "SearchMessage")
                vm.showAlert = true
            }) {
                Image(iconName: .search)
                    .renderingMode(.template)
                    .foregroundColor(.tasman)
            }
        }
    }
}

struct Listings_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
