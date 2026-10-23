import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import 'host_car_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: AppTheme.cardLight,
                        backgroundImage: AssetImage(user?.avatar ?? 'assets/images/user_avatar.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Guest User',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'Sign in for VIP perks',
                              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.primary.withOpacity(0.4)),
                              ),
                              child: Text(
                                (user?.membershipTier ?? 'Visitor Tier').toUpperCase(),
                                style: const TextStyle(color: AppTheme.primary, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppTheme.border, height: 1),
                  const SizedBox(height: 16),

                  // Loyalty Points & KYC Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem('Loyalty Points', '${user?.loyaltyPoints ?? 0} PTS', Icons.stars, AppTheme.accent),
                      _statItem('KYC Status', 'Verified DL', Icons.verified_user, AppTheme.success),
                      _statItem('Active Role', user?.role.toUpperCase() ?? 'GUEST', Icons.badge, AppTheme.primary),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Demo Account Switcher
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quick Switch Demo Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  const SizedBox(height: 6),
                  const Text('Test customer, fleet host or admin experience instantly:', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _roleButton(context, auth, 'Customer', 'customer'),
                      const SizedBox(width: 8),
                      _roleButton(context, auth, 'Fleet Host', 'host'),
                      const SizedBox(width: 8),
                      _roleButton(context, auth, 'Admin', 'admin'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Host a car card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F1235), Color(0xFF13131D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add_business, color: Colors.purpleAccent, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('List Your Luxury Car', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                        Text('Earn up to \$4,000/mo by sharing your vehicle', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HostCarScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    child: const Text('Host Car', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings & Actions Menu
            _menuCard(
              context,
              children: [
                _menuTile(Icons.credit_card, 'Payment Methods & Cards', 'UPI, Cards & NetBanking'),
                _menuTile(Icons.currency_exchange, 'Default Currency', 'USD (\$) • Tap to switch'),
                _menuTile(Icons.support_agent, '24/7 VIP Concierge Support', 'Call or WhatsApp'),
                _menuTile(Icons.policy, 'Rental Terms & Conditions', 'View policy'),
              ],
            ),

            const SizedBox(height: 20),

            // Logout / Sign in
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (auth.isAuthenticated) {
                    auth.logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: auth.isAuthenticated ? AppTheme.error : AppTheme.primary,
                  side: BorderSide(color: auth.isAuthenticated ? AppTheme.error : AppTheme.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  auth.isAuthenticated ? 'Sign Out of Account' : 'Sign In / Register',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
      ],
    );
  }

  Widget _roleButton(BuildContext context, AuthProvider auth, String title, String role) {
    final isCurrent = auth.currentUser?.role == role;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          auth.loginAsRole(role);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.cardLight,
              content: Text('Switched to $title persona!'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isCurrent ? AppTheme.primary : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isCurrent ? AppTheme.primary : AppTheme.border),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isCurrent ? Colors.white : AppTheme.textSecondary,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _menuTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.cardLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 20),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 18),
      onTap: () {},
    );
  }
}
