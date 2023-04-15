
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "fa-apartments:handler", key = { forclose = true} },
          { title = "No", action = "fa-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
