//
//  DMEventPeer.swift
//  RealmUnsetPropertiesExample
//
//  Created by Mindaugas Jucius on 12/12/2017.
//  Copyright © 2017 Mindaugas Jucius. All rights reserved.
//

import Foundation
import RealmSwift
import MultipeerConnectivity

@objcMembers
class DMEventPeer: Object {
    
    dynamic var id: Int = 0
    dynamic var fullName: String? = nil
    dynamic var isHost: Bool = false
    dynamic var isConnected: Bool = false
    dynamic var isSelf: Bool = false
    dynamic var peerIDData: Data? = nil
    
    var peerID: MCPeerID? = nil {
        didSet {
            guard let `peerID` = peerID else {
                return
            }
            peerIDData = NSKeyedArchiver.archivedData(withRootObject: peerID)
        }
    }

    override static func ignoredProperties() -> [String] {
        return ["peerID"]
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}

extension DMEventPeer {
    
    static func peer(withPeerID peerID: MCPeerID, storeAsSelf: Bool = false, storeAsHost: Bool = false) -> DMEventPeer {
        let peer = DMEventPeer()
        peer.peerID = peerID
        peer.isSelf = storeAsSelf
        peer.isHost = storeAsHost
        return peer
    }
    
    static func peer(withDisplayName displayName: String, storeAsSelf: Bool = false, storeAsHost: Bool = false) -> DMEventPeer {
        return DMEventPeer.peer(
            withPeerID: MCPeerID(displayName: displayName),
            storeAsSelf: storeAsSelf,
            storeAsHost: storeAsHost
        )
    }
}
