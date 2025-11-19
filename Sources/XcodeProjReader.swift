//
//  XcodeProjReader.swift
//  OrphansFinder
//
//  Created by Nikita Koruts on 19.11.2025.
//

import Foundation
import XcodeProj

struct XcodeProjReader {
    static func collectReferencedSwiftFiles(projectURL: String, sourceRoot: String) -> [URL] {
        guard let proj = try? XcodeProj(pathString: projectURL) else { return [] }
        return proj.pbxproj.fileReferences.compactMap {
            guard let path = $0.path else { return nil }
            let urlPath = URL(fileURLWithPath: path)
            guard shouldProcessFileExtension(urlPath.pathExtension),
                  let fullPath: String = try? $0.fullPath(sourceRoot: sourceRoot)
            else { return nil }
            return URL(fileURLWithPath: fullPath)
        }
    }
}
