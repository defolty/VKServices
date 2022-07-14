//
//  TableViewCell.swift
//  VKChallenge
//
//  Created by Nikita Nesporov on 14.07.2022.
//
 
import SwiftUI

class TableViewCell: UITableViewCell {
     
    static let reuseID = "Cell"
    
    private var cellImage: UIImage? {
        get {
            return imageOfService.image
        } set {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            imageOfService.image = newValue
        }
    }
     
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
     
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
    private let imageOfService: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
     
    private let imageOfSelectCell: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.compact.right"))
        image.tintColor = .gray
        return image
    }()
     
    private  let serviceNameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    private  let serviceDescriptionLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reuseID)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Constraints
    
    func setupConstraints() {
        addSubview(cellView)
        self.selectionStyle = .none
        
        let textStack = UIStackView(arrangedSubviews: [serviceNameLbl, serviceDescriptionLbl])
        textStack.axis = .vertical
        textStack.spacing = 2
        textStack.alignment = .top
        textStack.distribution = .equalCentering
        
        let contentStack = UIStackView(arrangedSubviews: [imageOfService, textStack, imageOfSelectCell])
        cellView.addSubview(contentStack)
        contentStack.axis = .horizontal
        contentStack.spacing = 10
        contentStack.alignment = .center
        contentStack.distribution = .fillProportionally
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        imageOfService.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            contentStack.topAnchor.constraint(equalTo: cellView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            imageOfService.heightAnchor.constraint(equalToConstant: 60),
            imageOfService.widthAnchor.constraint(equalToConstant: 60),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageOfService.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageOfService.centerYAnchor),
            
            imageOfSelectCell.heightAnchor.constraint(equalToConstant: 17),
            imageOfSelectCell.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
}

extension TableViewCell {
    
    func setupCell(model: Service) {
        serviceNameLbl.text = model.name
        serviceDescriptionLbl.text = model.serviceDescription
        cellImage = UIImage()
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: model.iconURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.cellImage = UIImage(data: imageData)
            }
        }
    }
}
