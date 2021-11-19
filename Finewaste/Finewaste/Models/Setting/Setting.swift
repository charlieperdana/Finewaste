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
