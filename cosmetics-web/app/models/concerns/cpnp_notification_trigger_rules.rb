module CpnpNotificationTriggerRules
  def get_trigger_rules_question(id)
    TRIGGER_RULES_QUESTION_ID[id]
  end

  def get_trigger_rules_question_element(id)
    TRIGGER_RULES_QUESTION_ELEMENT_ID[id]
  end

  TRIGGER_RULES_QUESTION_ID = {
      100026 => :please_specify_the_percentage_weight_of_ethanol,
      100027 => :please_specify_the_percentage_weight_of_isopropanol,
      100001 => :please_specify_the_inci_name_and_concentration_of_the_antidandruff_agents_if_antidandruff_agents_are_not_present_in_the_cosmetic_product_then_not_applicable_must_be_checked,
      100008 => :please_specify_the_inci_name_and_concentration_of_the_antihair_loss_agents_if_antihair_loss_agents_are_not_present_in_the_cosmetic_product_then_not_applicable_must_be_checked,
      100009 => :please_specify_the_inci_name_and_concentration_of_the_antipigmenting_and_depigmenting_agents_if_antipigmenting_and_depigmenting_agents_are_not_present_in_the_cosmetic_product_then_not_applicable_must_be_checked,
      100010 => :please_specify_the_inci_name_and_concentration_of_chemical_exfoliating_agents_if_chemical_exfoliating_agents_are_not_present_in_the_cosmetic_product_then_not_applicable_must_be_checked,
      100011 => :please_specify_the_exact_content_of_vitamin_a_or_its_derivatives_for_the_whole_product_if_the_level_of_vitamin_a_or_any_of_its_derivatives_does_not_exceed_020_calculated_as_retinol_or_if_the_amount_does_not_exceed_009_grams_calculated_as_retinol_or_if_vitamin_a_or_any_of_its_derivatives_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100012 => :please_specify_the_inci_name_and_the_concentration_of_xanthine_derivatives_eg_caffeine_theophylline_theobromine_plant_extracts_containing_xanthine_derivatives_eg_paulinia_cupana_guarana_extractspowders_if_xanthine_derivatives_are_not_present_or_present_below_05_in_the_cosmetic_product_then_not_applicable_must_be_checked,
      100013 => :please_specify_the_inci_name_and_concentration_of_the_cationic_surfactants_with_two_or_more_chain_lengths_below_c12_if_the_surfactant_is_used_for_non_preservative_purpose_if_cationic_surfactants_with_two_or_more_chain_lengths_below_c12_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100014 => :please_specify_the_inci_name_and_concentration_of_each_propellant_if_propellants_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100015 => :please_specify_the_concentration_of_hydrogen_peroxide_if_hydrogen_peroxide_is_not_present_in_the_product_then_not_applicable_must_be_checked_,
      100016 => :please_specify_the_inci_name_and_the_concentration_of_the_compounds_that_release_hydrogen_peroxide_if_compounds_releasing_hydrogen_peroxide_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100017 => :please_specify_the_inci_name_and_concentration_of_each_reducing_agent_if_reducing_agents_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100018 => :please_specify_the_inci_name_and_concentration_of_each_persulfate_if_persulfates_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100019 => :please_specify_the_inci_name_and_concentration_of_each_straightening_agent_if_straightening_agents_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100020 => :please_indicate_the_total_concentration_of_inorganic_sodium_salts_if_inorganic_sodium_salts_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100021 => :please_indicate_the_concentration_of_fluoride_compounds_calculated_as_fluorine_if_fluoride_compounds_are_not_present_in_the_product_then_not_applicable_must_be_checked,
      100003 => :is_the_ph_of_the_component_lower_than_3_or_higher_than_10,
      100024 => :please_indicate_the_total_level_of_essential_oils_camphor_menthol_or_eucalyptol_if_essential_oils_camphor_menthol_or_eucalyptol_are_not_present_in_the_product_or_if_the_level_of_essential_oils_camphor_menthol_or_eucalyptol_does_not_exceed_05_then_not_applicable_must_be_checked,
      100025 => :please_indicate_the_name_and_the_quantity_of_each_essential_oil_camphor_menthol_or_eucalyptol_if_no_individual_essential_oil_camphor_menthol_or_eucalyptol_are_present_with_a_level_higher_than_05_015_in_case_of_camphor_then_not_applicable_must_be_checked,
      100002 => :please_indicate_the_total_concentration_of_inorganic_sodium_salts,
      100023 => :please_indicate_the_ph_of_the_hair_dye_component,
      100022 => :please_indicate_the_ph_of_the_mixed_hair_dye_product,
      100004 => :please_indicate_the_ph,
      100007 => :please_indicate_the_ph_of_the_mixed_product_,
      100006 => :do_the_components_of_the_product_need_to_be_mixed,
      100005 => :please_indicate_the_inci_name_and_concentration_of_each_alkaline_agent_including_ammonium_hydroxide_liberators
  }.freeze

  TRIGGER_RULES_QUESTION_ELEMENT_ID = {
      100042 => :ethanol,
      100043 => :propanol,
      100001 => :inciname,
      100002 => :incivalue,
      100011 => :inciname,
      100012 => :incivalue,
      100013 => :inciname,
      100014 => :incivalue,
      100015 => :inciname,
      100016 => :incivalue,
      100017 => :value,
      100018 => :inciname,
      100019 => :incivalue,
      100020 => :inciname,
      100021 => :incivalue,
      100022 => :inciname,
      100023 => :incivalue,
      100024 => :value,
      100025 => :inciname,
      100026 => :incivalue,
      100027 => :inciname,
      100028 => :incivalue,
      100029 => :inciname,
      100030 => :incivalue,
      100031 => :inciname,
      100032 => :incivalue,
      100033 => :value,
      100034 => :value,
      100004 => :value,
      100039 => :value,
      100040 => :inciname,
      100041 => :incivalue,
      100003 => :concentration,
      100037 => :minrangevalue,
      100038 => :maxrangevalue,
      100035 => :minrangevalue,
      100036 => :maxrangevalue,
      100005 => :ph,
      100009 => :minrangevalue,
      100010 => :maxrangevalue,
      100008 => :ph,
      100006 => :inciname,
      100007 => :incivalue
  }.freeze
end
