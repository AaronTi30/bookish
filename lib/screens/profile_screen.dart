import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  final Map<String, dynamic> _userData = {
    'name': 'Ada Lovelace',
    'username': '@booklover42',
    'bio':
        'Avid reader, coffee enthusiast, and occasional writer. Currently exploring sci-fi classics.',
    'joinedDate': 'January 2023',
    'location': 'New York, NY',
    'website': 'alexjohnson.com',
    'stats': {
      'booksRead': 47,
      'currentlyReading': 3,
      'toRead': 12,
      'reviews': 28,
      'friends': 89,
    },
  };

  final List<Map<String, dynamic>> _recentActivity = [
    {
      'type': 'review',
      'book': 'Dune',
      'author': 'Frank Herbert',
      'rating': 5.0,
      'time': '2 hours ago',
    },
    {
      'type': 'progress',
      'book': 'The Three-Body Problem',
      'author': 'Cixin Liu',
      'progress': 65,
      'time': '1 day ago',
    },
    {
      'type': 'added',
      'book': 'Project Hail Mary',
      'author': 'Andy Weir',
      'time': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            _buildProfileCard(),

            const SizedBox(height: 24),

            // Stats Grid
            _buildStatsGrid(),

            const SizedBox(height: 24),

            // Reading Goals
            _buildReadingGoals(),

            const SizedBox(height: 24),

            // Recent Activity
            _buildRecentActivity(),

            const SizedBox(height: 24),

            // Settings Section
            _buildSettingsSection(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                _userData['name'][0],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // User Info
          Text(
            _userData['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            _userData['username'],
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),

          const SizedBox(height: 16),

          // Bio
          Text(
            _userData['bio'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Meta Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Joined ${_userData['joinedDate']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                _userData['location'],
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Edit Profile Button
          ElevatedButton(
            onPressed: () {
              // Navigate to edit profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = _userData['stats'];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.8,
      children: [
        _buildStatCard('Books Read', stats['booksRead'], Icons.library_books),
        _buildStatCard('Reading', stats['currentlyReading'], Icons.autorenew),
        _buildStatCard('To Read', stats['toRead'], Icons.bookmark),
        _buildStatCard('Reviews', stats['reviews'], Icons.reviews),
        _buildStatCard('Friends', stats['friends'], Icons.people),
        _buildStatCard('Achievements', 5, Icons.emoji_events),
      ],
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingGoals() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2024 Reading Goal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 47 / 52,
            backgroundColor: Colors.grey[200],
            color: Colors.green,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '47 of 52 books',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                '90% complete',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ..._recentActivity.map((activity) => _buildActivityItem(activity)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color color;
    String subtitle;

    switch (activity['type']) {
      case 'review':
        icon = Icons.reviews;
        color = Colors.amber;
        subtitle = 'Rated ${activity['rating']} stars';
        break;
      case 'progress':
        icon = Icons.timeline;
        color = Colors.blue;
        subtitle = '${activity['progress']}% completed';
        break;
      case 'added':
        icon = Icons.add_circle;
        color = Colors.green;
        subtitle = 'Added to reading list';
        break;
      default:
        icon = Icons.book;
        color = Colors.grey;
        subtitle = 'Activity';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['book'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            activity['time'],
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingsItem(Icons.settings, 'Account Settings'),
          _buildSettingsItem(Icons.notifications, 'Notifications'),
          _buildSettingsItem(Icons.privacy_tip, 'Privacy & Security'),
          _buildSettingsItem(Icons.help, 'Help & Support'),
          _buildSettingsItem(Icons.logout, 'Log Out', isLogout: true),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (isLogout) {
          // Handle logout
        }
        // Handle other settings items
      },
      contentPadding: EdgeInsets.zero,
    );
  }
}
