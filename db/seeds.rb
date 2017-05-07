# Create game providers --------------------------------------------------------
puts "Game providers creation..."
steam = GameProvider.find_or_initialize_by("name"=>"steam")
steam.website = "http://store.steampowered.com"
steam.save
puts "  "+steam.name.to_s+" ✅"

battlenet = GameProvider.find_or_initialize_by("name"=>"battlenet")
battlenet.website = "http://eu.battle.net"
battlenet.save
puts "  "+battlenet.name.to_s+" ✅"
# ------------------------------------------------------------------------------

# Create Games -----------------------------------------------------------------
puts "Games creation..."
csgo = Game.find_or_initialize_by(
"name"=>"Counter-Strike: Global Offensive",
"shortname"=>"CS:GO",
"img"=>"",
"teambased"=>true
)
csgo.game_provider = steam
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
hs.game_provider = battlenet
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
ow.game_provider = battlenet
ow.save
puts "  "+ow.name.to_s+" ✅"

# ------------------------------------------------------------------------------


# Create GGC Events ------------------------------------------------------------
puts "Events creation..."
ggcOT = Event.find_or_initialize_by("name"=>"Online Tournament - GGC 2017")
ggcOT.shortname = "GGC Online Tournament"
ggcOT.description = "Geneva Gaming Convention first online tournaments with a LAN entrance offered to the winning teams"
ggcOT.date = "2017-06-03 15:00:00"
ggcOT.chat_url = "https://discord.gg/yBVSU58"
ggcOT.visible = true
ggcOT.save
puts ggcOT.name.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Overwatch", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Overwatch tournament."
event_resource.start_at = "2017-06-03 09:30:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58f2045e150ba0b0708b4579/"
event_resource.game = ow
event_resource.banner = "ow"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Rocket League", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Rocket League tournament."
event_resource.start_at = "2017-06-03 15:00:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58eb8fca140ba0b40c8b45b7/"
event_resource.game = rl
event_resource.banner = "rl"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Hearthstone", "event_id"=> ggcOT.id)
event_resource.description = "Join the battle to win a free entry for the Geneva Gaming Convention 2017 Hearthstone tournament."
event_resource.start_at = "2017-06-03 10:00:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58ae8d69150ba05d0d8b4588/"
event_resource.game = hs
event_resource.banner = "hs"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Counter-Strike: Global Offensive", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 CSGO tournament."
event_resource.start_at = "2017-06-03 15:00:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58f20516150ba0f0718b4583/"
event_resource.game = csgo
event_resource.banner = "csgo"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: League of Legends", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Leauge of Legends tournament."
event_resource.start_at = "2017-06-03 15:00:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58ab0eb0140ba04b0e8b457e/"
event_resource.game = lol
event_resource.banner = "lol"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"
# ------------------------------------------------------------------------------

# Create user's rules (later...)
#puts "User's rules creation..."
# UserRule.find_or_initialize_by("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
# UserRule.find_or_initialize_by("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
# UserRule.find_or_initialize_by("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
