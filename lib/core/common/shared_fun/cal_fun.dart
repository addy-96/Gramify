String calculatePostUploadTime(DateTime uploadTime) {
  final DateTime now = DateTime.now();

  final difference = now.difference(uploadTime);
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago.';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} hour ago.';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour ago.';
  } else {
    final daysDiffernece = difference.inDays;
    if (daysDiffernece < 29) {
      return '$daysDiffernece days ago.';
    } else if (daysDiffernece >= 29) {
      return '${uploadTime.day} ${uploadTime.month} ${uploadTime.year}';
    } else {
      return uploadTime.year.toString();
    }
  }
}

String claulateCommentTime(DateTime commentTime) {
  final DateTime now = DateTime.now();
  final difference = now.difference(commentTime);
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else {
    final daysDiffernece = difference.inDays;
    return '${daysDiffernece}d';
  }
}

String calulateChatLatTime(DateTime lastTime) {
  final List<String> months = [
    'Jan.',
    'Feb.',
    'Mar.',
    'Apr.',
    'May',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.',
  ];
  final now = DateTime.now();
  final difference = now.difference(lastTime);

  if (difference.inSeconds < 60 ||
      difference.inMinutes < 60 ||
      difference.inHours < 24) {
    if (difference.inHours < 12) {
      return '${lastTime.hour} : ${lastTime.minute} AM';
    } else if (difference.inHours >= 12 && difference.inMinutes < 24) {
      return '${difference.inHours} : ${difference.inMinutes} PM';
    }
  }
  return '${lastTime.day} ${months[lastTime.month + 1]} ${lastTime.year}';
}

String calculateMessageTime(DateTime datetime) {
  return '${datetime.hour} : ${datetime.minute}';
}

String calculateUserLatSeen(DateTime datetime) {
  final now = DateTime.now();
  final diffenrece = now.difference(datetime);
  if (diffenrece.inMinutes <= 2) {
    return 'Online';
  } else if (diffenrece.inHours < 24) {
    return '${datetime.hour} : ${datetime.minute}';
  } else {
    return 'Seen on ${datetime.day}/${datetime.month}/${datetime.year}';
  }
}

String getProperFullname(String word) {
  String name = word[0].toUpperCase();

  for (var i = 1; i < word.length; i++) {
    if (word[i - 1] == ' ') {
      name = name + word[i].toUpperCase();
    } else {
      name = name + word[i];
    }
  }
  return name;
}
