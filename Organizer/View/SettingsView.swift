import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var isThemeChanged: Bool = false
    // THEME
    let themes : [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    //MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                //MARK: - FORM
                Form {
                    //MARK: - Section 1
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundStyle(Color.primary)
                            } .frame(width: 44, height: 44)
                            //: ZSTACK
                            
                            Text("App Icons".uppercased())
                                .fontWeight(.bold)
                                .foregroundStyle(Color.primary)
                        }//: LABEL  HStack
                        )
                        {
                            ForEach(iconSettings.iconNames.indices, id: \.self) { index in
                                HStack {
                                    //                                    Image (uiImage: UIImage(named: iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                    //                                        .renderingMode(.original)
                                    //                                        .resizable()
                                    //                                        .scaledToFit()
                                    //                                        .frame(width: 44, height: 44)
                                    //                                        .cornerRadius(8)
                                    Spacer().frame(width: 8)
                                    Text(self.iconSettings.iconNames[index ] ?? "Blue")
                                        .frame(alignment: .leading )
                                } //: HStack
                            } //: Loop
                        } //: Picker
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in if let error = error {
                                    print(error.localizedDescription)
                                }
                                    else {
                                        print("Success! You have changed the app icon.")
                                    }
                                }
                            }
                            
                        }//: onreceive
                    } //: Section 1
                    .padding(.vertical, 3)
                    //MARK: - Section 2
                    Section(header:
                      HStack {
                        Text("Choose the app theme")
                        Image(systemName: "circle.fill")
                          .resizable()
                          .frame(width: 10, height: 10)
                          .foregroundColor(themes[self.theme.themeSettings].themeColor)
                      }
                    ) {
                      List {
                        ForEach(themes, id: \.id) { item in
                          Button(action: {
                            self.theme.themeSettings = item.id
                            UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                            self.isThemeChanged.toggle()
                          }) {
                            HStack {
                              Image(systemName: "circle.fill")
                                .foregroundColor(item.themeColor)
                              
                              Text(item.themeName)
                            }
                          } //: BUTTON
                            .accentColor(Color.primary)
                        }
                      }
                    } //: SECTION 2
                      .padding(.vertical, 3)
                      .alert(isPresented: $isThemeChanged) {
                        Alert(
                          title: Text("SUCCESS!"),
                          message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName)!"),
                          dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    //MARK: - Section 3
                    Section(header: Text("Follow me on Social Media")) {
                        FormRowLinkView(icon: "facebook-circle-fill", color: Color.pink, text: "FaceBook", link: "https://facebook.com")
                        FormRowLinkView(icon: "instagram", color: Color.orange, text: "Instagram", link: "https://www.instagram.com/ferusyaa/")
                        FormRowLinkView(icon: "github", color: Color.gray, text: "GitHub", link: "https://github.com/feruu")
                        FormRowLinkView(icon: "telegram", color: Color.blue, text: "Telegram", link: "https://t.me/ferusyaa")
                    } //: Section 3
                    .padding(.vertical, 3)
                    
                    //MARK: - Section 4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Organizer")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Ferusyaa")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Ferusyaa")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "10.0.0")
                    } //: Section 4
                } //: Form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - FOOTER
                Text("Copyright © All rights reserved \nOrganize tasks with our App")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
            } //: VStack
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground").ignoresSafeArea(.all))
        } //Navigation
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//MARK: - PREVIEW
#Preview {
    SettingsView().environmentObject(IconNames())
}
