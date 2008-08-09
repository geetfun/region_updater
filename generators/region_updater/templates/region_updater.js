var updateRegion = {
	region: function() {
		$('regioner').hide();
		$('regioner2').hide();
		var country = this.getValue();
		var label = Countries.get(this.getValue());
		if (label) {
			label = label.get("label");
			if (label=="null") {
				label=""
			} else {
				var regions = Countries.get(country).get("regions");	
			}
			$('regioner').innerHTML = label;
			$('regioner').show();
			var return_choices = '';
			var choices = regions.each(function(s) {
				return_choices += '<option>' + s + '</option>';
			});
			$('regioner2').innerHTML = return_choices;
			$('regioner2').show();
		} else {
			return false;
		}
	}
};

function RegionSelect() {
	$('country_selector').observe('change', updateRegion.region);
};

Event.observe(window, 'load', RegionSelect);