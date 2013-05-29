execute "install zend key" do
  command "wget --proxy http://repos.zend.com/zend.key -O- | apt-key add -"
  not_if "apt-key list| grep -c zend"
end

execute "install zend repo" do
  command "echo 'deb http://repos.zend.com/zend-server/6.0/deb_ssl1.0 server non-free' >> /etc/apt/sources.list"
  not_if "grep 'http://repos.zend.com/zend-server/6.0/deb_ssl1.0' -c /etc/apt/sources.list"
end

execute "update apt" do
  command "apt-get update -q -y"
end

package "zend-server-php-5.4"
package "php-5.4-pcntl-zend-server"
package "apache2-mpm-itk"

bash "reload path" do
  code <<-EOC
    . /etc/profile
  EOC
  action :nothing
end

cookbook_file "/etc/profile.d/zend-server.sh" do
  source "zend-server.sh"
  group "root"
  owner "root"
  mode "0644"
  notifies :run, 'bash[reload path]', :immediately
end

cookbook_file "/etc/apache2/sites-available/app.conf" do
  source "app.conf"
  group "root"
  owner "root"
end

execute "disable default site" do
  command "a2dissite default"
end

execute "enable app site" do
  command "a2ensite app.conf"
end

execute "enable pcntl" do
  command <<-EOC 
    sed -i 's,;\\(extension=pcntl.so\\),\\1,g' /usr/local/zend/etc/conf.d/pcntl.ini
  EOC
end

service "apache2" do
  action :restart
end


