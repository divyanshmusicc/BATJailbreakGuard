//
//  JailbreakDetectionChecksumCheckServiceProtocol.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Protocol

/// Extends `JailbreakDetectionServiceProtocol` to support file checksum validation.
///
/// Services conforming to this protocol allow monitoring of system files by
/// verifying their SHA-256 hashes against expected values.
public protocol JailbreakDetectionChecksumCheckServiceProtocol: JailbreakDetectionServiceProtocol {
    
    /// Sets expected file checksums for validation.
    ///
    /// - Parameter checksums: A dictionary where:
    ///   - Key: Absolute file path as String
    ///   - Value: Expected SHA-256 checksum as String
    ///
    /// - Important: Setting an empty dictionary disables checksum verification.
    func setExpectedChecksums(_ checksums: [String: String])
}


