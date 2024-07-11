//
//  SettingsView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/10/24.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 0) {
              //MARK: - FORM
                Form{
                    //MARK: - Section 3
                    Section(header: Text("Follow me on Social Media")) {
                        FormRowLinkView(icon: "facebook-circle-fill", color: Color.pink, text: "FaceBook", link: "hhtps://facebook.com")
                        FormRowLinkView(icon: "instagram", color: Color.orange, text: "Instagram", link: "https://www.instagram.com/ferusyaa/")
                        FormRowLinkView(icon: "facebook" , color: Color.gray, text: "GitHub", link: "https://github.com/feruu")
                        FormRowLinkView(icon: "telegram", color: Color.blue, text: "Telegram", link: "https://t.me/ferusyaa")
                    }.padding(.vertical, 3)
                    //MARK: - Section 4
                    Section(header: Text("About the application")){
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Organizer")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Ferusyaa")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Ferusyaa")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "10.0.0")
                    }
                } //: Form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                //MARK: - FOOTER
                Text("Copyright © All rights reserved \nOrganize tasks with our App")
                //♥️
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
            } //: VStack
            .navigationBarItems(trailing: Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
                
            })
            
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground").ignoresSafeArea(.all))
        } //Navigation
        
    }
}
    //MARK: - PREVIEW
#Preview {
    SettingsView()
}
