execute "config pear auto discover" do
  command "/usr/local/zend/bin/pear config-set auto_discover 1"
end

execute "config pear proxy" do
  command "/usr/local/zend/bin/pear config-set http_proxy #{node['proxy']['http_proxy']}"
end

execute "install phpunit" do
  command "/usr/local/zend/bin/pear install pear.phpunit.de/PHPUnit"
  not_if "/usr/local/zend/bin/pear list -c pear.phpunit.de | grep PHPUnit"
end

execute "install dbunit" do
  command "/usr/local/zend/bin/pear install pear.phpunit.de/DbUnit"
  not_if "/usr/local/zend/bin/pear list -c pear.phpunit.de | grep DbUnit"
end

execute "install PHP_Invoker" do
  command "/usr/local/zend/bin/pear install pear.phpunit.de/PHP_Invoker"
  not_if "/usr/local/zend/bin/pear list -c pear.phpunit.de | grep PHP_Invoker"
end

execute "install PHPUnit_Selenium" do
  command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Selenium"
  not_if "/usr/local/zend/bin/pear list -c pear.phpunit.de | grep PHPUnit_Selenium"
end

execute "install PHPUnit_Story" do
  command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Story"
  not_if "/usr/local/zend/bin/pear list -c pear.phpunit.de | grep PHPUnit_Story"
end