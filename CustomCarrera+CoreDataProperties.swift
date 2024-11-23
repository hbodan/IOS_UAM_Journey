//
//  CustomCarrera+CoreDataProperties.swift
//  UAMJourney
//
//  Created by Carlos Eduardo Gurdian on 23/11/24.
//
//

import Foundation
import CoreData


extension CustomCarrera {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomCarrera> {
        return NSFetchRequest<CustomCarrera>(entityName: "CustomCarrera")
    }

    @NSManaged public var departamento: String?
    @NSManaged public var descripcion: String?
    @NSManaged public var imagen: Data?
    @NSManaged public var masInformacion: String?
    @NSManaged public var nombre: String?
    @NSManaged public var oportunidadesLaborales: String?
    @NSManaged public var perfilEgresado: String?
    @NSManaged public var planEstudios: String?
    @NSManaged public var requisitosIngreso: String?

}

extension CustomCarrera : Identifiable {

}
