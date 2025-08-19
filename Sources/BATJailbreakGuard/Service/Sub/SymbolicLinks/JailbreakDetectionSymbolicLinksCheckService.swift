//
//  JailbreakDetectionSymbolicLinksCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


import Foundation

// MARK: - Implementation

/// Service that detects jailbreak by checking for **symbolic links** at known suspicious paths.
///
/// - Important:
///   Symbolic links at the listed suspicious paths **should never be present** on a clean iOS device.
///   If any of these paths are found to be symbolic links, it strongly indicates that the device
///   has been **tampered with or jailbroken**.
public final class JailbreakDetectionSymbolicLinksCheckService: JailbreakDetectionSymbolicLinksCheckServiceProtocol {
    
    /// Predefined list of suspicious paths that are commonly symbolic links on jailbroken devices.
    /// This includes jailbreak app directories, injected dylibs, and modified system binaries.
    private var _defaultSuspiciousPaths: [String] = [
        "/Applications/Cydia.app",
        "/Applications/Sileo.app",
        "/Applications/Zebra.app",
        "/Applications/Undecimus.app",
        "/Applications/Taurine.app",
        "/Applications/Odyssey.app",
        "/Applications/Chimera.app",
        "/Applications/Electra.app",
        "/Applications/Filza.app",
        "/Applications/iFile.app",
        "/Applications/blackra1n.app",
        "/Applications/IntelliScreen.app",
        "/Applications/Veency.app",
        "/Library/MobileSubstrate",
        "/private/var/lib/apt",
        "/private/var/lib/cydia",
        "/var/lib/cydia",
        "/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        "/Library/LaunchDaemons/com.ikey.bbot.plist",
        "/Library/LaunchDaemons/com.saurik.Cydia.SandboxReset.plist",
        "/palera1n",
        "/usr/libexec/palera1n-loader"
    ]
    
    /// User-defined suspicious paths.
    private var _userAddedPaths: [String] = []
    
    public init() {}
    
    /// Checks whether **any suspicious path** is a symbolic link.
    ///
    /// - Returns: `true` if at least one suspicious path is a symbolic link, otherwise `false`.
    public func isJailbreakDetected() -> Bool {
        
        let allPaths = self._defaultSuspiciousPaths + self._userAddedPaths
        
        for path in allPaths {
            do {
                let attributes = try FileManager.default.attributesOfItem(atPath: path)
                if let fileType = attributes[.type] as? FileAttributeType,
                   fileType == .typeSymbolicLink {
                    return true
                }
            } catch {
                // Ignore errors (e.g., file not found)
                continue
            }
        }
        return false
    }
    
    /// Adds custom suspicious paths to the symbolic link detection list.
    ///
    /// - Parameter paths: An array of absolute file paths to add.
    public func addSuspiciousPaths(_ paths: [String]) {
        self._userAddedPaths.append(contentsOf: paths)
    }
    
    /// Clears all **user-defined paths**.
    public func clearPaths() {
        self._userAddedPaths.removeAll()
    }
}
