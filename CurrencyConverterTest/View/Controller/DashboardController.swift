//
//  DashboardController.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class DashboardController : UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, GetChartData, SelectedFromDelegate, UITextFieldDelegate{
    
    var fromIsSelected = false
    var selectedCountry : RatesModel?
    var delegate : SelectedFromDelegate?
    
    var dateData = [String]()
    
    var currencyRate = [Double]()
    
    var items: [RatesModel] = []
    //Load this particular view into the memory
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set background color to white
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViews()
        initData()
    }
    
    
    //Add all the views I will be using, as well as define their constraints.
    func initViews(){
        view.addSubview(signUpLabel)
        view.addSubview(iconView)
        view.addSubview(scrollView)
        view.addSubview(collectionView)
        
        
        collectionView.isHidden = true
        
        view.addConstraint(NSLayoutConstraint(item: signUpLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: signUpLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15))
        
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15))
        
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_menu")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.textAlignment = .left
        label.textColor = .primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var collectionView : DynamicCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 4
        let collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CountryListCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return collectionView
    }()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        scrollView.addSubview(generalStackView)
        scrollView.tag = 19200
        
        generalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        generalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        generalStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        generalStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.80).isActive = true
        return scrollView
    }()
    lazy var generalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(currencyInfoLabel)
        stackView.addArrangedSubview(firstCurrencyField)
        stackView.addArrangedSubview(secondCurrencyField)
        stackView.addArrangedSubview(currencyTypeStackView)
        stackView.addArrangedSubview(convertButton)
        stackView.addArrangedSubview(exchangeRateUpdateLabel)
        
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 300))
        stackView.addArrangedSubview(lineChart)
        lineChart.layer.cornerRadius = 10
        lineChart.delegate = self
        
        lineChart.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        currencyInfoLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        currencyInfoLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        firstCurrencyField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        secondCurrencyField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        currencyTypeStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        convertButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        exchangeRateUpdateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        return stackView
    }()
    
    lazy var currencyTypeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(fromCountryCurrencyLabel)
        stackView.addArrangedSubview(arrowImage)
        stackView.addArrangedSubview(toCountryCurrencyLabel)
        
        fromCountryCurrencyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        toCountryCurrencyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        fromCountryCurrencyLabel.isUserInteractionEnabled = true
        fromCountryCurrencyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFromTapped)))
        
        toCountryCurrencyLabel.isUserInteractionEnabled = true
        toCountryCurrencyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onToTapped)))
        
        return stackView
    }()
    
    lazy var currencyInfoLabel: UILabel = {
        let label = UILabel()
        let stringValue = "Currency\nCalculator."
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColor(color: #colorLiteral(red: 0, green: 0.4799637198, blue: 0.9984303117, alpha: 1), forText: "Currency\nCalculator")
        attributedString.setColor(color: UIColor.primaryColor, forText: ".")
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.attributedText = attributedString
        return label
    }()
    
    lazy var currencyInfoLabel1: UILabel = {
        let label = UILabel()
        label.text = "Currency\nCalculator."
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0.4596363902, blue: 0.9990459085, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var firstCurrencyField : CustomTextField = {
        let field = CustomTextField.create(title: "", placeholder: "")
        field.keyboardType = .decimalPad
        field.delegate = self
        return field
    }()
    
    lazy var firstCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "EUR."
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var secondCurrencyField : CustomTextField = {
        let field = CustomTextField.create(title: "", placeholder: "")
        field.keyboardType = .decimalPad
        field.delegate = self
        return field
    }()
    
    lazy var secondCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "EUR."
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var fromCountryCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "  ".flag(country: "EUR") + "EUR    ▼"
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_direction")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    lazy var toCountryCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "  ".flag(country: "PLN") + "PLN    ▼"
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    let convertButton : UIButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.setTitle("Convert", for: UIControl.State());
        button.setBackgroundColor(UIColor.primaryColor, forState: UIControl.State())
        button.layer.cornerRadius = 8
        button.titleEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        button.layer.masksToBounds = true
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true
        button.addTarget(self, action: #selector(convertCall), for: .touchUpInside)
        //        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }()
    
    lazy var exchangeRateUpdateLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Mid-market exchange rate at 13:38 UTC"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0.4799637198, blue: 0.9984303117, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    @objc func convertCall(){
        
    }
}
