<script>
var ajaxurl = "<?php echo admin_url('admin-ajax.php'); ?>";
var pluginurl = "<?php $protocol = is_ssl() ? 'https://' : 'http://'; $urlparts = wp_parse_url(home_url()); $protocol = esc_html($urlparts['scheme']) . '://'; $domain = esc_html($urlparts['host']); $myurl = strtok($protocol . $domain . esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])), '?'); if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);} echo esc_html($myurl); ?>";
var dragonvisitzyx987_editVisit_nonce = "<?php echo wp_create_nonce('dragonvisitzyx987_editVisit'); ?>";
function formSubmit(event) {
    event.preventDefault();
}
var myform;
jQuery(function() {
    jQuery('h3#editvisit_header').focus();
    myform = document.getElementById('editvisit');
    myform.addEventListener('submit',formSubmit);
});
</script>
<style>
div#wpadminbar {
    display: none !important;
}
select, textarea, input {
    font-size: 2.25rem !important;
}
a.btn-lg {
    font-size: 2.25rem !important;
    border: 1px solid gray !important;
}
.bold, div.contentcontainer h3 {
    font-size: 2.25rem !important;
    font-weight: bold !important;
}
.xdsoft_datetimepicker .xdsoft_timepicker {
    width: 350px !important;
}
div.xdsoft_time {
    font-size: 2.25rem !important;
    font-weight: bold !important;
    padding: 5px 0px 5px 0px !important;
    height: 40px !important;
}
div.xdsoft_scrollbar {
    width: 35px !important;
}
div.xdsoft_scrollbar div.xdsoft_scroller {
    height: 50px !important;
}
span.w, li>a.w, .redtext {
    color: red !important;
}
span.m, li>a.m {
    color: orange !important;
}
span.b, li>a.b {
    color: black !important;
}
span.t, li>a.t {
    color: blue !important;
}
span.v, li>a.v {
    color: green !important;
}
span.h, li>a.h {
    color: purple !important;
}
span.o, li>a.o {
    color: cyan !important;
}
div.inline {
    display: inline-block;
}
.ui-tabs .ui-tabs-nav .ui-tabs-anchor {
    padding-left: 3px;
    padding-right: 3px;
}
.datepicker {
    padding: 0 0 0 0px;
}
.outer {
    display: table;
    position: absolute;
    height: 100%;
    width: 100%;
}
.middle {
    display: table-cell;
    vertical-align: middle;
}
.inner {
    margin-left: auto;
    margin-right: auto; 
    width: 10px;
}
.font24px {
    font-size:24px;
}
a.filled {
    background-color: #337ab7;
    border-color: #2e6da4;
}
/* The Close Button */
.closebutton {
    color: #fff;
    position: absolute;
    top: 10px;
    right: 25px;
    font-size: 35px;
    font-weight: bold;
    font-family: Verdana, sans-serif;
}
.closebutton:hover,
.closebutton:focus {
    color: #999;
    text-decoration: none;
    cursor: pointer;
}
.cursor {
    cursor: pointer
}
.visit_create_right_section {
    display: none;
}
</style>
<br/>
<h3 tabindex="0" id="editvisit_header">Edit Visit:</h3>
<?php if($dragon_visit_submitform_Result !== '') { ?>
<div class="updated col-12" style="color:#842029;background-color:#f8d7da;padding-top:5px;padding-bottom:5px;"><p style="margin-top:5px !important;margin-bottom:5px !important;text-align:center;"><?php echo esc_html($dragon_visit_submitform_Result); ?></p></div>
<?php } ?>
<form id="editvisit" name="editvisit" action="" method="POST" onsubmit="submitVisitData('editvisit', 'submiteditvisit');">
    <div class="container-fluid">      
        <div class="row"><br/>
            <div  class="col-xs-12 col-md-12 bold"><span tabindex="0">Visit Type*:</span> 
            <select tabindex="0" aria-label="Visit Type" name="visittypeid" id="visittypeid" class="form-select form-select-lg">
                <option value="-1">Select one...</option>
                <?php
                if(!empty($visittypes)){
                    foreach ($visittypes as $type){                    
                            $temp1 = empty($type->list) ? array() : explode('|',$type->list);
                            $myassociatearray = [];
                            foreach($temp1 as $temp2) {
                                $temp3 = empty($temp2) ? array('','') : explode('_',$temp2,2);
                                $myassociatearray[$temp3[0]] = esc_html($temp3[1]);
                            }

                        if (count($myassociatearray)){
                            foreach ($myassociatearray as $k => $v){
                                $selected = '';
                                if(intval($visit->visittypeid) === intval($k)) {
                                   $selected = ' selected ';
                                }
                                echo "<option value='" . esc_html($k) . "'" . $selected . ">" . esc_html($v) . "</option>";
                            }
                        }
                    }
                }
                ?>
            </select>
            </div>
        </div>

          <div class="row"><br/>
            <div class="col-xs-12 col-md-12 bold" ><span tabindex="0">Visitor Name*:</span>
                <input tabindex="0" aria-label="Visitor Name" type="text" name="visitorname" id="visitorname" class="fromdate form-control bold" value="<?php echo $visit->visitorname; ?>" />
            </div>
        </div>

          <div class="row"><br/>
            <div class="col-xs-12 col-md-12 bold" ><span tabindex="0">Visit Reason:</span>
                <textarea tabindex="0" aria-label="Visit Reason" name="visitreason" id="visitreason" class="form-control form-control-lg"  rows="3"><?php echo $visit->visitreason; ?></textarea>
            </div>
        </div>

        <div class="row"><br/>
            <div class="col-xs-12 col-md-12 bold" ><span tabindex="0">Visit Date* (For example, 2023-01-20, not 01/20/2023, not Jan 20, 2023):</span>
                <br/><input tabindex="0" aria-label="Visit Date" type="text" name="visitdate" id="visitdate" class="fromdate datepicker form-control bold" value="<?php echo $visit->visitdate; ?>" />
            </div>
        </div>

        <div class="row"><br/>
            <div  class="col-xs-12 col-md-12 bold" ><span tabindex="0">Time In* (For example, 09:00, 15:45, not 9, not 3:45pm):</span>
                <br/><input tabindex="0" aria-label="Time In" type="text" name="visittimein" id="visittimein" class="fromdate timepicker form-control bold" value="<?php echo $visit->timein; ?>" />
            </div>
        </div>

        <div class="row"><br/>
            <div  class="col-xs-12 col-md-12 bold" ><span tabindex="0">Time Out (For example, 09:00, 15:45, not 9, not 3:45pm):</span>
                <br/><input tabindex="0" aria-label="Time Out" type="text" name="visittimeout" id="visittimeout" class="fromdate timepicker form-control bold" value="<?php echo $visit->timeout; ?>" />
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-md-12">
                <br />
                <input type="submit" id="submiteditvisit" name="submit" class="btn btn-primary btn-lg bold" value="Submit" />
                <input type="button" name="reset" class="btn btn-default btn-lg bold" onclick="resetVisitData();" value="Reset" style="background-color:grey;" />
                <br/><br/><a class="btn btn-default btn-lg bold" role="button" tabindex="0" aria-label="cancel" href="<?php
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    echo $myurl;?>" target="_self">CANCEL</a>
                <p id="compose-error"></p>
            </div>
        </div>

        <br/>
        <div class="row">
            <input type="hidden" name="id" id="id" value="<?php echo $visit->id; ?>">
            <input type="hidden" name="dragonvisitzyx987_hidden_security_editvisit" value="<?php echo wp_create_nonce('dragonvisitzyx987_editvisit'); ?>" />
        </div>
    </div>
</form>