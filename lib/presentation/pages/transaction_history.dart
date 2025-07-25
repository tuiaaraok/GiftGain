import 'package:drift/drift.dart' as drift;
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
import 'package:scan_bonus_card_example/presentation/provider/theme_provider.dart';

import '../../data/data_sources/data_sources.dart';

class TransactionHistory extends StatefulWidget {
  final int cardId;
  final String cardName;
  final String cardNumber;
  final String expiryDate;

  const TransactionHistory({
    super.key,
    required this.cardId,
    required this.cardName,
    required this.cardNumber,
    required this.expiryDate,
  });

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  BonusCardAction _currentAction = BonusCardAction.menu;
  List<Transaction> _transactions = [];
  int _totalBonusPoints = 0; // Track total bonus points
  final DataSources _dataSources = DataSources(getIt<AppDatabase>());
  final _validityDateFormatter = MaskTextInputFormatter(
    mask: '##/##/## ##:##',
  );
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      // 1. Load transactions for this card
      final transactions =
          await _dataSources.getCardTransactions(widget.cardId);

      // 2. Calculate total bonus points
      int total = 0;
      for (final transaction in transactions) {
        total +=
            transaction.isAddition ? transaction.points : -transaction.points;
      }

      setState(() {
        _transactions = transactions;
        _totalBonusPoints = total;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load transactions: $e')),
      );
    }
  }

  Future<void> _saveTransaction() async {
    if (_pointsController.text.isEmpty || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      final points = int.parse(_pointsController.text);
      final date = DateFormat('dd/MM/yy HH:mm').parse(_dateController.text);
      final isAddition = _currentAction == BonusCardAction.add;

      // Save to database
      await _dataSources.addHistory(
        _currentAction,
        CardDetailCompanion.insert(
          idCard: widget.cardId,
          bonus: points,
          dateOperation: date,
          isAddBonus: drift.Value(isAddition),
        ),
      );

      // Update local state
      setState(() {
        _transactions.insert(
            0,
            Transaction(
              cardId: widget.cardId,
              points: points,
              isAddition: isAddition,
              date: date,
            ));

        _totalBonusPoints += isAddition ? points : -points;
        _currentAction = BonusCardAction.menu;
        _pointsController.clear();
        _dateController.clear();
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction saved successfully')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _pointsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMainContent(),
          if (_currentAction != BonusCardAction.menu) _buildTransactionForm(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 30.h),
          _buildCardDetails(),
          SizedBox(height: 20.h),
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.white
                : Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                textAlign: TextAlign.center,
                "Transaction History",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.sp,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return Container(
      width: 361.w,
      margin: EdgeInsets.only(bottom: 30.h),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? const Color(0xFF8ED000)
            : const Color(0xFF7DB700),
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cardName,
                      style: GoogleFonts.montserrat(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.black
                            : Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Bonus $_totalBonusPoints Points", // Updated this line
                      style: GoogleFonts.montserrat(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.black
                            : Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
                    ? const Color(0xFF8ED000)
                    : const Color(0xFF7DB700),
                child: ClipOval(
                  child: Image.asset(
                    "assets/bonus_card.png",
                    width: 37.w,
                    height: 37.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.cardNumber,
                style: GoogleFonts.montserrat(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.black
                      : Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.expiryDate,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          text: "Write off",
          backgroundColor: const Color(0xFFE25151),
          textColor: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.black
              : Colors.white,
          onPressed: () =>
              setState(() => _currentAction = BonusCardAction.subtract),
        ),
        _buildActionButton(
          text: "Accrue",
          backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.black
              : Colors.white,
          textColor: Provider.of<ThemeProvider>(context).isDarkMode
              ? const Color(0xFF8ED000)
              : const Color(0xFF7DB700),
          onPressed: () => setState(() => _currentAction = BonusCardAction.add),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 154.64.w,
        height: 44.32.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 16.97.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions",
            style: GoogleFonts.montserrat(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          SizedBox(height: 20.h),
          ..._transactions
              .map((transaction) => _buildTransactionItem(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final isAddition = transaction.isAddition;
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAddition
                        ? Provider.of<ThemeProvider>(context).isDarkMode
                            ? const Color(0xFF8ED000)
                            : const Color(0xFF7DB700)
                        : const Color(0xFFE12A2A),
                  ),
                  child: Center(
                    child: Icon(
                      isAddition ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 28.w,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Flexible(
                  child: Text(
                    DateFormat('MMM d, y h:mm a').format(transaction.date),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: isAddition
                  ? Provider.of<ThemeProvider>(context).isDarkMode
                      ? const Color(0xFF8ED000)
                      : const Color(0xFF7DB700)
                  : const Color(0xFFE12A2A),
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Center(
              child: Text(
                "${isAddition ? '+' : '-'}${transaction.points} Points",
                style: GoogleFonts.montserrat(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionForm() {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withValues(alpha: 0.3),
          onDismiss: () =>
              setState(() => _currentAction = BonusCardAction.menu),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: 362.w,
              margin: EdgeInsets.only(
                  top: 20.h + MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? const Color(0xFF8ED000)
                        : const Color(0xFF7DB700),
                    width: 2.w),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  _buildPointsInput(),
                  SizedBox(height: 30.h),
                  _buildDateInput(),
                  SizedBox(height: 100.h),
                  _buildFormButtons(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointsInput() {
    return SizedBox(
      width: 296.w,
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
        ],
        controller: _pointsController,
        keyboardType: TextInputType.datetime,
        style: GoogleFonts.montserrat(
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.white
              : Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
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
            color: Color(0xFF7DB700), // Красный в активном состоянии
          ),
          labelText: 'Enter the number of bonus points',
          hintText: "",
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          suffixIconConstraints:
              BoxConstraints(minHeight: 20.w, minWidth: 20.h),
        ),
      ),
    );
  }

  Widget _buildDateInput() {
    return SizedBox(
      width: 296.w,
      child: TextField(
        controller: _dateController,
        inputFormatters: [_validityDateFormatter],
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
            borderSide: const BorderSide(color: Color(0xFF7DB700)),
          ),
          labelText: 'Validity period',
          hintText: "dd/MM/YY HH:mm",
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
            color: Color(0xFF7DB700), // Красный в активном состоянии
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

  Widget _buildFormButtons() {
    return SizedBox(
      width: 296.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFormButton(
            text: "Cancel",
            backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.black
                : Colors.white,
            textColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Color(0xFF8ED000)
                : const Color(0xFF7DB700),
            onPressed: () =>
                setState(() => _currentAction = BonusCardAction.menu),
          ),
          _buildFormButton(
            text: "Save",
            backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? const Color(0xFF8ED000)
                : const Color(0xFF7DB700),
            textColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.black
                : Colors.white,
            onPressed: _saveTransaction,
          ),
        ],
      ),
    );
  }

  Widget _buildFormButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140.w,
        height: 28.05.h,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: const Color(0xFF7DB700), width: 2.w)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: textColor,
              fontWeight: text == "Save" ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

enum BonusCardAction { menu, add, subtract }

class Transaction {
  final int id;
  final int cardId;
  final int points;
  final bool isAddition;
  final DateTime date;

  Transaction({
    this.id = 0,
    required this.cardId,
    required this.points,
    required this.isAddition,
    required this.date,
  });
}
