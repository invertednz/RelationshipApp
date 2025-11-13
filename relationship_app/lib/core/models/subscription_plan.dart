import 'package:equatable/equatable.dart';

enum PlanType {
  monthly,
  annual,
  payItForward,
  gift,
}

class SubscriptionPlan extends Equatable {
  final PlanType type;
  final String title;
  final String price;
  final double amount;
  final String interval;
  final String? description;
  final List<String> features;
  final bool isPopular;
  final String? savingsText;

  const SubscriptionPlan({
    required this.type,
    required this.title,
    required this.price,
    required this.amount,
    required this.interval,
    this.description,
    this.features = const [],
    this.isPopular = false,
    this.savingsText,
  });

  @override
  List<Object?> get props => [
        type,
        title,
        price,
        amount,
        interval,
        description,
        features,
        isPopular,
        savingsText,
      ];

  static const SubscriptionPlan annual = SubscriptionPlan(
    type: PlanType.annual,
    title: 'Annual Plan',
    price: '\$49',
    amount: 49.0,
    interval: 'year',
    description: 'Best value - just \$4.08/month',
    savingsText: 'Save \$59 vs monthly',
    isPopular: true,
    features: [
      'Unlimited journal entries',
      'Personalized date recommendations',
      'All games & activities',
      'Together Garden tracker',
      'Priority support',
    ],
  );

  static const SubscriptionPlan monthly = SubscriptionPlan(
    type: PlanType.monthly,
    title: 'Monthly Plan',
    price: '\$9',
    amount: 9.0,
    interval: 'month',
    description: 'Cancel anytime',
    features: [
      'Unlimited journal entries',
      'Personalized date recommendations',
      'All games & activities',
      'Together Garden tracker',
    ],
  );

  static const SubscriptionPlan payItForward = SubscriptionPlan(
    type: PlanType.payItForward,
    title: 'Pay It Forward',
    price: '\$59',
    amount: 59.0,
    interval: 'year',
    description: 'Annual plan + gift a couple in need',
    savingsText: 'Give back to the community',
    features: [
      'Everything in Annual Plan',
      'Gift subscription to another couple',
      'Exclusive "Supporter" badge',
      'Early access to new features',
      'Warm fuzzy feelings ❤️',
    ],
  );

  static const SubscriptionPlan gift = SubscriptionPlan(
    type: PlanType.gift,
    title: 'Gift Plan',
    price: '\$29',
    amount: 29.0,
    interval: '3 months',
    description: '3 months of premium access',
    features: [
      'Unlimited journal entries',
      'Personalized date recommendations',
      'All games & activities',
      'Together Garden tracker',
    ],
  );

  static List<SubscriptionPlan> get allPlans => [annual, monthly, payItForward];
}
