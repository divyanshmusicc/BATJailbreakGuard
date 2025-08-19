//
//  JailbreakDetectionDynamicLibraryCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Implementation

import Foundation
import os

/// Service responsible for detecting jailbreak by checking suspicious dynamic libraries
/// loaded in the current process.
///
/// This service inspects the dynamic libraries loaded by the application and compares them
/// to a predefined list of known jailbreak-related libraries. If any of these libraries
/// are present, it indicates a compromised device.
///
/// Conforms to `JailbreakDetectionDynamicLibraryCheckServiceProtocol`.
public final class JailbreakDetectionDynamicLibraryCheckService: JailbreakDetectionDynamicLibraryCheckServiceProtocol {
    
    /// Known suspicious dynamic libraries that only exist on jailbroken devices.
    private var _defaultSuspiciousLibraries: [String] = [
        "MobileSubstrate.dylib",
        "SubstrateInserter.dylib",
        "TweakInject.dylib",
        "libcycript.dylib",
        "FridaGadget.dylib",
        "Cycript.dylib",
        "libsubstrate.dylib",
        "SubstrateLoader.dylib",
        "Substrate.dylib"
    ]
    
    /// User-added dynamic libraries to check.
    private var _userAddedLibraries: [String] = []
    
    public init() {}
    
    /// Checks if any suspicious dynamic libraries are loaded in the current process.
    ///
    /// Combines default and user-added libraries and scans all loaded images
    /// in the process. Returns `true` if any suspicious library is found.
    ///
    /// - Returns: `true` if a suspicious dynamic library is detected; otherwise `false`.
    public func isJailbreakDetected() -> Bool {
        let librariesToCheck = self._defaultSuspiciousLibraries + self._userAddedLibraries
        let count = _dyld_image_count()
        
        for i in 0..<count {
            if let cName = _dyld_get_image_name(i),
               let name = String(validatingCString: cName) {
                for suspiciousLib in librariesToCheck {
                    if name.localizedCaseInsensitiveContains(suspiciousLib) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    /// Adds custom suspicious dynamic library names to check.
    ///
    /// - Parameter libraries: Array of library name substrings to detect.
    public func addSuspiciousLibraries(_ libraries: [String]) {
        self._userAddedLibraries.append(contentsOf: libraries)
    }
    
    /// Clears all user-added dynamic libraries from the detection list.
    ///
    /// **Important:** After calling this method, `isJailbreakDetected()` will
    /// only check the default built-in suspicious libraries.
    public func clearSuspiciousLibraries() {
        self._userAddedLibraries.removeAll()
    }
}
