//
//  DictionaryProcess.swift
//  Collections
//
//  Created by Антон Заверуха on 15.07.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation

class DictionaryProcess {
    weak var dictionaryCreatedArrayDelegate: DictionaryCreatedArrayDelegate?
    weak var dictionaryProcessDidCreateDictionaryDelegate: DictionaryProcessDidCreateDictionaryDelegate?
    weak var dictionaryProcessDidCreateArrayDelegate: DictionaryProcessDidCreateArrayDelegate?
    weak var dictionaryProcessDidArrayAction: DictionaryProcessDidArrayAction?
    weak var createdDictionaryDelegate: CreatedDictionaryDelegate?
    weak var dictionaryProcessDidDictionaryAction: DictionaryProcessDidDictionaryAction?
    
    func createArray() {
        var array: [ArrayContacts] = []
            for i in 0 ..< 10_000_000 {
                array.append(ArrayContacts(name: "Name\(i)", phone: String(i)))
            }
            self.dictionaryProcessDidCreateArrayDelegate?.didCreateArray(array: array)
    }
    
    func createDictionary() {
        var dictionary: [String: String] = [:]
            for i in 0 ..< 10_000_000 {
                dictionary.updateValue(String(i), forKey: "Name\(i)")
            }
            self.dictionaryProcessDidCreateDictionaryDelegate?.didCreateDictionary(dictionary: dictionary)
    }
    
    func findTheFirstContact(mode: CellsMode, action: CellsActions) {
        guard let unwrappedCreatedArray = self.dictionaryCreatedArrayDelegate?.passCreatedArray, let unwrappedCreatedDictionary = self.createdDictionaryDelegate?.passCreatedDictionary else {
            return
        }
        
        if mode == .array {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            guard let firstContact = unwrappedCreatedArray.first(where: { $0.name == "Name0" }) else {
                return
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.dictionaryProcessDidArrayAction?.didArrayAction(arrayActionResult: firstContact, withElapsedTime: diffRounded)
        } else if mode == .dictionary {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            guard let firstContact = unwrappedCreatedDictionary["Name0"] else {
                return
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.dictionaryProcessDidDictionaryAction?.didDictionaryAction(dictionaryActionResult: firstContact, withElapsedTime: diffRounded)
        }
    }
    
    func findTheLastContact(mode: CellsMode, action: CellsActions) {
        guard let unwrappedCreatedArray = self.dictionaryCreatedArrayDelegate?.passCreatedArray, let unwrappedCreatedDictionary = self.createdDictionaryDelegate?.passCreatedDictionary else
        { return }
        
        if mode == .array {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            guard let lastContact = unwrappedCreatedArray.first(where: { $0.name == "Name9999999" }) else { return }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.dictionaryProcessDidArrayAction?.didArrayAction(arrayActionResult: lastContact, withElapsedTime: diffRounded)
        } else if mode == .dictionary {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            guard let lastContact = unwrappedCreatedDictionary["Name9999999"] else {
                return
            }
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            self.dictionaryProcessDidDictionaryAction?.didDictionaryAction(dictionaryActionResult: lastContact, withElapsedTime: diffRounded)
        }
    }
    
    func findNonExistingContact(mode: CellsMode, action: CellsActions) {
        guard let unwrappedCreatedArray = self.dictionaryCreatedArrayDelegate?.passCreatedArray, let unwrappedCreatedDictionary = self.createdDictionaryDelegate?.passCreatedDictionary else { return
        }
        
        let info = ProcessInfo.processInfo
        let begin = info.systemUptime
        
        defer {
            let diff = info.systemUptime - begin
            let diffRounded = round(diff * 1000) / 1000.0
            
            if mode == .array {
                self.dictionaryProcessDidArrayAction?.didArrayAction(arrayActionResult: ArrayContacts(name: "Non exist", phone: "Non Exist"), withElapsedTime: diffRounded)
            }
            if mode == .dictionary {
                var noExistDictionaryContact: [String: String] = [:]
                noExistDictionaryContact.updateValue("Non Exist", forKey: "Non Exist")
                self.dictionaryProcessDidDictionaryAction?.didDictionaryAction(dictionaryActionResult: "Non Exist", withElapsedTime: diffRounded)
            }
        }
        if mode == .array {
            guard unwrappedCreatedArray.first(where: { $0.name == "NameFive" }) != nil else {
                return
            }
        }
        if mode == .dictionary {
            guard unwrappedCreatedDictionary["NameFive"] != nil else {
                return
            }
        }
    }
}

