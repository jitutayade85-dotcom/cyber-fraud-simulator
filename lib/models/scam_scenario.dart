class ScamScenario {
  final String id;
  final String title;
  final String sender;
  final String body;
  final String category;
  final String type; // 'sms', 'upi', 'whatsapp'
  final String fakeUrl;
  final String realDomain;
  final String urgencyTrigger;
  final String explanation;
  final String goldenRule;

  ScamScenario({
    required this.id,
    required this.title,
    required this.sender,
    required this.body,
    required this.category,
    required this.type,
    required this.fakeUrl,
    required this.realDomain,
    required this.urgencyTrigger,
    required this.explanation,
    required this.goldenRule,
  });
}

final List<ScamScenario> appScams = [
  ScamScenario(
    id: 'elec_01',
    title: 'Electricity Power Disconnection',
    sender: '+91 98765 43210',
    body: 'Dear Consumer, your electricity power will be disconnected tonight at 9:30 PM from the power office because your previous month bill was not updated. Please immediately contact our officer at 9876543210.',
    category: 'Fear & Urgency (SMS)',
    type: 'sms',
    fakeUrl: 'None (Direct Call Trap)',
    realDomain: 'Official Discom Portal (1912)',
    urgencyTrigger: 'Disconnection threat within 2 hours',
    explanation: 'Discoms kabhi normal 10-digit mobile number se disconnect warning nahi bhejte. Call karne par wo screen sharing app (AnyDesk) install karwate hain.',
    goldenRule: 'Emergency threats ko hamesha 1912 ya bijli bill receipt par diye number se verify karein.',
  ),
  ScamScenario(
    id: 'upi_02',
    title: 'Cashback Received Reward',
    sender: 'Rewards Department',
    body: 'Congratulations! You won ₹1,250 Cashback on Google Pay. Scan the QR code or tap button and ENTER YOUR UPI PIN to receive money in account.',
    category: 'UPI Fraud',
    type: 'upi',
    fakeUrl: 'gpay-cashback-reward.in/claim',
    realDomain: 'In-app Google Pay rewards',
    urgencyTrigger: 'Expire in 10 minutes',
    explanation: 'Scammers fake QR bhejkar PIN mangte hain. Jaise hi aap PIN dalte hain, account se paise kat jate hain.',
    goldenRule: 'UPI PIN sirf paise BHEJNE ke liye hota hai, PANE ke liye KABHI PIN nahi lagta.',
  ),
  ScamScenario(
    id: 'kyc_03',
    title: 'SBI YONO Suspended Notice',
    sender: 'VK-SBIINB (Spoofed)',
    body: 'Dear Customer, your SBI YONO account has been suspended today due to KYC expiry. Immediately update your PAN card here: http://sbi-kyc-verify.top',
    category: 'Phishing Link',
    type: 'sms',
    fakeUrl: 'sbi-kyc-verify.top',
    realDomain: 'onlinesbi.sbi',
    urgencyTrigger: 'Immediate account suspension',
    explanation: 'URL domain check karein: ".top" ek sasta fake domain hai. Bank kabhi SMS me direct form link nahi bhejta.',
    goldenRule: 'Bank se jude SMS me aaye kisi bhi link par kabhi PAN/Aadhaar/OTP na bharein.',
  ),
  ScamScenario(
    id: 'job_04',
    title: 'Part-Time Work From Home',
    sender: 'HR Global Online',
    body: 'Earn ₹2,000 to ₹5,000 daily from home. Just like YouTube videos & review hotels. Daily payout via UPI. Tap to join Telegram.',
    category: 'Task / Prepaid Fraud',
    type: 'whatsapp',
    fakeUrl: 't.me/earn_daily_task_vip',
    realDomain: 'No legitimate hiring company',
    urgencyTrigger: 'Only 5 slots left today',
    explanation: 'Pehle 2 tasks par ₹150 dekar vishwas jeette hain, fir lakho rupaye investment task ke naam par loot lete hain.',
    goldenRule: 'Koi bhi company video like karne ke hazaro rupaye nahi deti. Har task-based job fraud hai.',
  ),
];
