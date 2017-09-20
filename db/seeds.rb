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
csgo.nb_players = 5
csgo.game_provider = steam
csgo.save
puts "  "+csgo.name.to_s+" ✅"

lol = Game.find_or_initialize_by(
"name"=>"League Of Legends",
"shortname"=>"LoL",
"img"=>"",
"teambased"=>true
)
lol.nb_players = 5
lol.game_provider = riot_games
lol.save
puts "  "+lol.name.to_s+" ✅"

hs = Game.find_or_initialize_by(
"name"=>"Hearthstone",
"shortname"=>"HS",
"img"=>"",
"teambased"=>false
)
hs.nb_players = 1
hs.game_provider = battlenet
hs.save
puts "  "+hs.name.to_s+" ✅"

rl = Game.find_or_initialize_by(
"name"=>"Rocket League",
"shortname"=>"RL",
"img"=>"",
"teambased"=>true
)
rl.nb_players = 3
rl.game_provider = steam
rl.save
puts "  "+rl.name.to_s+" ✅"

ow = Game.find_or_initialize_by(
"name"=>"Overwatch",
"shortname"=>"OW",
"img"=>"",
"teambased"=>true
)
ow.nb_players = 6
ow.game_provider = battlenet
ow.save
puts "  "+ow.name.to_s+" ✅"

fifa = Game.find_or_initialize_by(
"shortname"=>"Fifa",
"img"=>"",
"teambased"=>false
)
fifa.nb_players = 1
fifa.name = "FIFA 17"
fifa.game_provider = electronic_arts
fifa.save
puts "  "+fifa.name.to_s+" ✅"

ssb = Game.find_or_initialize_by(
"shortname"=>"SSB",
"teambased"=>false
)
ssb.nb_players = 1
ssb.name = "Super Smash Bros."
ssb.game_provider = nintendo
ssb.save
puts "  "+ssb.name.to_s+" ✅"

# ssb_teambased = Game.find_or_initialize_by(
# "shortname"=>"SSB",
# "teambased"=>true
# )
# ssb_teambased.name = "Super Smash Bros 2v2"
# ssb_teambased.game_provider = nintendo
# ssb_teambased.save
# puts "  "+ssb_teambased.name.to_s+" ✅"
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
event_resource.registration_end_at = "2017-09-19 23:59:59"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333240044767895/"
event_resource.game = csgo
event_resource.banner = "csgo"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 16
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - League Of Legends ", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:00:00"
event_resource.registration_end_at = "2017-09-19 23:59:59"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333176392008757/"
event_resource.game = lol
event_resource.banner = "lol"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Overwatch", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.registration_end_at = "2017-09-19 23:59:59"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333241420499689/"
event_resource.game = ow
event_resource.banner = "ow"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Rocket League", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.registration_end_at = "2017-09-19 23:59:59"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436333243433765774/"
event_resource.game = rl
event_resource.banner = "rl"
event_resource.visible = true
event_resource.quota = 16
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Hearthstone", "event_id"=> ggc2k17.id)
event_resource.description = ""
event_resource.start_at = "2017-09-23 09:30:00"
event_resource.registration_end_at = "2017-09-19 23:59:59"
event_resource.remote = false
event_resource.remote_url = "https://widget.toornament.com/tournaments/436334570645769838/"
event_resource.game = hs
event_resource.banner = "hs"
event_resource.visible = true
event_resource.quota = 64
event_resource.locked_quota = 0
event_resource.save
puts "  "+event_resource.title.to_s+" ✅"

ssb_tournament = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Super Smash Bros", "event_id"=> ggc2k17.id)
ssb_tournament.description = "A Smasher has access to all the Smash Bros. animations and tournaments. No Access to the LAN zone through this registration! For seeding purposes, the registration is 100% confirmed only when registered on the smash.gg/ggconvention page after payment."
ssb_tournament.start_at = "2017-09-23 09:30:00"
ssb_tournament.registration_end_at = "2017-09-19 23:59:59"
ssb_tournament.remote = false
ssb_tournament.remote_url = "https://widget.toornament.com/tournaments/436333247862950954/"
ssb_tournament.game = ssb
ssb_tournament.banner = "ssb"
ssb_tournament.visible = true
ssb_tournament.quota = 128
ssb_tournament.locked_quota = 0
ssb_tournament.save
puts "  "+ssb_tournament.title.to_s+" ✅"

# event_resource = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Super Smash Bros 2v2", "event_id"=> ggc2k17.id)
# event_resource.description = ""
# event_resource.start_at = "2017-09-23 09:30:00"
# event_resource.remote = false
# event_resource.remote_url = "https://widget.toornament.com/tournaments/436333247862950954/"
# event_resource.game = ssb_teambased
# event_resource.banner = "ssb"
# event_resource.visible = true
# event_resource.quota = 128
# event_resource.locked_quota = 0
# event_resource.save
# puts "  "+event_resource.title.to_s+" ✅"

fifa_tournament = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Fifa", "event_id"=> ggc2k17.id)
fifa_tournament.description = "The FIFA tournament will take place in the visitors area. No Access to the LAN zone through this registration!"
fifa_tournament.start_at = "2017-09-23 09:30:00"
fifa_tournament.registration_end_at = "2017-09-19 23:59:59"
fifa_tournament.remote = false
fifa_tournament.remote_url = "https://widget.toornament.com/tournaments/"
fifa_tournament.game = fifa
fifa_tournament.banner = "fifa"
fifa_tournament.visible = true
fifa_tournament.quota = 64
fifa_tournament.locked_quota = 64
fifa_tournament.visible = false
fifa_tournament.save
puts "  "+fifa_tournament.title.to_s+" ✅"

manager = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Manager", "event_id"=> ggc2k17.id)
manager.description = "A manager has access to the LAN area and can come with a computer. A table is reserved for him."
manager.start_at = "2017-09-22 11:00:00"
manager.registration_end_at = "2017-09-19 23:59:59"
manager.remote = false
manager.remote_url = ""
manager.game = nil
manager.banner = "manager"
manager.visible = true
manager.quota = 56
manager.locked_quota = 0
manager.save
puts "  "+manager.title.to_s+" ✅"

supporter = EventResource.find_or_initialize_by("title"=>"GGC 2017 - Supporter", "event_id"=> ggc2k17.id)
supporter.description = "A support has access to the LAN area. He can't come with a computer, he is only here to support teammates. There is no table reservation for him."
supporter.start_at = "2017-09-22 11:00:00"
supporter.registration_end_at = "2017-09-19 23:59:59"
supporter.remote = false
supporter.remote_url = ""
supporter.game = nil
supporter.banner = "supporter"
supporter.visible = true
supporter.quota = 80
supporter.locked_quota = 0
supporter.save
puts "  "+supporter.title.to_s+" ✅"

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
<li class=\"list-group-item\">Convention's access - Sunday Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">GGC's Competitions' access</li>
</ul>
</p>"
pack.price = 75
pack.external_reference = "369789"
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Starter\"", "event"=>ggc2k17, "event_resource"=>ssb_tournament)
pack.description = "<p>No perks, only what is necessary!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Convention's access - Saturday Pass</li>
</ul>
</p>"
pack.price = 40
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Starter\"", "event"=>ggc2k17, "event_resource"=>fifa_tournament)
pack.description = "<p>No perks, only what is necessary!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Convention's access - Saturday Pass</li>
</ul>
</p>"
pack.price = 40
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Starter\"", "event"=>ggc2k17, "event_resource"=>supporter)
pack.description = "<p>No perks, only what is necessary!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Convention's access - Saturday Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">A chair to support your teammates (no table)</li>
</ul>
</p>"
pack.price = 40
pack.external_reference = ""
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

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Medium\"", "event"=>ggc2k17, "event_resource"=>ssb_tournament)
pack.description = "<p>The most asked e-sport pack! Offers access for the 3 days of the convention AND for the competitions!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 60
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Medium\"", "event"=>ggc2k17, "event_resource"=>fifa_tournament)
pack.description = "<p>The most asked e-sport pack! Offers access for the 3 days of the convention AND for the competitions!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 60
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Medium\"", "event"=>ggc2k17, "event_resource"=>supporter)
pack.description = "<p>The most asked e-sport pack! Offers access for the 3 days of the convention AND for the competitions!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
<li class=\"list-group-item\">A chair to support your teammates (no table)</li>
</ul>
</p>"
pack.price = 60
pack.external_reference = ""
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

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Pro\"", "event"=>ggc2k17, "event_resource"=>ssb_tournament)
pack.description = "<p>One of our signature packs, it allows you to save time and money!
Enjoy those 3 days all-inclusive. Illimited catering, rest zone, convention access and even more!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">Catering - 3 days</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 100
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Pro\"", "event"=>ggc2k17, "event_resource"=>fifa_tournament)
pack.description = "<p>One of our signature packs, it allows you to save time and money!
Enjoy those 3 days all-inclusive. Illimited catering, rest zone, convention access and even more!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">Catering - 3 days</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
</ul>
</p>"
pack.price = 100
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

pack = EventPack.find_or_initialize_by("name"=>"E-sport \"Pro\"", "event"=>ggc2k17, "event_resource"=>supporter)
pack.description = "<p>One of our signature packs, it allows you to save time and money!
Enjoy those 3 days all-inclusive. Illimited catering, rest zone, convention access and even more!</p>
<h5>Pack content:<h5>
<ul class=\"list-group\">
<li class=\"list-group-item\">Access to the convention - 3 days Pass</li>
<li class=\"list-group-item\">LAN access</li>
<li class=\"list-group-item\">Catering - 3 days</li>
<li class=\"list-group-item\">Rest area</li>
<li class=\"list-group-item\">Goodies \"Second Year\"</li>
<li class=\"list-group-item\">A chair to support your teammates (no table)</li>
</ul>
</p>"
pack.price = 100
pack.external_reference = ""
pack.save
puts "  "+pack.name.to_s+" ✅"

# Create user's rules (later...)
#puts "User's rules creation..."
# UserRule.find_or_initialize_by("name"=>"administrator", "description"=>"Global administration rights. Can administrate every thing.", "value"=>"0")
# UserRule.find_or_initialize_by("name"=>"human resources", "description"=>"Human resources management rights. Can assignate privileges to users", "value"=>"20")
# UserRule.find_or_initialize_by("name"=>"user", "description"=>"Standard user rights. Can manage personal concern", "value"=>"1000")
