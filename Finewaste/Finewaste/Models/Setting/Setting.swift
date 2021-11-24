//
//  Setting.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import Foundation
import SwiftUI

struct SettingSection {
    var name : String
    var item : [SettingItem]
}

struct SettingItem {
    var name : String
//    var view : View
    var view : String
}

struct SettingData {
    static let setting: [SettingSection] = [
        SettingSection(name: "", item: [
            SettingItem(name: "How We Work", view: "HowWeWorkView()"),
            SettingItem(name: "Frequently Asked Questions", view: "FaqView()")]),
        SettingSection(name: "", item: [
            SettingItem(name: "Terms of Use", view: "TermOfUseView()"),
            SettingItem(name: "Privacy Policy", view: "PrivacyPolicyView()"),
            SettingItem(name: "Contact Us", view: "ContactUsView()")]),
        SettingSection(name: "", item: [
            SettingItem(name: "Sign Out", view: "SignOutView()")
        ])
        
    ]
}

struct SettingDataChild: Hashable {
    var title: String
    var image: String
    var desc: String
}

struct SettingContent {
    static var dataUpcycler : [SettingDataChild] = contentDataUpcycler
    static var dataWasteOwner : [SettingDataChild] = contentDataWasteOwner
}

var contentDataUpcycler = [
    SettingDataChild(title: "1.Showcase Project", image: "settingUpcycler1", desc: "Create and showcase your project idea by adding project."),
    SettingDataChild(title: "2.Reach out for materials", image: "settingUpcycler2", desc: "State your needs of materials to support your goal"),
    SettingDataChild(title: "3.Spark Conversations", image: "settingUpcycler3", desc: "Chat with the waste owner to confirm the materials"),
    SettingDataChild(title: "4.Delivery Process", image: "settingUpcycler4", desc: "Track your materials delivery process through the contribution status"),
    SettingDataChild(title: "5.Update your progress", image: "settingUpcycler5", desc: "Let your contributors know the results of your projects to engage interest")
]

var contentDataWasteOwner = [
    SettingDataChild(title: "1. Look for the projects that inspire you the most", image: "settingWaste1", desc: "Create and showcase your project idea by adding project."),
    SettingDataChild(title: "2. Contribute your waste to the project owner", image: "settingWaste2", desc: "Match your used stuffs that you want to give with the materials needed by the project owner"),
    SettingDataChild(title: "3. Delivery Process", image: "settingWaste3", desc: "Track your waste delivery process through the contribution status"),
    SettingDataChild(title: "4. See Updates", image: "settingWaste4", desc: "See your contribution and project updates from the project owner")
]
