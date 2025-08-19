//
//  JailbreakPathCheckService.swift
//  BATJailbreakGuard
//
//  Created by Basel AbuTaleb on 13/08/2025.
//


// MARK: - Implementation

import Foundation


/// Service responsible for detecting jailbreak by checking suspicious file paths.
///
/// This service works by checking if there are any common jailbreak related files
/// or tweaks directories existing on the Apple device file system.
///
/// Conforms to `JailbreakDetectionFilePathCheckServiceProtocol`.
public final class JailbreakDetectionFilePathCheckService: JailbreakDetectionFilePathCheckServiceProtocol {
    
    private var _defaultSuspiciousPaths: [String] = [
        "/var/jb" ,
        "/Applications/Cydia.app",
        "/Applications/Sileo.app",
        "/Applications/Zebra.app",
        "/Applications/Installer.app",
        "/Applications/Undecimus.app",
        "/Applications/Taurine.app",
        "/Applications/Odyssey.app",
        "/Applications/Chimera.app",
        "/Applications/Electra.app",
        "/Applications/Pangu.app",
        "/Applications/Evasi0n.app",
        "/Applications/redsn0w.app",
        "/Applications/Absinthe.app",
        "/Applications/Spirit.app",
        "/Applications/Filza.app",
        "/Applications/iFile.app",
        "/Applications/iNalyzer.app",
        "/Applications/blackra1n.app",
        "/Applications/IntelliScreen.app",
        "/Applications/Veency.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/LiveReload.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/FridaGadget.dylib",
        "/usr/lib/libjailbreak.dylib",
        "/usr/sbin/frida-server",
        "/usr/sbin/cycript",
        "/usr/bin/cycript",
        "/usr/local/bin/cycript",
        "/etc/apt",
        "/private/var/lib/apt",
        "/private/var/lib/cydia",
        "/private/var/mobile/Library/SBSettings",
        "/private/var/tmp/cydia.log",
        "/var/cache/apt",
        "/var/lib/cydia",
        "/var/lib/dpkg",
        "/private/var/lib/dpkg/info",
        "/private/var/lib/dpkg/status",
        "/var/tmp/cydia.log",
        "/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        "/Library/LaunchDaemons/com.ikey.bbot.plist",
        "/Library/LaunchDaemons/com.saurik.Cydia.SandboxReset.plist",
        "/usr/lib/frida/frida-agent.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/CrashReporter.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/Filza.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/Activator.dylib",
        "/Library/MobileSubstrate/DynamicLibraries/PreferenceLoader.dylib",
        "/palera1n",
        "/usr/libexec/palera1n-loader",
        "/private/var/tmp/unjailbreak",
        "/private/var/tmp/jailbreakd",
        "/private/var/tmp/unjailbreakd"
        
    ]
    
    /// Stores user added suspicious file paths.
    private var _userAddedPaths: [String] = []
    
    public init() {}
    
    /// Loops through a predefined list of jailbreak-related file paths and returns true if any exist on the device, otherwise returns false.
    ///
    /// - Returns: `true` if a suspicious jailbreak file or directory is found; otherwise, `false`.
    public func isJailbreakDetected() -> Bool {
        let allPaths = self._defaultSuspiciousPaths + self._userAddedPaths
        return allPaths.contains { FileManager.default.fileExists(atPath: $0) }
    }
    
    /// Adds additional suspicious file paths to the detection list.
    ///
    /// This method allows users to provide custom file paths that should be
    /// checked during the jailbreak detection process. These paths will be
    /// combined with the default known suspicious paths.
    ///
    /// - Parameter paths: An array of string paths representing suspicious files or directories.
    public func addSuspiciousPaths(_ paths: [String]) -> Void {
        self._userAddedPaths.append(contentsOf: paths)
    }
    
    
    /// Removes all default suspicious file paths from the detection list.
       ///
       /// This method clears the built-in `_defaultSuspiciousPaths` array, leaving
       /// only any user-defined paths that were added via `addSuspiciousPaths(_:)`.
       ///
       /// **Important:**
       /// - After calling this method, `isJailbreakDetected()` will **only** check
       ///   user-added paths for jailbreak detection.
       /// - Use this when you want to completely override the built-in detection list
       ///   and rely solely on custom paths provided at runtime.
       ///
       public func clearPaths() -> Void {
           self._defaultSuspiciousPaths.removeAll()
       }
}






