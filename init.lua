minetest.register_node("zythias_lantern:lantern",{
	
	description="Lantern",
	drawtype="plantlike",
	tiles={name="zythias_lantern_lantern.png"},
	wield_image = "zythias_lantern_lantern.png",
	paramtype="light",
	paramtype2="wallmounted",
	sunlight_propagates=true,
	walkable=false,
	liquids_pointable=false,
	light_source=15,
	groups={choppy=2, dig_immediate=3, flammable=1, attach_node=1, torch=1},
	drop="zythias_lantern:lantern",
	inventory_image="zythias_lantern_lantern.png",
	stack_max=1,
})

minetest.register_craft({

	output="zythias_lantern:lantern",
	recipe= {
		{"default:steel_ingot", "default:obsidian_shard", "default:steel_ingot"},
		{"default:glass", "default:torch", "default:glass",},
		{"default:steel_ingot", "default:diamond", "default:steel_ingot",},
	},
})

minetest.register_node("zythias_lantern:airlight",{

	description="Air Light",
	inventory_image="zythias_lantern_airlight.png",
	drawtype="airlike",
	walkable=false,
	diggable=false,
	pointable=false,
	buildable_to=true,
	sunlight_propagates=true,
	light_source=14,
	on_timer=function(pos)
		minetest.set_node(pos,{name="air"})
	end
})

minetest.register_globalstep(function(dtime)
	
	for _,player in ipairs( minetest.get_connected_players() )do

		if player:get_wielded_item():get_name()=="zythias_lantern:lantern"then
			local node = minetest.get_node(player:getpos())
			if node.name ~= "air" then
				local vpos = vector.new(player:getpos().x, player:getpos().y+1, player:getpos().z)
				node = minetest.get_node(vpos)
				if node.name == "air" then
					minetest.set_node(vpos,{name="zythias_lantern:airlight"})
					minetest.get_node_timer(vpos):set(0.2, 0)
				end
			else
				minetest.set_node(player:getpos(),{name="zythias_lantern:airlight"})
				minetest.get_node_timer(player:getpos()):set(0.2, 0)
			end
		end
	end
end)