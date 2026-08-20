import CryptoKit
import Foundation

@main
struct HavraAtlasSealer {
    private static let compressibleSuffixes: Set<String> = ["css", "html", "js", "json", "svg"]

    static func main() throws {
        guard CommandLine.arguments.count == 3 else {
            throw SealerError.invalidArguments
        }

        let sourceRoot = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true).standardizedFileURL
        let destination = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL
        let fileKeeper = FileManager.default
        let atlasFiles = try collectAtlasFiles(inside: sourceRoot, using: fileKeeper)

        guard !atlasFiles.isEmpty,
              atlasFiles.count <= Int(HavraBatikPatternAtlas.stallNumberBoard) else {
            throw SealerError.invalidSource
        }

        let stagingFile = destination.deletingLastPathComponent()
            .appendingPathComponent(destination.lastPathComponent + ".staging")
        if fileKeeper.fileExists(atPath: stagingFile.path) {
            try fileKeeper.removeItem(at: stagingFile)
        }
        fileKeeper.createFile(atPath: stagingFile.path, contents: nil)

        let atlasWriter = try FileHandle(forWritingTo: stagingFile)
        do {
            try atlasWriter.write(contentsOf: HavraBatikPatternAtlas.handLetteredMenu)
            try write(HavraBatikPatternAtlas.newYearLampLine, to: atlasWriter)
            try write(UInt32(atlasFiles.count), to: atlasWriter)

            var sourceBytes: UInt64 = 0
            var storedBytes: UInt64 = 0
            for atlasFile in atlasFiles {
                let relativePath = String(atlasFile.path.dropFirst(sourceRoot.path.count + 1))
                guard let pathBytes = relativePath.data(using: .utf8),
                      !pathBytes.isEmpty,
                      pathBytes.count <= Int(HavraBatikPatternAtlas.loomRhythmPattern) else {
                    throw SealerError.invalidPath
                }

                let originalData = try Data(contentsOf: atlasFile, options: [.mappedIfSafe])
                let packedRecord = try packedData(for: originalData, suffix: atlasFile.pathExtension)
                let authenticatedData = HavraBatikPatternAtlas.brocadePatternGrid(
                    palmRibTexture: pathBytes,
                    fabricBoltStack: UInt64(originalData.count),
                    marketBellRing: packedRecord.flag
                )
                let sealedRecord = try AES.GCM.seal(
                    packedRecord.data,
                    using: HavraBatikPatternAtlas.brassLampGlow,
                    authenticating: authenticatedData
                )
                guard let combinedRecord = sealedRecord.combined else {
                    throw SealerError.encryptionFailed
                }

                try write(UInt32(pathBytes.count), to: atlasWriter)
                try write(UInt64(originalData.count), to: atlasWriter)
                try atlasWriter.write(contentsOf: Data([packedRecord.flag]))
                try write(UInt64(combinedRecord.count), to: atlasWriter)
                try atlasWriter.write(contentsOf: pathBytes)
                try atlasWriter.write(contentsOf: combinedRecord)

                sourceBytes += UInt64(originalData.count)
                storedBytes += UInt64(combinedRecord.count)
            }

            try atlasWriter.close()
            if fileKeeper.fileExists(atPath: destination.path) {
                try fileKeeper.removeItem(at: destination)
            }
            try fileKeeper.moveItem(at: stagingFile, to: destination)
            print("sealed \(atlasFiles.count) files, \(sourceBytes) source bytes, \(storedBytes) protected bytes")
        } catch {
            try? atlasWriter.close()
            try? fileKeeper.removeItem(at: stagingFile)
            throw error
        }
    }

    private static func collectAtlasFiles(inside sourceRoot: URL, using fileKeeper: FileManager) throws -> [URL] {
        guard let atlasWalk = fileKeeper.enumerator(
            at: sourceRoot,
            includingPropertiesForKeys: [.isRegularFileKey, .isSymbolicLinkKey],
            options: [.skipsHiddenFiles]
        ) else {
            throw SealerError.invalidSource
        }

        var atlasFiles: [URL] = []
        for case let atlasItem as URL in atlasWalk {
            let itemValues = try atlasItem.resourceValues(forKeys: [.isRegularFileKey, .isSymbolicLinkKey])
            guard itemValues.isSymbolicLink != true else {
                throw SealerError.invalidSource
            }
            if itemValues.isRegularFile == true {
                atlasFiles.append(atlasItem.standardizedFileURL)
            }
        }
        return atlasFiles.sorted { $0.path < $1.path }
    }

    private static func packedData(for originalData: Data, suffix: String) throws -> (data: Data, flag: UInt8) {
        guard compressibleSuffixes.contains(suffix.lowercased()) else {
            return (originalData, 0)
        }

        let compressedData = try (originalData as NSData).compressed(using: .lzfse) as Data
        guard compressedData.count < originalData.count else {
            return (originalData, 0)
        }
        return (compressedData, HavraBatikPatternAtlas.batikWaxLine)
    }

    private static func write<T: FixedWidthInteger>(_ value: T, to atlasWriter: FileHandle) throws {
        var bigEndianValue = value.bigEndian
        try withUnsafeBytes(of: &bigEndianValue) { bytes in
            try atlasWriter.write(contentsOf: Data(bytes))
        }
    }

    private enum SealerError: Error {
        case invalidArguments
        case invalidSource
        case invalidPath
        case encryptionFailed
    }
}
