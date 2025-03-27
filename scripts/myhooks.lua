
--shoutout truelch for most of this fire code
modApi.events.onTestMechEntered:subscribe(function()


  modApi:runLater(function() 
      local pawn = false
          or Game:GetPawn(0)
          or Game:GetPawn(1)
          or Game:GetPawn(2)


      local points = {}
      if pawn and pawn:IsWeaponEquipped("nutellaman111_sand") then
          for j = 0, 7 do
              for i = 0, 7 do
                  local curr = Point(i, j)
                  if not Board:IsBlocked(curr, PATH_PROJECTILE) then
                      points[#points + 1] = curr
                      break
                  end
              end
          end
      end

      local spawnCount = 2 



      for i = 1, spawnCount do
          if #points > 0 then
              local index = math.random(1, #points)
              local spawn = SpaceDamage(points[index], 0)
              spawn.sPawn = "testnutellaman111_jar"
              Board:AddEffect(spawn)
              table.remove(points, index) -- Remove the used point
          end
      end

  end)
end)