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
    static var dataFaqSetting : [FaqSectionData] = dataFaq
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


struct SettingDataFaq: Hashable, Identifiable {
    var id : Int
    var title: String
    var image: String
    var content: String
}

struct FaqSection: Hashable, Identifiable {
    var id: Int
    var title: String
}

struct FaqSectionData: Hashable, Identifiable {
    var id : Int
    var section: FaqSection
    var data: [SettingDataFaq]
}

var faqSectionCotent = [
    FaqSection(id: 1, title: "ABOUT FINEWASTE"),
    FaqSection(id: 2, title: "UPCYCLING"),
    FaqSection(id: 3, title: "CONTRIBUTION"),
    FaqSection(id: 4, title: "DELIVERY")
]

var contentFaq = [
    SettingDataFaq(id: 1, title: "What is Finewaste?", image: "", content: "FineWaste is a movement to sustain our environment by providing a platform for upcylers to connect with fellow sustainability enthusiasts or waste owner and they are able to collaborate by"),
    SettingDataFaq(id: 2,title: "Where does FineWaste get revenue?", image: "", content: ""),
    SettingDataFaq(id: 3,title: "What is Upcycle and how is upcycling helping the environment?", image: "", content: ""),
    SettingDataFaq(id: 4,title: "I’m not an upcyclers now, can I still organize my own project in the future?", image: "", content: ""),
    SettingDataFaq(id: 5,title: "How will my donation be used?", image: "", content: ""),
    SettingDataFaq(id: 6,title: "What if I only have 1 item to donate?", image: "", content: ""),
    SettingDataFaq(id: 7,title: "Do you accept worn or damaged clothing?", image: "", content: ""),
    SettingDataFaq(id: 8,title: "I would like to know if FineWaste provide a donation pick-up service?", image: "", content: "")
]

var dataFaq = [
    FaqSectionData(id: 1, section: faqSectionCotent[0], data: [
        contentFaq[0],
        contentFaq[1]
    ]),
    FaqSectionData(id: 2,section: faqSectionCotent[1], data: [
        contentFaq[2],
        contentFaq[3]
    ]),
    FaqSectionData(id: 3,section: faqSectionCotent[2], data: [
        contentFaq[4],
        contentFaq[5],
        contentFaq[6]
    ]),
    FaqSectionData(id: 4,section: faqSectionCotent[3], data: [
        contentFaq[7]
    ])
    
]
