// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/themes.dart';

import '../../constants.dart';
import '../../data/api/models/offer_model.dart';
import '../auth_information_page/auth_information_page.dart';
import '../offers_page/bloc/offers_bloc.dart';
import 'components/congratulations_bottom_sheet.dart';

class AcceptOfferDetailsPage extends StatefulWidget {
  const AcceptOfferDetailsPage({required this.offer, super.key});

  final OfferModel offer;

  @override
  State<AcceptOfferDetailsPage> createState() => _AcceptOfferDetailsPageState();
}

class _AcceptOfferDetailsPageState extends State<AcceptOfferDetailsPage> {
  bool selectCountryIsOpen = false;
  String email = '';
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OffersBloc>();

    return WillPopScope(
      onWillPop: () async {
        model.add(RemoveSelectedValuesEvent());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          model.add(RemoveSelectedValuesEvent());
                          context.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12, bottom: 12),
                          child: SvgPicture.asset(
                            'assets/icons/BackArrow.svg',
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Fill in your details to receive the brif from Amazon sellers',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            height: 1.36,
                          ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      '🏳️ Country',
                      style:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Not selected',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 100,
                          searchInnerWidget: TextField(
                            controller: textEditingController,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 15,
                              ),
                              hintText: 'Search country',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                height: 1,
                                color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value!.toLowerCase().contains(searchValue.toLowerCase());
                          },
                        ),
                        items: countries
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ))
                            .toList(),
                        value: model.selectedCountry,
                        onMenuStateChange: (flag) {
                          setState(() {
                            selectCountryIsOpen = flag;
                          });
                        },
                        onChanged: (value) {
                          model.add(SelectCountryEvent(country: value!));
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.only(left: 15, right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                            ),
                            color: Colors.transparent,
                          ),
                          elevation: 0,
                        ),
                        iconStyleData: IconStyleData(
                          icon: RotationTransition(
                            turns: AlwaysStoppedAnimation(
                              selectCountryIsOpen ? 90 / 360 : -90 / 360,
                            ),
                            child: SvgPicture.asset('assets/icons/BackArrow.svg'),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          width: MediaQuery.of(context).size.width - 16 * 2,
                          padding: const EdgeInsets.all(0),
                          maxHeight: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptCountrySelectColor,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(
                            top: 15,
                            right: 12,
                            bottom: 15,
                            left: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      '😎 Email',
                      style:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1,
                        ),
                        onChanged: (value) => setState(() {
                          email = value;
                          model.needError = false;
                        }),
                        forceErrorText: !model.validMail && model.needError ? 'Incorrect mail' : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 17,
                            horizontal: 15,
                          ),
                          hintText: 'Email address',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            height: 1,
                            color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GradientContainer(
                      isActive: model.selectedCountry != null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ActionButton(
                        onPressed: () {
                          model.add(EditEMailTextEvent(text: email));
                          if (model.checkValidMail(email) && email != '') {
                            model.add(AcceptOfferEvent(
                              id: widget.offer.id,
                              email: email,
                              country: model.selectedCountry!,
                            ));
                            model.add(RemoveSelectedValuesEvent());
                            model.add(OffersChangeSelectedStatusEvent(index: 1));
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              useRootNavigator: true,
                              builder: (context) => CongratulationsBottomSheet(
                                email: email,
                              ),
                            );
                          } else {
                            model.needError = true;
                          }
                        },
                        text: 'Get an offer',
                        isActive: model.selectedCountry != null,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 99,
                right: 0,
                child: Image.asset('assets/images/Step.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
