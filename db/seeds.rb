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

electronic_arts = GameProvider.find_or_initialize_by("name"=>"electronic arts")
electronic_arts.website = "https://www.ea.com/"
electronic_arts.save
puts "  "+electronic_arts.name.to_s+" ✅"

riot_games = GameProvider.find_or_initialize_by("name"=>"riot games")
riot_games.website = "https://www.riotgames.com/"
riot_games.save
puts "  "+riot_games.name.to_s+" ✅"

nintendo = GameProvider.find_or_initialize_by("name"=>"nintendo")
nintendo.website = "http://www.nintendo.com/"
nintendo.save
puts "  "+nintendo.name.to_s+" ✅"
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
lol.game_provider = riot_games
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
rl.game_provider = steam
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

fifa = Game.find_or_initialize_by(
"name"=>"Fifa 18",
"shortname"=>"Fifa",
"img"=>"",
"teambased"=>false
)
fifa.game_provider = electronic_arts
fifa.save
puts "  "+fifa.name.to_s+" ✅"

ssb = Game.find_or_initialize_by(
"shortname"=>"SSB",
"teambased"=>false
)
ssb.name = "Super Smash Bros 1v1"
ssb.game_provider = nintendo
ssb.save
puts "  "+ssb.name.to_s+" ✅"

ssb_teambased = Game.find_or_initialize_by(
"shortname"=>"SSB",
"teambased"=>true
)
ssb_teambased.name = "Super Smash Bros 2v2"
ssb_teambased.game_provider = nintendo
ssb_teambased.save
puts "  "+ssb_teambased.name.to_s+" ✅"
# ------------------------------------------------------------------------------


# Create GGC Events ------------------------------------------------------------
puts "Events creation..."
ggc2k17 = Event.find_or_initialize_by("name"=>"Geneva Gaming Convention 2017")
ggc2k17.shortname = "GGC 2k17"
ggc2k17.description = "The second edition of the Geneva Gaming Convention (GGC) arrives at the Palexpo center from the 22th to the 24th of september 2017. More than 15'000 people, 80 exhibitors and 500 athletes are expected for a total immersion in the gaming universe."
ggc2k17.date = "2017-09-22 11:00:00"
ggc2k17.end_date = "2017-09-24 18:00:00"
ggc2k17.chat_url = "https://discord.gg/yBVSU58"
ggc2k17.visible = true
ggc2k17.save
puts ggc2k17.name.to_s+" ✅"

# GGC 2k17 tournaments
event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Counter-Strike: Global Offensive", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333240044767895/"
event_resource.game = csgo
event_resource.banner = "csgo"
event_resource.visible = true
event_resource.quota = 24
event_resource.locked_quota = 1
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - League Of Legends ", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333176392008757/"
event_resource.game = lol
event_resource.banner = "lol"
event_resource.visible = true
event_resource.quota = 24
event_resource.locked_quota = 1
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Overwatch", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333241420499689/"
event_resource.game = ow
event_resource.banner = "ow"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 1
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Rocket League", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333243433765774/"
event_resource.game = rl
event_resource.banner = "rl"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 1
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Hearthstone", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436334570645769838/"
event_resource.game = hs
event_resource.banner = "hs"
event_resource.visible = true
event_resource.quota = 64
event_resource.locked_quota = 1
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Super Smash Bros 1v1", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333247862950954/"
event_resource.game = ssb
event_resource.banner = "ssb"
event_resource.visible = true
event_resource.quota = 128
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Super Smash Bros 2v2", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333247862950954/"
event_resource.game = ssb_teambased
event_resource.banner = "ssb"
event_resource.visible = true
event_resource.quota = 128
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Fifa", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/"
event_resource.game = fifa
event_resource.banner = "fifa"
event_resource.visible = true
event_resource.quota = 64
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

# GGC Online tournaments
ggcOT = Event.find_or_initialize_by("name"=>"Online Tournament - GGC 2017")
ggcOT.shortname = "GGC Online Tournament"
ggcOT.description = "Geneva Gaming Convention first online tournaments with a LAN entrance offered to the winning teams"
ggcOT.date = "2017-06-03 15:00:00"
ggcOT.end_date = "2017-06-05 20:00:00"
ggcOT.chat_url = "https://discord.gg/yBVSU58"
ggcOT.visible = true
ggcOT.save
puts ggcOT.name.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Overwatch", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Overwatch tournament."
event_resource.start_at = "2017-06-03 07:30:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58f2045e150ba0b0708b4579/"
event_resource.game = ow
event_resource.banner = "ow"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Rocket League", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Rocket League tournament."
event_resource.start_at = "2017-06-03 07:30:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58eb8fca140ba0b40c8b45b7/"
event_resource.game = rl
event_resource.banner = "rl"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Hearthstone", "event_id"=> ggcOT.id)
event_resource.description = "Join the battle to win a free entry for the Geneva Gaming Convention 2017 Hearthstone tournament."
event_resource.start_at = "2017-06-03 08:00:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58ae8d69150ba05d0d8b4588/"
event_resource.game = hs
event_resource.banner = "hs"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: Counter-Strike: Global Offensive", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 CSGO tournament."
event_resource.start_at = "2017-06-03 07:30:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58f20516150ba0f0718b4583/"
event_resource.game = csgo
event_resource.banner = "csgo"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"Online Tournament - GGC 2017: League of Legends", "event_id"=> ggcOT.id)
event_resource.description = "Team up and join the battle to win a free entry for you and your team at the the Geneva Gaming Convention 2017 Leauge of Legends tournament."
event_resource.start_at = "2017-06-03 07:30:00"
event_resource.remote = true
event_resource.remote_url = "https://widget.toornament.com/tournaments/58ab0eb0140ba04b0e8b457e/"
event_resource.game = lol
event_resource.banner = "lol"
event_resource.visible = true
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"
# ------------------------------------------------------------------------------


# Create event's packs
puts "Event's packs creation..."

# => EventPack(id: integer, name: string, description: text, price: decimal, external_reference: string, event_id: integer, created_at: datetime, updated_at: datetime)
pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Starter\"", "event"=>ggc2k17)
pack.description = "<p>No perks, only what is necessary!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Convention's access/Sunday Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">GGC's Competitions' access</li>
</ul>
</p>"
pack.price = 75
pack.external_reference = "369789"
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Medium\"", "event"=>ggc2k17)
pack.description = "<p>The most asked e-sport pack! Offers access for the 3 days of the convention AND for the competitions!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">GGC's Competitions' access</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 95
pack.external_reference = "369784"
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Pro\"", "event"=>ggc2k17)
pack.description = "<p>One of our signature packs, it allows you to save time and money!
Enjoy those 3 days all-inclusive. Illimited catering, rest zone, convention access and even more!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">GGC's Competitions' access</li>
<li class=\"list-group-item\">Catering - 3 days</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 135
pack.external_reference = "369778"
pack.save
puts "  "+pack.name.to_s+" ✅"

# Create user's rules (later...)
#puts "User's rules creation..."
# UserRule.find_or_initialize_by("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
# UserRule.find_or_initialize_by("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
# UserRule.find_or_initialize_by("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
