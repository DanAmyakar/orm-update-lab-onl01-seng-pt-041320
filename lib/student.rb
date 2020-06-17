require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :id, :name, :grade
  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT);
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end
  
  def save
    sql <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create(name:, grade:)
    new_stud = self.new(name, grade)
    new_stud.save
    new_stud
  end
  
  def self.new_from_db(row)
    new_stud = self.new
    new_stud.id = row[0]
    new_stud.name = row[1]
    new_stud.grade = row[2]
  end
  
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    res = DB[:conn].execute(sql, name)[0]
    self.new(res[0], res[1], res[2])
  end
  
  def update
    sql = "UPDATE students SET name = ?, album = ? WHERE "
    DB[:conn].execute(sql)
  end
  
end
