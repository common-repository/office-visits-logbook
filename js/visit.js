/*
  Author: Ming's IT Services Ltd.
  Date: 2018-09-01
  Email: mingtl2010@gmail.com
  Copyright: All rights reserved.
*/
var visit_drop_counter = 0, allCorrect = true, startTimeEmpty = false, endTimeEmpty = false, endTimeEarlierThanStartTime = false;
var startTimeWrongDateFormat = false, endTimeWrongDateFormat = false, endTimeNotEqualToNextStartTime = false;

jQuery(function() {   
    jQuery('input.timepicker').each(function(){
        jQuery(this).datetimepicker({
            format:'H:i',
            datepicker:false,
        });
    });
});

//validate date xxxx-xx-xx
function isValidDate(dateString) {
  var regEx = /^\d{4}-\d{2}-\d{2}$/;
  if(!dateString.match(regEx)) return false;  // Invalid format
  var d = new Date(dateString);
  var dNum = d.getTime();
  if(!dNum && dNum !== 0) return false; // NaN value, Invalid date
  return d.toISOString().slice(0,10) === dateString;
}

function getDateFromUTCString(d, getDate) {
    //Sat, 12 Aug 2017 00:00:00 GMT
    var n = d.toUTCString();
    var re = / (20[0-9][0-9]) /;
    var r = n.split(re);
    var myYear = r[1];
    var rex = /, /;
    var r1 = r[0].split(rex);
    var s = r1[1].split(" ");
    var h = '';
    if (getDate === undefined) {
        getDate = 0;
    }
    if(getDate === 1) {//return Mon, ... Sat
        return mytrans.Myweek[r1[0]];
    } else {
        var myDay = s[0];
        var mon = s[1].toLowerCase();
        var days = {'jan':'01', 'feb':'02', 'mar':'03', 'apr':'04', 'may':'05', 'jun':'06', 'jul':'07', 'aug':'08', 'sep':'09', 'oct':'10', 'nov':'11', 'dec':'12'};
        var myMonth = days[mon];    
        h = myYear + '-' + myMonth + '-' + myDay;
        if(getDate === 0) {
            return h;
        } else if(getDate === 2) {//return Sat, 2017-08-06
            return mytrans.Myweek[r1[0]] + ', ' + h;
        }
    }
}

function onFromDateChangeDateTime(mydate, element) {
    var timepickerID = jQuery(element).attr('id');
    if(jQuery(element).val() !== '') {
        updateComposeAreaHeaderDate();
    }
}

function getDayBeginning(mydate) {
    var d = new Date(mydate);
    d.setHours(0);
    d.setMinutes(0);
    d.setSeconds(0);
    return d;
}

function getGMTTime(mydate) {
    var d = new Date(mydate);
    d.setMinutes( d.getMinutes() - d.getTimezoneOffset() );
    return d;
}

function submitVisitData(formid, submitbuttonid) {
    if(formid ==='') {return "Form id is emtpy.";}
    var vtype = jQuery.trim(jQuery("select#visittypeid").val());
    var vtypeid = parseInt(vtype) || 0;
    var vname = jQuery.trim(jQuery("input#visitorname").val());
    var vreason = jQuery.trim(jQuery("textarea#visitreason").val());
    var vtimein = jQuery.trim(jQuery("input#visittimein").val());
    var vtimeout = jQuery.trim(jQuery("input#visittimeout").val());
    var vdate = '';
    if(jQuery("input#visitdate").length > 0) {
        vdate =jQuery.trim(jQuery("input#visitdate").val());
    }

    if(vtype === '-1' || vtypeid <= 0 || vname === '' || vtimein === '' || (formid === 'editvisit' && vdate === '')) {
        return alert("Please enter all the required information.");
    }
    //validate date
    if(formid === 'editvisit') {
        if(!isValidDate(vdate)) {
            return alert("Visit date is not valid.");
        }
    }

    //validate timein, timeout
    var startTimeWrongDateFormat = false;
    var regex=new RegExp("^[0-2][0-9][:][0-5][0-9]$");
    var dateOk=regex.test(vtimein);
    if(!dateOk) {
        startTimeWrongDateFormat = true;
    }
    var temp01 = parseFloat(vtimein.replace(':', '.'));
    if(temp01 < 0 || temp01 > 24.0) {
        startTimeWrongDateFormat = true;
    }
    if(startTimeWrongDateFormat) {
        return alert("Start time has wrong format.");
    }

    if(vtimeout !== '') {
        var endTimeWrongDateFormat = false;
        var dateOk2=regex.test(vtimeout);
        if(!dateOk2) {
            endTimeWrongDateFormat = true;
        }
        var temp02 = parseFloat(vtimeout.replace(':', '.'));
        if(temp02 < 0 || temp02 > 24.0) {
            endTimeWrongDateFormat = true;
        }
        if(endTimeWrongDateFormat) {
            return alert("End time has wrong format.");
        }
        if(temp02 < temp01) {
            return alert("Time out should be later than time in.");
        }
    }
    myform.removeEventListener('submit',formSubmit);
    jQuery('#' + submitbuttonid).click();
}

function resetVisitData() {
    jQuery("select#visittypeid").val('-1');
    jQuery("input#visitorname").val('');
    jQuery("textarea#visitreason").val('');
    jQuery("input#visittimein").val('');
    jQuery("input#visittimeout").val('');
}