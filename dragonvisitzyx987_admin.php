<?php
    /**
    @ini_set('display_errors','On');
    ini_set('display_startup_errors', 1); error_reporting(E_ALL);
    **/
    global $wpdb;
    if (function_exists( 'mysqli_connect' ) && $wpdb->use_mysqli) {
    } else if (function_exists( 'mysqli_connect' ) && !$wpdb->use_mysqli) {
        ?><div class="nomysqli" style="color:#721c24;background-color:#f8d7da;"><p><strong><?php
            _e("Bad news. Mysqli is NOT used in your WordPress. So this plugin can NOT be used for your website.");
        ?></strong></p></div><?php
        exit;
    } else if (!function_exists( 'mysqli_connect' ) && !$wpdb->use_mysqli) {
        ?><div class="nomysqli" style="color:#721c24;background-color:#f8d7da;"><p><strong><?php
            _e("Bad news. Mysqli does NOT exist in your WordPress. So this plugin can NOT be used for your website.");        
        ?></strong></p></div><?php
        exit;
    }
    global $dragon_visit_dbResult;
    global $user_ID;
    $dragon_visit_dbResult = null;
    $timezone=get_option('timezone_string');
    if(!empty($timezone)){date_default_timezone_set($timezone);}
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo "Invalid User.";exit;
    }    
    $userdetails = dragonvisitzyx987_getOneUser(intval($current_user->data->ID));

    if($user_ID && in_array( 'administrator', (array) $current_user->roles ) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $dragon_visit_dbResult = '';
        
        if($_POST['Submit'] === 'Create Type Category') {
            dragonvisitzyx987_addTypecategory();
        }elseif($_POST['Submit'] === 'Create Type') {
            dragonvisitzyx987_addType();
        } elseif($_POST['Submit'] === 'Create Role') {
            dragonvisitzyx987_addRole();
        } elseif($_POST['Submit'] === 'Create Department') {
            dragonvisitzyx987_addDepartment();
        } elseif($_POST['Submit'] === "Update a User Types") {
            dragonvisitzyx987_updateUserTypes();
        } elseif($_POST['Submit'] === 'Clone a User Types') {
            dragonvisitzyx987_cloneUserTypes();
        } elseif($_POST['Submit'] === 'Create User') {
            dragonvisitzyx987_addUser();
        } elseif($_POST['Submit'] === 'ENABLE automatically backup database') {
            dragonvisitzyx987_enableAutoBackupDatabaseEveryday();
        } elseif($_POST['Submit'] === 'DISABLE automatically backup database') {
            dragonvisitzyx987_disableAutoBackupDatabaseEveryday();
        } elseif($_POST['Submit'] === 'Backup database now') {
            dragonvisitzyx987_OneTimeBackupDatabaseNow();
        } elseif($_POST['Submit'] === 'Recreate all the stored procedures') {
            dragonvisitzyx987_dropAllStoredprocedures();
        }
    }

    $allvisits = dragonvisitzyx987_getAllVisits();
    $activevisits = dragonvisitzyx987_getAllVisits(true);
    $allvisittypes = dragonvisitzyx987_getAllVisitTypes();
    $activevisittypes = dragonvisitzyx987_getAllVisitTypes(true);
    $alltypecategories = dragonvisitzyx987_getAllTypecategories();
    $activetypecategories = dragonvisitzyx987_getAllTypecategories(true);
    $alltypes = dragonvisitzyx987_getAllTypes();
    $activetypes = dragonvisitzyx987_getAllTypes(true);
    $allWPusers = dragonvisitzyx987_getAllWPUsers();
    $activeWPusers = dragonvisitzyx987_getAllWPUsers(true);
    $allusers = dragonvisitzyx987_getAllUsers();
    $activeusers = dragonvisitzyx987_getAllUsers(true);
    $allroles = dragonvisitzyx987_getAllRoles();
    $activeroles = dragonvisitzyx987_getAllRoles(true);
    $alldepartments = dragonvisitzyx987_getAllDepartments();
    $activedepartments = dragonvisitzyx987_getAllDepartments(true);

    $log_Arr = dragonvisitzyx987_getAllLogtypesProcessnamesUserids();
    $log_types = $log_Arr["type"];
    $log_processnames = $log_Arr["processname"];
    $log_userids = $log_Arr["userid"];

    if($dragon_visit_dbResult !== null) {
    ?><div class="updated" style="<?php echo ($dragon_visit_dbResult === '' || strtolower($dragon_visit_dbResult) === 'success. ' || strtolower($dragon_visit_dbResult) === 'success.' || strtolower($dragon_visit_dbResult) === 'success') ? 'color:#155724;background-color:#d4edda;' : 'color:#721c24;background-color:#f8d7da;'; ?>"><p><strong><?php echo ($dragon_visit_dbResult === '' ? _e('Saved.') : sanitize_text_field($dragon_visit_dbResult)); ?></strong></p></div>
    <?php        
    }
    
    $name = '';
    $start = '';
    $end = '';
    $description = '';
    $groupname = '';
    $color = '';
    $name2 = '';
    $start2 = '';
    $end2 = '';
    $description2 = '';

    wp_enqueue_script('jquery');
    wp_enqueue_script('jquery-ui-core');
    wp_enqueue_script("jquery-ui-tabs");
    wp_enqueue_script('jquery-ui-datepicker');
    wp_enqueue_script('jquery-ui-dialog');
    wp_enqueue_style('wp-jquery-ui-dialog');  
    wp_enqueue_script('jquery-ui-datepicker2', includes_url() . 'js/jquery/ui/datepicker.min.js');
    wp_enqueue_script('custom-script', plugins_url('js/jquery.datetimepicker.full.min.js', __FILE__ ));
    wp_enqueue_style('custom-style', plugins_url('css/jquery.datetimepicker.min.css', __FILE__ )); 
    wp_enqueue_script('custom-script-bootstrap', plugins_url('bootstrap/js/bootstrap.min.js', __FILE__ ));
    wp_enqueue_style('custom-style-bootstrap', plugins_url('bootstrap/css/bootstrap.min.css', __FILE__ )); 
    wp_enqueue_script('custom-script-d3', plugins_url('js/d3.v7.min.js', __FILE__ ));    
    
    wp_enqueue_style('custom-style-jqueryui', plugins_url('css/jquery-ui.css', __FILE__ ));
    wp_enqueue_style('custom-style-dragonvisit', plugins_url('css/dragonvisit.css', __FILE__ ));
?><noscript>Your browser does not support JavaScript! Please enable Javascript in your browser and refresh the page!</noscript>
<script>
var dragonvisitzyx987_addproductlocationarray = [], dragonvisitzyx987_editproductlocationarray = [], dragonvisitzyx987_addshippingpolicylocationarray = [], dragonvisitzyx987_addtaxlocationarray = [];
var mediummodalElementContainer = "<div id='mymediummodal' style='display:none;' title=''></div>";        
var largemodalElementContainer = "<div id='mylargemodal' data-bs-backdrop='static' data-bs-keyboard='false' class='modal fade' style='z-index: 99999 !important;background-color:white;min-width:100% !important;width:100% !important;height:100% !important;overflow:auto;padding:0px !important;' title='' role='dialog'></div>";    
var VISIT_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_visit = 1, pg_onload_admin_visit = 1;
var VISITDETAILS_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_visitdetails = 1, pg_onload_admin_visitdetails = 1;    
var TYPECATEGORY_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_typecategory = 1, pg_onload_admin_typecategory = 1;    
var TYPE_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_type = 1, pg_onload_admin_type = 1;
var ROLE_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_role = 1, pg_onload_admin_role = 1;
var DEPARTMENT_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_department = 1, pg_onload_admin_department = 1;
var USER_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_user = 1, pg_onload_admin_user = 1;    
var USERTYPE_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_usertype = 1, pg_onload_admin_usertype = 1;
var LOG_ITEMS_PER_PAGE_PRESET_VALUE = '10';
var totalpagenumber_onload_admin_log = 1, pg_onload_admin_log = 1;

function dragonvisitzyx987_validString(mystring) {
    if(typeof mystring === 'undefined' || mystring === null) {
        return '';
    }
    return mystring; 
}

function dragonvisitzyx987_isEnterSpaceEvent(event) {
    if(event.type === 'keydown') {
        var code = event.charCode || event.keyCode;
        if(code === 32 || code === 13) {
            event.preventDefault();
            return true;
        }            
    }
    return false;    
}

function dragonvisitzyx987_isClickEnterSpaceEvent(event) {
    if(event.type === 'click') {
        return true;
    } else if(event.type === 'keydown') {
        var code = event.charCode || event.keyCode;
        if(code === 32 || code === 13) {
            event.preventDefault();
            return true;
        }            
    }
    return false;    
}
        
//a - amount per page; o - order (asc, desc); pg - page number; st - sortby; n - search visitor name; r - search visit reason;status - visit status
//f - from date; t - to date;
function dragonvisitzyx987_createPagination(totalpagenumber, topagenumber, itemname) {
    if(totalpagenumber !== parseInt(totalpagenumber, 10) || topagenumber !== parseInt(topagenumber, 10)) {jQuery('div.master_pwrapper > div.master_mypagination').html('');return;}
    var temp = '<ul class="pagination">',i;
    if(topagenumber > totalpagenumber) {topagenumber = 1;totalpagenumber=1;}
    if(totalpagenumber < 7) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        for(i=1;i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" role="button" tabindex="0" >' + i + '</a></li>';
        }
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item next"><a class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber < 4) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        for(i=1;i<=5;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" role="button" tabindex="0" >' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item active" ><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item"><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber < (totalpagenumber - 2)) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item active" ><a class="page-link" role="button" tabindex="0" >1</a></li>';
        } else {
            temp += '<li class="page-item prev"><a class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item"><a class="page-link" role="button" tabindex="0" >1</a></li>';                
        }
        temp += (topagenumber > 4) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        for(i=(topagenumber-2);i<=((topagenumber+2)>(totalpagenumber-1) ? (totalpagenumber-1) : (topagenumber+2));i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" role="button" tabindex="0" >' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item active"><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item"><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber >= (totalpagenumber - 2)) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        temp += '<li' + (topagenumber===1 ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" role="button" tabindex="0" >1</a></li>';
        temp += ((topagenumber - 1) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        for(i=(totalpagenumber-4);i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" role="button" tabindex="0" >' + i + '</a></li>';
        }
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item next"><a class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    }
    temp += '</ul>';
    if(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_' + itemname).length > 0) {
        jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_' + itemname).html(temp);
    }
}

function dragonvisitzyx987_showResultOnAjaxReloadedPage(pagenumber, itemname) {          
    if(itemname === 'visit') {
        dragonvisitzyx987_getVisitsList(pagenumber);
    } else if(itemname === 'typecategory') {
        dragonvisitzyx987_getTypecategoriesList(pagenumber);
    } else if(itemname === 'type') {
        dragonvisitzyx987_getTypesList(pagenumber);
    } else if(itemname === 'role') {
        dragonvisitzyx987_getRolesList(pagenumber);
    } else if(itemname === 'department') {
        dragonvisitzyx987_getDepartmentsList(pagenumber);
    } else if(itemname === 'user') {
        dragonvisitzyx987_getUsersList(pagenumber);
    }
}

function dragonvisitzyx987_updateApprovedValue(element) {
    if(jQuery(element).val() !== '-1') {
        jQuery('select#dragonvisit_visit_approved').val('1');
    }
}

function dragonvisitzyx987_getVisitsList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_getvisits:"<?php echo wp_create_nonce('dragonvisitzyx987_getVisits'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getVisits"};
    dataObj.userid = (jQuery('select#dragonvisit_visit_userid').length === 0 || jQuery('select#dragonvisit_visit_userid').val() === '') ? -1 : parseInt(jQuery('select#dragonvisit_visit_userid').val());
    dataObj.visittypeid = (jQuery('select#dragonvisit_visit_type').length === 0 || jQuery('select#dragonvisit_visit_type').val() === '') ? -1 : parseInt(jQuery('select#dragonvisit_visit_type').val());
    dataObj.searchname = jQuery('input#dragonvisit_visit_name').val();        
    dataObj.searchvisitreason = jQuery('input#dragonvisit_visit_reason').val();
    dataObj.fromdate = jQuery('input#dragonvisit_visit_fromdate').val();
    dataObj.todate = jQuery('input#dragonvisit_visit_todate').val();
    if(dataObj.fromdate > dataObj.todate) {
        return alert("Error. From date is later than to date.");            
    }
    dataObj.mystatus = jQuery('select#dragonvisit_visit_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_visit_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_visit_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'userid|asc') {
        dataObj.sortby = 'userid';
        dataObj.order = 'asc';                  
    } else if(sortby === 'userid|desc') {
        dataObj.sortby = 'userid';
        dataObj.order = 'desc';                      
    } else if(sortby === 'date|asc') {
        dataObj.sortby = 'visitdate';
        dataObj.order = 'asc';      
    } else if(sortby === 'date|desc') {
        dataObj.sortby = 'visitdate';
        dataObj.order = 'desc';                  
    } else if(sortby === 'visittype|asc') {
        dataObj.sortby = 'visittypeid';
        dataObj.order = 'asc';      
    } else if(sortby === 'visittype|desc') {
        dataObj.sortby = 'visittypeid';
        dataObj.order = 'desc';                  
    } else {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';            
    }
            
    jQuery('tbody#dragonvisit_visit').html('');
    jQuery('span#totalvisitquantity').text('');
    jQuery('img#admin_visitlist_loader').show();
    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["visit"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {                
            tempRows += '<tr><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td>';                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].visittypename) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].visitorname) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].visitreason) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].visitdate) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].timein) + '</td>';                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].timeout) + '</td>';
            tempRows += '<td>' + (parseInt(dragonvisitzyx987_validString(objArr[i].status)) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">Inactive</span>');
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].username) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].username2) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].userid) + '</td>';
            tempRows += '</tr>';                
        }                                    
        jQuery('tbody#dragonvisit_visit').html(tempRows);
        jQuery('input.datepicker').datepicker({changeMonth:true,changeYear:true,yearRange:"1900:c+10",dateFormat:"yy-mm-dd"});
        var totalVisitQuantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totalvisitquantity').text(totalVisitQuantity);
        
        totalVisitQuantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_visit_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(VISIT_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_visit = Math.ceil(totalVisitQuantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_visit, pagenumber , 'visit');        
        }            
        jQuery('img#admin_visitlist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Visit request failed: " + textStatus );
    });        
}

function dragonvisitzyx987_resetVisitsSearchParameters() {    
    jQuery('input#dragonvisit_visit_name').val('');        
    jQuery('input#dragonvisit_visit_reason').val('');    
    jQuery('select#dragonvisit_visit_userid').val('-1');
    jQuery('select#dragonvisit_visit_type').val('-1');        
    jQuery('input#dragonvisit_visit_fromdate').val('');
    jQuery('input#dragonvisit_visit_todate').val('');
    jQuery('select#dragonvisit_visit_status').val('-1');
    jQuery('select#dragonvisit_visit_itemsperpage').val('-1');
    jQuery('select#dragonvisit_visit_sortby').val('-1');
}

function dragonvisitzyx987_getTypecategoriesList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_gettypecategories:"<?php echo wp_create_nonce('dragonvisitzyx987_getTypecategories'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getTypecategories"};
    dataObj.searchwords = jQuery('input#dragonvisit_typecategory_name').val();
    dataObj.typecategorystatus = jQuery('select#dragonvisit_typecategory_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_typecategory_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_typecategory_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'name|asc') {
        dataObj.sortby = 'name';
        dataObj.order = 'asc';                  
    } else if(sortby === 'name|desc') {
        dataObj.sortby = 'name';
        dataObj.order = 'desc';                      
    } else if(sortby === 'createtimeutc|asc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'asc';      
    } else if(sortby === 'createtimeutc|desc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'desc';                  
    }
            
    jQuery('tbody#dragonvisit_typecategory').html('');
    jQuery('span#totaltypecategoryquantity').text('');
    jQuery('img#admin_typecategorylist_loader').show();        

    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["typecategory"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_button = '';
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>                                
            temp_button += '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editTypecategory(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_typecategory_container_\');">Edit</a>';
            temp_button += '<a role="button" tabindex="0" aria-label="save" href="javascript:void(0);" style="display:none;" class="btn btn-primary dragonvisit_typecategory_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_saveTypecategory(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_typecategory_\');">Save</a>';
            <?php } ?>
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + dragonvisitzyx987_validString(objArr[i].name);
            tempRows += '<div style="display:none;" class="dragonvisit_typecategory_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_typecategory_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_typecategory_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].name).replace(/"/g, '\\&#34;') + '" /></div>';

            tempRows += '</td><td>' + dragonvisitzyx987_validString(objArr[i].description);
            tempRows += '<div style="display:none;" class="dragonvisit_typecategory_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_typecategory_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_typecategory_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '\\&#34;') + '" /></div>';
            
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_typecategory_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_typecategory_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_typecategory_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'selected' : '') + '>ACTIVE</option>';
            tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].status) === 0 ? 'selected' : '') + '>NOT ACTIVE</option>';
            tempRows += '</select></div>';
            tempRows += '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_typecategory').html(tempRows);
        var totaltypecategoryquantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totaltypecategoryquantity').text(totaltypecategoryquantity);
        totaltypecategoryquantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_typecategory_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(TYPECATEGORY_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_typecategory = Math.ceil(totaltypecategoryquantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_typecategory, pagenumber , 'typecategory');        
        }                    
        jQuery('img#admin_typecategorylist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request type category list failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetTypecategoriesSearchParameters() {    
    jQuery('input#dragonvisit_typecategory_name').val('');        
    jQuery('select#dragonvisit_typecategory_status').val('-1');
    jQuery('select#dragonvisit_typecategory_itemsperpage').val('-1');    
    jQuery('select#dragonvisit_typecategory_sortby').val('-1');
}

function dragonvisitzyx987_editTypecategory(typecategoryid, containerid) {
    if(jQuery('.' + containerid + typecategoryid).length > 0) {
        jQuery('.' + containerid + typecategoryid).toggle();
    }
}

function dragonvisitzyx987_saveTypecategory(typecategoryid, selectid) {        
    var typecategoryname = '';
    if(jQuery('input#' + selectid + 'name_' + typecategoryid).length > 0) {
        typecategoryname = jQuery('input#' + selectid + 'name_' + typecategoryid).val();    
    }        
    var typecategorydescription = '';
    if(jQuery('input#' + selectid + 'description_' + typecategoryid).length > 0) {
        typecategorydescription = jQuery('input#' + selectid + 'description_' + typecategoryid).val();    
    }                                    
    var typecategorystatus = '-1';                            
    if(jQuery('select#' + selectid + 'status_' + typecategoryid).length > 0) {            
        typecategorystatus = jQuery('select#' + selectid + 'status_' + typecategoryid).val();
    }        
    if(typecategoryname === '' && typecategorydescription === '' && (typecategorystatus !== '0' && typecategorystatus !== '1')) {
        return alert("Please enter a value.");
    }
    if(typecategoryname === '' || (typecategorystatus !== '0' && typecategorystatus !== '1')) {
        return alert("Name and status are required.");
    }        
    var typecategorystatusvalue = parseInt(typecategorystatus);
    var dataObj = {dragonvisitzyx987_hidden_security_savetypecategory:"<?php echo wp_create_nonce('dragonvisitzyx987_saveTypecategory'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_saveTypecategory",id: typecategoryid};
    dataObj.name = typecategoryname;
    dataObj.description = typecategorydescription;                
    dataObj.status = typecategorystatusvalue;
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getTypecategoriesList();
        } else {
            alert(mydata);
        }
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Type category update failed: " + textStatus );
    });
}

function dragonvisitzyx987_getTypesList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_gettypes:"<?php echo wp_create_nonce('dragonvisitzyx987_getTypes'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getTypes"};
    dataObj.searchwords = jQuery('input#dragonvisit_type_name').val();
    dataObj.typestatus = jQuery('select#dragonvisit_type_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_type_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_type_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'name|asc') {
        dataObj.sortby = 'name';
        dataObj.order = 'asc';                  
    } else if(sortby === 'name|desc') {
        dataObj.sortby = 'name';
        dataObj.order = 'desc';                      
    } else if(sortby === 'createtimeutc|asc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'asc';      
    } else if(sortby === 'createtimeutc|desc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'desc';                  
    }
            
    jQuery('tbody#dragonvisit_type').html('');
    jQuery('span#totaltypequantity').text('');
    jQuery('img#admin_typelist_loader').show();        

    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["type"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_button = '';
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>
            temp_button += '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editType(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_type_container_\');">Edit</a>';
            temp_button += '<a role="button" tabindex="0" aria-label="save" href="javascript:void(0);" style="display:none;" class="btn btn-primary dragonvisit_type_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_saveType(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_type_\');">Save</a>';
            <?php } ?>
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + dragonvisitzyx987_validString(objArr[i].name);
            tempRows += '<div style="display:none;" class="dragonvisit_type_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_type_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_type_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].name).replace(/"/g, '\\&#34;') + '" /></div>';

            tempRows += '</td><td>' + dragonvisitzyx987_validString(objArr[i].description);
            tempRows += '<div style="display:none;" class="dragonvisit_type_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_type_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_type_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '\\&#34;') + '" /></div>';                
            tempRows += '</td>';

            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].typecategoryname);
            tempRows += '<div style="display:none;" class="dragonvisit_type_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_type_typecategoryid_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_type_typecategoryid_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Please choose one...</option>';
            <?php foreach ($activetypecategories as $typecategory) { ?>
            <?php $typecategory_status_temp = $typecategory->status === '1' ? '' : 'color:grey;'; ?>
            tempRows += "<option " + (dragonvisitzyx987_validString(objArr[i].typecategoryid) === <?php echo $typecategory->id === null ? 0 : intval($typecategory->id); ?> ? 'selected' : '') + " value='<?php echo intval($typecategory->id); ?>' style='<?php echo esc_html($typecategory_status_temp); ?>'><?php echo esc_html($typecategory->name); ?></option>";
            <?php } ?>                
            tempRows += '</select></div>';                
            tempRows += '</td>';
            
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_type_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_type_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_type_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'selected' : '') + '>ACTIVE</option>';
            tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].status) === 0 ? 'selected' : '') + '>NOT ACTIVE</option>';
            tempRows += '</select></div>';
            tempRows += '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_type').html(tempRows);
        var totaltypequantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totaltypequantity').text(totaltypequantity);
        totaltypequantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_type_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(TYPE_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_type = Math.ceil(totaltypequantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_type, pagenumber , 'type');        
        }                    
        jQuery('img#admin_typelist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request type list failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetTypesSearchParameters() {    
    jQuery('input#dragonvisit_type_name').val('');        
    jQuery('select#dragonvisit_type_status').val('-1');
    jQuery('select#dragonvisit_type_itemsperpage').val('-1');    
    jQuery('select#dragonvisit_type_sortby').val('-1');
}

function dragonvisitzyx987_editType(typeid, containerid) {
    if(jQuery('.' + containerid + typeid).length > 0) {
        jQuery('.' + containerid + typeid).toggle();
    }
}

function dragonvisitzyx987_saveType(typeid, selectid) {        
    var typename = '';
    if(jQuery('input#' + selectid + 'name_' + typeid).length > 0) {
        typename = jQuery('input#' + selectid + 'name_' + typeid).val();    
    }        
    var typedescription = '';
    if(jQuery('input#' + selectid + 'description_' + typeid).length > 0) {
        typedescription = jQuery('input#' + selectid + 'description_' + typeid).val();    
    }
    var typecategoryid = '-1';
    if(jQuery('select#' + selectid + 'typecategoryid_' + typeid).length > 0) {
        typecategoryid = jQuery('select#' + selectid + 'typecategoryid_' + typeid).val();    
    }    
    var typestatus = '-1';                            
    if(jQuery('select#' + selectid + 'status_' + typeid).length > 0) {            
        typestatus = jQuery('select#' + selectid + 'status_' + typeid).val();
    }        
    if(typename === '' && typedescription === '' && typecategoryid === '-1' && (typestatus !== '0' && typestatus !== '1')) {
        return alert("Please enter a value.");
    }
    if(typename === '' || (typestatus !== '0' && typestatus !== '1') || typecategoryid === '-1') {
        return alert("Name, type category, and status are required.");
    }        
    var typestatusvalue = parseInt(typestatus);
    var dataObj = {dragonvisitzyx987_hidden_security_savetype:"<?php echo wp_create_nonce('dragonvisitzyx987_saveType'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_saveType",id: typeid};
    dataObj.name = typename;
    dataObj.description = typedescription;
    dataObj.typecategoryid = typecategoryid;
    dataObj.status = typestatusvalue;
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getTypesList();
        } else {
            alert(mydata);
        }
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Type update failed: " + textStatus );
    });
}

function dragonvisitzyx987_getRolesList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_getroles:"<?php echo wp_create_nonce('dragonvisitzyx987_getRoles'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getRoles"};
    dataObj.searchwords = jQuery('input#dragonvisit_role_name').val();
    dataObj.rolestatus = jQuery('select#dragonvisit_role_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_role_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_role_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'name|asc') {
        dataObj.sortby = 'name';
        dataObj.order = 'asc';                  
    } else if(sortby === 'name|desc') {
        dataObj.sortby = 'name';
        dataObj.order = 'desc';                      
    } else if(sortby === 'createtimeutc|asc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'asc';      
    } else if(sortby === 'createtimeutc|desc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'desc';                  
    }
            
    jQuery('tbody#dragonvisit_role').html('');
    jQuery('span#totalrolequantity').text('');
    jQuery('img#admin_rolelist_loader').show();        

    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["role"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_button = '';
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>
            temp_button += '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editRole(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_role_container_\');">Edit</a>';
            temp_button += '<a role="button" tabindex="0" aria-label="save" href="javascript:void(0);" style="display:none;" class="btn btn-primary dragonvisit_role_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_saveRole(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_role_\');">Save</a>';
            <?php } ?>
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + dragonvisitzyx987_validString(objArr[i].name);
            tempRows += '<div style="display:none;" class="dragonvisit_role_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_role_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_role_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].name).replace(/"/g, '\\&#34;') + '" /></div>';

            tempRows += '</td><td>' + dragonvisitzyx987_validString(objArr[i].description);
            tempRows += '<div style="display:none;" class="dragonvisit_role_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_role_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_role_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '\\&#34;') + '" /></div>';
            
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_role_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_role_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_role_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'selected' : '') + '>ACTIVE</option>';
            tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].status) === 0 ? 'selected' : '') + '>NOT ACTIVE</option>';
            tempRows += '</select></div>';
            tempRows += '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_role').html(tempRows);
        var totalrolequantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totalrolequantity').text(totalrolequantity);
        totalrolequantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_role_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(ROLE_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_type = Math.ceil(totalrolequantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_role, pagenumber , 'role');        
        }                    
        jQuery('img#admin_rolelist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request role list failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetRolesSearchParameters() {    
    jQuery('input#dragonvisit_role_name').val('');        
    jQuery('select#dragonvisit_role_status').val('-1');
    jQuery('select#dragonvisit_role_itemsperpage').val('-1');    
    jQuery('select#dragonvisit_role_sortby').val('-1');
}

function dragonvisitzyx987_editRole(roleid, containerid) {
    if(jQuery('.' + containerid + roleid).length > 0) {
        jQuery('.' + containerid + roleid).toggle();
    }
}

function dragonvisitzyx987_saveRole(roleid, selectid) {        
    var rolename = '';
    if(jQuery('input#' + selectid + 'name_' + roleid).length > 0) {
        rolename = jQuery('input#' + selectid + 'name_' + roleid).val();    
    }        
    var roledescription = '';
    if(jQuery('input#' + selectid + 'description_' + roleid).length > 0) {
        roledescription = jQuery('input#' + selectid + 'description_' + roleid).val();    
    }                                    
    var rolestatus = '-1';                            
    if(jQuery('select#' + selectid + 'status_' + roleid).length > 0) {            
        rolestatus = jQuery('select#' + selectid + 'status_' + roleid).val();
    }        
    if(rolename === '' && roledescription === '' && (rolestatus !== '0' && rolestatus !== '1')) {
        return alert("Please enter a value.");
    }
    if(rolename === '' || (rolestatus !== '0' && rolestatus !== '1')) {
        return alert("Name and status are required.");
    }        
    var rolestatusvalue = parseInt(rolestatus);
    var dataObj = {dragonvisitzyx987_hidden_security_saverole:"<?php echo wp_create_nonce('dragonvisitzyx987_saveRole'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_saveRole",id: roleid};
    dataObj.name = rolename;
    dataObj.description = roledescription;                
    dataObj.status = rolestatusvalue;
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getRolesList();
        } else {
            alert(mydata);
        }
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Role update failed: " + textStatus );
    });
}

function dragonvisitzyx987_getDepartmentsList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_getdepartments:"<?php echo wp_create_nonce('dragonvisitzyx987_getDepartments'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getDepartments"};
    dataObj.searchwords = jQuery('input#dragonvisit_department_name').val();
    dataObj.departmentstatus = jQuery('select#dragonvisit_department_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_department_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_department_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'name|asc') {
        dataObj.sortby = 'name';
        dataObj.order = 'asc';                  
    } else if(sortby === 'name|desc') {
        dataObj.sortby = 'name';
        dataObj.order = 'desc';                      
    } else if(sortby === 'createtimeutc|asc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'asc';      
    } else if(sortby === 'createtimeutc|desc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'desc';                  
    }
            
    jQuery('tbody#dragonvisit_department').html('');
    jQuery('span#totaldepartmentquantity').text('');
    jQuery('img#admin_departmentlist_loader').show();        

    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["department"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_button = '';
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>
            temp_button += '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editDepartment(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_department_container_\');">Edit</a>';
            temp_button += '<a role="button" tabindex="0" aria-label="save" href="javascript:void(0);" style="display:none;" class="btn btn-primary dragonvisit_department_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_saveDepartment(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_department_\');">Save</a>';
            <?php } ?>
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + dragonvisitzyx987_validString(objArr[i].name);
            tempRows += '<div style="display:none;" class="dragonvisit_department_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_department_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_department_name_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].name).replace(/"/g, '\\&#34;') + '" /></div>';

            tempRows += '</td><td>' + dragonvisitzyx987_validString(objArr[i].description);
            tempRows += '<div style="display:none;" class="dragonvisit_department_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_department_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_department_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '\\&#34;') + '" /></div>';
            
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_department_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_department_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_department_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'selected' : '') + '>ACTIVE</option>';
            tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].status) === 0 ? 'selected' : '') + '>NOT ACTIVE</option>';
            tempRows += '</select></div>';
            tempRows += '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_department').html(tempRows);
        var totaldepartmentquantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totaldepartmentquantity').text(totaldepartmentquantity);
        totaldepartmentquantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_department_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(DEPARTMENT_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_type = Math.ceil(totaldepartmentquantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_department, pagenumber , 'department');        
        }                    
        jQuery('img#admin_departmentlist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request department list failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetDepartmentsSearchParameters() {    
    jQuery('input#dragonvisit_department_name').val('');        
    jQuery('select#dragonvisit_department_status').val('-1');
    jQuery('select#dragonvisit_department_itemsperpage').val('-1');    
    jQuery('select#dragonvisit_department_sortby').val('-1');
}

function dragonvisitzyx987_editDepartment(departmentid, containerid) {
    if(jQuery('.' + containerid + departmentid).length > 0) {
        jQuery('.' + containerid + departmentid).toggle();
    }
}

function dragonvisitzyx987_saveDepartment(departmentid, selectid) {        
    var departmentname = '';
    if(jQuery('input#' + selectid + 'name_' + departmentid).length > 0) {
        departmentname = jQuery('input#' + selectid + 'name_' + departmentid).val();    
    }        
    var departmentdescription = '';
    if(jQuery('input#' + selectid + 'description_' + departmentid).length > 0) {
        departmentdescription = jQuery('input#' + selectid + 'description_' + departmentid).val();    
    }                                    
    var departmentstatus = '-1';                            
    if(jQuery('select#' + selectid + 'status_' + departmentid).length > 0) {            
        departmentstatus = jQuery('select#' + selectid + 'status_' + departmentid).val();
    }        
    if(departmentname === '' && departmentdescription === '' && departmentstatus === '-1') {
        return alert("Please enter a value.");
    }
    if(departmentname === '' || departmentstatus === '-1') {
        return alert("Name and status are required.");
    }        
    var departmentstatusvalue = parseInt(departmentstatus);
    var dataObj = {dragonvisitzyx987_hidden_security_savedepartment:"<?php echo wp_create_nonce('dragonvisitzyx987_saveDepartment'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_saveDepartment",id: departmentid};
    dataObj.name = departmentname;
    dataObj.description = departmentdescription;                
    dataObj.status = departmentstatusvalue;
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getDepartmentsList();
        } else {
            alert(mydata);
        }
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Department update failed: " + textStatus );
    });
}

function dragonvisitzyx987_getUsersList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_getusers:"<?php echo wp_create_nonce('dragonvisitzyx987_getUsers'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getUsers"};
    dataObj.userid = (jQuery('select#dragonvisit_user_userid').length === 0 || jQuery('select#dragonvisit_user_userid').val() === '') ? -1 : parseInt(jQuery('select#dragonvisit_user_userid').val());    
    dataObj.userfullname = jQuery('input#dragonvisit_user_userfullname').val();        
    dataObj.email = jQuery('input#dragonvisit_user_email').val();
    dataObj.reportto = jQuery('select#dragonvisit_user_reportto').val();
    dataObj.canreadinadminpage = jQuery('select#dragonvisit_user_canreadinadminpage').val();
    dataObj.cancreateinadminpage = jQuery('select#dragonvisit_user_cancreateinadminpage').val();
    dataObj.caneditinadminpage = jQuery('select#dragonvisit_user_caneditinadminpage').val();
    dataObj.canactivateinadminpage = jQuery('select#dragonvisit_user_canactivateinadminpage').val();
    dataObj.candeactivateinadminpage = jQuery('select#dragonvisit_user_candeactivateinadminpage').val();
    dataObj.roleid = jQuery('select#dragonvisit_user_roleid').val();
    dataObj.departmentid = jQuery('select#dragonvisit_user_departmentid').val();        
    dataObj.userstatus = jQuery('select#dragonvisit_user_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_user_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;

    var sortby = jQuery('select#dragonvisit_user_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'userid|asc') {
        dataObj.sortby = 'userid';
        dataObj.order = 'asc';                  
    } else if(sortby === 'userid|desc') {
        dataObj.sortby = 'userid';
        dataObj.order = 'desc';                      
    } else if(sortby === 'userfullname|asc') {
        dataObj.sortby = 'userfullname';
        dataObj.order = 'asc';      
    } else if(sortby === 'userfullname|desc') {
        dataObj.sortby = 'userfullname';
        dataObj.order = 'desc';                  
    } else {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';    
    }
            
    jQuery('tbody#dragonvisit_user').html('');
    jQuery('span#totaluserquantity').text('');
    jQuery('img#admin_userlist_loader').show();
            
    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["user"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_button = '';
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>
            temp_button += '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editUser(' + dragonvisitzyx987_validString(objArr[i].id) + ', \'dragonvisit_user_container_\');">Edit</a>';                    
            temp_button += '<a role="button" tabindex="0" aria-label="save" href="javascript:void(0);" style="display:none;" class="btn btn-primary dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_saveUser(' + dragonvisitzyx987_validString(objArr[i].id) + ',' + dragonvisitzyx987_validString(objArr[i].userid) + ', \'dragonvisit_user_\');">Save</a>';                    
            <?php } ?>
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].firstname);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_firstname_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_firstname_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].firstname).replace(/"/g, '\\&#34;') + '" /></div>';
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].lastname);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_lastname_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_lastname_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].lastname).replace(/"/g, '\\&#34;') + '" /></div>';
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].userid); + '</td>';
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].canreadinadminpage) === 1 ? '<span style="color:green;">YES</span>' : '<span style="color:red;">NO</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_canreadinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_canreadinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].canreadinadminpage) === 1 ? 'selected' : '') + '>YES</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].canreadinadminpage) === 0 ? 'selected' : '') + '>NO</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';                                
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].cancreateinadminpage) === 1 ? '<span style="color:green;">YES</span>' : '<span style="color:red;">NO</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_cancreateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_cancreateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].cancreateinadminpage) === 1 ? 'selected' : '') + '>YES</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].cancreateinadminpage) === 0 ? 'selected' : '') + '>NO</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';                
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].caneditinadminpage) === 1 ? '<span style="color:green;">YES</span>' : '<span style="color:red;">NO</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_caneditinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_caneditinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].caneditinadminpage) === 1 ? 'selected' : '') + '>YES</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].caneditinadminpage) === 0 ? 'selected' : '') + '>NO</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].canactivateinadminpage) === 1 ? '<span style="color:green;">YES</span>' : '<span style="color:red;">NO</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_canactivateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_canactivateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].canactivateinadminpage) === 1 ? 'selected' : '') + '>YES</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].canactivateinadminpage) === 0 ? 'selected' : '') + '>NO</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].candeactivateinadminpage) === 1 ? '<span style="color:green;">YES</span>' : '<span style="color:red;">NO</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_candeactivateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_candeactivateinadminpage_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].candeactivateinadminpage) === 1 ? 'selected' : '') + '>YES</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].candeactivateinadminpage) === 0 ? 'selected' : '') + '>NO</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].reportto);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_reportto_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_reportto_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Please choose one...</option>';
            <?php foreach ($activeWPusers as $user) { ?>
            tempRows += "<option " + (dragonvisitzyx987_validString(objArr[i].reportto) === <?php echo $user->ID === null ? 0 : intval($user->ID); ?> ? 'selected' : '') + " value='<?php echo intval($user->ID); ?>' ><?php echo esc_html($user->fullname) . ' (' . intval($user->ID) . ')'; ?></option>";
            <?php } ?>                
            tempRows += '</select></div>';                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].rolename);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_roleid_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_roleid_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Please choose one...</option>';
            <?php foreach ($activeroles as $role) { ?>
            <?php $role_status_temp = $role->status === '1' ? '' : 'color:grey;'; ?>
            tempRows += "<option " + (dragonvisitzyx987_validString(objArr[i].roleid) === <?php echo $role->id === null ? 0 : intval($role->id); ?> ? 'selected' : '') + " value='<?php echo intval($role->id); ?>' style='<?php echo esc_html($role_status_temp); ?>'><?php echo esc_html($role->name); ?></option>";
            <?php } ?>                
            tempRows += '</select></div>';                
            tempRows += '</td>';                                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].departmentname);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_departmentid_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_departmentid_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Please choose one...</option>';
            <?php foreach ($activedepartments as $department) { ?>
            <?php $department_status_temp = $department->status === '1' ? '' : 'color:grey;'; ?>
            tempRows += "<option " + (dragonvisitzyx987_validString(objArr[i].departmentid) === <?php echo $department->id === null ? 0 : intval($department->id); ?> ? 'selected' : '') + " value='<?php echo intval($department->id); ?>' style='<?php echo esc_html($department_status_temp); ?>'><?php echo esc_html($department->name); ?></option>";
            <?php } ?>                
            tempRows += '</select></div>';                
            tempRows += '</td>';                
            tempRows += '<td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>');
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<select name="dragonvisit_user_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_status_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
            tempRows += '<option value="-1">Choose one...</option>';
            tempRows += '<option value="1"' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'selected' : '') + '>ACTIVE</option>';
            tempRows += '<option value="0"' + (dragonvisitzyx987_validString(objArr[i].status) === 0 ? 'selected' : '') + '>NOT ACTIVE</option>';
            tempRows += '</select></div>';
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].email);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_email_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_email_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].email).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].phone);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_phone_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_phone_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].phone).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].address);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_address_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_address_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].address).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].address2);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_address2_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_address2_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].address2).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].city);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_city_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_city_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].city).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].province);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_province_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_province_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].province).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].country);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_country_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_country_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].country).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].zip);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_zip_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_zip_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].zip).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';                
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].description);
            tempRows += '<div style="display:none;" class="dragonvisit_user_container_' + dragonvisitzyx987_validString(objArr[i].id) + '" ><input type="text" name="dragonvisit_user_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="dragonvisit_user_description_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '\\&#34;') + '" /></div>';                                                
            tempRows += '</td>';                    
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_user').html(tempRows);
        var totalUserQuantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totaluserquantity').text(totalUserQuantity);            
        totalUserQuantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_user_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(USER_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_user = Math.ceil(totalUserQuantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_user, pagenumber , 'user');        
        }            
        jQuery('img#admin_userlist_loader').hide();                        
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Get user list request failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetUsersSearchParameters() {    
    jQuery('select#dragonvisit_user_userid').val('-1');
    jQuery('input#dragonvisit_user_userfullname').val('');        
    jQuery('input#dragonvisit_user_email').val('');        
    jQuery('select#dragonvisit_user_reportto').val('-1');
    jQuery('select#dragonvisit_user_canreadinadminpage').val('-1');
    jQuery('select#dragonvisit_user_cancreateinadminpage').val('-1');
    jQuery('select#dragonvisit_user_caneditinadminpage').val('-1');
    jQuery('select#dragonvisit_user_canactivateinadminpage').val('-1');
    jQuery('select#dragonvisit_user_candeactivateinadminpage').val('-1');
    jQuery('select#dragonvisit_user_roleid').val('-1');
    jQuery('select#dragonvisit_user_departmentid').val('-1');        
    jQuery('select#dragonvisit_user_status').val('-1');
    jQuery('select#dragonvisit_user_itemsperpage').val('-1');
    jQuery('select#dragonvisit_user_sortby').val('-1');
}

function dragonvisitzyx987_editUser(userid, containerid) {
    if(jQuery('.' + containerid + userid).length > 0) {
        jQuery('.' + containerid + userid).toggle();
    }
}

function dragonvisitzyx987_saveUser(id, userid, selectid) {    
    var userfirstname = '';
    if(jQuery('input#' + selectid + 'firstname_' + id).length > 0) {
        userfirstname = jQuery('input#' + selectid + 'firstname_' + id).val();    
    }
    var userlastname = '';
    if(jQuery('input#' + selectid + 'lastname_' + id).length > 0) {
        userlastname = jQuery('input#' + selectid + 'lastname_' + id).val();    
    }        
    var usercanreadinadminpage = '-1';
    if(jQuery('select#' + selectid + 'canreadinadminpage_' + id).length > 0) {
        usercanreadinadminpage = jQuery('select#' + selectid + 'canreadinadminpage_' + id).val();    
    }        
    var usercancreateinadminpage = '-1';
    if(jQuery('select#' + selectid + 'cancreateinadminpage_' + id).length > 0) {
        usercancreateinadminpage = jQuery('select#' + selectid + 'cancreateinadminpage_' + id).val();    
    }        
    var usercaneditinadminpage = '-1';
    if(jQuery('select#' + selectid + 'caneditinadminpage_' + id).length > 0) {
        usercaneditinadminpage = jQuery('select#' + selectid + 'caneditinadminpage_' + id).val();    
    }        
    var usercanactivateinadminpage = '-1';
    if(jQuery('select#' + selectid + 'canactivateinadminpage_' + id).length > 0) {
        usercanactivateinadminpage = jQuery('select#' + selectid + 'canactivateinadminpage_' + id).val();    
    }        
    var usercandeactivateinadminpage = '-1';
    if(jQuery('select#' + selectid + 'candeactivateinadminpage_' + id).length > 0) {
        usercandeactivateinadminpage = jQuery('select#' + selectid + 'candeactivateinadminpage_' + id).val();    
    }
    var userreportto = '-1';
    if(jQuery('select#' + selectid + 'reportto_' + id).length > 0) {
        userreportto = jQuery('select#' + selectid + 'reportto_' + id).val();    
    }
    var userrole = '-1';
    if(jQuery('select#' + selectid + 'roleid_' + id).length > 0) {
        userrole = jQuery('select#' + selectid + 'roleid_' + id).val();    
    }        
    var userdepartment = '-1';
    if(jQuery('select#' + selectid + 'departmentid_' + id).length > 0) {
        userdepartment = jQuery('select#' + selectid + 'departmentid_' + id).val();    
    }        
    var userstatus = '-1';                            
    if(jQuery('select#' + selectid + 'status_' + id).length > 0) {            
        userstatus = jQuery('select#' + selectid + 'status_' + id).val();
    }        
    var useremail = '';
    if(jQuery('input#' + selectid + 'email_' + id).length > 0) {
        useremail = jQuery('input#' + selectid + 'email_' + id).val();    
    }
    var userphone = '';
    if(jQuery('input#' + selectid + 'phone_' + id).length > 0) {
        userphone = jQuery('input#' + selectid + 'phone_' + id).val();    
    }        
    var useraddress = '';
    if(jQuery('input#' + selectid + 'address_' + id).length > 0) {
        useraddress = jQuery('input#' + selectid + 'address_' + id).val();    
    }
    var useraddress2 = '';
    if(jQuery('input#' + selectid + 'address2_' + id).length > 0) {
        useraddress2 = jQuery('input#' + selectid + 'address2_' + id).val();    
    }        
    var usercity = '';
    if(jQuery('input#' + selectid + 'city_' + id).length > 0) {
        usercity = jQuery('input#' + selectid + 'city_' + id).val();    
    }
    var userprovince = '';
    if(jQuery('input#' + selectid + 'province_' + id).length > 0) {
        userprovince = jQuery('input#' + selectid + 'province_' + id).val();    
    }
    var usercountry = '';
    if(jQuery('input#' + selectid + 'country_' + id).length > 0) {
        usercountry = jQuery('input#' + selectid + 'country_' + id).val();    
    }
    var userzip = '';
    if(jQuery('input#' + selectid + 'zip_' + id).length > 0) {
        userzip = jQuery('input#' + selectid + 'zip_' + id).val();    
    }            
    var userdescription = '';
    if(jQuery('input#' + selectid + 'description_' + id).length > 0) {
        userdescription = jQuery.trim(jQuery('input#' + selectid + 'description_' + id).val());    
    }                                            
    if(userfirstname === '' && userlastname === '' && id <= 0 && userid <= 0 && userreportto === '-1') {
        return alert("First name, last name, user id and report to user id are required.");
    }
    if(userfirstname === '' || userlastname === '' || id <= 0 || userid <= 0 || userreportto === '-1') {
        return alert("First name, last name, user id and report to user id are required.");
    }        
    var dataObj = {dragonvisitzyx987_hidden_security_saveuser:"<?php echo wp_create_nonce('dragonvisitzyx987_saveUser'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_saveUser",id: id};
    dataObj.firstname = userfirstname;
    dataObj.lastname = userlastname;
    dataObj.id = id;
    dataObj.userid = userid;
    dataObj.reportto = userreportto;        
    dataObj.canreadinadminpage = usercanreadinadminpage;
    dataObj.cancreateinadminpage = usercancreateinadminpage;
    dataObj.caneditinadminpage = usercaneditinadminpage;
    dataObj.canactivateinadminpage = usercanactivateinadminpage;
    dataObj.candeactivateinadminpage = usercandeactivateinadminpage;
    dataObj.roleid = userrole;
    dataObj.departmentid = userdepartment;
    dataObj.email = useremail;
    dataObj.phone = userphone;
    dataObj.address = useraddress;
    dataObj.address2 = useraddress2;
    dataObj.city = usercity;
    dataObj.province = userprovince;
    dataObj.country = usercountry;
    dataObj.zip = userzip;
    dataObj.description = userdescription;                
    dataObj.status = userstatus;
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getUsersList();
        } else {
            alert(mydata);
        }
    }).fail(function( jqXHR, textStatus ) {
        //alert( "User update failed: " + textStatus );
    });
}

function dragonvisitzyx987_updateusertypes_getTypesForUser() {
    var userid = parseInt(jQuery('select#dragonvisitzyx987_updateusertypesuser').val());
    jQuery('p#dragonvisitzyx987_updateusertypescheckboxes').hide();
    jQuery('p#dragonvisitzyx987_updateusertypescheckboxes').html('');
    if(userid <= 0) { return alert('Please choose a user.');}
    jQuery('input#dragonvisitzyx987_updateusertypessubmit').hide();        
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: {dragonvisitzyx987_hidden_security_gettypesforuser:"<?php echo wp_create_nonce('dragonvisitzyx987_gettypesforuser'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_gettypesforuser", id:userid}
    }).done(function (mydata) {
        jQuery('p#dragonvisitzyx987_updateusertypescheckboxes').show();
        jQuery('input#dragonvisitzyx987_updateusertypessubmit').show();    
        if(mydata.length > 0) {
            var temp = '';
            for (var i = 0; i < mydata.length; i++) {
                temp += '<input type="checkbox" id="dragonvisitzyx987_updateusertypes_type_' + mydata[i]["id"] + '" name="dragonvisitzyx987_updateusertypes_type[]" value="' + mydata[i]["id"] + '" ' + (mydata[i]["userid"] === userid ? 'checked' : '') + '><span style="">' + mydata[i]["name"] + '(' + mydata[i]["id"] + ')' + '</span>&nbsp;&nbsp;&nbsp;&nbsp;';
            }
            jQuery('p#dragonvisitzyx987_updateusertypescheckboxes').html(temp);
        }                        
    });
}    

function dragonvisitzyx987_getLogsList(pagenumber) {
    var dataObj = {dragonvisitzyx987_hidden_security_getlogs:"<?php echo wp_create_nonce('dragonvisitzyx987_getLogs'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getLogs"};
    dataObj.searchwords = jQuery('input#dragonvisit_log_description').val();
    dataObj.searchtype = jQuery.trim(jQuery('select#dragonvisit_log_type').val());
    dataObj.processname = jQuery.trim(jQuery('select#dragonvisit_log_processname').val());    
    dataObj.userid = jQuery('select#dragonvisit_log_userid').val();
    dataObj.logstatus = jQuery('select#dragonvisit_log_status').val();
    dataObj.amountperpage = jQuery('select#dragonvisit_log_itemsperpage').val();
    if(typeof pagenumber === 'undefined') {pagenumber = 1;}
    dataObj.pagenumber = pagenumber;
                
    var sortby = jQuery('select#dragonvisit_log_sortby').val();
    if(sortby === 'id|asc') {
        dataObj.sortby = 'id';
        dataObj.order = 'asc';                  
    } else if(sortby === 'id|desc') {
        dataObj.sortby = 'id';
        dataObj.order = 'desc';                  
    } else if(sortby === 'type|asc') {
        dataObj.sortby = 'type';
        dataObj.order = 'asc';                  
    } else if(sortby === 'type|desc') {
        dataObj.sortby = 'type';
        dataObj.order = 'desc';                      
    } else if(sortby === 'createtimeutc|asc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'asc';      
    } else if(sortby === 'createtimeutc|desc') {
        dataObj.sortby = 'createtimeutc';
        dataObj.order = 'desc';                  
    }
            
    jQuery('tbody#dragonvisit_log').html('');
    jQuery('span#totallogquantity').text('');
    jQuery('img#admin_loglist_loader').show();        
    
    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: dataObj
    }).done(function (mydata) {
        var objArr = mydata["log"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {        
            tempRows += '<tr><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + dragonvisitzyx987_validString(objArr[i].type) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].processname) + '</td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].userid) + '</td>';
            tempRows += '<td><span class="logspan" >' + dragonvisitzyx987_validString(objArr[i].description) + '</span><input class="logedittextbox" style="display:none;" name="log_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="log_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].description).replace(/"/g, '&#34;') + '" /><input class="logedittextbox" style="display:none;" type="button" value="Update" name="logeditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="logeditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitLogValue(\'log_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ');" /></td>';
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? '<span style="color:green;">ACTIVE</span>' : '<span style="color:red;">INACTIVE</span>') + '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_log').html(tempRows);
        var totallogquantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totallogquantity').text(totallogquantity);
        totallogquantity = parseInt(mydata["total"]);
        var amountperpage = parseInt(jQuery('select#dragonvisit_log_itemsperpage').val());
        if(amountperpage === -1) {amountperpage = parseInt(LOG_ITEMS_PER_PAGE_PRESET_VALUE);}
        if(amountperpage > 0) {
            totalpagenumber_onload_admin_log = Math.ceil(totallogquantity / amountperpage);
            dragonvisitzyx987_createPagination(totalpagenumber_onload_admin_log, pagenumber , 'log');        
        }                    
        jQuery('img#admin_loglist_loader').hide();
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request log list failed: " + textStatus );
    });
}

function dragonvisitzyx987_resetLogsSearchParameters() {    
    jQuery('select#dragonvisit_log_type').val('-1');        
    jQuery('select#dragonvisit_log_processname').val('-1');                
    jQuery('select#dragonvisit_log_userid').val('-1');
    jQuery('input#dragonvisit_log_description').val('');
    jQuery('select#dragonvisit_log_status').val('-1');
    jQuery('select#dragonvisit_log_itemsperpage').val('-1');    
    jQuery('select#dragonvisit_log_sortby').val('-1');
    
}

function dragonvisitzyx987_getConstantsList() {
    jQuery('tbody#dragonvisit_constant').html('');
    jQuery('span#totalconstantquantity').text('');
    jQuery('img#admin_constantlist_loader').show();
    jQuery.ajax({
        type: "POST",
        async: true,
        url: ajaxurl,
        data: {dragonvisitzyx987_hidden_security_getconstants:"<?php echo wp_create_nonce('dragonvisitzyx987_getConstants'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_getConstants"}
    }).done(function (mydata) {
        var objArr = mydata["constant"];
        var tempRows = '';
        for (var i = 0; i < objArr.length; i++) {
            var temp_name = dragonvisitzyx987_validString(objArr[i].name);
            if(temp_name === 'COMPANY_TIMEZONE_HOURS') {
                temp_name += '&nbsp;(manually change it for daylight savings time)';;
            }    
            var temp_button = '';    
            <?php  if($userdetails[0]->caneditinadminpage === '1') {  ?>
            temp_button = '<a role="button" tabindex="0" aria-label="edit" href="javascript:void(0);" class="btn btn-primary" onclick="dragonvisitzyx987_editConstant(this, ' + dragonvisitzyx987_validString(objArr[i].id) + ');">Edit</a>';                                    
            if(temp_name === 'DBBACKUP_DETAILS' || temp_name === 'PAYMENT_METHOD') {
                temp_button = '';
            }
            <?php } ?>                
            tempRows += '<tr><td>'+ temp_button + '</td><td>' + dragonvisitzyx987_validString(objArr[i].id) + '</td><td>' + temp_name + '</td>';
            if(temp_name === 'COMPANY_TIMEZONE') {
                /*tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value) + '</span>';
                tempRows += '<select class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
                
                //tempRows += '<option value="-1">Please choose one...</option>';
                tempRows += '<option value="Etc/GMT+12|-12:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Etc/GMT+12' ? 'selected' : '') + '>(GMT-12:00) International Date Line West</option>';
                tempRows += '<option value="Pacific/Midway|-11:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Midway' ? 'selected' : '') + '>(GMT-11:00) Midway Island, Samoa</option>';
                tempRows += '<option value="Pacific/Honolulu|-10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Honolulu' ? 'selected' : '') + '>(GMT-10:00) Hawaii</option>';
                tempRows += '<option value="America/Anchorage|-09:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Anchorage' ? 'selected' : '') + '>(GMT-09:00) Alaska</option>';
                tempRows += '<option value="America/Los_Angeles|-08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Los_Angeles' ? 'selected' : '') + '>(GMT-08:00) Pacific Time (US & Canada)</option>';
                tempRows += '<option value="America/Tijuana|-08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Tijuana' ? 'selected' : '') + '>(GMT-08:00) Tijuana, Baja California</option>';
                tempRows += '<option value="America/Phoenix|-07:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Phoenix' ? 'selected' : '') + '>(GMT-07:00) Arizona</option>';
                tempRows += '<option value="America/Chihuahua|-07:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Chihuahua' ? 'selected' : '') + '>(GMT-07:00) Chihuahua, La Paz, Mazatlan</option>';
                tempRows += '<option value="America/Denver|-07:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Denver' ? 'selected' : '') + '>(GMT-07:00) Mountain Time (US & Canada)</option>';
                tempRows += '<option value="America/Managua|-06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Managua' ? 'selected' : '') + '>(GMT-06:00) Central America</option>';
                tempRows += '<option value="America/Chicago|-06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Chicago' ? 'selected' : '') + '>(GMT-06:00) Central Time (US & Canada)</option>';
                tempRows += '<option value="America/Mexico_City|-06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Mexico_City' ? 'selected' : '') + '>(GMT-06:00) Guadalajara, Mexico City, Monterrey</option>';
                tempRows += '<option value="America/Regina|-06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Regina' ? 'selected' : '') + '>(GMT-06:00) Saskatchewan</option>';
                tempRows += '<option value="America/Bogota|-05:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Bogota' ? 'selected' : '') + '>(GMT-05:00) Bogota, Lima, Quito, Rio Branco</option>';
                tempRows += '<option value="America/New_York|-05:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/New_York' ? 'selected' : '') + '>(GMT-05:00) Eastern Time (US & Canada)</option>';
                tempRows += '<option value="America/Indiana/Indianapolis|-05:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Indiana/Indianapolis' ? 'selected' : '') + '>(GMT-05:00) Indiana (East)</option>';
                tempRows += '<option value="America/Halifax|-04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Halifax' ? 'selected' : '') + '>(GMT-04:00) Atlantic Time (Canada)</option>';
                tempRows += '<option value="America/Caracas|-04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Caracas' ? 'selected' : '') + '>(GMT-04:00) Caracas, La Paz</option>';
                tempRows += '<option value="America/Manaus|-04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Manaus' ? 'selected' : '') + '>(GMT-04:00) Manaus</option>';
                tempRows += '<option value="America/Santiago|-04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Santiago' ? 'selected' : '') + '>(GMT-04:00) Santiago</option>';
                tempRows += '<option value="America/St_Johns|-03:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/St_Johns' ? 'selected' : '') + '>(GMT-03:30) Newfoundland</option>';
                tempRows += '<option value="America/Sao_Paulo|-03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Sao_Paulo' ? 'selected' : '') + '>(GMT-03:00) Brasilia</option>';
                tempRows += '<option value="America/Argentina/Buenos_Aires|-03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Argentina/Buenos_Aires' ? 'selected' : '') + '>(GMT-03:00) Buenos Aires, Georgetown</option>';
                tempRows += '<option value="America/Godthab|-03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Godthab' ? 'selected' : '') + '>(GMT-03:00) Greenland</option>';
                tempRows += '<option value="America/Montevideo|-03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Montevideo' ? 'selected' : '') + '>(GMT-03:00) Montevideo</option>';
                tempRows += '<option value="America/Noronha|-02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'America/Noronha' ? 'selected' : '') + '>(GMT-02:00) Mid-Atlantic</option>';
                tempRows += '<option value="Atlantic/Cape_Verde|-01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Atlantic/Cape_Verde' ? 'selected' : '') + '>(GMT-01:00) Cape Verde Is.</option>';
                tempRows += '<option value="Atlantic/Azores|-01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Atlantic/Azores' ? 'selected' : '') + '>(GMT-01:00) Azores</option>';
                tempRows += '<option value="Africa/Casablanca|+00:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Casablanca' ? 'selected' : '') + '>(GMT+00:00) Casablanca, Monrovia, Reykjavik</option>';
                tempRows += '<option value="Etc/Greenwich|+00:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Etc/Greenwich' ? 'selected' : '') + '>(GMT+00:00) Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London</option>';
                tempRows += '<option value="Europe/Amsterdam|+01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Amsterdam' ? 'selected' : '') + '>(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna</option>';
                tempRows += '<option value="Europe/Belgrade|+01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Belgrade' ? 'selected' : '') + '>(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague</option>';
                tempRows += '<option value="Europe/Brussels|+01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Brussels' ? 'selected' : '') + '>(GMT+01:00) Brussels, Copenhagen, Madrid, Paris</option>';
                tempRows += '<option value="Europe/Sarajevo|+01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Sarajevo' ? 'selected' : '') + '>(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb</option>';
                tempRows += '<option value="Africa/Lagos|+01:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Lagos' ? 'selected' : '') + '>(GMT+01:00) West Central Africa</option>';
                tempRows += '<option value="Asia/Amman|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Amman' ? 'selected' : '') + '>(GMT+02:00) Amman</option>';
                tempRows += '<option value="Europe/Athens|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Athens' ? 'selected' : '') + '>(GMT+02:00) Athens, Bucharest, Istanbul</option>';
                tempRows += '<option value="Asia/Beirut|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Beirut' ? 'selected' : '') + '>(GMT+02:00) Beirut</option>';
                tempRows += '<option value="Africa/Cairo|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Cairo' ? 'selected' : '') + '>(GMT+02:00) Cairo</option>';
                tempRows += '<option value="Africa/Harare|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Harare' ? 'selected' : '') + '>(GMT+02:00) Harare, Pretoria</option>';
                tempRows += '<option value="Europe/Helsinki|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Helsinki' ? 'selected' : '') + '>(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius</option>';
                tempRows += '<option value="Asia/Jerusalem|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Jerusalem' ? 'selected' : '') + '>(GMT+02:00) Jerusalem</option>';
                tempRows += '<option value="Europe/Minsk|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Minsk' ? 'selected' : '') + '>(GMT+02:00) Minsk</option>';
                tempRows += '<option value="Africa/Windhoek|+02:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Windhoek' ? 'selected' : '') + '>(GMT+02:00) Windhoek</option>';
                tempRows += '<option value="Asia/Kuwait|+03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Kuwait' ? 'selected' : '') + '>(GMT+03:00) Kuwait, Riyadh, Baghdad</option>';
                tempRows += '<option value="Europe/Moscow|+03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Europe/Moscow' ? 'selected' : '') + '>(GMT+03:00) Moscow, St. Petersburg, Volgograd</option>';
                tempRows += '<option value="Africa/Nairobi|+03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Africa/Nairobi' ? 'selected' : '') + '>(GMT+03:00) Nairobi</option>';
                tempRows += '<option value="Asia/Tbilisi|+03:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Tbilisi' ? 'selected' : '') + '>(GMT+03:00) Tbilisi</option>';
                tempRows += '<option value="Asia/Tehran|+03:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Tehran' ? 'selected' : '') + '>(GMT+03:30) Tehran</option>';
                tempRows += '<option value="Asia/Muscat|+04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Muscat' ? 'selected' : '') + '>(GMT+04:00) Abu Dhabi, Muscat</option>';
                tempRows += '<option value="Asia/Baku|+04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Baku' ? 'selected' : '') + '>(GMT+04:00) Baku</option>';
                tempRows += '<option value="Asia/Yerevan|+04:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Yerevan' ? 'selected' : '') + '>(GMT+04:00) Yerevan</option>';
                tempRows += '<option value="Asia/Kabul|+04:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Kabul' ? 'selected' : '') + '>(GMT+04:30) Kabul</option>';
                tempRows += '<option value="Asia/Yekaterinburg|+05:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Yekaterinburg' ? 'selected' : '') + '>(GMT+05:00) Yekaterinburg</option>';
                tempRows += '<option value="Asia/Karachi|+05:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Karachi' ? 'selected' : '') + '>(GMT+05:00) Islamabad, Karachi, Tashkent</option>';
                tempRows += '<option value="Asia/Calcutta|+05:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Calcutta' ? 'selected' : '') + '>(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi, Sri Jayawardenapura</option>';
                tempRows += '<option value="Asia/Katmandu|+05:45" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Katmandu' ? 'selected' : '') + '>(GMT+05:45) Kathmandu</option>';
                tempRows += '<option value="Asia/Almaty|+06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Almaty' ? 'selected' : '') + '>(GMT+06:00) Almaty, Novosibirsk</option>';
                tempRows += '<option value="Asia/Dhaka|+06:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Dhaka' ? 'selected' : '') + '>(GMT+06:00) Astana, Dhaka</option>';
                tempRows += '<option value="Asia/Rangoon|+06:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Rangoon' ? 'selected' : '') + '>(GMT+06:30) Yangon (Rangoon)</option>';
                tempRows += '<option value="Asia/Bangkok|+07:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Bangkok' ? 'selected' : '') + '>(GMT+07:00) Bangkok, Hanoi, Jakarta</option>';
                tempRows += '<option value="Asia/Krasnoyarsk|+07:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Krasnoyarsk' ? 'selected' : '') + '>(GMT+07:00) Krasnoyarsk</option>';
                tempRows += '<option value="Asia/Hong_Kong|+08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Hong_Kong' ? 'selected' : '') + '>(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi</option>';
                tempRows += '<option value="Asia/Kuala_Lumpur|+08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Kuala_Lumpur' ? 'selected' : '') + '>(GMT+08:00) Kuala Lumpur, Singapore</option>';
                tempRows += '<option value="Asia/Irkutsk|+08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Irkutsk' ? 'selected' : '') + '>(GMT+08:00) Irkutsk, Ulaan Bataar</option>';
                tempRows += '<option value="Australia/Perth|+08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Perth' ? 'selected' : '') + '>(GMT+08:00) Perth</option>';
                tempRows += '<option value="Asia/Taipei|+08:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Taipei' ? 'selected' : '') + '>(GMT+08:00) Taipei</option>';
                tempRows += '<option value="Asia/Tokyo|+09:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Tokyo' ? 'selected' : '') + '>(GMT+09:00) Osaka, Sapporo, Tokyo</option>';
                tempRows += '<option value="Asia/Seoul|+09:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Seoul' ? 'selected' : '') + '>(GMT+09:00) Seoul</option>';
                tempRows += '<option value="Asia/Yakutsk|+09:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Yakutsk' ? 'selected' : '') + '>(GMT+09:00) Yakutsk</option>';
                tempRows += '<option value="Australia/Adelaide|+09:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Adelaide' ? 'selected' : '') + '>(GMT+09:30) Adelaide</option>';
                tempRows += '<option value="Australia/Darwin|+09:30" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Darwin' ? 'selected' : '') + '>(GMT+09:30) Darwin</option>';
                tempRows += '<option value="Australia/Brisbane|+10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Brisbane' ? 'selected' : '') + '>(GMT+10:00) Brisbane</option>';
                tempRows += '<option value="Australia/Canberra|+10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Canberra' ? 'selected' : '') + '>(GMT+10:00) Canberra, Melbourne, Sydney</option>';
                tempRows += '<option value="Australia/Hobart|+10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Australia/Hobart' ? 'selected' : '') + '>(GMT+10:00) Hobart</option>';
                tempRows += '<option value="Pacific/Guam|+10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Guam' ? 'selected' : '') + '>(GMT+10:00) Guam, Port Moresby</option>';
                tempRows += '<option value="Asia/Vladivostok|+10:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Vladivostok' ? 'selected' : '') + '>(GMT+10:00) Vladivostok</option>';
                tempRows += '<option value="Asia/Magadan|+11:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Asia/Magadan' ? 'selected' : '') + '>(GMT+11:00) Magadan, Solomon Is., New Caledonia</option>';
                tempRows += '<option value="Pacific/Auckland|+12:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Auckland' ? 'selected' : '') + '>(GMT+12:00) Auckland, Wellington</option>';
                tempRows += '<option value="Pacific/Fiji|+12:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Fiji' ? 'selected' : '') + '>(GMT+12:00) Fiji, Kamchatka, Marshall Is.</option>';
                tempRows += '<option value="Pacific/Tongatapu|+13:00" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'Pacific/Tongatapu' ? 'selected' : '') + '>(GMT+13:00) Nuku\'alofa</option>';                
                tempRows += '</select>';                    
                
                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ',\'COMPANY_TIMEZONE\');" /></td>';                    
                jQuery('span#dragonvisit_form_3_5_1_backup_timezone').text(dragonvisitzyx987_validString(objArr[i].value));*/
            } else if(temp_name === 'DBBACKUP_FREQUENCY') {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value) + '</span>';
                tempRows += '<select class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
                tempRows += '<option value="daily" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'daily' ? 'selected' : '') + '>daily</option>';
                tempRows += '<option value="weekly" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'weekly' ? 'selected' : '') + '>weekly (Since WordPress 5.4)</option>';
                tempRows += '<option value="twicedaily" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'twicedaily' ? 'selected' : '') + '>twicedaily</option>';
                tempRows += '<option value="hourly" ' + (dragonvisitzyx987_validString(objArr[i].value) === 'hourly' ? 'selected' : '') + '>hourly</option>';            
                tempRows += '</select>';                    
                
                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ');" /></td>';                    
                
            } else if(temp_name === 'DBBACKUP_LOCALTIME') {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value) + '</span>';
                tempRows += '<input class="constantedittextbox dragonvisitzyx987_datetimepicker" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].value) + '"/>';                    
                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ');" /></td>';                    
            } else if(temp_name === 'DBBACKUP_DETAILS') {
                if(dragonvisitzyx987_validString(objArr[i].value) === '') {
                    tempRows += '<td><span class="constantspan" >VALUE IS NOT SET</span>';    
                } else {
                    tempRows += '<td><span class="constantspan" >HAS VALUE, CONFIDENTIAL</span>';    
                }                        
                tempRows += '</td>';                    
            } else if(temp_name === 'USE_BOOTSTRAP_JS') {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value === '1' ? 'yes' : 'no') + '</span>';
                tempRows += '<select class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
                
                //tempRows += '<option value="-1">Please choose one...</option>';
                tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].value) === '1' ? 'selected' : '') + '>Yes</option>';
                tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].value) === '0' ? 'selected' : '') + '>No</option>';
                tempRows += '</select>';

                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ',\'USE_BOOTSTRAP_JS\');" /></td>';
            } else if(temp_name === 'USE_BOOTSTRAP_CSS') {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value === '1' ? 'yes' : 'no') + '</span>';
                tempRows += '<select class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
                
                //tempRows += '<option value="-1">Please choose one...</option>';
                tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].value) === '1' ? 'selected' : '') + '>Yes</option>';
                tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].value) === '0' ? 'selected' : '') + '>No</option>';
                tempRows += '</select>';

                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ',\'USE_BOOTSTRAP_CSS\');" /></td>';
            } else if(temp_name === 'SHOW_ALL_VISITS_WHEN_NOT_SEARCH') {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value === '1' ? 'yes' : 'no') + '</span>';
                tempRows += '<select class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" >';
                
                //tempRows += '<option value="-1">Please choose one...</option>';
                tempRows += '<option value="1" ' + (dragonvisitzyx987_validString(objArr[i].value) === '1' ? 'selected' : '') + '>Yes</option>';
                tempRows += '<option value="0" ' + (dragonvisitzyx987_validString(objArr[i].value) === '0' ? 'selected' : '') + '>No</option>';
                tempRows += '</select>';

                tempRows += '<input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ',\'SHOW_ALL_VISITS_WHEN_NOT_SEARCH\');" /></td>';
            } else {
                tempRows += '<td><span class="constantspan" >' + dragonvisitzyx987_validString(objArr[i].value) + '</span><input class="constantedittextbox" style="display:none;" name="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constant_' + dragonvisitzyx987_validString(objArr[i].id) + '" value="' + dragonvisitzyx987_validString(objArr[i].value) + '" /><input class="constantedittextbox" style="display:none;" type="button" value="Update" name="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" id="constanteditsubmitbutton_' + dragonvisitzyx987_validString(objArr[i].id) + '" onclick="dragonvisitzyx987_submitConstantValue(\'constant_' + dragonvisitzyx987_validString(objArr[i].id) + '\', ' + dragonvisitzyx987_validString(objArr[i].id) + ');" /></td>';
            }
            tempRows += '<td>' + dragonvisitzyx987_validString(objArr[i].createtimeutc) + '</td><td>' + (dragonvisitzyx987_validString(objArr[i].status) === 1 ? 'ACTIVE' : 'INACTIVE') + '</td></tr>';
        }                                    
        jQuery('tbody#dragonvisit_constant').html(tempRows);
        var totalconstantquantity = mydata["total"] == null ? '0' : mydata["total"];
        jQuery('span#totalconstantquantity').text(totalconstantquantity);                    
        jQuery('img#admin_constantlist_loader').hide();            
        jQuery(".dragonvisitzyx987_datetimepicker").datetimepicker({ scrollMonth: false, scrollInput: false, format:'Y-m-d H:i:s' });            
        jQuery(".dragonvisitzyx987_datetimepicker2").datetimepicker({ scrollMonth: false, scrollInput: false, datepicker:false, format:'H:i:s' });            
    }).fail(function( jqXHR, textStatus ) {
        //alert( "Request constant list failed: " + textStatus );
    });
}

jQuery(document).ready(function(){
    jQuery("select.presetto_1").val('-1');        
    jQuery('div#dragonvisit_tabs').tabs();    
    jQuery('div#dragonvisit_tabs_1 select').val('14days');
    jQuery("body").append(mediummodalElementContainer);
    jQuery('div#mymediummodal').html('');
    jQuery("body").append(largemodalElementContainer);
    jQuery('div#mylargemodal').html('');
    document.getElementById('mymediummodal').title = '';        
    document.getElementById('mylargemodal').title = '';
    jQuery(".datepicker").val('');
    jQuery(".datepicker").datepicker({ changeMonth:true,changeYear:true,yearRange:"1900:c+10",dateFormat:'yy-mm-dd' });
    jQuery(".dragonvisitzyx987_datetimepicker").datetimepicker({ scrollMonth: false, scrollInput: false, format:'Y-m-d H:i:s' });
    jQuery(".dragonvisitzyx987_datetimepicker2").datetimepicker({ scrollMonth: false, scrollInput: false, datepicker:false, format:'H:i:s' });        
    jQuery("input:text").val('');        
    
    jQuery(window).resize(function() {ng
        jQuery("div#mylargemodal").parent().css("width", jQuery(window).width()).css("height", jQuery(window).height()).css("top", 0);
        jQuery("div#mylargemodal").css("width", jQuery(window).width());
    });
    
    dragonvisitzyx987_getVisitsList();
    dragonvisitzyx987_getRolesList();
    dragonvisitzyx987_getConstantsList();
    dragonvisitzyx987_getTypecategoriesList();
    dragonvisitzyx987_getTypesList();
    dragonvisitzyx987_getDepartmentsList();
    dragonvisitzyx987_getUsersList();
    dragonvisitzyx987_getLogsList();        
    
    if(jQuery('div.master_pwrapper').length > 0) {
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_visit > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).children().first().text())) ? 0 : parseInt(jQuery(this).children().first().text());
                var currentpage;
                if(jQuery(this).hasClass('prev')){
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visit > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visit > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visit > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visit > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_visit, (currentpage+1));
                }
                var sortby = jQuery("select#dragonvisit_visit_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'visit');
            }
        });

        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_visitdetails > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage;
                if(jQuery(this).hasClass('prev')){
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visitdetails > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visitdetails > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visitdetails > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_visitdetails > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_visitdetails, (currentpage+1));
                }
                var sortby = jQuery("select#dragonvisit_visitdetails_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'visitdetails');
            }
        });
        
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_typecategory > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_typecategory > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_typecategory > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_typecategory > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_typecategory > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_typecategory, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_typecategory_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'typecategory');
            }
        });

        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_type > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_type > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_type > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_type > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_type > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_type, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_type_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'type');
            }
        });
        
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_role > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_role > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_role > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_role > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_role > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_role, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_role_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'role');
            }
        });
        
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_user > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_user > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_user > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_user > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_user > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_user, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_user_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'user');
            }
        });

        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_department > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_department > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_department > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_department > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_department > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_department, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_department_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'department');
            }
        });

        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_admin_usertype > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
                var currentpage2;
                if(jQuery(this).hasClass('prev')){
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_usertype > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_usertype > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage2-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage2 = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_usertype > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_admin_usertype > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_admin_usertype, (currentpage2+1));
                }
                var sortby = jQuery("select#dragonvisit_usertype_sortby").val();
                dragonvisitzyx987_showResultOnAjaxReloadedPage(topagenumber, 'usertype');
            }
        });        
    }        
}); //end of jQuery(document).ready

function dragonvisitzyx987_containElement(mystring, myelement) {
    var res = mystring === null ? []: mystring.split(",");
    for (var i = 0; i < res.length; i++) {
        if (res[i] === myelement) {
            return true;
        }
    }
    return false;
}
    
function dragonvisitzyx987_validateInput(callback) {
    return true;
}

function dragonvisitzyx987_confirmDeleteEvent() {
    if(confirm("Are you sure you want to delete this event?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_confirmDisable(dropdownlistid, disableitemname) {
    if(jQuery('#' + dropdownlistid).val() === '0') {
        alert('Please choose a ' + disableitemname + '.');
        return false;
    }
    if(confirm("Are you sure you want to disable this " + disableitemname + "?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_confirmUpload(dropdownlistid) {
    if(jQuery('#' + dropdownlistid).val() === '0') {
        alert('Please choose an excel file.');
        return false;
    }
    if(confirm("Are you sure you want to upload this excel file?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_confirmDrop(dropitemname, includeRelatedTables) {
    var temp = '';
    if(typeof includeRelatedTables !== 'undefined') {
        if(includeRelatedTables === true) {
            temp = ' and related tables';
        }            
    } else {
        temp = ' and related tables';
    }
    if(dropitemname !== 'all') {
        if(confirm("Are you sure you want to drop the " + dropitemname + " table" + temp + "?") == true) {           
            return true;
        }
    } else {
        if(confirm("Are you sure you want to drop all the tables?") == true) {           
            return true;
        }
    }
    return false;
}

function dragonvisitzyx987_confirmDropSP(dropitemname) {
    if(dropitemname !== 'all') {
        if(confirm("Are you sure you want to recreate the " + dropitemname + "?") == true) {           
            return true;
        }
    } else {
        if(confirm("Are you sure you want to recreate all the stored procedures?") == true) {           
            return true;
        }
    }
    return false;
}

function dragonvisitzyx987_confirmEnableAutoBackupDatabaseEveryday() {
    if(confirm("Are you sure you want to enable automatically backup database?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_confirmDisableAutoBackupDatabaseEveryday() {
    if(confirm("Are you sure you want to disable automatically backup database?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_confirmEnableOnetimeImmediateBackupDatabase() {
    if(confirm("Are you sure you want to backup database now for one time?") == true) {           
        return true;
    }
    return false;
}

function dragonvisitzyx987_editConstant(element, constantid) {
    jQuery(element).parent().parent().find('span.constantspan').toggle();
    jQuery(element).parent().parent().find('.constantedittextbox').toggle();
}

function dragonvisitzyx987_submitConstantValue(textboxid, constantid, constantname) {
    if(textboxid === '' || jQuery('#' + textboxid).length === 0) {return "Text box does not exist";}
    var myvalue = jQuery('#' + textboxid).val();
    var myname = ((typeof constantname === 'undefined') ? '' : (constantname === null ? '' : constantname));
    
    var mypluginurl = "<?php $protocol = is_ssl() ? 'https://' : 'http://'; $urlparts = wp_parse_url(home_url()); $protocol = esc_html($urlparts['scheme']) . '://'; $domain = esc_html($urlparts['host']); $myurl = strtok($protocol . $domain . strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI']))), '?'); if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);} echo esc_html($myurl); ?>";                 
    jQuery.ajax({
        type: "POST",
        url: ajaxurl,
        data: {dragonvisitzyx987_hidden_security_editconstantvalue:"<?php echo wp_create_nonce('dragonvisitzyx987_editConstantvalue'); ?>",dragonvisitzyx987_hidden:"Y",action:"dragonvisitzyx987_editConstantvalue", id: constantid, name: myname, value: myvalue, pluginurl: mypluginurl}
    }).done(function (mydata) {
        if(mydata === 'Success') {
            dragonvisitzyx987_getConstantsList();                        
        } else {
            var myresult = mydata === "" ? 'fail' : mydata;
            alert(myresult);
        }
    }).fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
    });
}

function dragonvisitzyx987_cloneusertypesuserto_filter(element) {
    if(jQuery(element).length > 0 && jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > span').length > 0) {
        if(jQuery(element).val() !== '') {
            jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > span').each(function(index){
                if(jQuery(this).text().toLowerCase().indexOf(jQuery(element).val().toLowerCase()) >= 0) {
                    jQuery(this).show();
                    jQuery(this).prev('input').show();
                } else {
                    jQuery(this).hide();
                    jQuery(this).prev('input').hide();
                }
            });
        } else {
            jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').show();
            jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > span').show();
        }
    }
}

function dragonvisitzyx987_cloneusertypesuserto_checkall() {
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').prop('checked', true);
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').attr('checked', true);
}

function dragonvisitzyx987_cloneusertypesuserto_reset() {
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').prop('checked', false);
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').attr('checked', false);
}

function dragonvisitzyx987_cloneusertypesuserto_onlyshowchecked() {
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').each(function(index){
        if(jQuery(this).is(":checked")) {
            jQuery(this).show();
            jQuery(this).next('span').show();
        } else {
            jQuery(this).hide();
            jQuery(this).next('span').hide();
        }
    });        
}

function dragonvisitzyx987_cloneusertypesuserto_showall() {
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > input').show();
    jQuery('p#dragonvisitzyx987_cloneusertypesuserto_list > span').show();        
}

function dragonvisitzyx987_validateDateInput(dateString) {
    var re = /^\d{4}-\d{2}-\d{2}$/;
    var re2 = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/;
    var re3 = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/;
    return (dateString==="") || re.test(dateString) || re2.test(dateString) || re3.test(dateString);    
}    
</script>
<div class="wrap">
<?php 
    // Search for an existing page with the specified page slug.
    $slug = 'officevisitslogbook';
    $valid_pages_found = $wpdb->get_results( $wpdb->prepare( "SELECT guid FROM $wpdb->posts WHERE post_type='page' AND post_status NOT IN ( 'pending', 'trash', 'future', 'auto-draft' )  AND post_name = %s;", $slug ) );
    if ( count($valid_pages_found) > 1 ) {
        echo '<h2 style="text-decoration: none;font-weight: bold;">' . __( 'Office Visits Logbook', 'dragonvisit_trdom' ) . "</h2>";
        echo "<p style='color:red !important;'>" . __( "More than one visit page were created:", "dragonvisit_trdom" ) . "</p>";
        $pagecounter = 1;
        foreach( $valid_pages_found as $page ) {
            echo '<p><a target="_blank" style="text-decoration: none;" href=' . $page->guid . ">" . __( 'Page ' . $pagecounter . ': ' . $page->guid, 'dragonvisit_trdom' ) . "</a></p>";
            $pagecounter ++;
        }
    } else if ( count($valid_pages_found) == 1 ) {
        foreach( $valid_pages_found as $page ) {
            echo '<h2><a target="_blank" style="text-decoration: none;font-weight: bold;" href=' . $page->guid . ">" . __( 'Office Visits Logbook', 'dragonvisit_trdom' ) . "</a></h2>";
        }
    } else {
        echo '<h2 style="text-decoration: none;font-weight: bold;">' . __( 'Office Visits Logbook', 'dragonvisit_trdom' ) . "</h2>"; 
    }
?>
<p>This plugin helps you to record company office visitors' visit details. After plugin activation, go to the "Settings" menu to find the plugin admin page. By default, when you activate this plugin, it will automatically create a visit landing page for you. For some themes, if it does not automatically create a visit landing page for you, add this plugin root folder template-officevisitslogbook.php file to your template folder. For example, if you are using theme twentytwenty, then add the template-officevisitslogbook.php file to this folder: wordpress\wp-content\themes\twentytwenty\templates. Then you can create a new page (not a new post) using this template. When you use the template method to create a new visit page, do not set the page title to "officevisitslogbook". If you set the page title to "officevisitslogbook", it could conflict with the page automatically created when you activate this plugin. Please click "Documents" tab to learn more from the documentation file.</p>
<?php if($userdetails[0]->canreadinadminpage !== '1') { ?>
    <p style="color:red;">You are not authorized to read this page. Please contact web admin.</p>
<?php exit;} ?>
<div id="dragonvisit_tabs">
    <ul>
        <li><a href="#dragonvisit_tabs_2"><?php echo "<h3>" . __( 'Tables 1', 'dragonvisit_trdom' ) . "</h3>"; ?></a></li>
        <li><a href="#dragonvisit_tabs_3"><?php echo "<h3>" . __( 'Tables 2', 'dragonvisit_trdom' ) . "</h3>"; ?></a></li>
        <li><a href="#dragonvisit_tabs_4"><?php echo "<h3>" . __( 'Tables 3', 'dragonvisit_trdom' ) . "</h3>"; ?></a></li>
        <li><a href="#dragonvisit_tabs_6"><?php echo "<h3>" . __( 'Re-create stored procedures', 'dragonvisit_trdom' ) . "</h3>" ?></a></li>
        <li><a href="#dragonvisit_tabs_7"><?php echo "<h3>" . __( 'Documents', 'dragonvisit_trdom' ) . "</h3>" ?></a></li>
    </ul>
<div id="dragonvisit_tabs_2">
<?php echo "<h3>" . __( '1. Office Visits:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <div id="dragonvisit_order_container">
        <p>Search Visitor Name: <input type="text" id="dragonvisit_visit_name" name="dragonvisit_visit_name" class="" value="" size="50" /></p>
        <p>Search Visit Reason: <input type="text" id="dragonvisit_visit_reason" name="dragonvisit_visit_reason" class="" value="" size="50" /></p>

        <p>Search User: <select id="dragonvisit_visit_userid" name="dragonvisit_visit_userid" class="presetto_1" >
           <option value="-1">Please choose one...</option>        
           <?php foreach ($allusers as $user) { ?>
           <option value="<?php echo $user->userid; ?>" style="<?php echo $user->status === '1' ? '' : 'color:grey;'; ?>"><?php echo esc_html($user->firstname) . ' ' . esc_html($user->lastname) . " (" . $user->userid . ")"; ?></option>
           <?php } ?>        
        </select></p>    

        <p>Search From Date: <input type="text" id="dragonvisit_visit_fromdate" name="dragonvisit_visit_fromdate" class="datepicker" value="" size="50" /></p>    
        <p>Search To Date: <input type="text" id="dragonvisit_visit_todate" name="dragonvisit_visit_todate" class="datepicker" value="" size="50" /></p>    

        <p>Search Visit Type: 
            <select id="dragonvisit_visit_type" name="dragonvisit_visit_type"  class="presetto_1" >
                <option value="-1">Please choose one...</option>        
                <?php
                if(!empty($activevisittypes)){
                    foreach ($activevisittypes as $type){
                        echo "<option value='" . intval($type->id) . "'>" . esc_html($type->name) . ' (' . esc_html($type->typecategoryname) . ")</option>";
                    }
                }
                ?>            
            </select>    
        </p>

        <p>Search Visit Status: 
            <select id="dragonvisit_visit_status" name="dragonvisit_visit_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>
                <option value="0" >NOT ACTIVE</option>                
            </select>    
        </p>        
        
        <p>
            <input type="button" id="dragonvisit_visit_search" name="dragonvisit_visit_search" class="" value="Search" onclick="dragonvisitzyx987_getVisitsList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="dragonvisit_visit_searchreset" name="dragonvisit_visit_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetVisitsSearchParameters();" style="background-color:grey;"/>
        </p>    
        
        <p>Items per Page: 
            <select id="dragonvisit_visit_itemsperpage" name="dragonvisit_visit_itemsperpage" onchange="dragonvisitzyx987_getVisitsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_visit_sortby" name="dragonvisit_visit_sortby" onchange="dragonvisitzyx987_getVisitsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >Visit ID low-high</option>
                <option value="id|desc" >Visit ID high-low</option>    
                <option value="userid|asc" >User id low-high</option>
                <option value="userid|desc" >User id high-low</option>    
                <option value="date|asc" >Visit date old-new</option>    
                <option value="date|desc" >Visit date new-old</option>    
                <option value="visittype|asc" >Visit type id low-high</option>    
                <option value="visittype|desc" >Visit type id high-low</option>                    
            </select>    
        </p>
    
        Total visits: <span id="totalvisitquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_visitlist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_visit" style="display: inline-block;"></div>
        </div>
        
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Visit Type</th>
                    <th>Visitor Name</th>
                    <th>Reason For Visit</th>
                    <th>Visit Date</th>
                    <th>Time In</th>
                    <th>Time Out</th>
                    <th>Status</th>
                    <th>User Name</th>
                    <th>User Name 2</th>
                    <th>User Id</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_visit">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_visit" style="display: inline-block;"></div>
        </div>        
    </div><hr/>
    
    <?php echo "<h3>" . __( '2. Type Category:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <?php echo "<h3>" .  __( '2.1 Create a new type category', 'dragonvisit_trdom' ) . "</h3>" ?>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form2_1" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html($_SERVER['REQUEST_URI']))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_addTypecategory"); ?>">
        <p><?php _e("Type Category Name *: " ); ?><input type="text" name="dragonvisitzyx987_addtypecategoryname" value="" size="100"><?php _e(" e.g. Cancelled" ); ?></p>
        <p><?php _e("Description: " ); ?><br/><textarea name="dragonvisitzyx987_addtypecategorydescription" rows="4" cols="100"></textarea><br/></p>

        <p class="submit">
            <input type="submit" name="Submit" onclick="return dragonvisitzyx987_validateInput();" value="<?php _e('Create Type Category', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>
    <?php } else { ?>
            <p style="color:red;">You are not authorized to create a new type category. Please contact web admin.</p>
    <?php } ?>
        <hr />
    <?php echo "<h3>" .  __( '2.2 Type Category list', 'dragonvisit_trdom' ) . "</h3>" ?>        
    <div id="dragonvisit_typecategory_container">
        <p>Search Name: <input type="text" id="dragonvisit_typecategory_name" name="dragonvisit_typecategory_name" class="" value="" size="50" /></p>
        <p>Search Type Category Status: 
            <select id="dragonvisit_typecategory_status" name="dragonvisit_typecategory_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>
                <option value="0" >NOT ACTIVE</option>            
            </select>    
        </p>
        
        <p>
            <input type="button" id="dragonvisit_typecategory_search" name="dragonvisit_typecategory_search" class="" value="Search" onclick="dragonvisitzyx987_getTypecategoriesList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="dragonvisit_typecategory_searchreset" name="dragonvisit_typecategory_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetTypecategoriesSearchParameters();" style="background-color:grey;"/>
        </p>    
        
        <p>Items per Page: 
            <select id="dragonvisit_typecategory_itemsperpage" name="dragonvisit_typecategory_itemsperpage" onchange="dragonvisitzyx987_getTypecategoriesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_typecategory_sortby" name="dragonvisit_typecategory_sortby" onchange="dragonvisitzyx987_getTypecategoriesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>
                <option value="name|asc" >Name a-z</option>
                <option value="name|desc" >Name z-a</option>
                <option value="createtimeutc|asc" >Created Date old-new</option>
                <option value="createtimeutc|desc" >Created Date new-old</option>                
            </select>    
        </p>    
        
        Total type categories: <span id="totaltypecategoryquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_typecategorylist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_typecategory" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Created Date(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_typecategory">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_typecategory" style="display: inline-block;"></div>
        </div>        
    </div><hr/>

    <?php echo "<h3>" . __( '3. Type:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <?php echo "<h3>" .  __( '3.1 Create a new type', 'dragonvisit_trdom' ) . "</h3>" ?>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form3_1" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_addType"); ?>">        
        <p><?php _e("Type category *: "); ?>
        <select id="dragonvisitzyx987_addtypetypecategory"  name="dragonvisitzyx987_addtypetypecategory" class="presetto_1">
           <option value="-1">Please choose one...</option>
           <?php foreach ($activetypecategories as $typecategory) { ?>
           <option value="<?php echo intval($typecategory->id); ?>" ><?php echo esc_html($typecategory->name); ?></option>
           <?php } ?>
         </select></p>
        
        <p><?php _e("Type Name *: " ); ?><input type="text" name="dragonvisitzyx987_addtypename" value="" size="100"></p>
        <p><?php _e("Description: " ); ?><br/><textarea name="dragonvisitzyx987_addtypedescription" rows="4" cols="100"></textarea><br/></p>
        
        <p class="submit">
            <input type="submit" name="Submit" onclick="return dragonvisitzyx987_validateInput();" value="<?php _e('Create Type', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>
    <?php } else { ?>
            <p style="color:red;">You are not authorized to create a new type. Please contact web admin.</p>
    <?php } ?>    
    <hr />
    
    <?php echo "<h3>" .  __( '3.2 Type list', 'dragonvisit_trdom' ) . "</h3>" ?>        
    <div id="dragonvisit_type_container">
        <p>Search Name: <input type="text" id="dragonvisit_type_name" name="dragonvisit_type_name" class="" value="" size="50" /></p>
        <p>Search Type Status: 
            <select id="dragonvisit_type_status" name="dragonvisit_type_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>
                <option value="0" >NOT ACTIVE</option>            
            </select>    
        </p>
        
        <p>
        <input type="button" id="dragonvisit_type_search" name="dragonvisit_type_search" class="" value="Search" onclick="dragonvisitzyx987_getTypesList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" id="dragonvisit_type_searchreset" name="dragonvisit_type_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetTypesSearchParameters();" style="background-color:grey;"/>
        </p>    
        
        <p>Items per Page: 
            <select id="dragonvisit_type_itemsperpage" name="dragonvisit_type_itemsperpage" onchange="dragonvisitzyx987_getTypesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_type_sortby" name="dragonvisit_type_sortby" onchange="dragonvisitzyx987_getTypesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>
                <option value="name|asc" >Name a-z</option>
                <option value="name|desc" >Name z-a</option>
                <option value="createtimeutc|asc" >Created Date old-new</option>
                <option value="createtimeutc|desc" >Created Date new-old</option>                
            </select>    
        </p>    
        
        Total types: <span id="totaltypequantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_typelist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_type" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Type Category Name</th>
                    <th>Created Date(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_type">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_type" style="display: inline-block;"></div>
        </div>        
    </div><hr/>
</div>
<div id="dragonvisit_tabs_3">
    <?php echo "<h3>" . __( '4. Role:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <?php echo "<h3>" .  __( '4.1 Create a new role', 'dragonvisit_trdom' ) . "</h3>" ?>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form4_1" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_addRole"); ?>">
                
        <p><?php _e("Role Name *: " ); ?><input type="text" name="dragonvisitzyx987_addrolename" value="" size="100"><?php _e(" e.g. manager" ); ?></p>
        <p><?php _e("Description: " ); ?><br/><textarea name="dragonvisitzyx987_addroledescription" rows="4" cols="100"></textarea><br/></p>
               
        <p class="submit">
            <input type="submit" name="Submit" onclick="return dragonvisitzyx987_validateInput();" value="<?php _e('Create Role', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>
    <?php } else { ?>
            <p style="color:red;">You are not authorized to create a new role. Please contact web admin.</p>
    <?php } ?>    
        <hr />
    <?php echo "<h3>" .  __( '4.2 Role list', 'dragonvisit_trdom' ) . "</h3>" ?>        
    <div id="dragonvisit_role_container">
        <p>Search Name: <input type="text" id="dragonvisit_role_name" name="dragonvisit_role_name" class="" value="" size="50" /></p>
        <p>Search Role Status: 
            <select id="dragonvisit_role_status" name="dragonvisit_role_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>    
                <option value="0" >NOT ACTIVE</option>        
            </select>    
        </p>
        
        <p>
            <input type="button" id="dragonvisit_role_search" name="dragonvisit_role_search" class="" value="Search" onclick="dragonvisitzyx987_getRolesList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="dragonvisit_role_searchreset" name="dragonvisit_role_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetRolesSearchParameters();" style="background-color:grey;"/>
        </p>    
        
        <p>Items per Page: 
            <select id="dragonvisit_role_itemsperpage" name="dragonvisit_role_itemsperpage" onchange="dragonvisitzyx987_getRolesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_role_sortby" name="dragonvisit_role_sortby" onchange="dragonvisitzyx987_getRolesList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>
                <option value="name|asc" >Name a-z</option>
                <option value="name|desc" >Name z-a</option>
                <option value="createtimeutc|asc" >Created Date old-new</option>
                <option value="createtimeutc|desc" >Created Date new-old</option>                
            </select>    
        </p>    
        
        Total roles: <span id="totalrolequantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_rolelist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_role" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Created Date(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_role">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_role" style="display: inline-block;"></div>
        </div>        
    </div><hr/>

    <?php echo "<h3>" . __( '5. Department:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <?php echo "<h3>" . __( '5.1 Create a new department', 'dragonvisit_trdom' ) . "</h3>" ?>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form5_1" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_addDepartment"); ?>">
                
        <p><?php _e("Department Name *: " ); ?><input type="text" name="dragonvisitzyx987_adddepartmentname" value="" size="100"><?php _e(" e.g. Cancelled" ); ?></p>
        <p><?php _e("Description: " ); ?><br/><textarea name="dragonvisitzyx987_adddepartmentdescription" rows="4" cols="100"></textarea><br/></p>
               
        <p class="submit">
            <input type="submit" name="Submit" onclick="return dragonvisitzyx987_validateInput();" value="<?php _e('Create Department', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>    
    <?php } else { ?>
            <p style="color:red;">You are not authorized to create a new department. Please contact web admin.</p>
    <?php } ?>    
        <hr />
    <?php echo "<h3>" .  __( '5.2 Department list', 'dragonvisit_trdom' ) . "</h3>" ?>        
    <div id="dragonvisit_department_container">
        <p>Search Name: <input type="text" id="dragonvisit_department_name" name="dragonvisit_department_name" class="" value="" size="50" /></p>
        <p>Search Department Status: 
            <select id="dragonvisit_department_status" name="dragonvisit_department_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>
                <option value="0" >NOT ACTIVE</option>            
            </select>    
        </p>
        
        <p>
            <input type="button" id="dragonvisit_department_search" name="dragonvisit_department_search" class="" value="Search" onclick="dragonvisitzyx987_getDepartmentsList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="dragonvisit_department_searchreset" name="dragonvisit_department_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetDepartmentsSearchParameters();" style="background-color:grey;"/>
        </p>    
        
        <p>Items per Page: 
            <select id="dragonvisit_department_itemsperpage" name="dragonvisit_department_itemsperpage" onchange="dragonvisitzyx987_getDepartmentsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_department_sortby" name="dragonvisit_department_sortby" onchange="dragonvisitzyx987_getDepartmentsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>
                <option value="name|asc" >Name a-z</option>
                <option value="name|desc" >Name z-a</option>
                <option value="createtimeutc|asc" >Created Date old-new</option>
                <option value="createtimeutc|desc" >Created Date new-old</option>                
            </select>    
        </p>    
        
        Total departments: <span id="totaldepartmentquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_departmentlist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_department" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Created Date(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_department">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_department" style="display: inline-block;"></div>
        </div>        
    </div><hr/>

    <?php echo "<h3>" . __( '6. User:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <?php echo "<h3>" . __( '6.1 Create a new user', 'dragonvisit_trdom' ) . "</h3>" ?>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form6_1" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_addUser"); ?>">
                
        <p><?php _e("First name *: " ); ?><input type="text" name="dragonvisitzyx987_adduserfirstname" value="" size="50"><?php _e(" e.g. John" ); ?></p>
        <p><?php _e("Last name *: " ); ?><input type="text" name="dragonvisitzyx987_adduserlastname" value="" size="50"><?php _e(" e.g. Jackson" ); ?></p>
        <p><?php _e("WordPress user ID *: " ); ?>
        <select name="dragonvisitzyx987_adduserid"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeWPusers as $user) { ?>
           <option value="<?php echo intval($user->ID); ?>" style=""><?php echo esc_html($user->fullname) . " (" . intval($user->ID) . ")"; ?></option>
           <?php } ?>        
        </select></p>
        
        <p><?php _e("Report to WordPress user ID *: " ); ?>
        <select name="dragonvisitzyx987_adduserreportto"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeWPusers as $user) { ?>
           <option value="<?php echo intval($user->ID); ?>" style=""><?php echo esc_html($user->fullname) . " (" . intval($user->ID) . ")"; ?></option>
           <?php } ?>        
        </select></p>
        
        <p><?php _e("User can read data in admin page (default is NO): " ); ?>
        <select name="dragonvisitzyx987_addusercanreadinadminpage"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        
        <p><?php _e("User can create data in admin page (default is NO): " ); ?>
        <select name="dragonvisitzyx987_addusercancreateinadminpage"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can edit data in admin page (default is NO): " ); ?>
        <select name="dragonvisitzyx987_addusercaneditinadminpage"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can activate data in admin page (default is NO): " ); ?>
        <select name="dragonvisitzyx987_addusercanactivateinadminpage"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can deactivate data in admin page (default is NO): " ); ?>
        <select name="dragonvisitzyx987_addusercandeactivateinadminpage"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>

        <p><?php _e("Role : " ); ?>
        <select name="dragonvisitzyx987_adduserrole"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeroles as $role) { ?>
           <option value="<?php echo intval($role->id); ?>" style="<?php echo $role->status === '1' ? '' : 'color:grey;'; ?>"><?php echo esc_html($role->name) . " (" . intval($role->id) . ")"; ?></option>
           <?php } ?>        
        </select></p>
        
        <p><?php _e("Department : " ); ?>
        <select name="dragonvisitzyx987_adduserdepartment"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activedepartments as $department) { ?>
           <option value="<?php echo intval($department->id); ?>" style="<?php echo $department->status === '1' ? '' : 'color:grey;'; ?>"><?php echo esc_html($department->name) . " (" . intval($department->id) . ")"; ?></option>
           <?php } ?>        
        </select></p>        
        
        <p><?php _e("Status (default is active): " ); ?>
        <select name="dragonvisitzyx987_adduserstatus"  class="presetto_1"  >
           <option value="-1">Please choose one...</option>
           <option value="1">ACTIVE</option>
           <option value="0">NOT ACTIVE</option>           
        </select></p>

        <p><?php _e("Email : " ); ?><input type="text" name="dragonvisitzyx987_adduseremail" value="" size="50"><?php _e(" e.g. abc@gmail.com" ); ?></p>
        <p><?php _e("Phone : " ); ?><input type="text" name="dragonvisitzyx987_adduserphone" value="" size="50"><?php _e(" e.g. 123-456-7890" ); ?></p>
        <p><?php _e("Address : " ); ?><input type="text" name="dragonvisitzyx987_adduseraddress" value="" size="50"><?php _e(" e.g. 123 main road" ); ?></p>
        <p><?php _e("Address 2 : " ); ?><input type="text" name="dragonvisitzyx987_adduseraddress2" value="" size="50"><?php _e(" e.g. suite 201" ); ?></p>
        <p><?php _e("City : " ); ?><input type="text" name="dragonvisitzyx987_addusercity" value="" size="50"><?php _e(" e.g. London" ); ?></p>
        <p><?php _e("Province/State : " ); ?><input type="text" name="dragonvisitzyx987_adduserprovince" value="" size="50"><?php _e(" e.g. Iowa" ); ?></p>
        <p><?php _e("Country : " ); ?><input type="text" name="dragonvisitzyx987_addusercountry" value="" size="50"><?php _e(" e.g. Canada" ); ?></p>
        <p><?php _e("ZIP : " ); ?><input type="text" name="dragonvisitzyx987_adduserzip" value="" size="50"><?php _e(" e.g. 03897" ); ?></p>        
        <p><?php _e("Description: " ); ?><br/><textarea name="dragonvisitzyx987_adduserdescription" rows="4" cols="100"></textarea><br/></p>
               
        <p class="submit">
            <input type="submit" name="Submit" onclick="return dragonvisitzyx987_validateInput();" value="<?php _e('Create User', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>    
    <?php } else { ?>
            <p style="color:red;">You are not authorized to create a new user. Please contact web admin.</p>
    <?php } ?>    
        <hr />
    <?php echo "<h3>" .  __( '6.2 User list', 'dragonvisit_trdom' ) . "</h3>" ?>            
    <div id="dragonvisit_order_container">
        <p>Search User ID: 
        <select id="dragonvisit_user_userid" name="dragonvisit_user_userid" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeWPusers as $user) { ?>
           <option value="<?php echo intval($user->ID); ?>" style=""><?php echo esc_html($user->fullname) . " (" . intval($user->ID) . ")"; ?></option>
           <?php } ?>        
        </select></p>

        <p>Search User Full Name: <input type="text" id="dragonvisit_user_userfullname" name="dragonvisit_user_userfullname" class="" value="" size="50" /></p>    

        <p>Search User Email: <input type="text" id="dragonvisit_user_email" name="dragonvisit_user_email" class="" value="" size="50" /></p>    

        <p><?php _e("Report to user ID *: " ); ?>
        <select id="dragonvisit_user_reportto" name="dragonvisit_user_reportto" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeWPusers as $user) { ?>
           <option value="<?php echo intval($user->ID); ?>" style=""><?php echo esc_html($user->fullname) . " (" . intval($user->ID) . ")"; ?></option>
           <?php } ?>        
        </select></p>
        
        <p><?php _e("User can read data in admin page : " ); ?>
        <select id="dragonvisit_user_canreadinadminpage" name="dragonvisit_user_canreadinadminpage" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        
        <p><?php _e("User can create data in admin page : " ); ?>
        <select id="dragonvisit_user_cancreateinadminpage" name="dragonvisit_user_cancreateinadminpage" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can edit data in admin page : " ); ?>
        <select id="dragonvisit_user_caneditinadminpage" name="dragonvisit_user_caneditinadminpage" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can activate data in admin page : " ); ?>
        <select id="dragonvisit_user_canactivateinadminpage" name="dragonvisit_user_canactivateinadminpage" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>
        <p><?php _e("User can deactivate data in admin page : " ); ?>
        <select id="dragonvisit_user_candeactivateinadminpage" name="dragonvisit_user_candeactivateinadminpage" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <option value="1">YES</option>
           <option value="0">NO</option>           
        </select></p>

        <p><?php _e("Role : " ); ?>
        <select id="dragonvisit_user_roleid" name="dragonvisit_user_roleid" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activeroles as $role) { ?>
           <option value="<?php echo intval($role->id); ?>" style="<?php echo $role->status === '1' ? '' : 'color:grey;'; ?>"><?php echo esc_html($role->name) . " (" . intval($role->id) . ")"; ?></option>
           <?php } ?>        
        </select></p>
        
        <p><?php _e("Department : " ); ?>
        <select id="dragonvisit_user_departmentid" name="dragonvisit_user_departmentid" class="presetto_1" >
           <option value="-1">Please choose one...</option>
           <?php foreach ($activedepartments as $department) { ?>
           <option value="<?php echo intval($department->id); ?>" style="<?php echo $department->status === '1' ? '' : 'color:grey;'; ?>"><?php echo esc_html($department->name) . " (" . intval($department->id) . ")"; ?></option>
           <?php } ?>        
        </select></p>        

        <p>Search User Status: 
            <select id="dragonvisit_user_status" name="dragonvisit_user_status" class="presetto_1">
                <option value="-1">Please choose one...</option>
                <option value="1" >ACTIVE</option>
                <option value="0" >NOT ACTIVE</option>                    
            </select>    
        </p>        
        
        <p>
            <input type="button" id="dragonvisit_user_search" name="dragonvisit_user_search" class="" value="Search" onclick="dragonvisitzyx987_getUsersList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="dragonvisit_user_searchreset" name="dragonvisit_user_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetUsersSearchParameters();" style="background-color:grey;"/>
        </p>

        <p style="color:red;">This is not WordPress' wp_users table. This table name is wp_dragonvisitzyx987_users. All the users in this table can access the plugin's landing page. But only users with WordPress administrator role can access the dashboard settings page for this Office Visits Logbook plugin.</p>        
        
        <p>Items per Page: 
            <select id="dragonvisit_user_itemsperpage" name="dragonvisit_user_itemsperpage" onchange="dragonvisitzyx987_getUsersList();" class="presetto_1">
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_user_sortby" name="dragonvisit_user_sortby" onchange="dragonvisitzyx987_getUsersList();" class="presetto_1">
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>    
                <option value="userid|asc" >User ID low-high</option>
                <option value="userid|desc" >User ID high-low</option>    
                <option value="userfullname|asc" >User Full Name a-z</option>    
                <option value="userfullname|desc" >User Full Name z-a</option>                
            </select>    
        </p>        
    
        Total users: <span id="totaluserquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_userlist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_user" style="display: inline-block;"></div>
        </div>
        
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>First name</th>
                    <th>Last name</th>
                    <th>User ID</th>                
                    <th>can read in adminpage</th>
                    <th>can create in adminpage</th>
                    <th>can edit in adminpage</th>
                    <th>can activate in adminpage</th>
                    <th>can deactivate in adminpage</th>
                    <th>Report to user ID</th>
                    <th>Role</th>
                    <th>Department</th>                
                    <th>Status</th>                    
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>                    
                    <th>Address2</th>
                    <th>City</th>
                    <th>Province</th>
                    <th>Country</th>
                    <th>ZIP</th>
                    <th>Description</th>
                    <th>Created(UTC)</th>                
                </tr>
            </thead>
            <tbody id="dragonvisit_user">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_user" style="display: inline-block;"></div>
        </div>
        
    </div><hr/>
</div>
<div id="dragonvisit_tabs_4">    
    <?php echo "<h3>" . __( '7. Constant:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <div id="dragonvisit_constant_container">
		<p style="color:red;font-weight:bold;">For this plugin to get your company's current local date, you must set the timezone value correctly. You can edit the timezone at Dashboard -> Settings -> General -> Timezone -> check if the value has been set correctly.</p>	
        Total constants: <span id="totalconstantquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_constantlist_loader" alt="loading" style="display:none;" />
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Value</th>
                    <th>Created(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_constant">
            </tbody>
        </table>    
    </div><hr/>        

    <?php echo "<h3>" . __( '8. Log:', 'dragonvisit_trdom' ) . "</h3>"; ?>
    <div id="dragonvisit_log_container">        
        <p>Search Type: 
        <select id="dragonvisit_log_type" name="dragonvisit_log_type" class="presetto_1">
           <option value="-1">Please choose one...</option>
           <?php foreach ($log_types as $log_type) { ?>
           <option value="<?php echo esc_html($log_type->type); ?>" ><?php echo esc_html($log_type->type); ?></option>
           <?php } ?>
         </select></p>
        
        <p>Search Process Name: 
        <select id="dragonvisit_log_processname" name="dragonvisit_log_processname" class="presetto_1">
           <option value="-1">Please choose one...</option>
           <?php foreach ($log_processnames as $log_processname) { ?>
           <option value="<?php echo esc_html($log_processname->processname); ?>" ><?php echo esc_html($log_processname->processname); ?></option>
           <?php } ?>
         </select></p>

        <p>Search User ID: 
        <select id="dragonvisit_log_userid" name="dragonvisit_log_userid" class="presetto_1">
           <option value="-1">Please choose one...</option>
           <?php foreach ($log_userids as $log_userid) { ?>
           <option value="<?php echo ($log_userid === null || empty($log_userid->userid)) ? 0 : intval($log_userid->userid); ?>" ><?php echo ($log_userid === null || empty($log_userid->userid)) ? 0 : intval($log_userid->userid); ?></option>
           <?php } ?>
         </select></p>
        
        <p>Search Description: <input type="text" id="dragonvisit_log_description" name="dragonvisit_log_description" class="" value="" size="50" /></p>
        <p>Search Status: 
            <select id="dragonvisit_log_status" name="dragonvisit_log_status" class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="0" >NOT ACTIVE</option>
                   <option value="1" >ACTIVE</option>            
            </select>    
        </p>        
        <p>
        <input type="button" id="dragonvisit_log_search" name="dragonvisit_log_search" class="" value="Search" onclick="dragonvisitzyx987_getLogsList();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" id="dragonvisit_log_searchreset" name="dragonvisit_log_searchreset" class="" value="Reset" onclick="dragonvisitzyx987_resetLogsSearchParameters();" style="background-color:grey;"/>
        </p>        
        <p>Items per Page: 
            <select id="dragonvisit_log_itemsperpage" name="dragonvisit_log_itemsperpage" onchange="dragonvisitzyx987_getLogsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="10" >10</option>
                <option value="20" >20</option>    
                <option value="40" >40</option>    
                <option value="60" >60</option>    
                <option value="80" >80</option>    
                <option value="100" >100</option>                    
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            Sort By:
            <select id="dragonvisit_log_sortby" name="dragonvisit_log_sortby" onchange="dragonvisitzyx987_getLogsList();"  class="presetto_1" >
                <option value="-1">Please choose one...</option>
                <option value="id|asc" >ID low-high</option>
                <option value="id|desc" >ID high-low</option>
                <option value="type|asc" >Type a-z</option>
                <option value="type|desc" >Type z-a</option>
                <option value="createtimeutc|asc" >Created Date old-new</option>
                <option value="createtimeutc|desc" >Created Date new-old</option>                
            </select>    
        </p>    
        
        Total logs: <span id="totallogquantity"></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_loglist_loader" alt="loading" style="display:none;" />
        
        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_log" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Type</th>
                    <th>Process Name</th>
                    <th>User ID</th>
                    <th>Description</th>
                    <th>Created Date(UTC)</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_log">
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_admin_log" style="display: inline-block;"></div>
        </div>        
    </div><br/>
</div>
<div id="dragonvisit_tabs_6">
    <p>Attention: The old stored procedures will be dropped. Then the new stored procedures will be created.</p>
    <?php  if($userdetails[0]->cancreateinadminpage === '1') {  ?>
    <form name="dragonvisit_form_3_7_14" method="post" action="<?php echo str_replace( '%7E', '~', strip_tags(esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])))); ?>" enctype="multipart/form-data">
        <input type="hidden" name="dragonvisitzyx987_hidden" value="Y">
        <input type="hidden" name="dragonvisitzyx987_hidden_security" value="<?php echo wp_create_nonce("dragonvisitzyx987_dropAllStoredprocedures"); ?>">        
        <p class="submit">
            <input type="submit" name="Submit" class="delete-danger" onclick="return dragonvisitzyx987_confirmDropSP('all', false);" value="<?php _e('Recreate all the stored procedures', 'dragonvisit_trdom' ) ?>" />
        </p>
    </form>
    <?php } else { ?>
            <p style="color:red;">You are not authorized to drop tables. Please contact web admin.</p>
    <?php } ?>    
</div>
<div id="dragonvisit_tabs_7">
<h3>Here are the manual for this plugin:</h3><br/>
<a style="color:blue;" href="<?php echo plugins_url('documentation_officevisitslogbook.pdf', __FILE__ ); ?>" >Manual pdf</a><br/><br/>
</div>
</div>
</div>