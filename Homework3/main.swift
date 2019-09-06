//
//  main.swift
//  Homework3
//
//  Created by Ani on 9/4/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import Foundation

enum Gender: String{
    case man
    case women
}

class Employee: CustomStringConvertible {
    fileprivate static var number = 0
    var name: String
    var gender: Gender
    weak var team: Team?
    
    init(name: String, gender: Gender, team: Team?) {
        Employee.number += 1
        self.gender = gender
        self.name = name
        self.team = team
    }
    //    init(){
    //        name = ""
    //        gender = Gender.man
    //        team = Team(name: name, members: [Team.Prof.designer: [], Team.Prof.developer: [], Team.Prof.pm: []])
    //    }
    
    var description: String {
        let str = "\(name) \(gender) \(team)"
        return str
    }
    deinit {
        Employee.number -= 1
    }
}

class Team {
    fileprivate static var number = 0
    var name: String
    var members: [Prof:[Employee]]
    
    
    init(name :String, members:[Team.Prof:[Employee]]) {
        Team.number += 1
        self.name = name
        self.members = members
    }
    
    func addMember(member: Employee){
        
        switch member {
        case is Developer:
            if let _ = members[Prof.developer] {
                members[.developer]?.append(member)
                member.team = self
                break
            }
            members.updateValue([member], forKey: .developer)
            member.team = self
        case is Designer:
            if let _ = members[Prof.designer]{
                members[.designer]?.append(member)
                member.team = self
                break
            }
            members.updateValue([member], forKey: .designer)
            member.team = self
        case is ProductManager:
            if let _ = members[Prof.pm]{
                members[.pm]?.append(member)
                member.team = self
                break
            }
            members.updateValue([member], forKey: .pm)
            member.team = self
        default:
            break
        }
        
    }
    
    enum Prof{
        case designer
        case developer
        case pm
    }
    deinit {
        Team.number -= 1
    }
}

class Company {
    fileprivate static var number = 0
    var name: String
    var employees: [Employee]
    var teams: [Team]
    
    init(name: String, employees: [Employee] = [], teams: [Team] = []) {
        self.name = name
        self.employees = employees
        self.teams = teams
        Company.number += 1
    }
    
    func  register(employees: Employee, teams: Team) {
        self.employees.append(employees)
        teams.addMember(member: employees)
        
    }
    
    func createTeam(naem: String, members: [Team.Prof: [Employee]]) {
        teams.append(Team(name: naem, members:members))
    }
    
    deinit {
        Company.number -= 1
        
    }
}

class Developer: Employee {
    enum Platform: String{
        case iOS = "iOS"
        case Android = "Android"
        case Web = "Web"
        case Windows = "Windows"
        case Student = "Student"
    }
    
    var platform: Platform
    
    override init(name: String, gender: Gender, team: Team?) {
        self.platform = Platform.Student
        super.init(name: name, gender: gender, team: team)
    }
    
    init(name: String, gender: Gender, team: Team?, platform: Platform) {
        self.platform = platform
        super.init(name: name, gender: gender, team: team)
    }
    
    func develop(project: String) {
        
    }
    override var description: String {
        let str = "\(name) \(gender) \(team)"
        return str
    }
}

class Designer: Employee {
    func design(project: String) {
        
    }
    
    override init(name: String, gender: Gender, team: Team?) {
        super.init(name: name, gender: gender, team: team)
    }
    override var description: String {
        let str = "\(name) \(gender) \(team)"
        return str
    }
}

class ProductManager: Employee {
    var project: String
    
    init(name: String, gender: Gender, team: Team?, project: String = "") {
        self.project = project
        super.init(name: name, gender: gender, team: team)
    }
    func manage(project: String) {
        
    }
    override var description: String {
        let teamName = team?.name ?? ""
        let str = "\(name) \(gender) \(teamName)"
        return str
    }
}

//var team: Team! = Team(name: "Team1", members: [Team.Prof.designer: []])


//var employees = [Employee]()
//var employee1 = Employee(name: "An", gender: Gender.women, team: team)

//employees.append(employee1)



var companyPicsart: Company! = Company(name: "PicsArt")
companyPicsart.createTeam(naem: "Team1", members:[Team.Prof.designer: [], Team.Prof.developer: [], Team.Prof.pm: []])

//print(companyPicsart.teams[0].name)

companyPicsart.register(employees: Designer(name: "Anna", gender: .women, team: nil), teams: companyPicsart.teams[0])
companyPicsart.register(employees: Developer(name: "Dav", gender: .man, team: nil, platform: .Web), teams: companyPicsart.teams[0])


for emp in companyPicsart.employees {
    print(emp)
}
companyPicsart = nil
//team = nil
print(Company.number, Team.number, Employee.number)

