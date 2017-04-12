# Create Games -----------------------------------------------------------------
puts "Games creation..."
csgo = Game.find_or_initialize_by(
"name"=>"Counter-Strike: Global Offensive",
"shortname"=>"CS:GO",
"img"=>"",
"teambased"=>true
)
csgo.save
puts "  "+csgo.name.to_s+" ✅"

lol = Game.find_or_initialize_by(
"name"=>"League Of Legends",
"shortname"=>"LoL",
"img"=>"",
"teambased"=>true
)
lol.save
puts "  "+lol.name.to_s+" ✅"

hs = Game.find_or_initialize_by(
"name"=>"Hearthstone",
"shortname"=>"HS",
"img"=>"",
"teambased"=>false
)
hs.save
puts "  "+hs.name.to_s+" ✅"

rl = Game.find_or_initialize_by(
"name"=>"Rocket League",
"shortname"=>"RL",
"img"=>"",
"teambased"=>true
)
rl.save
puts "  "+rl.name.to_s+" ✅"

ow = Game.find_or_initialize_by(
"name"=>"Overwatch",
"shortname"=>"OW",
"img"=>"",
"teambased"=>true
)
ow.save
puts "  "+ow.name.to_s+" ✅"

# ------------------------------------------------------------------------------


# Create GGC Events ------------------------------------------------------------
puts "Events creation..."
ggcOT = Event.find_or_initialize_by(
"name"=>"Online Tournament - GGC 2017",
"shortname"=>"GGC Online Tournament",
"description"=>"Geneva Gaming Convention first online tournaments with a LAN entrance offered to the winning teams",
"date"=>"2017-06-03 09:45:00",
"chat_url" => "https://discord.gg/yBVSU58",
"visible" => true
)
ggcOT.save
puts ggcOT.name.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by(
"title"=>"Online Tournament - GGC 2017: Overwatch",
"description"=>"Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Overwatch tournament.",
"start_at"=>"2017-06-03 09:45:00",
"remote"=>true,
"remote_url"=>"https://widget.toornament.com/tournaments/589d946a140ba044458b461c/",
"event_id"=> ggcOT.id,
"game"=>ow,
"banner"=>"ow",
"visible" => true
)
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by(
"title"=>"Online Tournament - GGC 2017: Rocket League",
"description"=>"Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Rocket League tournament.",
"start_at"=>"2017-06-03 09:45:00",
"remote"=>true,
"remote_url"=>"https://widget.toornament.com/tournaments/58eb8fca140ba0b40c8b45b7/",
"event_id"=> ggcOT.id,
"game"=>rl,
"banner"=>"rl",
"visible" => true
)
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by(
"title"=>"Online Tournament - GGC 2017: Hearthstone",
"description"=>"Join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Hearthstone tournament.",
"start_at"=>"2017-06-03 09:45:00",
"remote"=>true,
"remote_url"=>"https://widget.toornament.com/tournaments/58ae8d69150ba05d0d8b4588/",
"event_id"=> ggcOT.id,
"game"=>hs,
"banner"=>"hs",
"visible" => true
)
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by(
"title"=>"Online Tournament - GGC 2017: Counter-Strike: Global Offensive",
"description"=>"Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 CSGO tournament.",
"start_at"=>"2017-06-03 09:45:00",
"remote"=>true,
"remote_url"=>"",
"event_id"=> ggcOT.id,
"game"=>csgo,
"banner"=>"cs",
"visible" => true
)
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by(
"title"=>"Online Tournament - GGC 2017: League of Legends",
"description"=>"Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Leauge of Legends tournament.",
"start_at"=>"2017-06-03 15:00:00",
"remote"=>true,
"remote_url"=>"https://widget.toornament.com/tournaments/58ab0eb0140ba04b0e8b457e/",
"event_id"=> ggcOT.id,
"game"=>lol,
"banner"=>"lol",
"visible" => true
)
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"
# ------------------------------------------------------------------------------

# Create user's rules (later...)
#puts "User's rules creation..."
# UserRule.find_or_initialize_by("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
# UserRule.find_or_initialize_by("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
# UserRule.find_or_initialize_by("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
