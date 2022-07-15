import 'package:get/state_manager.dart';

class DoctorController extends GetxController {
  String firstName = 'user'; //no need for .obs
  String? id;
  String? title;
  String? lastName;
  String? nationalIdentificationNumber;
  String? address;
  int? cityId;
  String? govDoctorRegNo;
  String? nicFrontPicUrl;
  String? nicBackPicUrl;
  String? govDoctorIdentityPicFrontUrl;
  String? govDoctorIdentityPicBackUrl;
  bool? isVerified;
  String? verifiedDate;
  String? verifiedById;
  bool? isActive;
  String? phoneNumber;
  bool? isPhoneNumberVerified;
  String? email;
  bool? isEmailVerified;
  List<Null>? doctorSpecializations;
  bool? phoneNumberVisibleToPatient;
  Null? profilePicture;
  String? description;

  void setFirstname(String name) {
    firstName = name;
    update();
  }

  void setTitle(String title) {
    this.title = title;
    update();
  }

  void setId(String id) {
    this.id = id;
    update();
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
    update();
  }

  void setNationalIdentificationNumber(String nationalIdentificationNumber) {
    this.nationalIdentificationNumber = nationalIdentificationNumber;
    update();
  }

  void setAddress(String address) {
    this.address = address;
    update();
  }

  void setCityId(int cityId) {
    this.cityId = cityId;
    update();
  }

  void setGovDoctorRegNo(String govDoctorRegNo) {
    this.govDoctorRegNo = govDoctorRegNo;
    update();
  }

  void setNicFrontPicUrl(String nicFrontPicUrl) {
    this.nicFrontPicUrl = nicFrontPicUrl;
    update();
  }

  void setNicBackPicUrl(String nicBackPicUrl) {
    this.nicBackPicUrl = nicBackPicUrl;
    update();
  }

  void setGovDoctorIdentityPicFrontUrl(String govDoctorIdentityPicFrontUrl) {
    this.govDoctorIdentityPicFrontUrl = govDoctorIdentityPicFrontUrl;
    update();
  }

  void setGovDoctorIdentityPicBackUrl(String govDoctorIdentityPicBackUrl) {
    this.govDoctorIdentityPicBackUrl = govDoctorIdentityPicBackUrl;
    update();
  }

  void setIsVerified(bool isVerified) {
    this.isVerified = isVerified;
    update();
  }

  void setVerifiedDate(String verifiedDate) {
    this.verifiedDate = verifiedDate;
    update();
  }

  void setVerifiedById(String verifiedById) {
    this.verifiedById = verifiedById;
    update();
  }

  void setIsActive(bool isActive) {
    this.isActive = isActive;
    update();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    update();
  }

  void setIsPhoneNumberVerified(bool isPhoneNumberVerified) {
    this.isPhoneNumberVerified = isPhoneNumberVerified;
    update();
  }

  void setEmail(String email) {
    this.email = email;
    update();
  }

  void setIsEmailVerified(bool isEmailVerified) {
    this.isEmailVerified = isEmailVerified;
    update();
  }

  void setIsDoctorSpecializations(List doctorSpecializations) {
    this.doctorSpecializations = doctorSpecializations.cast<Null>();
    update();
  }

  void setIsphoneNumberVisibleToPatient(bool phoneNumberVisibleToPatient) {
    this.phoneNumberVisibleToPatient = phoneNumberVisibleToPatient;
    update();
  }

  void setprofilePicture(String profilePicture) {
    this.profilePicture = profilePicture as Null?;
    update();
  }

  void setDescription(String description) {
    this.description = description;
    update();
  }
}
