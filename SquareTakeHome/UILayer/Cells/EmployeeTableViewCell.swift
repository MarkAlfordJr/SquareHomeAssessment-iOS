//
//  EmployeeTableViewCell.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import UIKit
import SwiftUI

class EmployeeTableViewCell: UITableViewCell {
    static let reuseID = "EmployeeTableViewCell"
    
    //MARK: - UI Elements
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemGray6
        return image
    }()
    
    let phoneNumber: UILabel = {
       let text = UILabel()
        text.text = "phone number"
        text.textAlignment = .right
        text.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return text
    }()
    
    let email: UILabel = {
       let text = UILabel()
        text.text = "email address"
        text.textAlignment = .right
        text.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return text
    }()
    
    let team: UILabel = {
       let text = UILabel()
        text.text = "team department"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return text
    }()
    
    let fullName: UILabel = {
       let text = UILabel()
        text.text = "Hutch McCann"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return text
    }()
    
    let summary: UILabel = {
       let text = UILabel()
        text.text = "this description will soon be populated with summary of the employees"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return text
    }()
    
    let cardView = UIView()
    
    //MARK: - ViewDidLoad
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(cardView)
        setupCard()
        setupConstraints()
        contentView.backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layouts
    func setupCard() {
        cardView.backgroundColor = .systemBackground
        cardView.addSubview(profileImage)
        cardView.addSubview(phoneNumber)
        cardView.addSubview(email)
        cardView.addSubview(team)
        cardView.addSubview(fullName)
        cardView.addSubview(summary)
    }
    
    func setupConstraints() {
        // CARDVIEW
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
        cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        // PROFILE
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // PHONE AND EMAIL
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 42).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24).isActive = true
        
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 8).isActive = true
        email.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24).isActive = true
        // TEAM
        team.translatesAutoresizingMaskIntoConstraints = false
        team.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 24).isActive = true
        team.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24).isActive = true
        // FULLNAME
        fullName.translatesAutoresizingMaskIntoConstraints = false
        fullName.topAnchor.constraint(equalTo: team.bottomAnchor, constant: 8).isActive = true
        fullName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24).isActive = true
        // SUMMARY
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 16).isActive = true
        summary.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24).isActive = true
        summary.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24).isActive = true
        summary.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32).isActive = true
    }
    
    //MARK: - View Data configuration
    func setupImage(url: String) {
        profileImage.loadImageFromURL(urlString: url, placeholder: UIImage(systemName: "house"))
    }
    
    func configureCell(phoneNumber: String, email: String, teamName: String, fullName: String, summary: String) {
        self.phoneNumber.text = phoneNumber
        self.email.text = email
        self.team.text = teamName
        self.fullName.text = fullName
        self.summary.text = summary
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

