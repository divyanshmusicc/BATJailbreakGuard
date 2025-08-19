//
//  JailbreakDetectionChecksumCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


import Foundation
import CryptoKit
import CommonCrypto

/// Detects jailbreaks by verifying SHA-256 checksums of system files.
///
/// This service compares the actual hash of each monitored file against its expected value.
/// Any mismatch, missing file, or unreadable file indicates a potential jailbreak.
public final class JailbreakDetectionChecksumCheckService: JailbreakDetectionChecksumCheckServiceProtocol {
    
    /// Mapping of monitored file paths to expected SHA-256 checksums.
    private var _expectedChecksums: [String: String] = [:]
    
    public init() {}
    
    /// Checks file integrity to detect jailbreak.
    ///
    /// - Returns: `true` if any monitored file:
    ///   - Is missing
    ///   - Cannot be read
    ///   - Does not match the expected SHA-256 checksum
    public func isJailbreakDetected() -> Bool {
        for (filePath, expectedHash) in _expectedChecksums {
            guard FileManager.default.fileExists(atPath: filePath) else { return true }
            guard let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return true }
            let actualHash = _sha256(fileData)
            if actualHash != expectedHash { return true }
        }
        return false
    }
    
    /// Configures files and their expected checksums.
    ///
    /// - Parameter checksums: Dictionary of file paths and expected SHA-256 hashes.
    public func setExpectedChecksums(_ checksums: [String: String]) {
        self._expectedChecksums = checksums
    }
    
    /// Computes SHA-256 hash for given data.
    private func _sha256(_ data: Data) -> String {
        if #available(iOS 13.0, *) {
            let hash = SHA256.hash(data: data)
            return hash.map { String(format: "%02x", $0) }.joined()
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            data.withUnsafeBytes { _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &digest) }
            return digest.map { String(format: "%02x", $0) }.joined()
        }
    }
}
