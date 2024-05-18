//
//  DataParser.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-17.
//

import Foundation
import TabularData

// REQUIRES: filename - the path of the .csv file containing country data
// EFFECTS: If successful, returns a dataframe containing the data from the .csv file, otherwise returns nil
public func parseCSV(filename: String) -> DataFrame? {
    do {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "csv")
            else { print("Unable to find csv file"); return nil }
        let options = CSVReadingOptions(hasHeaderRow: true, delimiter: ",")
        let dataframe = try DataFrame(contentsOfCSVFile: fileURL, options: options)
        return dataframe
    } catch {
        print("Failed to parse CSV")
        return nil
    }
}

