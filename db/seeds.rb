# Create GGC Events
ggcOT = Event.first_or_create("name"=>"GGC Online Tournament", "shortname"=>"GGC Online Tournament", "description"=>"Online ESports Tournament", "date"=>"2017-04-08 20:00:00")
event_resource = EventResource.first_or_create("title"=>"GGC Online Tournament: Overwatch", "description"=>"Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Overwatch tournament.", "start_at"=>"2017-04-08 20:00:00", "remote"=>true, "remote_url"=>"https://widget.toornament.com/tournaments/589d946a140ba044458b461c/","event_id"=> ggcOT.id)
# EventResource.first_or_create("title"=>"", "description"=>"", "start_at"=>"", "remote"=>true, "remote_url"=>"","event_id"=> ggcOT.id)
# EventResource.first_or_create("title"=>"", "description"=>"", "start_at"=>"", "remote"=>true, "remote_url"=>"","event_id"=> ggcOT.id)
# EventResource.first_or_create("title"=>"", "description"=>"", "start_at"=>"", "remote"=>true, "remote_url"=>"","event_id"=> ggcOT.id)


# Create user's rules (later...)
# UserRule.first_or_create("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
# UserRule.first_or_create("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
# UserRule.first_or_create("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
