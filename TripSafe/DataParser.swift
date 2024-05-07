//
//  DataParser.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-17.
//

import Foundation
import TabularData

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

