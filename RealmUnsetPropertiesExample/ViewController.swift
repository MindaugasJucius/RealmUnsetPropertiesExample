//
//  ViewController.swift
//  RealmUnsetPropertiesExample
//
//  Created by Mindaugas Jucius on 12/12/2017.
//  Copyright © 2017 Mindaugas Jucius. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let peer = DMEventPeer.peer(withDisplayName: UIDevice.current.name, storeAsSelf: true, storeAsHost: true)
        
        let realm = try! Realm()
        try! realm.write {
            peer.id = (realm.objects(DMEventPeer.self).max(ofProperty: "id") ?? 0) + 1
            realm.add(peer)
        }
        
        let selfPeer = realm.objects(DMEventPeer.self).filter("isSelf == true").first
        print(selfPeer)
    }

}

