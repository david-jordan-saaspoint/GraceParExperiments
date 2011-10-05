require 'rubygems'
require 'active_record'


ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "library.database")

ActiveRecord::Schema.define do
     
   create_table :libusers do |table|
    #table.column :book_id, :integer
    table.column :b_name, :string
    table.column :b_dob, :date
    table.column :b_status, :string
   end
  
   create_table :books do |table|
  table.column :libuser_id, :integer
       table.column :bk_title, :string
       table.column :bk_borrowed, :date
       table.column :bk_dueback, :date
       table.column :bk_return, :date
    end

end

class Libuser < ActiveRecord::Base
    has_many :books
end

class Book < ActiveRecord::Base
    belongs_to :libuser
end



libuser = Libuser.create(:b_name => 'Peter Hofman', :b_dob => '1953-04-28', :b_status => 'Professor')
libuser.books.create(:bk_title => 'Java for Dummies', :bk_borrowed => '2010-10-24', :bk_dueback => '2010-12-03', :bk_return => '2010-11-01')
libuser.books.create(:bk_title => 'Ruby for Beginners', :bk_borrowed => '2010-10-14', :bk_dueback => '2010-12-03', :bk_return =>'2010-11-03')

libuser = Libuser.create(:b_name => 'Jack Mall', :b_dob => '1983-06-20', :b_status => 'Research')
libuser.books.create(:bk_title => 'Java for Dummies', :bk_borrowed => '2010-10-02', :bk_dueback => '2010-12-03', :bk_return =>'2010-10-20')
libuser.books.create(:bk_title => 'Ruby: Programming Guide', :bk_borrowed => '2010-09-04', :bk_dueback => '2010-12-03', :bk_return =>'2010-10-10')

libuser = Libuser.create(:b_name => 'Aida Slik', :b_dob => '8-Dec-1988', :b_status => 'UG')
libuser.books.create(:bk_title => 'Wireless Networking', :bk_borrowed => '2010-08-17', :bk_dueback => '2010-08-31', :bk_return =>'')
libuser.books.create(:bk_title => 'Ruby: Programming Guide', :bk_borrowed => '2010-10-24', :bk_dueback => '2010-10-26', :bk_return =>'2010-10-26')
libuser.books.create(:bk_title => 'Java for Dummies', :bk_borrowed => '2010-11-05', :bk_dueback => '2010-11-08', :bk_return =>'')

libuser = Libuser.create(:b_name => 'Ron Marcus', :b_dob => '3-Apr-1979', :b_status => 'Research')
libuser.books.create(:bk_title => 'Wireless Networking', :bk_borrowed => '2010-08-04', :bk_dueback => '2010-08-16', :bk_return =>'2010-08-16')

libuser = Libuser.create(:b_name => 'Sarah Suman', :b_dob => '7-May-1989', :b_status => 'UG')
libuser.books.create(:bk_title => 'Ruby for Beginners', :bk_borrowed => '2010-09-04', :bk_dueback => '2010-12-03', :bk_return =>'2010-10-10')
libuser.books.create(:bk_title => 'Ruby for Beginners', :bk_borrowed => '2010-11-03', :bk_dueback => '2010-11-30', :bk_return =>'')

libuser = Libuser.create(:b_name => 'Sandy James', :b_dob => '13-Feb-1989', :b_status => 'UG')


### To output the data #####


  p Book.find(:all)

 





