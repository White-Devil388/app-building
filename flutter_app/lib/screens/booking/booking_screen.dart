import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/booking_provider.dart';
import '../../providers/auth_provider.dart';
import '../../data/app_data.dart';
import '../../widgets/offline_car_visual.dart';
import 'booking_success_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _couponController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _licenseController = TextEditingController();

  String _paymentMethod = 'UPI (Google Pay / PhonePe)';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final user = auth.currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
      _emailController.text = user.email;
      _licenseController.text = user.licenseNumber;
    }
  }

  @override
  void dispose() {
    _couponController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange(BuildContext context, BookingProvider bp) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDateRange: DateTimeRange(start: bp.startDate, end: bp.endDate),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.primary,
              surface: AppTheme.card,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      bp.setDates(picked.start, picked.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bp = Provider.of<BookingProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final car = bp.selectedCar ?? AppData.initialCars.first;
    final dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Reservation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Summary Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 70,
                      child: OfflineCarVisual(
                        imageUrl: car.images.isNotEmpty ? car.images.first : '',
                        brand: car.brand,
                        name: car.name,
                        type: car.type,
                        height: 70,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(car.brand.toUpperCase(), style: const TextStyle(fontSize: 11, color: AppTheme.accent, fontWeight: FontWeight.bold)),
                          Text(
                            car.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${car.pricePerDay.toInt()} / day • ${car.transmission}',
                            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Locations Card
              const Text('Rental Hubs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: bp.pickupLocation,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Pickup Hub',
                        prefixIcon: Icon(Icons.flight_takeoff, color: AppTheme.primary, size: 20),
                      ),
                      dropdownColor: AppTheme.cardLight,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      items: AppData.locations.map((loc) {
                        return DropdownMenuItem(value: loc, child: Text(loc, overflow: TextOverflow.ellipsis));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) bp.setLocations(val, bp.dropLocation);
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: bp.dropLocation,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Return Hub',
                        prefixIcon: Icon(Icons.flight_land, color: AppTheme.accent, size: 20),
                      ),
                      dropdownColor: AppTheme.cardLight,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      items: AppData.locations.map((loc) {
                        return DropdownMenuItem(value: loc, child: Text(loc, overflow: TextOverflow.ellipsis));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) bp.setLocations(bp.pickupLocation, val);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Date Selection Card
              const Text('Rental Dates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _pickDateRange(context, bp),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.calendar_today, color: AppTheme.primary, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dateFormat.format(bp.startDate)} - ${dateFormat.format(bp.endDate)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                              ),
                              Text(
                                '${bp.totalDays} Rental Days',
                                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        'Change',
                        style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Add-on Extras
              const Text('Add-on Extras & Protection', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              ...AppData.extraServices.map((extra) {
                final isSelected = bp.isExtraSelected(extra['id']);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.cardLight : AppTheme.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.border),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    activeColor: AppTheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(extra['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                    subtitle: Text('\$${extra['price'].toInt()} ${extra['unit']}', style: const TextStyle(color: AppTheme.accent, fontSize: 12)),
                    onChanged: (val) {
                      bp.toggleExtra(extra['id'], extra['name'], extra['price']);
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Promo Coupon
              const Text('Promo Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Enter WELCOME10 or LUXURY20',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final ok = bp.applyCoupon(_couponController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ok ? AppTheme.success : AppTheme.error,
                          content: Text(ok ? 'Promo coupon applied!' : 'Invalid coupon code'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              if (bp.couponCode != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 14, color: AppTheme.success),
                      const SizedBox(width: 6),
                      Text('Applied ${bp.couponCode} (Discount active)', style: const TextStyle(color: AppTheme.success, fontSize: 12)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          bp.removeCoupon();
                          _couponController.clear();
                        },
                        child: const Text('Remove', style: TextStyle(color: AppTheme.error, fontSize: 12)),
                      )
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Driver KYC Details
              const Text('Driver & KYC Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Legal Name'),
                      validator: (val) => val == null || val.isEmpty ? 'Please enter driver full name' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Contact Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (val) => val == null || val.isEmpty ? 'Please enter contact phone' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email Address'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val == null || val.isEmpty ? 'Please enter email' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _licenseController,
                      decoration: const InputDecoration(labelText: 'Driving License Number'),
                      validator: (val) => val == null || val.isEmpty ? 'Please enter driving license' : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Payment Method
              const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      value: 'UPI (Google Pay / PhonePe)',
                      groupValue: _paymentMethod,
                      activeColor: AppTheme.primary,
                      title: const Text('UPI (Instant & Zero Fee)', style: TextStyle(color: Colors.white, fontSize: 13)),
                      onChanged: (val) => setState(() => _paymentMethod = val!),
                    ),
                    RadioListTile<String>(
                      value: 'Credit / Debit Card (Visa/Mastercard)',
                      groupValue: _paymentMethod,
                      activeColor: AppTheme.primary,
                      title: const Text('Credit / Debit Card', style: TextStyle(color: Colors.white, fontSize: 13)),
                      onChanged: (val) => setState(() => _paymentMethod = val!),
                    ),
                    RadioListTile<String>(
                      value: 'NetBanking / Corporate NEFT',
                      groupValue: _paymentMethod,
                      activeColor: AppTheme.primary,
                      title: const Text('Net Banking', style: TextStyle(color: Colors.white, fontSize: 13)),
                      onChanged: (val) => setState(() => _paymentMethod = val!),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Price Breakdown
              const Text('Fare Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    _priceRow('Base Rental (${bp.totalDays} Days)', '\$${bp.baseRate.toStringAsFixed(2)}'),
                    if (bp.extrasTotal > 0)
                      _priceRow('Add-ons & Extras', '+\$${bp.extrasTotal.toStringAsFixed(2)}'),
                    if (bp.discountAmount > 0)
                      _priceRow('Promo Discount', '-\$${bp.discountAmount.toStringAsFixed(2)}', isDiscount: true),
                    _priceRow('GST Tax (18%)', '\$${bp.taxAmount.toStringAsFixed(2)}'),
                    _priceRow('Refundable Security Deposit', '\$${car.deposit.toStringAsFixed(2)}'),
                    const Divider(color: AppTheme.border, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Grand Total Payable', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                        Text(
                          '\$${bp.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newBooking = bp.confirmBooking(
                        userId: auth.currentUser?.id ?? 1,
                        driverName: _nameController.text,
                        driverPhone: _phoneController.text,
                        driverEmail: _emailController.text,
                        licenseNumber: _licenseController.text,
                        paymentMethod: _paymentMethod,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingSuccessScreen(booking: newBooking),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Confirm & Pay Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: isDiscount ? AppTheme.success : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
