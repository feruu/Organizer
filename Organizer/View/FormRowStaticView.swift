//
//  FormRowStaticView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/10/24.
//

import SwiftUI

struct FormRowStaticView: View {
    //MARK: - PROPERTIES
    var icon: String
    var firstText: String
    var secondText: String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundStyle(Color.white)
            }//ZStack
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText).foregroundStyle(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}
//MARK: - PREVIEW
#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Organizer")
    
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
