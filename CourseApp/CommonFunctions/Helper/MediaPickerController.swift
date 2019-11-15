//
//  MediaPickerController.swift
//  Bagant
//
//  Created by OSX on 27/12/17.
//  Copyright © 2017 OSX. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos

public enum MediaPickerControllerType {
    case imageOnly
    case imageAndVideo
    case videoOnly
}

@objc public protocol MediaPickerControllerDelegate {
    @objc optional func mediaPickerControllerDidPickImage(_ image: UIImage)
    @objc optional func mediaPickerControllerDidPickVideo(url: URL, data: Data, thumbnail: UIImage)
}
typealias DidPickImage = (_ image: UIImage) -> ()

open class MediaPickerController: NSObject {
    
    // MARK: - Public
    open weak var delegate: MediaPickerControllerDelegate?
    var didSelectImage: DidPickImage?
    
    public init(type: MediaPickerControllerType, presentingViewController controller: UIViewController) {
        self.type = type
        self.presentingController = controller
        self.mediaPicker = UIImagePickerController()
        super.init()
        self.mediaPicker.delegate = self
    }
    
    open func show() {
        let actionSheet = self.optionsActionSheet
        self.presentingController.present(actionSheet, animated: true, completion: nil)
    }
    
    open func openCameraForImageAndVideo() {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
            self.presentingController.showAlert(message: VCLiterals.cameraDenied.localized, title: VCLiterals.permissionDenied.localized, ok: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            })
        } else {
            self.mediaPicker.sourceType = UIImagePickerController.SourceType.camera
            self.mediaPicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
        }
    }
    
    open func openGalleryToPickVideoAndImage() {
        if PHPhotoLibrary.authorizationStatus() == .denied {
            self.presentingController.showAlert(message: VCLiterals.mediaPickerDenied.localized, title: VCLiterals.permissionDenied.localized, ok: {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
        } else {
            self.mediaPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.mediaPicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
        }
    }
    func showImagePicker(selected: @escaping DidPickImage) {
        
        let actionSheet = self.optionsActionSheet
        self.didSelectImage = selected
        self.presentingController.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Privatte
    fileprivate let presentingController: UIViewController
    fileprivate let type: MediaPickerControllerType
    let mediaPicker: UIImagePickerController
    
}

extension MediaPickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss()
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            self.delegate?.mediaPickerControllerDidPickImage?(chosenImage.fixOrientation())
            if let item = didSelectImage {
                item(chosenImage.fixOrientation())
            }
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            // Is Video
            let url: URL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            let chosenVideo = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            let videoData = try! Data(contentsOf: chosenVideo, options: [])
            let thumbnail = url.generateThumbnail()
            self.delegate?.mediaPickerControllerDidPickVideo?(url: url, data: videoData, thumbnail: thumbnail)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss()
    }
    
    // MARK: - UINavigationControllerDelegate
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

// MARK: - Private
private extension MediaPickerController {
    
    var optionsActionSheet: UIAlertController {
        let actionSheet = UIAlertController(title: Strings.Title, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        self.addChooseExistingMediaActionToSheet(actionSheet)
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            switch self.type {
            case .imageAndVideo:
                self.addTakePhotoActionToSheet(actionSheet)
                self.addTakeVideoActionToSheet(actionSheet)
            case .imageOnly:
                self.addTakePhotoActionToSheet(actionSheet)
            case .videoOnly:
                self.addTakeVideoActionToSheet(actionSheet)
            }
        }
        self.addCancelActionToSheet(actionSheet)
        return actionSheet
    }
    
    func addChooseExistingMediaActionToSheet(_ actionSheet: UIAlertController) {
        let chooseExistingAction = UIAlertAction(title: self.chooseExistingText, style: UIAlertAction.Style.default) { (_) -> Void in
            if PHPhotoLibrary.authorizationStatus() == .denied {
                self.presentingController.showAlert(message: VCLiterals.mediaPickerDenied.localized, title: VCLiterals.permissionDenied.localized, ok: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
            } else {
                self.mediaPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.mediaPicker.mediaTypes = self.chooseExistingMediaTypes
                self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(chooseExistingAction)
    }
    
    func addTakePhotoActionToSheet(_ actionSheet: UIAlertController) {
        let takePhotoAction = UIAlertAction(title: Strings.TakePhoto, style: UIAlertAction.Style.default) { (_) -> Void in
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
                self.presentingController.showAlert(message: VCLiterals.cameraDenied.localized, title: VCLiterals.permissionDenied.localized, ok: {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
            } else {
                self.mediaPicker.sourceType = UIImagePickerController.SourceType.camera
                self.mediaPicker.mediaTypes = [kUTTypeImage as String]
                self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(takePhotoAction)
    }
    
    func addTakeVideoActionToSheet(_ actionSheet: UIAlertController) {
        let takeVideoAction = UIAlertAction(title: Strings.TakeVideo, style: UIAlertAction.Style.default) { (_) -> Void in
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
                self.presentingController.showAlert(message: VCLiterals.cameraDenied.localized, title: VCLiterals.permissionDenied.localized, ok: {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
            } else {
                self.mediaPicker.sourceType = UIImagePickerController.SourceType.camera
                self.mediaPicker.mediaTypes = [kUTTypeMovie as String]
                self.presentingController.present(self.mediaPicker, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(takeVideoAction)
    }
    
    func addCancelActionToSheet(_ actionSheet: UIAlertController) {
        let cancel = Strings.Cancel
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: nil)
        actionSheet.addAction(cancelAction)
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.presentingController.dismiss(animated: true, completion: nil)
        }
    }
    
    var chooseExistingText: String {
        switch self.type {
        case .imageOnly: return Strings.ChoosePhoto
        case .imageAndVideo: return Strings.ChoosePhotoOrVideo
        case .videoOnly: return Strings.ChooseVideo
        }
    }
    
    var chooseExistingMediaTypes: [String] {
        switch self.type {
        case .imageOnly: return [kUTTypeImage as String]
        case .imageAndVideo: return [kUTTypeImage as String, kUTTypeMovie as String]
        case .videoOnly: return [kUTTypeMovie as String]
        }
    }
    
    // MARK: - Constants
    
    struct Strings {
        static let Title = NSLocalizedString("Attach image from", comment: "Title for a generic action sheet for picking media from the device.")
        static let ChoosePhoto = NSLocalizedString("Gallery", comment: "Text for an option that lets the user choose an existing photo in a generic action sheet for picking media from the device.")
        static let ChoosePhotoOrVideo = NSLocalizedString("Choose existing photo or video", comment: "Text for an option that lets the user choose an existing photo or video in a generic action sheet for picking media from the device.")
        static let TakePhoto = NSLocalizedString("Camera", comment: "Text for an option that lets the user take a picture with the device camera in a generic action sheet for picking media from the device.")
        static let TakeVideo = NSLocalizedString("Take a video", comment: "Text for an option that lets the user take a video with the device camera in a generic action sheet for picking media from the device.")
        static let Cancel = NSLocalizedString("Cancel", comment: "Text for the 'cancel' action in a generic action sheet for picking media from the device.")
        static let ChooseVideo = NSLocalizedString("Choose Video", comment: "Choose Video")
    }
    
}

public extension URL {
    
    func generateThumbnail() -> UIImage {
        let asset = AVAsset(url: self)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = 0
        let imageRef = try? generator.copyCGImage(at: time, actualTime: nil)
        let thumbnail = UIImage(cgImage: imageRef!)
        return thumbnail
    }
    
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

//PROJECT DETAIL VC CONSTANTS

enum VCLiterals: String {
    case aboutProject = "About the Project"
    case priceFloorPlan = "Price & Floor Plan"
    case bankOffers = "Bank Offers"
    case towerDetails = "Tower Details"
    case amenities = "Amenities"
    case specification = "Specifications"
    case overview = "Overview"
    case configs = "Configurations"
    case gallary = "Gallery"
    case floating = "Floating"
    case favoriteProperties = "Favorite Properties"
    case favoriteProjects = "Favorite Projects"
    case properties = "My Properties"
    case projects = "My Projects"
    case customers = "My Customers"
    case terms = "Terms & Conditions"
    case privacyPolicy = "Privacy Policy"
    case contactUs = "Contact Us"
    case signOut = "Sign out"
    
    case ok = "OK"
    case cancel = "Cancel"
    case logotAlert = "Are you sure you want to logout of this app?"
    case sessionExpire = "Session Expired"
    
    
    case cancelAlert = "Canceling this can reset information entered on all the steps. Are you sure you want to cancel this?"
    case backAlert = "Moving back can reset information entered on current step. Are you sure you want to move back?"
    
    case countryAlert = "Please choose country"
    case buyRentAlert = "Please choose property available for"
    case stateAlert = "Pease choose state"
    case cityAlert = "Please choose city"
    case localityAlert = "Please choose locality"
    case neighbourhoodAlert = "Please choose neighbourhood"
    case propertyTypeAlert = "Please choose property type"
    case areaPriceAlert = "Please enter carpet area and average price for the property"
    case countryStateAlert = "Please choose a country or state first"
    case countryStateCityAlert = "Please choose a country, state or city first"
    case selectCountry = "Select Country"
    case selectState = "Select State"
    case selectCity = "Select City"
    case selectNeighborHood = "Select Neighbourhood"
    case selectAmenities = "Select Amenities"
    case selectBanks = "Select Banks"
    case selectBuilding = "Select Buildings"
    case selectStatus = "Lead Status"
    case selectType = "Lead Type"
    case propertType = "Property Type"
    case searchBuilding = "Search your building in Our Database "
    case coverImageAlert = "Please choose cover image for the property"
    case otherImagesAlert = "Please choose more images for property."
    case floorPlanAlert = "Please choose floor plan image"
    case descAlert = "Please describe about property."
    case floorAlert = "Number of floors can't be zero"
    case bedRoomAlert = "Number of bedrooms can't be zero"
    case bathRoomAlert = "Number of bathrooms can't be zero"
    case qtyAlert = "Quantity can't be zero"
    case amenityAlert = "Please choose some amenities"
    case bankAlert = "Please choose minimum one bank"
    case didntFindBuilding = "Didn't Found your Building? "
    case reqAddNewbuiding = "Generate a Request to add a building by our Data collectors"
    case buildingSearchAlert = "Please search a building to tag and choose"
    case buildingNameAlert = "Please enter name of building for properties"
    case buildingAddressAlert = "Please choose address for building"
    case configAlert = "Please choose configuration of property"
    case availFor = "This Property is available for?"
    case country = "Country"
    case config = "Configuration"
    case areaPrice = "Enter Carpet Area and Average Price"
    case paramPH = "Parameter"
    case valuePH = "Enter Value"
    case paramValue = "Enter Parameter and Value"
    case buy = "For Sale"
    case rent = "Rent"
    case areaPlaceholder = "in Sq/ft."
    case amountPHL = "Amount should be in $"
    case areaAlert = "Please enter carpet area"
    case amountAlert = "Please enter average amount"
    case paramAlert = "Please add a parameter first"
    case valueAlert = "Please add a value first"
    case addImages = "Add Images of your property"
    case totalArea = "Total Area"
    case noOfFloors = "Number of floors"
    case noOfBedRooms = "Number of bedrooms"
    case noOfBathRooms = "Number of bathrooms"
    case parking = "Parking"
    case finished = "Finished"
    case desc = "Description"
    case howMuchQTY = "How much quantity do you have?"
    case otherImages = "Other Images"
    case banks = "Banks"
    case floorPlan = "Floor Plan"
    case cameraDenied = "Press OK to allow permission access of camera to take pictures or videos"
    case mediaPickerDenied = "Press OK to allow access of photo library to use pictures or videos"
    case permissionDenied = "Permission denied"
    case descPlaceholder = "Enter description"
    case imagesAlert = "You can add maximum of 6 images for any property."
    case martialAlert = "Please choose marital status for buyers."
    case devNameAlert = "Please enter name of developer"
    case devEmailAlert = "Please enter email of developer"
    case validEmailAlert = "Please enter valid email"
    case devPhoneAlert = "Please enter phone no. of developer"
    case validPhoneAlert = "Please enter valid phone no."
    case phoneRangeAlert = "Phone no. must be 5-15 digits."
    case customParamAlert = "Please enter parameter name"
    case customValueAlert = "Please enter value for parameter."
    case profilePrefernces = "Profile Preferences"
    case myFavs = "My Favourites"
    case dealFinalised = "Deal finalised"
    case interestedProperties = "Interested Properties"
    case settings = "Settings"
    case devAppAlert = "Are you sure you want to switch to developer app?"
    case userAppAlert = "Are you sure you want to switch to user app?"
    case openLeads = "Open Leads"
    case closed = "Closed"
    case nameAlert = "Please enter name"
    case phoneNoAlert = "Please enter phone no."
    case deleteAlert = "Are you sure you want to delete?"
    case qtyFloorAlert = "Please enter  floor number"
    case qtyAreaAlert = "Please enter area per sqft"
    case qtyPriceAlert = "Please enter price per sqft"
    case qtyTotalAlert = "Please enter total price"
    case qtyConfigTypeAlert = "Please enter configuration type"
    case qtyFacingDirection = "Please enter facing direction"
    case bed2 = "2 Bed"
    case bed3 = "3 Bed"
    case floorNo = "Floor number"
    case areaPerSqft = "Area per Sqft."
    case configType = "Configuration type"
    case type = "Type"
    case pricePerSqft = "Price per Sqft."
    case status = "Status"
    case facingDir = "Facing Direction"
    case totalPrice = "Total Price"
    case addDetailAlert = "Do you want to add details of property?"
    
    case deleteNote = "Are you sure you want to delete this note?"
    case delete = "Delete"
    case myAppointments = "My Appointments"
    
    case spanish = "Español"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
