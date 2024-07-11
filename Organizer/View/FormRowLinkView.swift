//
//  FormRowLinkView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/10/24.
//

import SwiftUI

struct FormRowLinkView: View {
    //MARK: - Section PROPERTIES
    var icon : String
    var color : Color
    var text : String
    var link : String
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.white)
            }//: ZStack
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text).foregroundStyle(Color.gray)
            Spacer()
            Button(action: {
                //OPEN a LINK
                guard let url = URL(string: self.link),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }){
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .tint(Color(.systemGray2))
        }//: HStack
    }
}
//MARK: - PREVIEW
#Preview {
    FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "hhtps://google.com")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
