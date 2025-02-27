import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';
import 'package:tik_dog/pages/accept_denied_offer_details_page/accept_offer_details_page.dart';

import '../../../data/api/models/offer_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc({required this.offersRepositoryImpl}) : super(OffersInitial()) {
    on<OffersInitEvent>((event, emit) async {
      final status = event.status ?? getOffersStatus;
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;

      await fetchOffers(limit: limit, status: status);
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<RefreshOffersEvent>((event, emit) async {
      final status = getOffersStatus;
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;

      await fetchOffers(limit: limit, status: status);
      emit(OffersCurrentOffersState(offers: offers));
    });

    on<OffersChangeSelectedStatusEvent>((event, emit) async {
      if (event.index != selectedOffersTypeStatus) {
        changeOffersTypeStatus(event.index);
        // final limit = selectedOffersTypeStatus == 0 ? 1 : null;
        // await fetchOffers(limit: limit, status: getOffersStatus);
        emit(OffersCurrentOffersState().copyWith(
          offers: null,
          selectedOffersStatus: event.index,
        ));
      }
    });
    on<AcceptOfferEvent>((event, emit) async {
      await acceptOffer(id: event.id, email: event.email, country: event.country);
    });
    on<DeniedOfferEvent>((event, emit) async {
      await deniedOffer(id: event.id, reason: event.reason);
    });
    on<SelectCountryEvent>((event, emit) {
      selectedCountry = event.country;
      emit(OffersCurrentOffersState().copyWith(
        selectedCountry: selectedCountry,
      ));
    });
    on<EditTextReasonEvent>((event, emit) {
      selectedTextReason = event.textReason;
      emit(OffersCurrentOffersState().copyWith(
        selectedTextReason: selectedTextReason,
      ));
    });
    on<SelectCountReasonEvent>((event, emit) {
      selectedReasonIndex = event.index;
      emit(OffersCurrentOffersState().copyWith());
    });
    on<RemoveSelectedValuesEvent>((event, emit) {
      selectedCountry = null;
      selectedTextReason = null;
      selectedReasonIndex = null;
      emit(OffersCurrentOffersState().copyWith());
    });
  }

  OffersRepositoryImpl offersRepositoryImpl;
  int selectedOffersTypeStatus = 0;

  List<String> items = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo, Democratic Republic of the',
    'Congo, Republic of the',
    'Costa Rica',
    "Cote d'Ivoire",
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czechia',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'UAE',
    'UK',
    'USA',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Holy See',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];

  String? selectedCountry;

  List<String>? reasons;
  String? selectedTextReason;
  int? selectedReasonIndex;

  bool validMail = false;

  List<OfferModel> offers = [];
  String? get getOffersStatus => selectedOffersTypeStatus == 0
      ? null
      : selectedOffersTypeStatus == 1
          ? 'accepted'
          : 'declined';

  Future<void> fetchOffers({int? limit, String? status}) async {
    try {
      await offersRepositoryImpl.getOffers(limit: limit, status: status).then((response) {
        offers = response;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  void changeOffersTypeStatus(int index) {
    selectedOffersTypeStatus = index;
  }

  Future<void> acceptOffer({
    required String id,
    required String email,
    required String country,
  }) async {
    try {
      final status = getOffersStatus;
      await offersRepositoryImpl.acceptOffer(id: id, email: email, country: country).then((response) async {
        Future.microtask(() => add(OffersInitEvent(status: status)));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deniedOffer({
    required String id,
    required String reason,
  }) async {
    try {
      final status = getOffersStatus;
      await offersRepositoryImpl.deniedOffer(id: id, reason: reason).then((response) async {
        Future.microtask(() => add(OffersInitEvent(status: status)));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> fetchDeniedOfferReasons() async {
    try {
      final response = await offersRepositoryImpl.fetchDeniedOfferReasons();
      reasons = response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  bool checkMail(String? value) {
    validMail = value != null && value.isValidEmail();
    print(validMail);
    return validMail;
  }
}
