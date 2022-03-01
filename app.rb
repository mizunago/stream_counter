require 'bundler'
Bundler.require
# require 'bundler/setup'
require 'sinatra'
require 'sqlite3'

NGINX = false

def db
  _db = SQLite3::Database.new('db/stream.db')
  sql = <<-SQL
    create table data (
      id INTEGER primary key,
      count INTEGER default '0'
    );
  SQL
  insert_sql = 'INSERT INTO data VALUES(1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 0)'

  begin
    _db.execute(sql)
    _db.execute(insert_sql)
  rescue SQLite3::SQLException => e
    raise if e.message != 'table data already exists'
  end
  _db
end

def select_data
  rows = []
  select_sql = 'SELECT id, count FROM data ORDER BY id'
  db.execute(select_sql) do |row|
    rows << row
  end
  rows
end

def select_count(id)
  count = nil
  select_sql = 'SELECT count FROM data WHERE id = ?'
  db.execute(select_sql, id) do |row|
    count = row[0]
  end
  count
end

def increment_data(id)
  db.transaction do
    count = nil
    select_sql = 'SELECT count FROM data WHERE id = ? ORDER BY id limit 1'
    db.execute(select_sql, id) do |row|
      count = row[0]
    end

    if count
      update_sql = 'UPDATE data SET count = ? WHERE id = ?'
      begin
        db.execute(update_sql, count + 1, id)
      rescue SQLite3::ConstraintException
        raise
      end
    else
      insert_sql = 'INSERT INTO data VALUES(?, ?)'
      begin
        db.execute(insert_sql, id, 1)
      rescue SQLite3::ConstraintException
        raise
      end
    end
  end
end

def reset_data
  update_sql = 'UPDATE data SET count = 0'
  db.execute(update_sql)
end

get '/' do
  id = params['id']
  return '%0.2d' % select_count(id) if id

  button = params['button'].to_i
  case button
  when 0
    # nothing to do. read only
  when 1..6
    increment_data(button)
  when 7
    reset_data
  end

  erb :index
end
