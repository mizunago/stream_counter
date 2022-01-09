#!/home/nagonago/.rbenv/versions/2.7.4/bin/ruby
# #!/usr/bin/ruby
# encoding: utf-8

require 'bundler'
Bundler.require
# require 'bundler/setup'
require 'sinatra'
require 'sqlite3'

def db
  _db = SQLite3::Database.new('db/stream.db')
  sql = <<-SQL
    create table data (
      id INTEGER primary key,
      count INTEGER default '0'
    );
  SQL

  begin
    _db.execute(sql)
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
  update_sql = 'DELETE FROM data WHERE id NOT BETWEEN 1 AND 6'
  db.execute(update_sql)
end

get '/' do
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
