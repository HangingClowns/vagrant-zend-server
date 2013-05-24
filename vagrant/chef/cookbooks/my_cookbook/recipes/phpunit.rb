bash "config pear" do
  code "pear config-set auto_discover 1 2>&1 > /dev/null"
end

bash "config pear proxy" do
  code "pear config-set http_proxy #{node['proxy']['http_proxy']} 2>&1 > /dev/null"
end

execute "install phpunit" do
  command "pear install pear.phpunit.de/PHPUnit 2>&1 > /dev/null"
  not_if "pear list -c pear.phpunit.de | grep PHPUnit"
end