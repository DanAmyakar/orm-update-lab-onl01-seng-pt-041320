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
      CREATE TABLE IF NOT EXIST students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    sql <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create(name:, grade:)
    new_stud = self.new
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
    sql = <<-SQL
      
    SQL
end
