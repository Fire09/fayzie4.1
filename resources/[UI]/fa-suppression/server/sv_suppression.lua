local BlacklistedModels = {
  -- Peds
  [`a_c_seagull`] = true,
  [`a_c_pigeon`] = true,
  [`a_c_rat`] = true,
  [`s_m_y_armymech_01`] = true,
  [`csb_mweather`] = true,
  [`csb_ramp_marine`] = true,
  [`s_m_m_marine_01`] = true,
  [`s_m_y_marine_01`] = true,
  [`s_m_m_marine_02`] = true,
  [`s_m_y_marine_02`] = true,
  [`s_m_y_marine_03`] = true,
  [`s_m_y_blackops_01`] = true,
  [`s_m_y_blackops_02`] = true,
  [`s_m_y_blackops_03`] = true,
  [`s_m_y_swat_01`] = true,
  [`s_f_y_cop_01`] = true,
  [`s_m_y_cop_01`] = true,
  [`csb_cop`] = true,
  [`s_m_y_hwaycop_01`] = true,
  [`s_m_m_security_01`] = true,
  [`mp_m_securoguard_01`] = true,
  [337826907] = true,
  
  -- Vehicle
  [`BLIMP`] = true,
  [`BLIMP2`] = true,
  [`JET`] = true,
  [`LAZER`] = true,
  [`TITAN`] = true,
  [`BARRACKS`] = true,
  [`BARRACKS2`] = true,
  [`CRUSADER`] = true,
  [`RHINO`] = true,
  [`POLICE`] = true,
  [`POLICE2`] = true,
  [`POLICE3`] = true,
  [`POLICE4`] = true,
  [`POLMAV`] = true,
  [`PREDATOR`] = true,
  [`AMBULANCE`] = true,
  [`BUZZARD`] = true,
  [`BUZZARD2`] = true,
  [`CARGOBOB`] = true,
  [`CARGOBOB2`] = true,
  [`CARGOBOB3`] = true,
  [`CARGOBOB4`] = true,
  [`SHERIFF`] = true,
  [`SHERIFF2`] = true,
  [`FIRETRUK`] = true,

  [`INFERNUS2`] = true,
  [`TORERO`] = true,
  [`STOCKADE`] = "moneytruck",
}

local BlacklistedProps = {
  [`apa_mp_apa_crashed_usaf_01a`] = true,
  [`apa_mp_apa_yacht_door`] = true,
  [`apa_mp_apa_yacht_door2`] = true,
  [`apa_mp_apa_yacht_jacuzzi_cam`] = true,
  [`apa_mp_apa_yacht_jacuzzi_ripple1`] = true,
  [`apa_mp_apa_yacht_jacuzzi_ripple2`] = true,
  [`apa_mp_apa_yacht_jacuzzi_ripple003`] = true,
  [`apa_mp_apa_yacht_o1_rail_a`] = true,
  [`apa_mp_apa_yacht_o1_rail_b`] = true,
  [`apa_mp_apa_yacht_o2_rail_a`] = true,
  [`apa_mp_apa_yacht_o2_rail_b`] = true,
  [`apa_mp_apa_yacht_o3_rail_a`] = true,
  [`apa_mp_apa_yacht_o3_rail_b`] = true,
  [`apa_mp_apa_yacht_option1`] = true,
  [`apa_mp_apa_yacht_option1_cola`] = true,
  [`apa_mp_apa_yacht_option2`] = true,
  [`apa_mp_apa_yacht_option2_cola`] = true,
  [`apa_mp_apa_yacht_option2_colb`] = true,
  [`apa_mp_apa_yacht_option3`] = true,
  [`apa_mp_apa_yacht_option3_cola`] = true,
  [`apa_mp_apa_yacht_option3_colb`] = true,
  [`apa_mp_apa_yacht_option3_colc`] = true,
  [`apa_mp_apa_yacht_option3_cold`] = true,
  [`stt_prop_wallride_05`] = true,
  [`stt_prop_wallride_05b`] = true,
  [`stt_prop_wallride_45l`] = true,
  [`stt_prop_wallride_45la`] = true,
  [`stt_prop_wallride_45r`] = true,
  [`stt_prop_wallride_45ra`] = true,
  [`stt_prop_wallride_90l`] = true,
  [`stt_prop_wallride_90lb`] = true,
  [`stt_prop_wallride_90r`] = true,
  [`stt_prop_wallride_90rb`] = true,
  [`test_prop_gravestones_01a`] = true,
  [`test_prop_gravestones_02a`] = true,
  [`test_prop_gravestones_04a`] = true,
  [`test_prop_gravestones_05a`] = true,
  [`test_prop_gravestones_07a`] = true,
  [`test_prop_gravestones_08a`] = true,
  [`test_prop_gravestones_09a`] = true,
  [`v_44_planeticket`] = true,
  [`v_ilev_bk_vaultdoor`] = true,
  [`v_ilev_found_cranebucket`] = true,
  [`v_res_fa_stones01`] = true,
  [`v_res_mexball`] = true,
  [`xm_prop_x17_shamal_crash`] = true,
  [`xm_prop_hamburgher_wl`] = true,
  [`xm_prop_plastic_bottle_wl`] = true,
}

local PropWhitelist = {
  [`prop_bowling_pin`] = true,
  [`prop_cash_case_01`] = true,
  [`prop_cs_ciggy_01`] = true,
  [`prop_notepad_01`] = true,
  [`prop_player_phone_01`] = true,
  [`prop_anim_cash_pile_01`] = true,
  [`prop_coffee_mac_02`] = true,
  [`prop_ecola_can`] = true,
  [`prop_security_case_01`] = true,
  [`prop_ld_case_01`] = true,
  [`prop_energy_drink`] = true,
  [`prop_amb_ciggy_01`] = true,
  [`prop_cs_hand_radio`] = true,
  [`prop_ld_health_pack`] = true,
  [`prop_cash_case_02`] = true,
  [`xm_prop_x17_bag_01a`] = true,
  [`prop_cigar_02`] = true,
  [`np_npc_card`] = true,
  [`p_ing_microphonel_01_lsbn`] = true,
  [`prop_drink_whisky`] = true,
  [`p_whiskey_bottle_s`] = true,
  [`prop_armour_pickup`] = true,
  [`prop_golf_iron_01`] = true,
  [`prop_amb_donut`] = true,
  [`prop_food_bs_chips`] = true,
  [`prop_megaphone_01`] = true,
  [`np_npc_card`] = true,
  [`p_ing_microphonel_01`] = true,
  [`prop_golf_iron_01`] = true,
  [`np_npc_binder`] = true,
  [`v_ilev_mp_bedsidebook`] = true,
  [`prop_vodka_bottle`] = true,
  [`p_cs_bottle_01`] = true,
  [`p_amb_coffeecup_01`] = true,
  [`p_amb_clipboard_01`] = true,
  [`prop_cs_cardbox_01`] = true,
  [`prop_idol_case_01`] = true,
  [`prop_golf_iron_01`] = true,
  [`hei_prop_heist_weed_block_01`] = true,
  [`prop_weed_bottle`] = true,
  [`prop_shots_glass_cs`] = true,
  [`prop_drink_redwine`] = true,
  [`prop_food_bs_juice01`] = true,
  [`prop_cs_street_binbag_01`] = true,
  [`prop_police_id_board`] = true,
  [`prop_cs_walking_stick`] = true,
  [`denis3d_policebadge_01`] = true,
  [`prop_boombox_01`] = true,
  [`prop_food_bs_coffee`] = true,
  [`hei_prop_hei_bust_01`] = true,
  [`prop_dym_pc_02`] = true,
  [`prop_taco_01`] = true,
  [`prop_golf_pitcher_01`] = true,
  [`prop_speaker_06`] = true,
  [`prop_meth_bag_01`] = true,
  [`ba_prop_battle_glowstick_01`] = true,
  [`prop_golf_iron_01`] = true,
  [`prop_golf_driver`] = true,
  [`prop_cs_brain_chunk`] = true,
  [`prop_sandwich_01`] = true,
  [`prop_golf_bag_01`] = true,
  [`prop_tennis_rack_01`] = true,
  [`ng_proc_food_aple2a`] = true,
  [`v_res_mcofcup`] = true,
  [`p_amb_clipboard_01`] = true,
  [`prop_cs_tablet`] = true,
  [`prop_beer_bottle`] = true,
  [`prop_golf_putter_01`] = true,
  [`prop_ld_flow_bottle`] = true,
  [`prop_tool_box_04`] = true,
  [`prop_amb_ciggy_01`] = true,
  [`prop_cigar_01`] = true,
  [`prop_ld_bomb`] = true,
  [`prop_v_bmike_01`] = true,
  [`ba_prop_battle_hobby_horse`] = true,
  [`prop_plastic_cup_02`] = true,
  [`ba_prop_battle_glowstick_01`] = true,
  [`prop_v_cam_01`] = true,
  [`prop_micro_02`] = true,
  [`prop_tv_flat_02`] = true,
  [`prop_cliff_paper`] = true,
  [`hei_prop_heist_drill`] = true,
  [`prop_pencil_01`] = true,
  [`prop_cs_burger_01`] = true,
  [`prop_bowling_ball`] = true,
  [`xm_prop_x17_bag_med_01a`] = true,
  [`prop_big_shit_01`] = true,
  [`prop_anim_cash_note`] = true,
  [`prop_oiltub_06`] = true,
  [`prop_amb_ciggy_01`] = true,
  [`prop_cs_heist_bag_01`] = true,
  [`prop_fishing_rod_01`] = true,
  [`prop_barrier_work05`] = true,
  [`prop_mp_cone_01`] = true,
  [`hei_prop_heist_thermite`] = true,
  [`prop_chair_01a`] = true,
  [`prop_cigar_03`] = true,
  [`hei_p_m_bag_var22_arm_s`] = true,
  [`p_parachute1_mp_s`] = true,
  [`ch_prop_ch_cash_trolley_01c`] = true,
  [`ch_prop_ch_cash_trolley_01c_empty`] = true,
  [`hei_prop_hst_laptop`] = true,
  [`hei_prop_heist_cash_pile`] = true,
  [`ch_prop_gold_bar_01a`] = true,
  [`prop_juicestand`] = true,
  [`p_attache_case_01_s`] = true,
  [`p_balaclavamichael_s`] = true,
  [`p_binbag_01_s`] = true,
  [`p_counter_04_glass`] = true,
  [`p_cs_beachtowel_01_s`] = true,
  [`p_cs_bottle_01`] = true,
  [`p_cs_bowl_01b_s`] = true,
  [`p_cs_clipboard`] = true,
  [`p_cs_clothes_box_s`] = true,
  [`p_cs_laptop_02`] = true,
  [`p_cs_laptop_02_w`] = true,
  [`p_cs_locker_01`] = true,
  [`p_cs_locker_01_s`] = true,
  [`p_cs_locker_02`] = true,
  [`p_cs_locker_door_01`] = true,
  [`p_cs_locker_door_01b`] = true,
  [`p_cs_locker_door_02`] = true,
  [`p_cs_shot_glass_s`] = true,
  [`p_cs_toaster_s`] = true,
  [`p_defilied_ragdoll_01_s`] = true,
  [`p_devin_box_01_s`] = true,
  [`p_dinechair_01_s`] = true,
  [`p_folding_chair_01_s`] = true,
  [`p_devin_box_01_s`] = true,
  [`p_dinechair_01_s`] = true,
  [`p_folding_chair_01_s`] = true,
  [`p_gaffer_tape_s`] = true,
  [`p_gasmask_s`] = true,
  [`p_idol_case_s`] = true,
  [`p_ilev_p_easychair_s`] = true,
  [`p_ing_coffeecup_01`] = true,
  [`p_ing_coffeecup_02`] = true,
  [`p_ing_microphonel_01`] = true,
  [`p_int_jewel_mirror`] = true,
  [`p_int_jewel_plant_01`] = true,
  [`p_int_jewel_plant_02`] = true,
  [`p_laptop_02_s`] = true,
  [`p_ld_am_ball_01`] = true,
  [`p_lev_sofa_s`] = true,
  [`p_orleans_mask_s`] = true,
  [`p_ortega_necklace_s`] = true,
  [`p_oscar_necklace_s`] = true,
  [`p_overalls_02_s`] = true,
  [`p_pallet_02a_s`] = true,
  [`p_panties_s`] = true,
  [`p_pantio_lounger1_s`] = true,
  [`p_pharm_unit_01`] = true,
  [`p_pharm_unit_02`] = true,
  [`p_planning_board_01`] = true,
  [`p_planning_board_02`] = true,
  [`p_planning_board_03`] = true,
  [`p_planning_board_04`] = true,
  [`p_res_sofa_l_s`] = true,
  [`p_soloffchair_s`] = true,
  [`p_tennis_bag_01_s`] = true,
  [`p_tourist_map_01_s`] = true,
  [`p_v_med_p_sofa_l_s`] = true,
  [`p_v_res_tt_bed_s`] = true,
  [`p_w_grass_gls_s`] = true,
  [`p_wade_necklace_s`] = true,
  [`p_whiskey_bottle_s`] = true,
  [`p_whiskey_notop`] = true,
  [`p_whiskey_notop_empty`] = true,
  [`p_yoga_mat_02_s`] = true,
  [`p_yoga_mat_03_s`] = true,
  [`p_ld_bs_bag_01`] = true,
  [`p_ld_sax`] = true,
  [`p_ld_soc_ball_01`] = true,
  [`p_watch_01`] = true,
  [`p_watch_02`] = true,
  [`p_watch_03`] = true,
  [`p_watch_04`] = true,
  [`p_watch_05`] = true,
  [`p_watch_06`] = true,
  [`p_armchair_01_s`] = true,
  [`p_s_scuba_tank_s`] = true,
  [`p_s_scuba_mask_s`] = true,
  [`p_amb_brolly_01`] = true,
  [`p_amb_brolly_01_s`] = true,
  [`prop_cs_crackpipe`] = true,
  [`prop_knife`] = true,
  [`prop_cs_steak`] = true,
  [`v_ilev_exball_blue`] = true,
  [`p_parachute1_mp_dec`] = true,
  [`p_parachute2_mp_dec`] = true,
  [`denis3d_teddyboe`] = true,
  [`np_boxing_bl_l`] = true,
  [`np_boxing_b_l`] = true,
  [`np_boxing_r_l`] = true,
  [`np_boxing_bl_r`] = true,
  [`np_boxing_b_r`] = true,
  [`np_boxing_r_r`] = true,
  [`prop_mug_02`] = true,
  [`prop_studio_light_02`] = true,
  [`prop_tool_pickaxe`] = true,
  [`prop_wateringcan`] = true,
  [`prop_cs_cardbox_01`] = true,
  [`w_am_digiscanner`] = true,
  [`prop_container_04a`] = true,
  [`w_ex_cash`] = true,
  [`w_ex_book`] = true,
  [`w_am_metaldetector`] = true,
  [`prop_golf_ball`] = true,
  [`prop_golf_tee`] = true,
  [`prop_golf_wood_01`] = true,
  [`prop_golf_iron_01`] = true,
  [`prop_golf_pitcher_01`] = true,
  [`prop_golf_putter_01`] = true,
  [`prop_golf_ball_p2`] = true,
  [`prop_golf_ball_p3`] = true,
  [`prop_golf_ball_p4`] = true,
  [`prop_cs_box_clothes`] = true,
  [`prop_hat_box_06`] = true,
  [`prop_tool_broom`] = true,
  [`prop_beach_sandcas_01`] = true,
  [`prop_beach_sandcas_03`] = true,
  [`prop_beach_sandcas_04`] = true,
  [`prop_beach_sandcas_05`] = true,
  [`prop_skid_chair_01`] = true,
  [`prop_skid_chair_02`] = true,
  [`prop_sign_road_01a`] = true,
  [`prop_golfflag`] = true,
  [`cg_chain`] = true,
}

local CheatAttempts = {}
local LastAlert = {}

AddEventHandler("fa-fiber:exploiterAlert", function(pServerId, pMessage, pValue)
    if not CheatAttempts[pServerId] then CheatAttempts[pServerId] = 0 end

    CheatAttempts[pServerId] = CheatAttempts[pServerId] + 1

    if (CheatAttempts[pServerId] < 4) then return end

    local time = GetGameTimer()

    if (LastAlert[pServerId] ~= nil and (time - LastAlert[pServerId]) < 15000) then return end

    local user = exports["fa-base"]:getModule("Player"):GetUser(pServerId)
    local coords = GetEntityCoords(GetPlayerPed(pServerId))

    --exports["fa-log"]:AddLog("Exploiter", user, message .. ("\nSteam: %s\nCoords: %s"):format(user.steamid, coords), value)

    LastAlert[pServerId] = time
end)    

local Bypassed = {}
local isPublicServer = nil

AddEventHandler("fa-suppression:bypass", function(pVehicle)
    Bypassed[pVehicle] = true
end)    

local currentTime = 0
local moneyTruckCooldown = 120000
local canSpawnMoneyTruckNow = false

--[[Citizen.CreateThread(function()
    while true do
      Wait(60000)
      currentTime = GetGameTimer()
      if (not canSpawnMoneyTruckNow) and moneyTruckLastSpawnTime + moneyTruckCooldown < currentTime then
        --canSpawnMoneyTruckNow = true
      end  
    end    
end)]]

RegisterNetEvent("entityCreating")
AddEventHandler("entityCreating", function(pEntity)
    if Bypassed[pEntity] then Bypassed[pEntity] = nil return end

    if PublicServer then
        isPublicServer = exports["fa-config"]:IsPublic()
    end
    
    local model = GetEntityModel(pEntity)

    if (PropWhitelist[model] or model == 0) then return end

    local entityType = GetEntityType(pEntity)

    if BlacklistedProps[model] or entityType == 3 then
        local owner = NetworkGetEntityOwner(pEntity)
        local coords = GetEntityCoords(pEntity)

        CancelEvent()

        if (owner == 0) then return end

        local data = { model = model, coords = coords }

        local message = ("User attempted to spawn blacklisted prop\nProp: %s"):format(model)

        TriggerEvent("fa-fiber:exploiterAlert", owner, message, data)

        return
    end
    
    local ref = BlacklistedModels[model]
    
    if not ref then return end

    if ref == true then
        CancelEvent()
        return
    end

    if isPublicServer or not canSpawnMoneyTruckNow then
        CancelEvent()
        return
    end

    if canSpawnMoneyTruckNow and ref == "moneytruck" then
        canSpawnMoneyTruckNow = false
        moneyTruckLastSpawnTime = GetGameTimer()
        if math.random() > 0.2 then
            CancelEvent()
        end
      end
    --end
end)              