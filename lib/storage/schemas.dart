/// The schemas variable stores a table - schema relationship
/// with the key being the table name and the value being the
/// schema sql.
/// This will be invoked on create which is same as on app lauch and
/// create the tables for your
const schemas = <String, String>{
  /// The user's table
  "users": """
    CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY,
      username TEXT NOT NULL UNIQUE,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      admission_number TEXT UNIQUE,
      national_id TEXT UNIQUE,
      gender TEXT,
      address TEXT,
      email TEXT UNIQUE,
      date_of_birth TEXT,
      campus TEXT,
      profile_url TEXT,
      school_profile TEXT,
      password TEXT,
      active INTEGER,
      vibe_points INTEGER,
      point_transactions TEXT,
      date_created TEXT,
      date_updated TEXT
    );
  """,

  // Courses table
  "courses": """
    CREATE TABLE IF NOT EXISTS courses (
      unit TEXT PRIMARY KEY,
      section TEXT NOT NULL,
      day_of_the_week TEXT NOT NULL,
      period TEXT NOT NULL,
      campus TEXT NOT NULL,
      room TEXT NOT NULL,
      lecturer TEXT NOT NULL,
      start_time TEXT,
      stop_time TEXT 
    );
  """,

  // Exams
  "exams": """
    CREATE TABLE IF NOT EXISTS exams (
      course_code TEXT PRIMARY KEY,
      day TEXT NOT NULL,
      time TEXT NOT NULL,
      venue TEXT NOT NULL,
      hrs TEXT NOT NULL,
      invigilator TEXT,
      coordinator TEXT,
      campus TEXT
    );
  """,

  // Rewards table
  "rewards": """
    CREATE TABLE IF NOT EXISTS rewards (
      id TEXT PRIMARY KEY,
      student_id TEXT NOT NULL,
      points INTEGER NOT NULL,
      reason TEXT NOT NULL,
      awarded_at TEXT NOT NULL
    );
  """,
  // todos
  "todos": """
    CREATE TABLE IF NOT EXISTS todos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      sub_tasks INTEGER NOT NULL,
      complete INTEGER NOT NULL,
      notify INTEGER NOT NULL,
      description TEXT NOT NULL,
      due TEXT NOT NULL,
      dateAdded TEXT NOT NULL,
      dateCompleted TEXT
    );
  """,
  "events": """
    CREATE TABLE IF NOT EXISTS events (
      id TEXT PRIMARY KEY,
      date_added TEXT NOT NULL,
      name TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NOT NULL,
      location TEXT NOT NULL,
      likes INTEGER NOT NULL,
      description TEXT NOT NULL,
      media TEXT NOT NULL,
      media_type TEXT NOT NULL,
      url TEXT,
      start_date TEXT NOT NULL,
      end_date TEXT NOT NULL
    );
  """,
  "course_topics": """
    CREATE TABLE IF NOT EXISTS course_topics (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course TEXT NOT NULL,
      name TEXT NOT NULL,
      description TEXT NOT NULL
    );
  """,
  // Anki
  // Topic
  "ankiTopics": """
    CREATE TABLE IF NOT EXISTS ankiTopics (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL,
      desc TEXT NOT NULL,
      is_favourite INTEGER DEFAULT 0 NOT NULL,
      num_cards INTERGER DEFAULT 0 NOT NULL
    );
  """,
  // AnkiCard
  "ankiCards": """
    CREATE TABLE IF NOT EXISTS ankiCards (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      topic_id INTERGER NOT NULL,
      question TEXT NOT NULL,
      answer TEXT NOT NULL,
      FOREIGN KEY(topic_id) REFERENCES ankiTopics(id)
    );
  """,

  //Ask Me
  //Files from Ask Me from which questions are being generated
  "askme_files": """
    CREATE TABLE IF NOT EXISTS askme_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      filePath TEXT NOT NULL,
      avgScore INTEGER NOT NULL
    );
  """,
  //AskMe Scores
  "askme_scores": """
    CREATE TABLE IF NOT EXISTS askme_scores (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      score INTEGER NOT NULL,
      filesId INTEGER,
      FOREIGN KEY (filesId) REFERENCES askme_files(id) ON DELETE CASCADE
    );
  """,
};
