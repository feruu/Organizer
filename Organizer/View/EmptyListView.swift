//
//  EmptyListView.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/1/24.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - PROPERTIES
    @State private var isAnimated: Bool = false
    let images : [String] = ["illustration-no1", "illustration-no2", "illustration-no3"]
    let tips: [String] = [
        "Use your time wisely.",
        "Slow and steady wins the race.",
        "Keep it short and sweet.",
        "Put hard tasks first.",
        "Reward yourself after work.",
        "Collect tasks ahead of time.",
        "Each night schedule for tomorrow."
<<<<<<< HEAD
                          ]
=======
    ]
    
    //: THEME
    let themes : [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
>>>>>>> new-branch
    //MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack(alignment: .center,spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
<<<<<<< HEAD
=======
                    .renderingMode(.template)
>>>>>>> new-branch
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
<<<<<<< HEAD
=======
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
>>>>>>> new-branch
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                
            }//: VSTACK
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50 )
<<<<<<< HEAD
            .animation(.easeOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
=======
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) { isAnimated.toggle()
                } //: withAnimation
            }//: onAppear
>>>>>>> new-branch
        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .ignoresSafeArea(.all)
    }
}
//MARK: - PREVIEW
#Preview {
    EmptyListView()
        .environment(\.colorScheme, .dark)
}
