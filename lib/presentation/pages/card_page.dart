import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:scan_bonus_card_example/core/drift/tables.dart';
import 'package:scan_bonus_card_example/core/injactable/injectable.dart';
import 'package:scan_bonus_card_example/data/data_sources/data_sources.dart';
import 'package:scan_bonus_card_example/presentation/pages/transaction_history.dart';

import 'package:scan_bonus_card_example/presentation/provider/theme_provider.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // State variables
  final DataSources _dataSource = DataSources(getIt<AppDatabase>());
  bool _showAddCardDialog = false;
  final _searchController = TextEditingController();
  String _searchText = '';

  // Form controllers
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _validityPeriodController = TextEditingController();

  // Formatters

  final _validityPeriodFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _validityPeriodController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: 346.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                          color: const Color(0xFF7DB700), width: 2.w),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        bottomLeft: Radius.circular(5.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFACB1C6),
                            fontSize: 15.76.sp,
                          ),
                        ),
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.76.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 43.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? const Color(0xFF8ED000)
                        : const Color(0xFF7DB700),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.search,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () => setState(() => _showAddCardDialog = true),
            child: SvgPicture.asset("assets/icons/new_card.svg"),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(CardWithBonus cardWithBonus) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionHistory(
                cardId: cardWithBonus.card.id,
                cardName: cardWithBonus.card.name,
                cardNumber: cardWithBonus.card.number,
                expiryDate:
                    DateFormat("MM/yy").format(cardWithBonus.card.validPeriod),
              ),
            ),
          );
        },
        child: Container(
          width: 346.w,
          decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              border: Border.all(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? const Color(0xFF8ED000).withValues(alpha: 0.24)
                    : const Color(0xFF7DB700).withValues(alpha: 0.24),
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 7.w),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor:
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? const Color(0xFF8ED000)
                              : const Color(0xFF7DB700),
                      child: Container(
                        width: 37.w,
                        height: 37.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/bonus_card.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cardWithBonus.card.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          Text(
                            "Bonus ${cardWithBonus.bonus} Points",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardWithBonus.card.number,
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 23.w),
                      child: Text(
                        DateFormat("MM/yy")
                            .format(cardWithBonus.card.validPeriod),
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleAddCard() async {
    try {
      final expiryDate =
          DateFormat('MM/yy').parse(_validityPeriodController.text);

      await _dataSource.addCard(CardCompanion.insert(
          number: _cardNumberController.text,
          name: _cardNameController.text,
          validPeriod: expiryDate));

      setState(() => _showAddCardDialog = false);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Карта успешно добавлена')),
      );

      // Очищаем поля после добавления
      _cardNumberController.clear();
      _cardNameController.clear();
      _validityPeriodController.clear();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при добавлении карты: $e')),
      );
    }
  }

  Widget _buildAddCardDialog() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 362.w,
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            border: Border.all(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? const Color(0xFF8ED000)
                    : const Color(0xFF7DB700),
                width: 2.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              children: [
                _buildDialogHeader(),
                Divider(color: const Color(0xFFCBD0DC), height: 2.h),
                SizedBox(height: 30.h),
                _buildCardNameField(),
                SizedBox(height: 30.h),
                _buildCardNumberField(),
                SizedBox(height: 30.h),
                _buildValidityPeriodField(),
                SizedBox(height: 28.h),
                _buildDialogButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader() {
    return SizedBox(
      width: 296.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32.63.w,
            height: 32.63.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2.w, color: const Color(0xFFCBD0DC)),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/card-add.svg",
                width: 20.w,
                height: 20.h,
                // ignore: deprecated_member_use
                color: const Color(0xFF7DB700),
              ),
            ),
          ),
          SizedBox(
            width: 218.69.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add new card",
                  style: GoogleFonts.montserrat(
                    fontSize: 11.8.sp,
                    fontWeight: FontWeight.bold,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Text(
                  "Simplify your checkout process by adding a new card for future transactions. Your card information is protected with advanced encryption technology.",
                  style: GoogleFonts.inter(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFA9ACB4),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _showAddCardDialog = false),
            child: const Icon(Icons.cancel_outlined, size: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildCardNameField() {
    return SizedBox(
      width: 296.w,
      child: TextField(
        controller: _cardNameController,
        decoration: InputDecoration(
          isDense: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: const BorderSide(color: Color(0xFF7DB700)),
          ),
          labelText: 'Card name',
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Color(0xFF8ED000)
                : const Color(0xFF7DB700), // Красный в активном состоянии
          ),
        ),
        style: GoogleFonts.montserrat(
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return SizedBox(
      width: 296.w,
      child: TextField(
        controller: _cardNumberController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
        ],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          isDense: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? const Color(0xFF8ED000)
                    : const Color(0xFF7DB700)),
          ),
          floatingLabelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Color(0xFF8ED000)
                : const Color(0xFF7DB700), // Красный в активном состоянии
          ),
          labelText: 'Card number',
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          suffixIconConstraints:
              BoxConstraints(minHeight: 20.w, minWidth: 20.h),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 7.w),
            child: SvgPicture.asset(
              "assets/icons/card.svg",
              width: 20.w,
              height: 20.h,
              // ignore: deprecated_member_use
              color: const Color(0xFFCBD0DC),
            ),
          ),
        ),
        style: GoogleFonts.montserrat(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget _buildValidityPeriodField() {
    return SizedBox(
      width: 296.w,
      child: TextField(
        controller: _validityPeriodController,
        inputFormatters: [_validityPeriodFormatter],
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          isDense: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? const Color(0xFF8ED000)
                    : const Color(0xFF7DB700)),
          ),
          labelText: 'Validity period',
          hintText: "MM/YY",
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.inder(
            fontSize: 12.sp,
            color: const Color(0xFFCBD0DC),
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Color(0xFF8ED000)
                : const Color(0xFF7DB700), // Красный в активном состоянии
          ),
          suffixIconConstraints:
              BoxConstraints(minHeight: 20.w, minWidth: 20.h),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 7.w),
            child: SvgPicture.asset(
              "assets/icons/calendar.svg",
              width: 20.w,
              height: 20.h,
              // ignore: deprecated_member_use
              color: const Color(0xFFCBD0DC),
            ),
          ),
        ),
        style: GoogleFonts.montserrat(
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDialogButtons() {
    return SizedBox(
      width: 296.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCancelButton(),
          _buildAddCardButton(),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return GestureDetector(
      onTap: () => setState(() => _showAddCardDialog = false),
      child: Container(
        width: 140.w,
        height: 28.05.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          border: Border.all(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? const Color(0xFF8ED000)
                  : const Color(0xFF7DB700),
              width: 2.w),
        ),
        child: Center(
          child: Text(
            "Cancel",
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? const Color(0xFF8ED000)
                  : const Color(0xFF7DB700),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    return _cardNumberController.text.isNotEmpty &&
        _cardNameController.text.isNotEmpty &&
        _validityPeriodController.text.length == 5;
  }

  Widget _buildAddCardButton() {
    return GestureDetector(
      onTap: () async {
        if (_validateFields()) {
          await _handleAddCard();
        }
      },
      child: Container(
        width: 140.w,
        height: 28.05.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xFF7DB700),
            Color(0xFF6C9E01),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/new_card.svg",
              width: 12.w,
              height: 12.h,
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
            SizedBox(width: 5.w),
            Text(
              "Add a card",
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<CardWithBonus>> _filterCards(String searchText) {
    return _dataSource.getListCard().map((cards) {
      return cards.where((card) {
        return card.card.name.toLowerCase().contains(searchText) ||
            card.card.number.contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: 40.h),
                      StreamBuilder<List<CardWithBonus>>(
                        stream: _filterCards(_searchText),
                        builder: (context, snapshot) {
                          // Обработка состояния загрузки
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          // Обработка ошибок
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          final cards = snapshot.data ?? [];

                          // Если карт нет - показываем сообщение
                          if (cards.isEmpty) {
                            return const Center(child: Text('No cards found'));
                          }

                          // Используем Column для отображения списка карт
                          return Column(
                            children: [
                              for (final card in cards) _buildCardItem(card),
                              SizedBox(height: 20.h), // Добавляем отступ снизу
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              )),
          if (_showAddCardDialog)
            ModalBarrier(
              color: Colors.black.withValues(alpha: 0.3),
              dismissible: true,
              onDismiss: () => setState(() => _showAddCardDialog = false),
            ),
          if (_showAddCardDialog) _buildAddCardDialog(),
        ],
      ),
    );
  }
}
