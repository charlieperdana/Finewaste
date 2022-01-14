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
    var content: [String]
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

let faqData1a = "FineWaste is a movement to sustain our environment by providing a platform for upcylers to connect with fellow sustainability enthusiasts or waste owner and they are able to collaborate by contributing"
let faqData1b = " and exchanging materials or publish their upcycle works for better presence within the community. We hope that FineWaste can help make an impact towards the circular economy goals."
let faqData2a = "FineWaste is a non-profit movement. We don’t collect any revenues from the whole process, our mission is to connect each person involved in the upcycling process so that upcyclers will "
let faqData2b = "be able to source more materials better and waste owner be able to give their used clothes to the right person/community that really needs it."
let faqData3a = "Upcycling, also known as creative reuse, is the process of transforming by-products, waste materials, useless, or unwanted products into new materials or products perceived to be of greater quality, such as artistic value or environmental value. "
let faqData3b = "Upcycle no need to go through industrial processes that requires collection of certain quantity and needing special machinery to breakdown the material. "
let faqData3c = "Thus, upcycle can be done by everyone to explore the waste and repurpose them into a new product without breaking them down into the basic material."
let faqData4a = "Of course yes! In the future if you are interested to start your own project, you can easily add your new project by tapping the plus button in the upper right part of the project page. "
let faqData4b = "Even though you have less or no experience in upcycling, we encourage everyone to upcycle and start small always a good idea :D"
let faqData5a = "It really depends on the project you chose to contribute to. As a user, you have the full right to donate your used clothes to the project that inspire or you like most. "
let faqData5b = "You will be able contact the project owner via our chat feature as well if there are still queries after you read the project details."
let faqData6a = "It doesn’t matter whether you only contribute one item or tons of items! Any contribution is still a contribution. Also, you can choose the project on your own and you may match your"
let faqData6b = " waste with the project owners’ needs. What really count is the will to support the sustainable environment and upcycling movement."
let faqData7a = "It may depend on the project you chose to contribute to. We can’t really assure all requirements are the same among projects. Project owners are able to define their own requirement and condition of materials they would like to accept. "
let faqData7b = "But worry not! Some of the projects really accept the used clothes in any forms be it good or damaged condition, you can contribute to those projects."
let faqData8a = "Currently FineWaste is not providing logistic services. We provide the options to drop off by the project owner location or the project owner will pick your waste at your place. "
let faqData8b = "But it may varies between one project to another, you can check the delivery option on each page of the project detail pages."
let faqData8c = " All logistics matter will be done between the project owners or the waste owners. You may want to contact the project owner or waste owner that want to contribute to confirm how they can help with the logistics."

var contentFaq = [
    SettingDataFaq(id: 1, title: "What is Finewaste?", image: "", content: [faqData1a+faqData1b]),
    SettingDataFaq(id: 2,title: "Where does FineWaste get revenue?", image: "", content: [faqData2a+faqData2b]),
    SettingDataFaq(id: 3,title: "What is Upcycle and how is upcycling helping the environment?", image: "", content: [faqData3a+faqData3b+faqData3c]),
    SettingDataFaq(id: 4,title: "I’m not an upcyclers now, can I still organize my own project in the future?", image: "", content: [faqData4a+faqData4b]),
    SettingDataFaq(id: 5,title: "How will my donation be used?", image: "", content: [faqData5a+faqData5b]),
    SettingDataFaq(id: 6,title: "What if I only have 1 item to donate?", image: "", content: [faqData6a+faqData6b]),
    SettingDataFaq(id: 7,title: "Do you accept worn or damaged clothing?", image: "", content: [faqData7a+faqData7b]),
    SettingDataFaq(id: 8,title: "I would like to know if FineWaste provide a donation pick-up service?", image: "", content: [faqData8a+faqData8b+faqData8c])
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
