local GeneralEntries, SubMenu = MenuEntries['general'], {}

local Expressions = {
    {
      id = 'radio:switchChannel1',
      title = "1",
      icon = "#general-door-keyFob",
      event = "ChannelSet1",
      parameters = { "1" }
  },
  {
      id = 'radio:switchChannel2',
      title = "2",
      icon = "#general-door-keyFob",
      event = "ChannelSet2",
  },
  {
      id = 'radio:switchChannel3',
      title = "3",
      icon = "#general-door-keyFob",
      event = "ChannelSet3",
  },
  {
      id = 'radio:switchChannel4',
      title = "4",
      icon = "#general-door-keyFob",
      event = "ChannelSet4",
  },
  {
      id = 'radio:switchChannel5',
      title = "5",
      icon = "#general-door-keyFob",
      event = "ChannelSet5",
  },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Expressions) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
          id = "radio:switchChannel",
          icon = "#general-door-keyFob",
          title = "Radio",
        },
        subMenus = SubMenu,
        isEnabled = function ()
            return not isDead and exports['isPed']:isPed('myjob') == 'police' and exports['fa-inventory']:hasEnoughOfItem('radio', 1)
        end,
    }
end)

