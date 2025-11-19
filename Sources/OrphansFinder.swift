// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main struct OrphansFinder {
    
    static func main() {
        print("Enter the .xcodeproj path:")
        guard let path = readLine(), !path.isEmpty else {
            print("Path not entered. Finished.")
            exit(1)
        }
        
        let xcodeProjPath = URL(fileURLWithPath: path)
        let sourcePath = xcodeProjPath.deletingLastPathComponent()
        let filePaths = FilesReader().readFromDirectory(path: sourcePath)
        let xcodePaths = XcodeProjReader.collectReferencedSwiftFiles(
            projectURL: path,
            sourceRoot: sourcePath.path()
        )
        let orphanedFiles = findOrphanedFiles(diskFiles: filePaths, xcodeFiles: xcodePaths)
        print(orphanedFiles)
    }
    
   private static func findOrphanedFiles(diskFiles: [URL], xcodeFiles: [URL]) -> [URL] {
        let diskSet = Set(diskFiles.map { $0.standardizedFileURL })
        let projSet = Set(xcodeFiles.map { $0.standardizedFileURL })
        return Array(diskSet.subtracting(projSet))
    }
}

func shouldProcessFileExtension(_ fileExtension: String) -> Bool {
    return fileExtension == "swift" || fileExtension == "xib" || fileExtension == "storyboard"
}
