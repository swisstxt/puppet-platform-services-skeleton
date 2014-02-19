#
#  IMPORTANT
#
#  Always include the base class as the last 
#  item on every node. Otherwise things will break.
#

node default {
  include base
}
node /^www(-\w+)?(-?\d+)?\./ {
  #include role::www
  include base
}
node /container-\d+\..*/ {
  #include role::container
  include base
}
node /cache-\d+\..*/ {
  #include role::cache
  include base
}

node /^web-.*\./ {
  include base
  include ::role::sochi_api
}
