import AppKit
import ScriptingBridge

@objc public protocol SBObjectProtocol: NSObjectProtocol {
    func get() -> AnyObject!
}

@objc public protocol SBApplicationProtocol: SBObjectProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
    var running: Bool { @objc(isRunning) get }
}

// MARK: SystemPreferencesSaveOptions
@objc public enum SystemPreferencesSaveOptions : AEKeyword {
    case Yes = 0x79657320 /* 'yes ' */
    case No = 0x6e6f2020 /* 'no  ' */
    case Ask = 0x61736b20 /* 'ask ' */
}

// MARK: SystemPreferencesPrintingErrorHandling
@objc public enum SystemPreferencesPrintingErrorHandling : AEKeyword {
    case Standard = 0x6c777374 /* 'lwst' */
    case Detailed = 0x6c776474 /* 'lwdt' */
}

// MARK: SystemPreferencesGenericMethods
@objc public protocol SystemPreferencesGenericMethods {
    @objc optional func closeSaving(saving: SystemPreferencesSaveOptions, savingIn: NSURL!) // Close a document.
    @objc optional func printWithProperties(withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
}

// MARK: SystemPreferencesApplication
@objc public protocol SystemPreferencesApplication: SBApplicationProtocol {
    @objc optional func documents() -> SBElementArray
    @objc optional func windows() -> SBElementArray
    @objc optional var name: String { get } // The name of the application.
    @objc optional var frontmost: Bool { get } // Is this the active application?
    @objc optional var version: String { get } // The version number of the application.
    @objc optional func open(x: AnyObject!) -> AnyObject // Open a document.
    @objc optional func print(x: AnyObject!, withProperties: [NSObject : AnyObject]!, printDialog: Bool) // Print a document.
    @objc optional func quitSaving(saving: SystemPreferencesSaveOptions) // Quit the application.
    @objc optional func exists(x: AnyObject!) -> Bool // Verify that an object exists.
    @objc optional func panes() -> SBElementArray
    @objc optional var currentPane: SystemPreferencesPane { get } // the currently selected pane
    @objc optional var preferencesWindow: SystemPreferencesWindow { get } // the main preferences window
    @objc optional var showAll: Bool { get } // Is SystemPrefs in show all view. (Setting to false will do nothing)
    @objc optional func setCurrentPane(currentPane: SystemPreferencesPane!) // the currently selected pane
    @objc optional func setShowAll(showAll: Bool) // Is SystemPrefs in show all view. (Setting to false will do nothing)
}
extension SBApplication: SystemPreferencesApplication {}

// MARK: SystemPreferencesDocument
@objc public protocol SystemPreferencesDocument: SBObjectProtocol, SystemPreferencesGenericMethods {
    @objc optional var name: String { get } // Its name.
    @objc optional var modified: Bool { get } // Has it been modified since the last save?
    @objc optional var file: NSURL { get } // Its location on disk, if it has one.
}
extension SBObject: SystemPreferencesDocument {}

// MARK: SystemPreferencesWindow
@objc public protocol SystemPreferencesWindow: SBObjectProtocol, SystemPreferencesGenericMethods {
    @objc optional var name: String { get } // The title of the window.
    @objc optional func id() -> Int // The unique identifier of the window.
    @objc optional var index: Int { get } // The index of the window, ordered front to back.
    @objc optional var bounds: NSRect { get } // The bounding rectangle of the window.
    @objc optional var closeable: Bool { get } // Does the window have a close button?
    @objc optional var miniaturizable: Bool { get } // Does the window have a minimize button?
    @objc optional var miniaturized: Bool { get } // Is the window minimized right now?
    @objc optional var resizable: Bool { get } // Can the window be resized?
    @objc optional var visible: Bool { get } // Is the window visible right now?
    @objc optional var zoomable: Bool { get } // Does the window have a zoom button?
    @objc optional var zoomed: Bool { get } // Is the window zoomed right now?
    @objc optional var document: SystemPreferencesDocument { get } // The document whose contents are displayed in the window.
    @objc optional func setIndex(index: Int) // The index of the window, ordered front to back.
    @objc optional func setBounds(bounds: NSRect) // The bounding rectangle of the window.
    @objc optional func setMiniaturized(miniaturized: Bool) // Is the window minimized right now?
    @objc optional func setVisible(visible: Bool) // Is the window visible right now?
    @objc optional func setZoomed(zoomed: Bool) // Is the window zoomed right now?
}
extension SBObject: SystemPreferencesWindow {}

// MARK: SystemPreferencesPane
@objc public protocol SystemPreferencesPane: SBObjectProtocol, SystemPreferencesGenericMethods {
    @objc optional func anchors() -> SBElementArray
    @objc optional func id() -> String // locale independent name of the preference pane; can refer to a pane using the expression: pane id "<name>"
    @objc optional var localizedName: String { get } // localized name of the preference pane
    @objc optional var name: String { get } // name of the preference pane as it appears in the title bar; can refer to a pane using the expression: pane "<name>"
    @objc optional func reveal() -> AnyObject // Reveals an anchor within a preference pane or preference pane itself
    @objc optional func authorize() -> SystemPreferencesPane // Prompt authorization for given preference pane
}
extension SBObject: SystemPreferencesPane {}

// MARK: SystemPreferencesAnchor
@objc public protocol SystemPreferencesAnchor: SBObjectProtocol, SystemPreferencesGenericMethods {
    @objc optional var name: String { get } // name of the anchor within a preference pane
    @objc optional func reveal() -> AnyObject // Reveals an anchor within a preference pane or preference pane itself
}
extension SBObject: SystemPreferencesAnchor {}

