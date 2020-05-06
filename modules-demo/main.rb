def print_module_details(title, instance_methods, methods, constants, count_only=false, prefix="  ", indent=20)
  puts
  puts title + ":"
  print_element = lambda do |title, array|
    print "#{prefix}#{title.to_s.rjust(indent)} (#{array.count})"
    puts (count_only ? '' : ':  [ '+array.join(',')+ ' ]')
  end
  print_element.call('instance methods', instance_methods)
  print_element.call('methods', methods)
  print_element.call('constants', constants)
  puts
end

# default values
c1 = Object.constants
m1 = Object.methods
mi1 = Object.instance_methods

# module singlenton values
require './module-singleton'
c2 = Object.constants - c1
m2 = Object.methods - m1
mi2 = ModuleSingleton.instance_methods #mi1 - Object.instance_methods

# module for include values
require './module-for-include'
c3 = Object.constants - c1 - c2
m3 = Object.methods - m1 - m2
mi3 = ModuleInclude.instance_methods #mi2 - Object.instance_methods - m2

print_module_details("DEFAULTS (Ruby Object)", mi1, m1, c1, true)
print_module_details("Module Singleton", mi2, m2, c2)
print_module_details("Module For Include", mi3, m3, c3)
