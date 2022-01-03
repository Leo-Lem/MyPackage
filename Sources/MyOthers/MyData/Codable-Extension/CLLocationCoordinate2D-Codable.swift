//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 02.01.22.
//

import CoreLocation

extension CLLocationCoordinate2D: Codable {
    private enum CodingKeys: CodingKey {
        case longitude, latitude
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(longitude, forKey: .longitude)
            try container.encode(latitude, forKey: .latitude)
        } catch {
            print("#####Encoding coordinates failed: \(error)")
        }
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
            self.latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        } catch {
            print("#####Decoding coordinates failed:\n\(error)")
        }
    }
}
