var updateRegion = {
	region: function() {
		// resets
		$('region_label').hide();
		$('region_select').hide();
		
		// performs update of region
		var country = this.getValue();
		var label = RegionUpdaterCountries.get(this.getValue());
		if (label) {
			label = label.get("label");
			if (label=="null") {
				label=""
			} else {
				var regions = RegionUpdaterCountries.get(country).get("regions");	
			}
			$('region_label').innerHTML = label;
			$('region_label').show();
			var return_choices = '<option>Choose a selection</option>';
			var choices = regions.each(function(s) {
				return_choices += '<option>' + s + '</option>';
			});
			$('region_select').innerHTML = return_choices;
			$('region_select').show();
		} else {
			return false;
		}
	}
};

function RegionSelect() {
	$('country_selector').observe('change', updateRegion.region);
};

Event.observe(window, 'load', RegionSelect);