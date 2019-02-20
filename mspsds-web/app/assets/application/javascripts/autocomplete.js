import $ from 'jquery';
import accessibleAutocomplete from 'accessible-autocomplete';

export function simpleAccessibleAutocomplete(id, autocompleteOptions) {
  const element = document.getElementById(id);

  const options = autocompleteOptions || {};
  if (element) {
    accessibleAutocomplete.enhanceSelectElement({
      defaultValue: '',
      selectElement: element,
      showAllValues: options.showAllValues,
      preserveNullOptions: true,
    });

    // In the case that the user deletes the entry from the field, we want this to be reflected in
    // the underlying select. This is a work-around to
    // https://github.com/alphagov/accessible-autocomplete/issues/205
    const $enhancedElement = $(element).parent().find('input');
    $enhancedElement.on('keyup', () => {
      if ($enhancedElement.val() !== $(element).find('option:selected').text()) {
        $(element).val('');
      }
    });

    // If we display a down arrow we want clicking on it to cause the same effect as clicking on
    // input field, showing all values. This is a work-around to
    // https://github.com/alphagov/accessible-autocomplete/issues/202
    const $downArrow = $(element).parent().find('svg');
    if ($downArrow) {
      $downArrow.on('click', () => {
        $enhancedElement.focus();
        $enhancedElement.click();
      });
    }

    // This adds ability to remove currently selected input by pressing on an X next to it
    // This is a work-around to
    // https://github.com/alphagov/accessible-autocomplete/issues/240
    const removeButton = document.getElementById(`remove-${id}`);
    if (removeButton) {
      removeButton.addEventListener('keyPress', () => {
        $enhancedElement.val('');
        $enhancedElement.click().focus().blur();
        $(element).parent().find('select').val('');
      });
      removeButton.addEventListener('click', () => {
        $enhancedElement.val('');
        $enhancedElement.click().focus().blur();
        $(element).parent().find('select').val('');
      });
    }
  }
}

export function callAutocompleteWhenReady(id, options) {
    $(document).ready(() => {
        console.log('Document ready ')
        simpleAccessibleAutocomplete(id, options)
    });
}
window.callAutocompleteWhenReady = callAutocompleteWhenReady;
