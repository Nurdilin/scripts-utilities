sudo gem install bundler &&
sudo git clone git://github.com/beefproject/beef.git &&
sudo apt-get install ruby-dev &&
sudo apt-get install libsqlite3-dev &&
sudo gem install do_sqlite3 &&
cd beef &&
bundle install &&
sudo ruby beef

