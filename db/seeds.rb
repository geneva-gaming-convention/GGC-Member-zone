# Create GGC Events
Event.find_or_create_by("name"=>"Geneva Gaming Convention 2017", "shortname"=>"GGC 2017", "description"=>"Gaming convention, LAN and much more...", "date"=>"2017-09-21 09:00:00")

# Create user's rules
UserRule.find_or_create_by("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
UserRule.find_or_create_by("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
UserRule.find_or_create_by("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
