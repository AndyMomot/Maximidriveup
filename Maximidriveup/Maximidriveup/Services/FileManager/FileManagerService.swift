//
//  FileManagerService.swift
//
//  Created by Andrii Momot on 06.03.2024.
//

import Foundation

struct FileManagerService {
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func saveFile(data: Data, forKey key: Key) {
        do {
            let fileURL = getFileURL(forKey: key.path)
            try data.write(to: fileURL)
            print("Did save file to: \(fileURL.absoluteString)")
        } catch {
            print("Error saving file: \(error)")
        }
    }
    
    func getFile(forKey key: Key) -> Data? {
        do {
            let fileURL = getFileURL(forKey: key.path)
            let isFileExists = fileManager.fileExists(atPath: fileURL.path)
            
            if isFileExists {
                let data = try Data(contentsOf: fileURL)
                return data
            } else {
                print("File does not exist for key: \(key.path)")
                return nil
            }
        } catch {
            print("Error retrieving file: \(error)")
            return nil
        }
    }
    
    func removeFile(forKey key: Key) -> Bool {
        do {
            let fileURL = getFileURL(forKey: key.path)
            try fileManager.removeItem(at: fileURL)
            print("File removed successfully for key: \(key.path)")
            return true
        } catch {
            print("Error removing file: \(key.path)")
            return false
        }
    }
    
    private func getFileURL(forKey key: String) -> URL {
        return documentsDirectory.appendingPathComponent("\(key).dat")
    }
    
    func removeAll() {
        for key in FileManagerService.Key.allCases {
            let result = removeFile(forKey: key)
            print("Did remove file: \(key.path) status \(result)")
        }
    }
}

extension FileManagerService {
    enum Key: CaseIterable {
        case profileIcon
        
        var path: String {
            switch self {
            case .profileIcon:
                return "profileIcon"
            }
        }
    }
}
