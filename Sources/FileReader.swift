//
//  FilesReader.swift
//  OrphansFinder
//
//  Created by Nikita Koruts on 19.11.2025.
//

import Foundation

struct FilesReader {
    func readFromDirectory(path: URL) -> [URL] {
        guard FileManager.default.fileExists(atPath: path.path()) else { return [] }
        guard let executor = FileManager.default.enumerator(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) else { return [] }
        return executor.compactMap {
            guard let fileURL = $0 as? URL, shouldProcessFileExtension(fileURL.pathExtension) else { return nil }
            return fileURL
        }
    }
}
