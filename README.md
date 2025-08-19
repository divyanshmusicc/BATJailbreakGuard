<h1 align="center">BATJailbreakGuard</h1>

<p align="center"> <a href="https://www.engbaselabutaleb.com" target="_blank"> <img src="https://img.shields.io/badge/By-Basel%20AbuTaleb-black?style=for-the-badge&logo=bat&logoColor=%23303658&labelColor=E6E6E6&color=%23303658" style="margin:0;" vertical-align: middle;"> </a> </p>

<h2></h2>

  <img width="1280" height="640" alt="Image" src="https://github.com/user-attachments/assets/aede38ea-9871-4b1f-8692-b9b8037f2401" />
  


<p align="center">

  <a href="" target="_blank">
  <img src="https://img.shields.io/badge/iOS-13%2B-303658?style=for-the-badge&logo=apple&logoColor=303658&labelColor=E6E6E6" alt="iOS 13+" style="margin:0;">
</a>

<a href="" target="_blank">
  <img src="https://img.shields.io/badge/Swift-5.5+-303658?style=for-the-badge&logo=swift&logoColor=303658&labelColor=E6E6E6" alt="Swift 5.5+" style="margin:0;">
</a>

<a href="" target="_blank">
  <img src="https://img.shields.io/badge/Package-SwiftPM-303658?style=for-the-badge&logo=distrobox&logoColor=303658&labelColor=E6E6E6" alt="SwiftPM" style="margin:0;">
</a>

<a href="" target="_blank">
  <img src="https://img.shields.io/badge/Version-1.0.0-303658?style=for-the-badge&logo=veed&logoColor=303658&labelColor=E6E6E6" alt="Version 1.0.0" style="margin:0;">
</a>

<a href="https://opensource.org/licenses/MIT" target="_blank">
  <img src="https://img.shields.io/badge/License-MIT-303658?style=for-the-badge&logo=gnu&logoColor=303658&labelColor=E6E6E6" alt="MIT License" style="margin:0;">
</a>


</p>

## Disclaimer

- Jailbreak detection is performed entirely on the client side, which means it **can be bypassed, patched, or otherwise circumvented** by a determined attacker. It is not foolproof and should never be relied upon as the sole security mechanism in your app.  

- False positives are possible. For example, some **rootless jailbreaks** or certain tweaks may trigger a detection even if the device is mostly secure. Conversely, some sophisticated jailbreaks may avoid detection entirely.  

- This package provides a **first layer of protection**. It is the **developer's responsibility** to implement additional security measures, follow secure coding practices, and combine multiple detection strategies for more robust protection.  

- Always assume that client-side checks **cannot fully guarantee** device integrity. Jailbreak detection should be treated as a **supplementary measure**, rather than a complete security solution.  

- Use this package as part of a **defense-in-depth strategy**, combining it with other techniques such as code obfuscation, runtime integrity checks, encrypted communication, and proper server-side validation.  



## Table of Contents
- [About](#1-about)
- [Installation](#2-installation)
- [Jailbreak Detection Checks](#3-jailbreak-detection-checks)
  - [FilePath](#filepath)
  - [SymbolicLinks](#symboliclinks)
  - [EnvironmentVariables](#environmentvariables)
  - [DynamicLib](#dynamiclib)
  - [SandboxedEnvironment](#sandboxedenvironment)
  - [RootUser](#rootuser)
  - [OpenPorts](#openports)
  - [PreventedAPIs](#preventedapis)
  - [Checksum](#checksum)
- [Supported Versions](#4-supported-versions)
- [Contributing](#5-contributing)
- [License](#6-license)
- [Support](#7-support)



## 1. About 
**BATJailbreakGuard** is a Swift package designed to enhance security in iOS mobile applications.
It includes 9 different jailbreak detection tests.
You can run any single test, a combination of tests, or customize which checks to use, giving you full flexibility to protect your app on compromised devices.

Apple does not provide any official API for detecting jailbroken devices, so there may be false positives. It is the developer’s responsibility to combine multiple detection techniques, randomize checks, and apply additional security measures. This package represents only the first step in protecting your app, and should not be relied upon as the sole line of defense



##  2. Installation

- **Open Your Project in Xcode**
   - Launch Xcode and open the project you want to add the package to.

- **Add the Package via Swift Package Manager**
   - Go to **File > Add Packages...**
   - In the search field, paste the repository URL:  
     ```
     https://github.com/Basilabt/BATJailbreakGuard
     ```
   - Select the latest version or a specific version tag.
   - Click **Add Package** and choose your app target.

- **Import the Package in Your Code**
   - At the top of any Swift file where you want to use it:
     ```swift
     import BATJailbreakGuard
     ```

- **Use the Package**
   - You can now call the jailbreak detection functions from your code.

## 3. Jailbreak Detection Checks

| #  | Test | Description |
|----|------|-------------|
| 1  | [`FilePath`](#filepath) | Checks for jailbreak files  |
| 2  | [`SymbolicLinks`](#symboliclinks) | Finds suspicious symlinks  |
| 3  | [`EnvironmentVariables`](#environmentvariables) | Checks for jailbreak env vars  |
| 4  | [`DynamicLib`](#dynamiclib) | Scans for injected libraries  |
| 5  | [`SandboxedEnvironment`](#sandboxedenvironment) | Verifies app sandbox restrictions |
| 6  | [`RootUser`](#rootuser) | Detects root privilege escalation |
| 7  | [`OpenPorts`](#openports) | Scans for suspicious debug ports  |
| 8  | [`PreventedAPIs`](#preventedapis) | Tests dangerous OS APIs  |
| 9 | [`Checksum`](#checksum) | Validates SHA-256 hashes of system file system structure |



## FilePath


Jailbreaking an iOS device often adds certain files and directories related to the jailbreak tool or package into the iOS file system.
If any of these known suspicious paths are detected, the device is considered to be  jailbroken.

Suspicious Paths Checked:
`/var/jb`
`/Applications/Cydia.app`
`/Applications/Sileo.app`
`/Applications/Zebra.app`
`/Applications/Installer.app`
`/Applications/Undecimus.app`
`/Applications/Taurine.app`
`/Applications/Odyssey.app`
`/Applications/Chimera.app`
`/Applications/Electra.app`
`/Applications/Pangu.app`
`/Applications/Evasi0n.app`
`/Applications/redsn0w.app`
`/Applications/Absinthe.app`
`/Applications/Spirit.app`
`/Applications/Filza.app`
`/Applications/iFile.app`
`/Applications/iNalyzer.app`
`/Applications/blackra1n.app`
`/Applications/IntelliScreen.app`
`/Applications/Veency.app`
`/Library/MobileSubstrate/MobileSubstrate.dylib`
`/Library/MobileSubstrate/DynamicLibraries/LiveReload.dylib`
`/Library/MobileSubstrate/DynamicLibraries/FridaGadget.dylib`
`/usr/lib/libjailbreak.dylib`
`/usr/sbin/frida-server`
`/usr/sbin/cycript`
`/usr/bin/cycript`
`/usr/local/bin/cycript`
`/etc/apt`
`/private/var/lib/apt`
`/private/var/lib/cydia`
`/private/var/mobile/Library/SBSettings`
`/private/var/tmp/cydia.log`
`/var/cache/apt`
`/var/lib/cydia`
`/var/lib/dpkg`
`/private/var/lib/dpkg/info`
`/private/var/lib/dpkg/status`
`/var/tmp/cydia.log`
`/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist`
`/Library/LaunchDaemons/com.ikey.bbot.plist`
`/Library/LaunchDaemons/com.saurik.Cydia.SandboxReset.plist`
`/usr/lib/frida/frida-agent.dylib`
`/Library/MobileSubstrate/DynamicLibraries/CrashReporter.dylib`
`/Library/MobileSubstrate/DynamicLibraries/Filza.dylib`
`/Library/MobileSubstrate/DynamicLibraries/Activator.dylib`
`/Library/MobileSubstrate/DynamicLibraries/PreferenceLoader.dylib`
`/palera1n`
`/usr/libexec/palera1n-loader`
`/private/var/tmp/unjailbreak`
`/private/var/tmp/jailbreakd`
`/private/var/tmp/unjailbreakd`




### Usage
```swift
// MARK: - FilePath Test
func testFilePath() {
    // 1️⃣ Using generic wrapper (injection)
    let filePathService = JailbreakDetectionFilePathCheckService()
    let filePathWrapper = JailbreakDetectionService(service: filePathService)
    let isJailbreakDetectedByFilePathWrapper = filePathWrapper.isJailbreakDetected()
    
    print("[Wrapper] FilePath Test → \(isJailbreakDetectedByFilePathWrapper)")

    // 2️⃣ Using the service directly
    let directService = JailbreakDetectionFilePathCheckService()
    
    // default detection
    let isJailbreakDetectedByFilePathDefault = directService.isJailbreakDetected()
    
    // add custom paths
    directService.addSuspiciousPaths(["/Custom/Path/One", "/Custom/Path/Two"])
    let isJailbreakDetectedByFilePathAdded = directService.isJailbreakDetected()
    
    // clear and use only custom paths
    directService.clearPaths()
    directService.addSuspiciousPaths(["/Only/Custom/Path"])
    let isJailbreakDetectedByFilePathCustomOnly = directService.isJailbreakDetected()
    
    print("[Direct] FilePath Default → \(isJailbreakDetectedByFilePathDefault)")
    print("[Direct] FilePath Added → \(isJailbreakDetectedByFilePathAdded)")
    print("[Direct] FilePath CustomOnly → \(isJailbreakDetectedByFilePathCustomOnly)")
}
```




---



## SymbolicLinks
On a jailbroken iOS device, system files and directories are often modified or relocated to bypass Apple’s security restrictions. Jailbreak tools commonly replace original system paths with symbolic links pointing to new locations. This allows unauthorized apps or modified files to run outside of Apple’s sandbox. Jailbreak detection identifies this by checking for unexpected symlinks in sensitive directories or verifying that critical paths resolve correctly. Any mismatch or abnormal redirection strongly indicates a compromised device.

Checked symbolic link:

`/Applications/Cydia.app`
`/Applications/Sileo.app`
`/Applications/Zebra.app`
`/Applications/Undecimus.app`
`/Applications/Taurine.app`
`/Applications/Odyssey.app`
`/Applications/Chimera.app`
`/Applications/Electra.app`
`/Applications/Filza.app`
`/Applications/iFile.app`
`/Applications/blackra1n.app`
`/Applications/IntelliScreen.app`
`/Applications/Veency.app`
`/Library/MobileSubstrate`
`/private/var/lib/apt`
`/private/var/lib/cydia`
`/var/lib/cydia`
`/palera1n`
`/usr/libexec/palera1n-loader`


### Usage
```swift

// MARK: - SymbolicLinks Test

func testSymbolicLinks() {
    // Generic wrapper
    let service = JailbreakDetectionSymbolicLinksCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedBySymbolicLinksWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] SymbolicLinks Test → \(isJailbreakDetectedBySymbolicLinksWrapper)")
    
    // Direct usage
    let direct = JailbreakDetectionSymbolicLinksCheckService()
    let isJailbreakDetectedBySymbolicLinksDefault = direct.isJailbreakDetected()
    
    direct.addSuspiciousPaths(["/Custom/Symlink/One"])
    let isJailbreakDetectedBySymbolicLinksAdded = direct.isJailbreakDetected()
    
    direct.clearPaths()
    direct.addSuspiciousPaths(["/Only/Custom/Symlink"])
    let isJailbreakDetectedBySymbolicLinksCustomOnly = direct.isJailbreakDetected()
    
    print("[Direct] SymbolicLinks Default → \(isJailbreakDetectedBySymbolicLinksDefault)")
    print("[Direct] SymbolicLinks Added → \(isJailbreakDetectedBySymbolicLinksAdded)")
    print("[Direct] SymbolicLinks CustomOnly → \(isJailbreakDetectedBySymbolicLinksCustomOnly)")
}
```

---

## EnvironmentVariables
Jailbreak tools and tweaks often set custom environment variables in the process to inject code, bypass system restrictions, or enable debugging features. Detecting these environment variables is an effective way to identify a compromised device. This check inspects both default suspicious keys commonly associated with jailbreak tools and any user-defined keys you provide. If any of these keys exist and contain a value, the device is likely jailbroken.

Checked environment variables:

`DYLD_INSERT_LIBRARIES`       
`LD_PRELOAD`                  
`CYDIA_SUBSTRATE_VERSION`     
`SUBSTITUTE`                 
`CYDIA`                       
`TWEAKS`                      
`HOOKS`                       
`FRIDA`                       
`MOBILE_SUBSTRATE`            
`BOOTSTRAPDIR`               
`INJECTED`                    
`CYDIA_INJECTED`             


### Usage
```swift
// MARK: - SymbolicLinks Test

func testSymbolicLinks() {
    // Generic wrapper
    let service = JailbreakDetectionSymbolicLinksCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedBySymbolicLinksWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] SymbolicLinks Test → \(isJailbreakDetectedBySymbolicLinksWrapper)")
    
    // Direct usage
    let direct = JailbreakDetectionSymbolicLinksCheckService()
    let isJailbreakDetectedBySymbolicLinksDefault = direct.isJailbreakDetected()
    
    direct.addSuspiciousPaths(["/Custom/Symlink/One"])
    let isJailbreakDetectedBySymbolicLinksAdded = direct.isJailbreakDetected()
    
    direct.clearPaths()
    direct.addSuspiciousPaths(["/Only/Custom/Symlink"])
    let isJailbreakDetectedBySymbolicLinksCustomOnly = direct.isJailbreakDetected()
    
    print("[Direct] SymbolicLinks Default → \(isJailbreakDetectedBySymbolicLinksDefault)")
    print("[Direct] SymbolicLinks Added → \(isJailbreakDetectedBySymbolicLinksAdded)")
    print("[Direct] SymbolicLinks CustomOnly → \(isJailbreakDetectedBySymbolicLinksCustomOnly)")
}
```

---

## DynamicLib
On a jailbroken iOS device, attackers and jailbreak tools often inject custom dynamic libraries into running processes. These libraries can hook system calls, modify behavior, or bypass Apple security restrictions. Detecting the presence of these suspicious dynamic libraries is a strong indicator that a device is compromised.

Suspicious dynamic libraries checked:

`MobileSubstrate.dylib`
`SubstrateInserter.dylib`
`TweakInject.dylib`
`libcycript.dylib`
`FridaGadget.dylib`
`Cycript.dylib`
`libsubstrate.dylib`
`SubstrateLoader.dylib`
`Substrate.dylib`



### Usage 
```swift
func testDynamicLib() {
    // Wrapper
    let service = JailbreakDetectionDynamicLibraryCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedByDynamicLibWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] DynamicLib → \(isJailbreakDetectedByDynamicLibWrapper)")
    
    // Direct usage
    let direct = JailbreakDetectionDynamicLibraryCheckService()
    let isJailbreakDetectedByDynamicLibDefault = direct.isJailbreakDetected()
    
    direct.addSuspiciousLibraries(["CustomLib.dylib"])
    let isJailbreakDetectedByDynamicLibAdded = direct.isJailbreakDetected()
    
    direct.clearSuspiciousLibraries()
    direct.addSuspiciousLibraries(["OnlyCustomLib.dylib"])
    let isJailbreakDetectedByDynamicLibCustomOnly = direct.isJailbreakDetected()
    
    print("[Direct] DynamicLib Default → \(isJailbreakDetectedByDynamicLibDefault)")
    print("[Direct] DynamicLib Added → \(isJailbreakDetectedByDynamicLibAdded)")
    print("[Direct] DynamicLib CustomOnly → \(isJailbreakDetectedByDynamicLibCustomOnly)")
}
```

---

## SandboxedEnvironment
This test attempts to write a file outside the app sandbox. On a standard iOS device, this operation will fail due to sandbox restrictions. If the write succeeds, it indicates a sandbox violation and strongly suggests that the device is jailbroken.

### Usage 
```swift
func testSandboxedEnvironment() {
    let service = JailbreakDetectionSandboxedEnvironmentViolationService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedBySandboxWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] SandboxedEnvironment → \(isJailbreakDetectedBySandboxWrapper)")
    
    let direct = JailbreakDetectionSandboxedEnvironmentViolationService()
    let isJailbreakDetectedBySandboxDefault = direct.isJailbreakDetected()
    
    direct.changeTestPath("/private/custom_jb_test.txt")
    let isJailbreakDetectedBySandboxCustomPath = direct.isJailbreakDetected()
    
    print("[Direct] SandboxedEnvironment Default → \(isJailbreakDetectedBySandboxDefault)")
    print("[Direct] SandboxedEnvironment CustomPath → \(isJailbreakDetectedBySandboxCustomPath)")
}
```

---

## RootUser
This test checks whether the app is running as the root user (UID 0). On non-jailbroken devices, apps run with limited privileges. If the app runs as root, it strongly indicates a jailbroken or compromised environment.

### Usage 
```swift
// MARK: - RootUser Test

func testRootUser() {
    let service = JailbreakDetectionRootUserCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedByRootUserWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] RootUser → \(isJailbreakDetectedByRootUserWrapper)")
    
    let direct = JailbreakDetectionRootUserCheckService()
    let isJailbreakDetectedByRootUserDefault = direct.isJailbreakDetected()
    print("[Direct] RootUser Default → \(isJailbreakDetectedByRootUserDefault)")
}
```

---


## OpenPorts
Jailbreak tools often open local TCP ports to allow remote debugging, SSH access, or code injection (e.g., `Frida server on 27042`). By scanning known suspicious ports on localhost, this check detects compromised devices.

### Usage 
```swift
// MARK: - OpenPorts Test

func testOpenPorts() {
    let service = JailbreakDetectionSuspiciousPortsCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedByOpenPortsWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] OpenPorts → \(isJailbreakDetectedByOpenPortsWrapper)")
    
    let direct = JailbreakDetectionSuspiciousPortsCheckService()
    let isJailbreakDetectedByOpenPortsDefault = direct.isJailbreakDetected()
    
    direct.addSuspiciousPorts([1337, 4444])
    let isJailbreakDetectedByOpenPortsAdded = direct.isJailbreakDetected()
    
    direct.clearSuspiciousPorts()
    direct.addSuspiciousPorts([5555])
    let isJailbreakDetectedByOpenPortsCustomOnly = direct.isJailbreakDetected()
    
    print("[Direct] OpenPorts Default → \(isJailbreakDetectedByOpenPortsDefault)")
    print("[Direct] OpenPorts Added → \(isJailbreakDetectedByOpenPortsAdded)")
    print("[Direct] OpenPorts CustomOnly → \(isJailbreakDetectedByOpenPortsCustomOnly)")
}
```

---

## PreventedAPIs
Jailbreaks often bypass sandbox restrictions, enabling restricted APIs that should not exist in normal apps such as:
`fork`
`system`
`posix_spawn`
`dlopen`
`dlsym`

### Usage 
```swift
func testPreventedAPIs() {
    let service = JailbreakDetectionPreventedAPICheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedByPreventedAPIsWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] PreventedAPIs → \(isJailbreakDetectedByPreventedAPIsWrapper)")
    
    let direct = JailbreakDetectionPreventedAPICheckService()
    let isJailbreakDetectedByFork = direct.isForkPossible()
    let isJailbreakDetectedBySystem = direct.isSystemPossible()
    let isJailbreakDetectedByPosixSpawn = direct.isPosixSpawnPossible()
    let isJailbreakDetectedByDyldInjectable = direct.isDyldInjectable()
    
    print("[Direct] PreventedAPIs → fork: \(isJailbreakDetectedByFork), system: \(isJailbreakDetectedBySystem), posix_spawn: \(isJailbreakDetectedByPosixSpawn), dyld: \(isJailbreakDetectedByDyldInjectable)")
}
```

--- 

## Checksum
The Checksum Check verifies system file integrity by comparing SHA-256 hashes of critical files against expected values. Jailbreak tools often modify system binaries or libraries; any mismatch in checksums indicates potential tampering and a compromised device.

- Only files that are modified, missing, or unreadable on jailbroken devices should be monitored.

- Combine this check with other jailbreak detection methods for comprehensive protection.

- Ensure expected hashes are securely stored and updated per iOS version.


### Usage
```swift
// MARK: - Checksum Test

func testChecksum() {
    let service = JailbreakDetectionChecksumCheckService()
    let wrapper = JailbreakDetectionService(service: service)
    let isJailbreakDetectedByChecksumWrapper = wrapper.isJailbreakDetected()
    print("[Wrapper] Checksum → \(isJailbreakDetectedByChecksumWrapper)")
    
    let direct = JailbreakDetectionChecksumCheckService()
    direct.setExpectedChecksums([
        "/bin/bash": "expected_sha256_hash_here",
        "/usr/lib/libSystem.B.dylib": "expected_sha256_hash_here"
    ])
    let isJailbreakDetectedByChecksumDirect = direct.isJailbreakDetected()
    print("[Direct] Checksum → \(isJailbreakDetectedByChecksumDirect)")
}
```


## 4. Supported Versions
- **iOS:** 13+
- **Swift:** 5.5+
- **Swift Package Manager:** Supported

## 5. Contributing
- Contributions are welcome, including bug fixes and additional detection checks.
- Ensure any added checks do not execute dangerous APIs directly.
- Keep safety and App Store compliance in mind.
  
## 6. License
**BATJailbreakGuard** is available under the MIT License.  
See the [LICENSE](LICENSE) file for more details.


## 7. Support

For questions, feedback, or support, you can reach Basel AbuTaleb via:

- **Website:** [https://www.engbaselabutaleb.com](https://www.engbaselabutaleb.com)  
- **Email:** [baabutaleb@gmail.com](mailto:baabutaleb@gmail.com)


