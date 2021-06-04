local open = false
local ESX  = nil
 
-- ESX
-- Added this so you can include the rest of the Usage-stuff found on the GitHub page
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function OpenTrashCan()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local pP = GetPlayerPed(-1)
    TaskPlayAnim(pP, "mp_common", "givetake2_a", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    TaskStartScenarioInPlace(pP, "mp_common", 0, true)
    Citizen.CreateThread(function()
      Citizen.Wait(2000)
      ClearPedTasksImmediately(pP)
    end)
  end)
end

local disableShuffle = true
function disableSeatShuffle(flag)
  disableShuffle = flag
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
      if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
        if GetIsTaskActive(GetPlayerPed(-1), 165) then
          SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
        end
      end
    end
  end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    disableSeatShuffle(false)
    Citizen.Wait(5000)
    disableSeatShuffle(true)
  else
    CancelEvent()
  end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

RegisterCommand("lihatid", function()
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterCommand("tunjukkanktp", function()
  local player, distance = ESX.Game.GetClosestPlayer()

  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))

  OpenTrashCan()
end)

RegisterCommand("lihatsim", function()
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end)

RegisterCommand("tunjukkansim", function()
  local player, distance = ESX.Game.GetClosestPlayer()

  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')

  OpenTrashCan()
end)

RegisterCommand("lihatlisensi", function()
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end)

RegisterCommand("tunjukkansenjataku", function()
  local player, distance = ESX.Game.GetClosestPlayer()

  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')

  OpenTrashCan()
end)