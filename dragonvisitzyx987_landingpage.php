<?php
    //phpinfo();//ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL);
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $protocol = is_ssl() ? 'https://' : 'http://'; 
        $adminLoginURL = site_url() . '/wp-login.php';
        wp_safe_redirect( $adminLoginURL, 302 );
        exit();
    }
    global $wpdb;
    $isSecure = is_ssl() ? true : false;
    $REQUEST_PROTOCOL = $isSecure ? 'https' : 'http';
    if(!$isSecure) {
        ?>
        <div class="nohttps" style="color:#ff0000;background-color:#000000;"><p style="font-size:24px;"><strong>
        <?php
            esc_html_e("Bad news. Your website is not using HTTPS. So this office visits logbook plugin can NOT be used for your website.");
        ?>
        </strong></p></div>
        <?php
        exit;
    }

    if (function_exists( 'mysqli_connect' ) && $wpdb->use_mysqli) {
    } else if (function_exists( 'mysqli_connect' ) && !$wpdb->use_mysqli) {
        ?>
        <div class="nomysqli" style="color:#ff0000;background-color:#000000;"><p style="font-size:24px;"><strong>
        <?php
            esc_html_e("Bad news. Mysqli is NOT used in your WordPress. So this office visits logbook plugin can NOT be used for your website.");
        ?>
        </strong></p></div>
        <?php
        exit;
    } else if (!function_exists( 'mysqli_connect' ) && !$wpdb->use_mysqli) {
        ?>
        <div class="nomysqli" style="color:#ff0000;background-color:#000000;"><p style="font-size:24px;"><strong>
        <?php
            esc_html_e("Bad news. Mysqli does NOT exist in your WordPress. So this office visits logbook plugin can NOT be used for your website.");
        ?>
        </strong></p></div>
        <?php
        exit;
    }

    session_start();
    if(session_id() == '' || !isset($_SESSION)) {
        setcookie(session_name(), session_id(), 0, '/', '', true, true);
        $_COOKIE[session_name()] = session_id();
        $_SESSION = array();
    } else {
        setcookie(session_name(), session_id(), 0, '/', '', true, true);
        $_COOKIE[session_name()] = session_id();
    }

    $table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        ?>
        <div class="nouser" style="color:#ff0000;background-color:#000000;"><p style="font-size:24px;"><strong>
        <?php
            esc_html_e("Please log in to use this page.");
        ?>
        </strong></p></div>
        <?php
        exit;
    }
    $visit_user = $wpdb->get_results("SELECT * from $table_name WHERE status = 1 AND userid = " . intval($current_user->data->ID));
    if(count($visit_user) === 0) {
        ?>
        <div class="nouser" style="color:#ff0000;background-color:#000000;"><p style="font-size:24px;"><strong>
        <?php
            esc_html_e("Please ask admin to give you access to this page.");
        ?>
        </strong></p></div>
        <?php
        exit;
    }
    //error_log("at 79, userid: " . intval($current_user->data->ID). ", visit: " . json_encode($visit_user));

    $dragon_visit_submitform_Result = '';
    $visits = [];
    $settings_temp = [];
    $settings = [];
    $settings["USE_BOOTSTRAP_JS"] = '1';
    $settings["USE_BOOTSTRAP_CSS"] = '1';
    $total = 0;
    $amountperpage = dragonvisitzyx987_getConstantRowPerTable();
    $amountperpage = empty($amountperpage) ? 10 : intval($amountperpage);
    $pagenumber = 1;
    $offset = 0;
    $mysortby = 'id';
    $myorder = 'desc';
    $visittypes = null;
    $visitfromdate = '1000-01-01';
    $visittodate = '9999-12-31';
    $visitstatus = -1;
    $total = 0;
    $totalpagenumber = 1;
    $table_name_prefix = 'wp_dragonvisitzyx987';
    $title = "Visit";
    if($_SERVER['REQUEST_METHOD'] === 'POST') {
        if(!empty($_POST['dragonvisitzyx987_hidden_security_createvisit'])) {
            if(!wp_verify_nonce($_POST['dragonvisitzyx987_hidden_security_createvisit'], 'dragonvisitzyx987_createvisit')) {
                $dragon_visit_submitform_Result =  'Invalid data.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $current_user = wp_get_current_user();
            if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
                $dragon_visit_submitform_Result =  'Invalid user info.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $input = array_map(function($v){
                $temp = trim(strip_tags($v));
                return dragonvisitzyx987_stripAllBackSlashes(sanitize_text_field($temp));
            }, $_POST);
            if($input["visittypeid"] === '' || intval($input["visittypeid"]) <= 0 || $input["visitorname"] === '' || $input["visittimein"] === '' || dragonvisitzyx987_validateTime($input["visittimein"]) === false || ($input["visittimeout"] !== '' && dragonvisitzyx987_validateTime($input["visittimeout"]) === false)) {
                //error_log("at 138, input: " . json_encode($input));
                $dragon_visit_submitform_Result =  'Please fill in all the required fields.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $visittimein  = $input["visittimein"]  ? $input["visittimein"]  : '';
            $visittimeout = $input["visittimeout"] ? $input["visittimeout"] : '';
            if($visittimeout !== '' && $visittimeout < $visittimein) {
                $dragon_visit_submitform_Result =  'Time out should be later than time in.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            global $wpdb;
            require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
            $table_name = 'wp_dragonvisitzyx987_visit';
            $table_name2 = $table_name_prefix . '_users';
            $finalresult = '';
            if($wpdb->use_mysqli) {
                if($wpdb->dbh->connect_error) {
                    die("Connection failed: " . $wpdb->dbh->connect_error);
                }
                $finalresult = '';
                try{
                    $wpdb->dbh->begin_transaction();
                    $sqlColumnsArray = array();    
                    $sqlColumnsArray['visittypeid|i'] = $input["visittypeid"] ? $input["visittypeid"] : '';
                    $sqlColumnsArray['visitorname|s'] = $input["visitorname"] ? $input["visitorname"] : '';
                    $sqlColumnsArray['visitreason|s'] = $input["visitreason"] ? $input["visitreason"] : '';

                    $table_name_constant = 'wp_dragonvisitzyx987_constant';
                    //$timezone = $wpdb->get_var("SELECT value FROM $table_name_constant WHERE name = 'COMPANY_TIMEZONE'");
                    //if($timezone !== '') {
                    //    date_default_timezone_set($timezone);
                    //}
                    $timezone=get_option('timezone_string');
                    if(!empty($timezone)){date_default_timezone_set($timezone);}
                    $sqlColumnsArray['visitdate|s'] = date('Y-m-d');

                    $sqlColumnsArray['visittimein|s'] = $input["visittimein"] ? $input["visittimein"] : '';
                    $sqlColumnsArray['visittimeout|s'] = $input["visittimeout"] ? $input["visittimeout"] : '';

                    if(count($sqlColumnsArray) > 0) {
                        $query = "INSERT INTO " . $table_name . " (`userid`,`visittypeid`,`visitorname`,`visitreason`,`visitdate`,`timein`,`timeout`,`status`,`created`) VALUES (?,?,?,?,?,?,?,1,UTC_TIMESTAMP())";
                        $stmt = $wpdb->dbh->prepare($query);
                        $types = '';
                        $parameterArray = array('');

                        $types .= 'i';
                        $myuserid = intval($current_user->data->ID);
                        $parameterArray[] = &$myuserid;

                        $types .= 'i';
                        $myvisittypeid = intval($input["visittypeid"]);
                        $parameterArray[] = &$myvisittypeid;

                        $types .= 's';
                        $parameterArray[] = &$sqlColumnsArray['visitorname|s'];

                        $types .= 's';
                        $parameterArray[] = &$sqlColumnsArray['visitreason|s'];

                        $types .= 's';
                        $parameterArray[] = &$sqlColumnsArray['visitdate|s'];

                        $types .= 's';
                        $parameterArray[] = &$sqlColumnsArray['visittimein|s'];

                        $types .= 's';
                        $parameterArray[] = &$sqlColumnsArray['visittimeout|s'];

                        $parameterArray[0] = $types;
                        call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                        $stmt->execute();
                        $myresult = $visitid = $stmt->insert_id;
                        $haserror = false;
                        if($myresult <= 0 || $wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                            $haserror = true;
                        }
                        $stmt->close();
                        if($haserror) {
                            $finalresult .= 'Error adding a visit into table ' . $table_name . ". ";
                            throw new Exception($finalresult);
                        }
                        $dragon_visit_submitform_Result = "";
                    } else {
                        $finalresult .= 'Nothing is added. ';
                        $dragon_visit_submitform_Result = 'Nothing is added.';
                    }
                    $wpdb->dbh->commit();
                    if($finalresult !== '') {
                        dragonvisitzyx987_saveToLogTable($finalresult, "Create visit", 'error', intval($current_user->data->ID));
                    }

                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']) . '://';
                    $domain = esc_html($urlparts['host']);
                    $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                } catch(Exception $e) {
                    $wpdb->dbh->rollback();
                    $finalresult .= $dragon_visit_submitform_Result = 'Error adding a visit into table ' . $table_name . ". Exception Message: " .$e->getMessage();
                    dragonvisitzyx987_saveToLogTable($finalresult, "Create visit", 'error', intval($current_user->data->ID));
                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']) . '://';
                    $domain = esc_html($urlparts['host']);
                    $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                }
            } else {
                $dragon_visit_submitform_Result = 'This website can not use mysqli. Please contact website admin.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
        } elseif(!empty($_POST['dragonvisitzyx987_hidden_security_editvisit'])) {
            if(!wp_verify_nonce($_POST['dragonvisitzyx987_hidden_security_editvisit'], 'dragonvisitzyx987_editvisit')) {
                $dragon_visit_submitform_Result =  'Invalid data.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $current_user = wp_get_current_user();
            if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
                $dragon_visit_submitform_Result =  'Invalid user info.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }

            $visitid_post = sanitize_text_field(strip_tags($_POST['id']));
            $visitid_temp = empty($visitid_post) ? 0 : $visitid_post;
            $visitid = intval($visitid_temp);

            if($visitid <= 0) {
                $dragon_visit_submitform_Result =  "Invalid visit id.";
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }

            $input = array_map(function($v){
                $temp = trim(strip_tags($v));
                return dragonvisitzyx987_stripAllBackSlashes(sanitize_text_field($temp));
            }, $_POST);
            if($input["visittypeid"] === '' || intval($input["visittypeid"]) <= 0 || $input["visitorname"] === '' || $input["visittimein"] === '' || dragonvisitzyx987_validateTime($input["visittimein"]) === false 
               || $input["visitdate"] === '' || dragonvisitzyx987_validateDate($input["visitdate"], 'Y-m-d') === false
               || ($input["visittimeout"] !== '' && dragonvisitzyx987_validateTime($input["visittimeout"]) === false)) {
                //error_log("at 347, input: " . json_encode($input));
                $dragon_visit_submitform_Result =  'Please fill in all the required fields correctly.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $visittimein  = $input["visittimein"]  ? $input["visittimein"]  : '';
            $visittimeout = $input["visittimeout"] ? $input["visittimeout"] : '';
            if($visittimeout !== '' && $visittimeout < $visittimein) {
                $dragon_visit_submitform_Result =  'Time out should be later than time in.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            global $wpdb;
            require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
            $table_name = 'wp_dragonvisitzyx987_visit';
            $finalresult = '';
            if($wpdb->use_mysqli) {
                if($wpdb->dbh->connect_error) {
                    die("Connection failed: " . $wpdb->dbh->connect_error);
                }

                //query table, update it only when status = 1 and timeout = ''
                $visit = $wpdb->get_results("SELECT * from $table_name WHERE id = " . $visitid);
                if(count($visit) !== 1) {
                    $dragon_visit_submitform_Result =  "We found incorrect amount of record for this visit id (" . $visitid . "): " . count($visit);
                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']) . '://';
                    $domain = esc_html($urlparts['host']);
                    $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                } else {
                    if(intval($visit[0]->status) !== 1 || ($visit[0]->timeout !== '' && $visit[0]->timeout !== null)) {
                        $dragon_visit_submitform_Result =  "We update the visit record only when it is active and timeout is empty.";
                        setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                        /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                        $urlparts = wp_parse_url(home_url());
                        $protocol = esc_html($urlparts['scheme']) . '://';
                        $domain = esc_html($urlparts['host']);
                        $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?')*/
                        $urlparts = wp_parse_url(home_url());
                        $protocol = esc_html($urlparts['scheme']);
                        $domain = esc_html($urlparts['host']);
                        $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                        $myurl = str_replace("&amp;", "&", $myurl);
                        $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                        if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                        wp_safe_redirect($myurl, 302);
                        exit();
                    }
                }

                $sqlColumnsArray = array();
                $sqlColumnsArray['visittypeid|i']  = $visittypeid  = $input["visittypeid"]  ? $input["visittypeid"]  : '';
                $sqlColumnsArray['visitorname|s']  = $visitorname  = $input["visitorname"]  ? $input["visitorname"]  : '';
                $sqlColumnsArray['visitreason|s']  = $visitreason  = $input["visitreason"]  ? $input["visitreason"]  : '';
                $sqlColumnsArray['visitdate|s']    = $visitdate    = $input["visitdate"]    ? $input["visitdate"]    : '';
                $sqlColumnsArray['timein|s']  = $visittimein  = $input["visittimein"]  ? $input["visittimein"]  : '';
                $sqlColumnsArray['timeout|s'] = $visittimeout = $input["visittimeout"] ? $input["visittimeout"] : '';

                if(count($sqlColumnsArray) > 0) {
                    $query = "UPDATE $table_name SET ";
                    $types = '';
                    $parameterArray = array('');
                    foreach($sqlColumnsArray as $key => $value) {
                        $temp = explode('|', $key, 2);
                        if($temp[0] === 'visitreason' && $sqlColumnsArray['visitreason|s'] === '') {
                            $query .= ' ' . $temp[0] . ' = null, ';
                        }elseif($temp[0] === 'timeout' && $sqlColumnsArray['timeout|s'] === '') {
                            $query .= ' ' . $temp[0] . ' = null, ';
                        }else{
                            $types .= $temp[1];
                            $query .= ' ' . $temp[0] . ' = ?, ';
                        }

                        if($temp[0] === 'visitreason') {
                            if($sqlColumnsArray['visitreason|s'] !== '') {
                                $parameterArray[] = &$visitreason;
                            }
                        }elseif($temp[0] === 'timeout') {
                            if($sqlColumnsArray['timeout|s'] !== '') {
                                $parameterArray[] = &$visittimeout;
                            }
                        }elseif($temp[0] === 'visittypeid') {
                            $parameterArray[] = &$visittypeid;
                        }elseif($temp[0] === 'visitorname') {
                            $parameterArray[] = &$visitorname;
                        }elseif($temp[0] === 'visitdate') {
                            $parameterArray[] = &$visitdate;
                        }elseif($temp[0] === 'timein') {
                            $parameterArray[] = &$visittimein;
                        }
                    }
                    $query .= " lastupdated = UTC_TIMESTAMP() WHERE id = ? ";

                    $types .= 'i';
                    $parameterArray[] = &$visitid;
                    $parameterArray[0] = $types;
                    $stmt = $wpdb->dbh->prepare($query);
                    call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                    $stmt->execute();
                    if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                        $dragon_visit_submitform_Result = 'Edit visit failed.';
                        setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                        /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                        $urlparts = wp_parse_url(home_url());
                        $protocol = esc_html($urlparts['scheme']) . '://';
                        $domain = esc_html($urlparts['host']);
                        $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                        $urlparts = wp_parse_url(home_url());
                        $protocol = esc_html($urlparts['scheme']);
                        $domain = esc_html($urlparts['host']);
                        $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                        $myurl = str_replace("&amp;", "&", $myurl);
                        $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                        if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                        wp_safe_redirect($myurl, 302);
                        exit();
                    }
                    $stmt->close();
                    $dragon_visit_submitform_Result = "";
                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']) . '://';
                    $domain = esc_html($urlparts['host']);
                    $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                } else {
                    $dragon_visit_submitform_Result = 'Nothing is updated.';
                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']) . '://';
                    $domain = esc_html($urlparts['host']);
                    $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                }
            } else {
                $dragon_visit_submitform_Result = 'This website can not use mysqli. Please contact website admin.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
        } elseif ((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
            if((!empty($_POST['dragonvisitzyx987_setcookiebysubmitform'])) && $_POST['dragonvisitzyx987_setcookiebysubmitform'] === 'setcookiebysubmitform') {
                $dragon_visit_submitform_Result = dragonvisitzyx987_setCookie_not_by_ajax();
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                /*$protocol = is_ssl() ? 'https://' : 'http://'; 
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']) . '://';
                $domain = esc_html($urlparts['host']);
                $myurl = strtok($protocol . $domain . esc_html($_SERVER['REQUEST_URI']), '?');*/
                $urlparts = wp_parse_url(home_url());
                $protocol = esc_html($urlparts['scheme']);
                $domain = esc_html($urlparts['host']);
                $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                $myurl = str_replace("&amp;", "&", $myurl);
                $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
        }
    } elseif ($_SERVER['REQUEST_METHOD'] === 'GET') {
        if($_GET['action'] === 'create') {
            add_filter('pre_get_document_title', function() {
                return 'Create Visit';
            }, 10, 1);
            apply_filters('pre_get_document_title', 'Create Visit - Visit');
            $table_name3 = $table_name_prefix . '_type';
            $table_name4 = $table_name_prefix . '_typecategory';
            $typecategories = $wpdb->get_results("SELECT * from $table_name4 WHERE status = 1 order by name");
            $sql = "SELECT min(t.typecategoryid) as mykey, min(c.name) as typecategoryname, group_concat(concat(t.id,'_',t.name) SEPARATOR '|') as list ";
            $sql .= " FROM $table_name3 t  ";
            $sql .= " LEFT JOIN $table_name4 c  ";
            $sql .= " on t.typecategoryid = c.id  ";
            $sql .= " WHERE t.status = 1 AND c.status = 1";
            $sql .= " GROUP BY t.typecategoryid ORDER BY mykey  ";
            $visittypes = $wpdb->get_results($sql);
            require_once('dragonvisitzyx987_masterpage.php');
            require_once('dragonvisitzyx987_createvisit.php');
            require_once('dragonvisitzyx987_masterpage2.php');
            exit();
        }elseif($_GET['action'] === 'edit') {
            add_filter('pre_get_document_title', function() {
                return 'Edit Visit';
            }, 10, 1);
            apply_filters('pre_get_document_title', 'Edit Visit - Visit');
            $table_name = $table_name_prefix . '_visit';
            $id_temp = sanitize_text_field(strip_tags($_GET['id']));
            $id = intval($id_temp);
            if($id <= 0) {exit();}
            //query table, update it only when status = 1 and timeout = ''
            $visit = $wpdb->get_results("SELECT * from $table_name WHERE id = " . $id);
            if(count($visit) !== 1) {
                $dragon_visit_submitform_Result =  "We found incorrect amount of record for this visit id (" . $id . "): " . count($visit);
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                $myurl = esc_html(add_query_arg($wp->query_vars, home_url()));
                $myurl = str_replace("&amp;", "&", $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            } else {
                if(intval($visit[0]->status) !== 1 || ($visit[0]->timeout !== '' && $visit[0]->timeout !== null)) {
                    $dragon_visit_submitform_Result =  "We update the visit record only when it is active and timeout is empty.";
                    setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                    $myurl = esc_html(add_query_arg($wp->query_vars, home_url()));
                    $myurl = str_replace("&amp;", "&", $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    wp_safe_redirect($myurl, 302);
                    exit();
                }
            }
            $visit_temp = $wpdb->get_results("SELECT * from $table_name WHERE userid = " . intval($current_user->data->ID) . " AND id = " . $id . " LIMIT 1");
            $visit = null;
            if(count($visit_temp) > 0) {
                $visit = $visit_temp[0];
            } else {
                $dragon_visit_submitform_Result = 'You can not edit this visit.';
                setcookie('dragon_visit_submitform_Result', $dragon_visit_submitform_Result, 0, '/', '', true, true);
                $myurl = esc_html(add_query_arg($wp->query_vars, home_url()));
                $myurl = str_replace("&amp;", "&", $myurl);
                if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                wp_safe_redirect($myurl, 302);
                exit();
            }
            $visit2_temp = $wpdb->get_results("SELECT * from $table_name WHERE id = " . $id);
            $visit2 = null;
            if(count($visit2_temp) > 0) {
                $visit2 = $visit2_temp[0];
            }
            //error_log("at 606, id: " . $id. ", visit: " . json_encode($visit2));
            if($visit2 && $visit && ($visit->userid == intval($current_user->data->ID)) ) {
                $droparea_extra = '';
                $table_name3 = $table_name_prefix . '_type';
                $table_name4 = $table_name_prefix . '_typecategory';
                $typecategories = $wpdb->get_results("SELECT * from $table_name4 WHERE status = 1 order by name");
                $fordate = "";
                $sql2 = "SELECT min(t.typecategoryid) as mykey, min(c.name) as typecategoryname, group_concat(concat(t.id,'_',t.name) SEPARATOR '|') as list ";
                $sql2 .= " FROM $table_name3 t  ";
                $sql2 .= " LEFT JOIN $table_name4 c  ";
                $sql2 .= " on t.typecategoryid = c.id  ";
                $sql2 .= " WHERE t.status = 1 AND c.status = 1";
                $sql2 .= " GROUP BY t.typecategoryid ORDER BY mykey  ";
                $visittypes = $wpdb->get_results($sql2);
                //error_log("at 620, visit: " . json_encode($visit2) . ", header_extra: " . json_encode($header_extra) . ", droparea_extra: " . json_encode($droparea_extra) . ", visit_timerange: " . json_encode($visit_timerange) . ", types: " . json_encode($types) . ", typecategories: " . json_encode($typecategories));
                $visit = $visit2;
                require_once('dragonvisitzyx987_masterpage.php');
                require_once('dragonvisitzyx987_editvisit.php');
                require_once('dragonvisitzyx987_masterpage2.php');
                exit();
            }
        } else {
            $table_name3 = $table_name_prefix . '_type';
            $table_name4 = $table_name_prefix . '_typecategory';
            $typecategories = $wpdb->get_results("SELECT * from $table_name4 WHERE status = 1 order by name");
            $sql = "SELECT min(t.typecategoryid) as mykey, min(c.name) as typecategoryname, group_concat(concat(t.id,'_',t.name) SEPARATOR '|') as list ";
            $sql .= " FROM $table_name3 t  ";
            $sql .= " LEFT JOIN $table_name4 c  ";
            $sql .= " on t.typecategoryid = c.id  ";
            $sql .= " WHERE t.status = 1 AND c.status = 1";
            $sql .= " GROUP BY t.typecategoryid ORDER BY mykey  ";
            $visittypes = $wpdb->get_results($sql);
        }

        if(isset($_COOKIE['dragon_visit_submitform_Result']) && $_COOKIE['dragon_visit_submitform_Result'] !== null && $_COOKIE['dragon_visit_submitform_Result'] !== 'success') {
            $dragon_visit_submitform_Result = sanitize_text_field($_COOKIE['dragon_visit_submitform_Result']);
            setcookie('dragon_visit_submitform_Result', '', time() - 42000, '/', '', true, true);
            unset($_COOKIE['dragon_visit_submitform_Result']);
        }

        if($_GET['action'] === 'activateaccount') {
            if(empty($_GET['id']) || empty($_GET['token'])) {
                echo 'We need your id and token to activate your account.';
                exit();
            }
            $result = dragonvisitzyx987_activateAccount();
            if($result === 'success') {
                echo 'Congratulations! Your account is successfully activated.';
            } else {
                echo esc_html($result);
            }
            exit();
        }

        //a - amount per page; o - order (asc, desc); pg - page number; st - sortby; n - search visitor name; r - search visit reason; status - visit status
        //f - from date; t - to date;
        $amountperpage_get = sanitize_text_field(strip_tags($_GET['a']));
        $amountperpage_temp = trim($amountperpage_get) === '' ? '10' : $amountperpage_get;
        $amountperpage_temp = preg_replace('/[^0-9]/', '', $amountperpage_temp);
        if(intval($amountperpage_temp) === 20 || intval($amountperpage_temp) === 40 || intval($amountperpage_temp) === 60 || intval($amountperpage_temp) === 80 || intval($amountperpage_temp) === 100) {
            $amountperpage = intval($amountperpage_temp);
        }
        $pagenumber_get = sanitize_text_field(strip_tags($_GET['pg']));
        $pagenumber_temp = trim($pagenumber_get) === '' ? '' : $pagenumber_get;
        $pagenumber_temp = preg_replace('/[^0-9]/', '', $pagenumber_temp);
        $pagenumber = trim($pagenumber_temp) === '' ? 1 : intval($pagenumber_temp);

        $offset = ($pagenumber - 1) * $amountperpage;
        $mysortby_get = sanitize_text_field(strip_tags($_GET['st']));
        $mysortby_temp = trim($mysortby_get) === '' ? '' : $mysortby_get;
        if(trim($mysortby_temp) === ''){
            $mysortby = 'id';
        } elseif(trim($mysortby_temp) === 'id') {
            $mysortby = 'id';
        } elseif(trim($mysortby_temp) === 'date') {
            $mysortby = 'visitdate';
        } else {
            $mysortby = 'id';
        }
        $myorder_get = sanitize_text_field(strip_tags($_GET['o']));
        $myorder_temp = trim($myorder_get) === '' ? '' : $myorder_get;
        $myorder = trim($myorder_temp) === '' ? 'desc' : (strtolower($myorder_temp) === "desc" ? "desc" : "asc");

        $searchname_temp = trim(sanitize_text_field(strip_tags($_GET['n']))) === '' ? '' : sanitize_text_field(strip_tags($_GET['n']));
        $searchname_temp = sanitize_text_field($searchname_temp);
        $searchname_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchname_temp);
        $searchname = trim($searchname_temp) === '' ? '' : $searchname_temp;

        $searchvisitreason_temp = trim(sanitize_text_field(strip_tags($_GET['r']))) === '' ? '' : sanitize_text_field(strip_tags($_GET['r']));
        $searchvisitreason_temp = sanitize_text_field($searchvisitreason_temp);
        $searchvisitreason_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchvisitreason_temp);
        $searchvisitreason = trim($searchvisitreason_temp) === '' ? '' : $searchvisitreason_temp;

        $visitfromdate_temp = trim(sanitize_text_field(strip_tags($_GET['f']))) === '' ? '' : sanitize_text_field(strip_tags($_GET['f']));
        $visitfromdate = trim($visitfromdate_temp) === '' ? $visitfromdate : urldecode($visitfromdate_temp);

        $visittodate_temp = trim(sanitize_text_field(strip_tags($_GET['t']))) === '' ? '' : sanitize_text_field(strip_tags($_GET['t']));
        $visittodate = trim($visittodate_temp) === '' ? $visittodate : urldecode($visittodate_temp);    

        $visittypeid_temp = trim($_GET['tid']) === '' ? '' : strip_tags($_GET['tid']);
        $visittypeid_temp = sanitize_text_field($visittypeid_temp);
        $visittypeid = trim($visittypeid_temp) === '' ? -1 : intval($visittypeid_temp);

        $visitstatus_temp = trim($_GET['status']) === '' ? '' : strip_tags($_GET['status']);
        $visitstatus_temp = sanitize_text_field($visitstatus_temp);
        $visitstatus = trim($visitstatus_temp) === '' ? $visitstatus : intval($visitstatus_temp);
        //error_log("at 712, $amountperpage: " . $amountperpage . ", pagenumber: " . $pagenumber . ", offset: " . $offset . ", mysortby: " . $mysortby . ", myorder: " . $myorder . ", visittypeid: " . $visittypeid . ", searchname: " . $searchname . ", searchvisitreason: " . $searchvisitreason . ", visitfromdate: " . $visitfromdate . ", visittodate: " . $visittodate . ", visitstatus: " . $visitstatus);
        $myresult = dragonvisitzyx987_getVisits_not_by_ajax($amountperpage, $pagenumber, $offset, $mysortby, $myorder, $visittypeid, $searchname, $searchvisitreason, $visitfromdate, $visittodate, $visitstatus);

        if(count($myresult) > 0) {
            $visits = $myresult["visit"];
            $settings_temp = $myresult["settings"];
            $total = $myresult["total"];
            if($pagenumber > ceil(intval($total) / intval($amountperpage))) {$pagenumber = ceil(intval($total) / intval($amountperpage));}

            for($i=0; $i<count($settings_temp); $i++) {
                if($settings_temp[$i]["name"] === 'AMOUNT_PER_PAGE') {
                    $settings["AMOUNT_PER_PAGE"] = $settings_temp[$i]["value"];
                }elseif($settings_temp[$i]["name"] === 'COMPANY_NAME') {
                    $settings["COMPANY_NAME"] = $settings_temp[$i]["value"];
                }elseif($settings_temp[$i]["name"] === 'COMPANY_ADDRESS') {
                    $settings["COMPANY_ADDRESS"] = $settings_temp[$i]["value"];
                }elseif($settings_temp[$i]["name"] === 'USE_BOOTSTRAP_JS') {
                    $settings["USE_BOOTSTRAP_JS"] = $settings_temp[$i]["value"];
                }elseif($settings_temp[$i]["name"] === 'USE_BOOTSTRAP_CSS') {
                    $settings["USE_BOOTSTRAP_CSS"] = $settings_temp[$i]["value"];
                }
            }
        }
    }

    $allusers = dragonvisitzyx987_getAllUsers();
    $activeusers = dragonvisitzyx987_getAllUsers(true);

    wp_enqueue_script('jquery');
    wp_enqueue_script('jquery-ui-dialog'); 
    wp_enqueue_style('wp-jquery-ui-dialog');
    if($settings["USE_BOOTSTRAP_JS"] === '1') {
        wp_enqueue_script('custom-script-bootstrap', plugins_url('bootstrap/js/bootstrap.min.js', __FILE__ ));
    }
    wp_enqueue_script('jquery-ui-core2', includes_url() . 'js/jquery/ui/core.min.js');
    wp_enqueue_script('jquery-ui-widget2', includes_url() . 'js/jquery/ui/widget.min.js');
    wp_enqueue_script('jquery-ui-mouse2', includes_url() . 'js/jquery/ui/mouse.min.js');
    wp_enqueue_script('jquery-ui-slider2', includes_url() . 'js/jquery/ui/slider.min.js');
    wp_enqueue_script('jquery-ui-datepicker2', includes_url() . 'js/jquery/ui/datepicker.min.js');
    wp_enqueue_script('jquery-ui-datetimepicker2', plugins_url('js/jquery.datetimepicker.full.min.js', __FILE__ ));

    function high_priority_style($mysettings) {
        if($mysettings["USE_BOOTSTRAP_CSS"] === '1') {
            wp_enqueue_style('bootstrap', plugins_url('bootstrap/css/bootstrap.min.css', __FILE__ ));
            wp_enqueue_style('bootstrap-icons', plugins_url('bootstrap/css/bootstrap-icons.css', __FILE__ ));
        }
        wp_enqueue_style('jquery-ui2', plugins_url('css/jquery-ui.css', __FILE__ ));
        wp_enqueue_style('jquery-datetimepicker2', plugins_url('css/jquery.datetimepicker.min.css', __FILE__ ));
        wp_enqueue_style('dragonvisit', plugins_url('css/dragonvisit.css?v=' . date('Ymd'), __FILE__ ));
    }
    add_action('wp_enqueue_scripts', function() use ($settings) {high_priority_style( $settings );}, 999);

    function dragonvisitzyx987_getproducts2() {
        if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
            $productid = 41;
            if($productid > 0) {
                global $wpdb;
                $charset_collate = $wpdb->get_charset_collate();
                require_once( ABSPATH . 'wp-admin/includes/upgrade.php' );
                $table_name = 'wp_dragonvisitzyx987_product';
                $table_name2 = 'wp_dragonvisitzyx987_department';
                $table_name3 = 'wp_dragonvisitzyx987_product_group';
                $table_name4 = 'wp_dragonvisitzyx987_product_country_province_city';
                $table_name5 = 'wp_dragonvisitzyx987_currency';
                $result = $wpdb->get_results("SELECT a.id,min(a.departmentId) departmentId,min(a.name) name,min(a.currencyId) currencyId,min(e.name) currency,min(e.sign) currencysign,min(a.description) description,min(a.imagefilenames) imagefilenames,min(a.weightlb) weightlb,min(a.price) price,min(a.barcode) barcode,min(a.createtimeutc) createtimeutc,min(a.shipfromnearestbranch) shipfromnearestbranch,min(b.name) as 'departmentname',group_concat(c.groupId) as 'groups',group_concat(concat(d.countryId, '|', d.provinceId, '|', d.cityId,'|',d.shippingpolicyId,'|',d.productquantity)) as locations from $table_name a LEFT JOIN $table_name2 b on a.departmentId = b.id left join $table_name3 c on a.id = c.productId left join $table_name4 d on a.id = d.productId left join $table_name5 e on a.currencyId = e.id WHERE a.id = " . $productid . " group by a.id");
                return json_encode($result);
            }
        }
        return '';
    }
    get_header(); 
    ?>
<script>
var mytemp = "<?php echo esc_html(dragonvisitzyx987_getConstants('LANGUAGE')); ?>", mylang = "en", mytrans = {};
if(mytemp === "bp") {
    mylang = "pt";
} else if(mytemp === "zhs" || mytemp === "zht") {
    mylang = "ch";
} else if(mytemp === "") {
    mylang = "en";
    mytemp = "en";
}
var master_totalpagenumber;

if(mytemp === "en") {
    mytrans.Myweek = {"Mon":"Mon","Tue":"Tue","Wed":"Wed","Thu":"Thu","Fri":"Fri","Sat":"Sat","Sun":"Sun"};
    mytrans.Week = "Week";
    mytrans.Submit = "Submit";
    mytrans.Cancel = "Cancel";
    mytrans.Submitting = "Submitting";
    mytrans.From = "From";
    mytrans.To = "To";
    mytrans.from = "from";
    mytrans.to = "to";
    mytrans.Up = "Up";
    mytrans.Down = "Down";
    mytrans.Remove = "Remove";
    mytrans.VisitsavedPostedtoallwebhooks = "Visit saved. Posted to all webhooks.";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "Visit saved. Posted to some of the webhooks.";
    mytrans.VisitsavedNowebhooksavailable = "Visit saved. No webhooks available.";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "You already saved some time period data into database. Duplicated. Please create again.";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "Not all the data can be saved into database. Please create again.";
    mytrans.Thisrecordisnotyours = "This record is not yours.";
    mytrans.ErrorPleasecreateagain = "Error. Please create again.";
    mytrans.ErrorPleasetryagain = "Error. Please try again.";
    mytrans.Requestfailed = "Request failed";
    mytrans.Pleaserefreshthepageandtryagain = "Please refresh the page and try again.";
    mytrans.Pleaseenterdatetimeinfo = "Please enter date time info.";
    mytrans.PleaseenterMondaySundayorSaturday = "Please enter Monday, Sunday or Saturday.";
    mytrans.Timeisnotcontinuousatdate = "Time is not continuous at date";
    mytrans.StartTimeEmpty = "Start time is empty";
    mytrans.EndTimeEmpty = "End time is empty";
    mytrans.EndTimeEarlierThanStartTime = "End time is earlier than start time.";
    mytrans.StartTimeWrongDateFormat = "Start time has a wrong date format.";
    mytrans.EndTimeWrongDateFormat = "End time has a wrong date format.";    
    mytrans.Pleasefillallthedatefirst = "Please fill all the date first!";
    mytrans.Areyousureyouwanttodeletethis = "Are you sure you want to delete this ";
    mytrans.DeleteTarget = {"visit":"visit","typecategory":"type category","type":"type","user":"user","role":"role","division":"division"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "Are you sure you want to impersonate as this user?";
    mytrans.Chooseoneuser = "Choose one user";
    mytrans.Chooseonetype = "Choose one type";
    mytrans.Onlyshowoneusersworkhourschart = "Only show one user's work/hours chart";
    mytrans.Onlyshowonetypesuserhourschart = "Only show one type's user/hours chart";
    mytrans.showchart = "show chart";
    mytrans.removeallchart = "remove all chart";
    mytrans.Fromdate = "From date";
    mytrans.Todate = "To date";
    mytrans.nodata = "no data";
    mytrans.Hours = "Hours";
    mytrans.UserName = "User Name";
    mytrans.Name = "Name";
    mytrans.Desc = "Desc";
    mytrans.Approved = "Approved";
    mytrans.Approvedby = "Approved by";
    mytrans.ApprovedTime = "Approved Time";
    mytrans.ReviewNotes = "Review Notes";
    mytrans.Status = "Status";
    mytrans.Created = "Created";
    mytrans.ID = "ID";
    mytrans.Review = "Review";
    mytrans.Youdidnotchangeanything = "You did not change anything.";
    mytrans.Youdidnotenteranything = "You did not enter anything.";
    mytrans.Youmustchooseatarget = "You must choose a target.";
    mytrans.duplicate = "duplicate";
    mytrans.Pleasedraganddroptypesfromtherightside = "Please drag and drop types from the right side.";
    mytrans.Pleasedraganddropusersfromtherightside = "Please drag and drop users from the right side.";
    mytrans.Pleaseentertypecategoryandorname = "Please enter type category and/or name.";
} else if(mytemp === "bp") {
    mytrans.Myweek = {"Mon":"Seg","Tue":"Ter","Wed":"Qua","Thu":"Qui","Fri":"Sex","Sat":"Sab","Sun":"Dom"};
    mytrans.Week = "Semana";
    mytrans.Submit = "Enviar";
    mytrans.Cancel = "Cancelar";
    mytrans.Submitting = "Enviando";
    mytrans.From = "de";
    mytrans.To = "para";
    mytrans.from = "de";
    mytrans.to = "para";
    mytrans.Up = "Acima";
    mytrans.Down = "Baixa";
    mytrans.Remove = "Retirar";
    mytrans.VisitsavedPostedtoallwebhooks = "Quadro de horários salvo. Publicado em todos os webhooks.";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "Quadro de horários salvo. Publicado em alguns dos webhooks.";
    mytrans.VisitsavedNowebhooksavailable = "Quadro de horários salvo. Não há webhooks disponíveis.";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "Você já salvou alguns dados do período no banco de dados. Duplicado. Por favor, crie novamente.";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "Nem todos os dados podem ser salvos no banco de dados. Por favor, crie novamente.";
    mytrans.Thisrecordisnotyours = "Este registro não é seu.";
    mytrans.ErrorPleasecreateagain = "Erro. Por favor, crie novamente.";
    mytrans.ErrorPleasetryagain = "Erro. Por favor, tente novamente.";
    mytrans.Requestfailed = "Falha no pedido";
    mytrans.Pleaserefreshthepageandtryagain = "Atualize a página e tente novamente.";
    mytrans.Pleaseenterdatetimeinfo = "Digite as informações de data e hora.";
    mytrans.PleaseenterMondaySundayorSaturday = "Por favor, insira segunda, domingo ou sábado.";
    mytrans.Timeisnotcontinuousatdate = "O tempo não é contínuo na data";
    mytrans.StartTimeEmpty = "A hora de início está vazia";
    mytrans.EndTimeEmpty = "O horário de término está vazio";
    mytrans.EndTimeEarlierThanStartTime = "O horário de término é anterior ao horário de início.";
    mytrans.StartTimeWrongDateFormat = "A hora de início tem um formato de data errado.";
    mytrans.EndTimeWrongDateFormat = "A hora de término tem um formato de data errado.";    
    mytrans.Pleasefillallthedatefirst = "Por favor preencha toda a data primeiro!";
    mytrans.Areyousureyouwanttodeletethis = "Tem certeza de que deseja excluir esta ";
    mytrans.DeleteTarget = {"visit":"planilha de horário","typecategory":"categorias","type":"tipo","user":"usuário","role":"função","division":"divisão"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "Tem certeza de que deseja se passar por esse usuário?";
    mytrans.Chooseoneuser = "Escolha um usuário";
    mytrans.Chooseonetype = "Olha um tipo";
    mytrans.Onlyshowoneusersworkhourschart = "Mostrar apenas o gráfico de horas/trabalho de um usuário";
    mytrans.Onlyshowonetypesuserhourschart = "Mostrar apenas o gráfico de horas/usuário de um tipo";
    mytrans.showchart = "mostrar gráfico";
    mytrans.removeallchart = "remover todo o gráfico";
    mytrans.Fromdate = "Do dia";
    mytrans.Todate = "Até dia";
    mytrans.nodata = "sem dados";
    mytrans.Hours = "Horas";        
    mytrans.UserName = "Nome de Usuário";
    mytrans.Name = "Nome";
    mytrans.Desc = "Descrição";
    mytrans.Approved = "Aprovado";
    mytrans.Approvedby = "Aprovado por";
    mytrans.ApprovedTime = "Data Aprovação";
    mytrans.ReviewNotes = "Notas de Revisão";
    mytrans.Status = "Status";
    mytrans.Created = "Criado";
    mytrans.ID = "ID";
    mytrans.Review = "Revisão";
    mytrans.Youdidnotchangeanything = "Você não mudou nada.";
    mytrans.Youdidnotenteranything = "Você não inseriu nada.";
    mytrans.Youmustchooseatarget = "Você deve escolher um alvo.";
    mytrans.duplicate = "duplicada";
    mytrans.Pleasedraganddroptypesfromtherightside = "Arraste e solte tipos do lado direito.";
    mytrans.Pleasedraganddropusersfromtherightside = "Arraste e solte os usuários do lado direito.";
    mytrans.Pleaseentertypecategoryandorname = "Digite a categoria e / ou nome do tipo.";
} else if(mytemp === "zhs") {
    mytrans.Myweek = {"Mon":"周一","Tue":"周二","Wed":"周三","Thu":"周四","Fri":"周五","Sat":"周六","Sun":"周日"};
    mytrans.Week = "周";
    mytrans.Submit = "提交";
    mytrans.Cancel = "取消";
    mytrans.Submitting = "正在提交";
    mytrans.From = "从";
    mytrans.To = "到";
    mytrans.from = "从";
    mytrans.to = "到";
    mytrans.Up = "上移";
    mytrans.Down = "下移";
    mytrans.Remove = "删除";
    mytrans.VisitsavedPostedtoallwebhooks = "时间表保存。自动发送了数据到所有的另外的网站。";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "时间表已保存。自动发送了数据到部分的另外的网站。";
    mytrans.VisitsavedNowebhooksavailable = "时间表已保存。没有另外的网站用来发送数据。";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "你以前已经存了某些时间段的数据。数据重复。请重新创建。";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "不是所有数据能存入数据库。请重新创建。";
    mytrans.Thisrecordisnotyours = "这记录不是您的。";
    mytrans.ErrorPleasecreateagain = "错误。请重新创建。";
    mytrans.ErrorPleasetryagain = "错误。请重试。";
    mytrans.Requestfailed = "请求失败";
    mytrans.Pleaserefreshthepageandtryagain = "请刷新网页重试。";
    mytrans.Pleaseenterdatetimeinfo = "请输入日期时间信息。";
    mytrans.PleaseenterMondaySundayorSaturday = "请输入周一，周日，或者周六。";
    mytrans.Timeisnotcontinuousatdate = "在这个日期时间不连续";
    mytrans.StartTimeEmpty = "起始时间为空";
    mytrans.EndTimeEmpty = "终止时间为空";
    mytrans.EndTimeEarlierThanStartTime = "终止时间比起始时间早。";
    mytrans.StartTimeWrongDateFormat = "错误的起始时间。";
    mytrans.EndTimeWrongDateFormat = "错误的终止时间。";    
    mytrans.Pleasefillallthedatefirst = "请先填写所有日期!";
    mytrans.Areyousureyouwanttodeletethis = "你确定你想删除这个";
    mytrans.DeleteTarget = {"visit":"时间表","typecategory":"类别","type":"具体类型","user":"用户","role":"角色","division":"部门"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "你确定你想用这个用户登录？";
    mytrans.Chooseoneuser = "选一个用户";
    mytrans.Chooseonetype = "选择一个具体类型";
    mytrans.Onlyshowoneusersworkhourschart = "只显示一个用户的图表";
    mytrans.Onlyshowonetypesuserhourschart = "只显示一个具体类型的图表";
    mytrans.showchart = "显示图表";
    mytrans.removeallchart = "删除所有图表";
    mytrans.Fromdate = "起始日期";
    mytrans.Todate = "终止日期";
    mytrans.nodata = "没有数据";
    mytrans.Hours = "小时";
    mytrans.UserName = "用户名";
    mytrans.Name = "名字";
    mytrans.Desc = "描述";
    mytrans.Approved = "通过";
    mytrans.Approvedby = "审阅人";
    mytrans.ApprovedTime = "审阅时间";
    mytrans.ReviewNotes = "审阅意见";
    mytrans.Status = "状态";
    mytrans.Created = "建立";
    mytrans.ID = "ID";
    mytrans.Review = "审阅";
    mytrans.Youdidnotchangeanything = "您什么都没改。";
    mytrans.Youdidnotenteranything = "您什么都没输入。";
    mytrans.Youmustchooseatarget = "您必须选择一个。";
    mytrans.duplicate = "重复";
    mytrans.Pleasedraganddroptypesfromtherightside = "请从右侧拖放具体类型到左侧。";
    mytrans.Pleasedraganddropusersfromtherightside = "请从右侧拖放用户到左侧。";
    mytrans.Pleaseentertypecategoryandorname = "请输入类别和/或名称。";
} else if(mytemp === "zht") {
    mytrans.Myweek = {"Mon":"週一","Tue":"週二","Wed":"週三","Thu":"週四","Fri":"週五","Sat":"週六","Sun":"週日"};
    mytrans.Week = "週";
    mytrans.Submit = "提交";
    mytrans.Cancel = "取消";
    mytrans.Submitting = "正在提交";
    mytrans.From = "從";
    mytrans.To = "到";
    mytrans.from = "從";
    mytrans.to = "到";
    mytrans.Up = "上移";
    mytrans.Down = "下移";
    mytrans.Remove = "刪除";
    mytrans.VisitsavedPostedtoallwebhooks = "時間表保存。自動發送了數據到所有的另外的網站。";
    mytrans.VisitsavedPostedtosomeofthewebhooks = "時間表已保存。自動發送了數據到部分的另外的網站。";
    mytrans.VisitsavedNowebhooksavailable = "時間表已保存。沒有另外的網站用來發送數據。";
    mytrans.YoualreadysavedsometimeperioddataintodatabaseDuplicatedPleasecreateagain = "你以前已經存了某些時間段的數據。數據重複。請重新創建。";
    mytrans.NotallthedatacanbesavedintodatabasePleasecreateagain = "不是所有數據能存入數據庫。請重新創建。";
    mytrans.Thisrecordisnotyours = "這記錄不是您的。";
    mytrans.ErrorPleasecreateagain = "錯誤。請重新創建。";
    mytrans.ErrorPleasetryagain = "錯誤。請重試。";
    mytrans.Requestfailed = "請求失敗";
    mytrans.Pleaserefreshthepageandtryagain = "請刷新網頁重試。";
    mytrans.Pleaseenterdatetimeinfo = "請輸入日期時間信息。";
    mytrans.PleaseenterMondaySundayorSaturday = "請輸入週一，週日，或者週六。";
    mytrans.Timeisnotcontinuousatdate = "在這個日期時間不連續";
    mytrans.StartTimeEmpty = "起始時間為空";
    mytrans.EndTimeEmpty = "終止時間為空";
    mytrans.EndTimeEarlierThanStartTime = "終止時間比起始時間早。";
    mytrans.StartTimeWrongDateFormat = "錯誤的起始時間。";
    mytrans.EndTimeWrongDateFormat = "錯誤的終止時間。";
    mytrans.Pleasefillallthedatefirst = "請先填寫所有日期!";
    mytrans.Areyousureyouwanttodeletethis = "你確定你想刪除這個";
    mytrans.DeleteTarget = {"visit":"時間表","typecategory":"類別","type":"具體類型","user":"用戶","role":"角色","division":"部門"};
    mytrans.Areyousureyouwanttoimpersonateasthisuser = "你確定你想用這個用戶登錄？";
    mytrans.Chooseoneuser = "選一個用戶";
    mytrans.Chooseonetype = "選擇一個具體類型";
    mytrans.Onlyshowoneusersworkhourschart = "只顯示一個用戶的圖表";
    mytrans.Onlyshowonetypesuserhourschart = "只顯示一個具體類型的圖表";
    mytrans.showchart = "顯示圖表";
    mytrans.removeallchart = "刪除所有圖表";
    mytrans.Fromdate = "起始日期";
    mytrans.Todate = "終止日期";
    mytrans.nodata = "沒有數據";
    mytrans.Hours = "小時";
    mytrans.UserName = "用戶名";
    mytrans.Name = "名字";
    mytrans.Desc = "描述";
    mytrans.Approved = "通過";
    mytrans.Approvedby = "審閱人";
    mytrans.ApprovedTime = "審閱時間";
    mytrans.ReviewNotes = "審閱意見";
    mytrans.Status = "狀態";
    mytrans.Created = "建立";
    mytrans.ID = "ID";
    mytrans.Review = "審閱";
    mytrans.Youdidnotchangeanything = "您什麼都沒改。";
    mytrans.Youdidnotenteranything = "您什麼都沒輸入。";
    mytrans.Youmustchooseatarget = "您必須選擇一個。";
    mytrans.duplicate = "重複";
    mytrans.Pleasedraganddroptypesfromtherightside = "請從右側拖放具體類型到左側。";
    mytrans.Pleasedraganddropusersfromtherightside = "請從右側拖放用戶到左側。";
    mytrans.Pleaseentertypecategoryandorname = "請輸入類別和/或名稱。";
}

jQuery(document).ready(function(){
    jQuery('input.datetimepicker').each(function(){
        jQuery(this).datetimepicker({
            scrollMonth: false,
            scrollInput: false,
            format:'Y-m-d H:i'
        });
    });
    var myurl = window.location.href, result;
    if(myurl.indexOf("://") !== -1) {
        myurl = myurl.split("://", 2)[1];
    }

    if(myurl.indexOf("/index.php") !== -1) {
        result = myurl.split("/index.php").slice(-1)[0];
    } else {
        result = myurl.split("/", 2)[1];
    }
    result = result.replace("/", "");

    if(result.indexOf('/') !== -1) {
        result = result.split("/")[0];
    } else if(result.indexOf('?') !== -1) {
        result = result.split("?")[0];
    }

    jQuery('div#navbarCollapse li').removeClass('active');
    jQuery('div#homeicon').removeClass('active');

    if(result === '') {
        jQuery('div#homeicon').addClass('active');
    } else {
        if(result !== 'access' && result !== 'user' && result !== 'role' && result !== 'division'){
            jQuery('li#' + result).addClass('active');
        } else {
            jQuery('li#setting').addClass('active');
            jQuery('li#' + result).addClass('active');
        }
    }

    if(jQuery('div.master_pwrapper').length > 0) {
        jQuery('div.master_pwrapper').on( 'click', 'div.master_mypagination > ul.pagination > li:not(.noborder):not(.disabled)', function () {
            var topagenumber = isNaN(parseInt(jQuery(this).text())) ? 0 : parseInt(jQuery(this).text());
            var currentpage;
            if(jQuery(this).hasClass('prev')){
                currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                topagenumber = Math.max(1, (currentpage-1));
            } else if (jQuery(this).hasClass('next')){ 
                currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                topagenumber = Math.min(master_totalpagenumber, (currentpage+1));
            }
            master_showResultOnReloadedPage('', topagenumber);
        });
    }

    if(jQuery('div#master_show_result').length > 0) {
        jQuery('div#master_show_result').on( 'click', 'table th i', function () {
            var class0 = 'fa fa-sort';
            var mysortby = jQuery(this).parent().attr('class');
            var myorder = '';
            if(jQuery(this).hasClass('fa-sort')){
                myorder = 'asc';
            } else if(jQuery(this).hasClass('fa-sort-asc')){
                myorder = 'desc';
            } else if(jQuery(this).hasClass('fa-sort-desc')){
                myorder = 'asc';
            }
            master_showResultOnReloadedPage('', 1, mysortby, myorder);
        });
    }

    jQuery("ul.navbar-right > li.dropdown > ul.dropdown-menu > li > select#master_lang").click(function(event){
        // Avoid following the href location when clicking
        event.preventDefault(); 
        // Avoid having the menu to close when clicking
        event.stopPropagation(); 
        jQuery('ul.navbar-right > li.dropdown > ul.dropdown-menu').show();
    });

    jQuery("ul.navbar-right > li.dropdown > ul.dropdown-menu > li > select#master_lang").keyup(function(event){
        // Avoid following the href location when clicking
        event.preventDefault(); 
        // Avoid having the menu to close when clicking
        event.stopPropagation(); 
        jQuery('ul.navbar-right > li.dropdown > ul.dropdown-menu').show();
    });

    <?php if(intval($settings["USE_BOOTSTRAP_JS"]) != 1) { ?>
    if(jQuery('div#dragonvisit_visit_container form div#accordionVisit button.accordion-button').length > 0) {
        if(jQuery('div#dragonvisit_visit_container form div#accordionVisit div#collapseThree').length > 0) {
            jQuery('div#dragonvisit_visit_container form div#accordionVisit').on( 'click', 'button.accordion-button', function (){
                jQuery('div#dragonvisit_visit_container form div#accordionVisit div#collapseThree').toggle();
            });
        }
    }
    <?php } ?>

});

function master_showResultOnReloadedPage(type, pagenumber, mysortby, myorder) {
    var mydata = {}, temp1 = '';
    mydata['p'] = pagenumber ? pagenumber : 1;
    mydata['s'] = (mysortby === undefined) ? '' : mysortby;
    mydata['o'] = (myorder === undefined) ? '' : myorder;
    mydata['a'] = jQuery('select#master_amountperpage').find(":selected").val();

    if (mysortby === undefined && myorder === undefined) {
        jQuery('div#master_show_result table th i').each(function () {
            if(jQuery(this).hasClass('fa-sort-asc')){
                mydata['o'] = 'asc';
                mydata['s'] = jQuery(this).parent().attr('class');
            } else if(jQuery(this).hasClass('fa-sort-desc')){
                mydata['o'] = 'desc';
                mydata['s'] = jQuery(this).parent().attr('class');
            }
        });
    }
    var str = jQuery.param(mydata);
    //console.log('at 1158, str: ' + str);
    var mytemp = window.location.href.split('?');
    window.location.href = mytemp[0] + '?' + str;
}

function master_delete(element, id, name, mypluginurl, myajaxurl, my_dragonvisitzyx987_deleteVisit_nonce) {
    var mytempname = typeof mytrans.DeleteTarget[name] === "undefined" ? "" : (mytrans.DeleteTarget[name] === null ? "" : mytrans.DeleteTarget[name]);
    if(confirm(mytrans.Areyousureyouwanttodeletethis + mytempname + "?")) {
        var finaldata = {};
        finaldata["id"] = id;
        finaldata['action'] = "dragonvisitzyx987_deleteVisit"; 
        finaldata['dragonvisitzyx987_hidden_security_deletevisit'] = my_dragonvisitzyx987_deleteVisit_nonce || '';        
        finaldata['dragonvisitzyx987_hidden'] = "Y";          
        //console.log('at 1171, finaldata: ' + JSON.stringify(finaldata));
        jQuery.ajax({
            method: "POST",
            url: myajaxurl,
            data: finaldata
        })
        .done(function( msg ) {
            //console.log("at 1178, msg: " + msg );
            if(msg === 'Success') {
                window.location.href = mypluginurl;
            } else {
                alert(msg);
            }
        })
        .fail(function( jqXHR, textStatus ) {
            alert( mytrans.Requestfailed + ": " + textStatus + ". " + mytrans.Pleaserefreshthepageandtryagain);
        });
    }
}

function master_impersonate(element, id, name) {
    if(confirm(mytrans.Areyousureyouwanttoimpersonateasthisuser)) {
        var mytemp = window.location.href.replace(/\/create/,'');
        var mytemp2 = mytemp.replace(/\/edit\/.*$/,'');
        window.location.href = mytemp2 + '/impersonate/' + id;
    }
}
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="Content-Type" content="<?php bloginfo( 'html_type' ); ?>; charset=<?php bloginfo( 'charset' ); ?>" />
<noscript>Your browser does not support JavaScript! Please enable Javascript in your browser and refresh the page!</noscript>
<script>
var ajaxurl = "<?php echo esc_html(admin_url('admin-ajax.php')); ?>";
var pluginurl0 = "<?php $protocol = is_ssl() ? 'https://' : 'http://'; $urlparts = wp_parse_url(home_url()); $protocol = esc_html($urlparts['scheme']) . '://'; $domain = esc_html($urlparts['host']); $myurl = strtok($protocol . $domain . esc_html(str_replace(' ', '%20', $_SERVER['REQUEST_URI'])), '?'); if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);} echo esc_html($myurl); ?>";
var pluginurl = "<?php
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    echo $myurl; ?>";
pluginurl = pluginurl.replace(/&amp;/g, '&');
var dragonvisitzyx987_deleteVisit_nonce = "<?php echo wp_create_nonce('dragonvisitzyx987_deleteVisit'); ?>";
var b1n9j5t7R9P1 = <?php $current_user = wp_get_current_user(); echo $current_user->data->ID === null ? 0 : intval($current_user->data->ID); ?>;
var b1n9j5t7R9P2 = <?php $temp_user = json_decode($_SESSION["dragonvisitzyx987_user"], true); $temp_data = empty($temp_user) ? array() : (empty($temp_user["data"]) ? array() : $temp_user["data"]); echo empty($temp_data) ? 0 : (empty($temp_data["ID"]) ? 0 : esc_html(sanitize_text_field($temp_data["ID"])));  ?>;
var settings =  <?php echo json_encode($settings);  ?>;
var pg_onload = <?php echo intval($pagenumber); ?>;
var st_onload = "<?php echo esc_html($mysortby); ?>";
var o_onload = "<?php echo esc_html($myorder);  ?>";
var a_onload = "<?php echo intval($amountperpage); ?>";
var totalpagenumber_onload = <?php echo $amountperpage === 0 ? 1 : ceil(intval($total) / intval($amountperpage)); ?>;
var searchIsReset = false;
if(settings.length ===0) {
    alert("Setting is empty. Please contact web admin.");
}

function dragonvisitzyx987_getCookie(name) {
    var nameString = name + "=";
    //console.log("at 1225, cookies: " + document.cookie);
    var cookieArr = document.cookie.split(';');
    for(var i=0;i < cookieArr.length;i++) {
        var c = cookieArr[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameString) == 0) return c.substring(nameString.length,c.length);
    }
    return null;
}

function dragonvisitzyx987_browserSupportsLocalStorage(){
    var e,a;a="81b5be350fdf6bfd8a350e4de9e8ec75";
    try{localStorage.setItem(a,a);localStorage.removeItem(a);return true;}catch(e){e;return false;}
}

function dragonvisitzyx987_eraseCookie(name) {   
    document.cookie = name +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
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

function dragonvisitzyx987_showResultOnReloadedPage(type, pagenumber) {
    //search keyword should be urlencoded, remove &, can only be a-z, A-Z, 0-9, space,:/()$@?![]{}#%^*+=|~<>
    var mydata = {};
    mydata['pg'] = pagenumber ? pagenumber : 1;
    mydata['st'] = 'id';
    mydata['o'] = 'desc';
    var sortby = jQuery("select#dragonvisit_visit_sortby").val();

    if(sortby === 'id|asc') {
        mydata['st'] = 'id';
        mydata['o'] = 'asc';
    } else if(sortby === 'id|desc') {
        mydata['st'] = 'id';
        mydata['o'] = 'desc';
    } else if(sortby === 'date|asc') {
        mydata['st'] = 'date';
        mydata['o'] = 'asc';
    } else if(sortby === 'date|desc') {
        mydata['st'] = 'date';
        mydata['o'] = 'desc';
    }
    mydata['a'] = jQuery("select#dragonvisit_visit_itemsperpage").val();
    mydata['a'] = (mydata['a'] === '-1' || mydata['a'] === '0' || mydata['a'] === '') ? '10' : mydata['a'];
    var searchname = jQuery('input#dragonvisit_visit_name').val();
    mydata['n'] = (searchname === undefined || searchname === null) ? '' : searchname.replace(/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/g, '%');

    var searchvisitreason = jQuery('input#dragonvisit_visit_reason').val();
    mydata['r'] = (searchvisitreason === undefined || searchvisitreason === null) ? '' : searchvisitreason.replace(/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/g, '%');

    var fromdate = jQuery('input#dragonvisit_visit_fromdate').val();
    mydata['f'] = (fromdate === undefined || fromdate === null) ? '' : encodeURIComponent(fromdate);

    var todate = jQuery('input#dragonvisit_visit_todate').val();
    mydata['t'] = (todate === undefined || todate === null) ? '' : encodeURIComponent(todate);

    var visittypeid = jQuery('select#dragonvisit_visit_type').val();
    mydata['tid'] = (visittypeid === undefined || visittypeid === null) ? '' : visittypeid;

    var mystatus = jQuery('select#dragonvisit_visit_status').val();
    mydata['status'] = (mystatus === undefined || mystatus === null) ? '' : mystatus;

    var str = jQuery.param(mydata);
    var mypluginurl = "<?php
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    echo $myurl; ?>";
    mypluginurl = mypluginurl.replace(/&amp;/g, '&');
    if(mydata['pg'] === 1 && mydata['st'] === 'id' && mydata['o'] === 'desc' && mydata['a'] === '10'
       && mydata['n'] === '' && mydata['r'] === '' && mydata['f'] === '' && mydata['t'] === ''
       && mydata['tid'] === '-1' && mydata['status'] === '-1'
    ) {
        searchIsReset = true;
    } else {
        searchIsReset = false;
    }
    if(searchIsReset) {
        window.location.href = mypluginurl;
    } else {
        var myurlArr = mypluginurl.split("?");
        if(myurlArr.length == 2) {
            if(myurlArr[1].trim() === "") { 
                window.location.href = myurlArr[0] + '?' + str;
            } else {
                window.location.href = mypluginurl + '&' + str;
            }
        } else if(myurlArr.length == 1) {
            window.location.href = myurlArr[0] + '?' + str;
        } else {
            window.location.href = mypluginurl;
        }
    }
}

function dragonvisitzyx987_validString(mystring) {
    if(typeof mystring === 'undefined' || mystring === null) {
        return '';
    }
    if (typeof mystring === 'string') {
        return mystring
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
    } else {
        return mystring;
    }
}

jQuery(document).ready(function(){
    function getPHPSessId() {
        var phpSessionId = document.cookie.match(/PHPSESSID=[A-Za-z0-9]+\;/i);

        if(phpSessionId == null) 
            return '';

        if(typeof(phpSessionId) == 'undefined')
            return '';

        if(phpSessionId.length <= 0)
            return '';

        phpSessionId = phpSessionId[0];

        var end = phpSessionId.lastIndexOf(';');
        if(end == -1) end = phpSessionId.length;

        return phpSessionId.substring(10, end);
    }
    jQuery('span#phpsessionid').text(getPHPSessId());

    jQuery('.modal').on('show.bs.modal', function (e) {});

    jQuery(window).resize(function() {
    });    //end of jQuery(window).resize    
    jQuery("select.reset").val('-1');
    jQuery('input.datepicker').datepicker({changeMonth:true,changeYear:true,yearRange:"1900:c+10",dateFormat:"yy-mm-dd"});

    var sortstring = st_onload + '|' + o_onload;
    jQuery('select#sortby').val(sortstring);
    jQuery("select#amountperpage").val(a_onload);

    //a - amount per page; o - order (asc, desc); pg - page number; st - sortby; n - search visitor name; r - search visit reason; status - visit status
    //f - from date; t - to date;
    function dragonvisitzyx987_createPagination(totalpagenumber, topagenumber) {
        if(totalpagenumber !== parseInt(totalpagenumber, 10) || topagenumber !== parseInt(topagenumber, 10)) {jQuery('div.master_pwrapper > div.master_mypagination').html('');return;}  // || totalpagenumber <= 1
        var temp = '<ul class="pagination">',i;
        if(topagenumber > totalpagenumber) {
            topagenumber = 1;
            totalpagenumber=1;
        }
        if(totalpagenumber === 0) {
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
            temp += '<li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else if(totalpagenumber < 7) {
            if(topagenumber===1) {
                temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
            } else {
                temp += '<li class="page-item prev"><a class="page-link" tabindex="0"  aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
            }
            for(i=1;i<=totalpagenumber;i++) {
                temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" aria-label="page ' + i + '" role="button" tabindex="0" >' + i + '</a></li>';
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
                temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" aria-label="page ' + i + '" role="button" tabindex="0" >' + i + '</a></li>';
            }
            temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
            if(topagenumber===totalpagenumber) {
                temp += '<li class="page-item active" ><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
            } else {
                temp += '<li class="page-item"><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a class="page-link" tabindex="0"  aria-label="next page" role="img"><span aria-hidden="true">&raquo;</span></a></li>';
            }
        } else if(topagenumber < (totalpagenumber - 2)) {
            if(topagenumber===1) {
                temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item active" ><a class="page-link" role="img" tabindex="0" >1</a></li>';
            } else {
                temp += '<li class="page-item prev"><a class="page-link" role="img" tabindex="0" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item"><a class="page-link" aria-label="page 1" role="button" tabindex="0" >1</a></li>';
            }
            temp += (topagenumber > 4) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
            for(i=(topagenumber-2);i<=((topagenumber+2)>(totalpagenumber-1) ? (totalpagenumber-1) : (topagenumber+2));i++) {
                temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" aria-label="page ' + i + '" role="button" tabindex="0" >' + i + '</a></li>';
            }
            temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
            if(topagenumber===totalpagenumber) {
                temp += '<li class="page-item active" ><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
            } else {
                temp += '<li class="page-item"><a class="page-link" role="button" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a class="page-link" tabindex="0"  aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
            }
        } else if(topagenumber >= (totalpagenumber - 2)) {
            if(topagenumber===1) {
                temp += '<li class="page-item disabled"><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
            } else {
                temp += '<li class="page-item prev"><a class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
            }
            temp += '<li' + (topagenumber===1 ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" aria-label="page 1" role="button" tabindex="0" >1</a></li>';
            temp += ((topagenumber - 1) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
            for(i=(totalpagenumber-4);i<=totalpagenumber;i++) {
                temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a class="page-link" aria-label="page ' + i + '" role="button" tabindex="0" >' + i + '</a></li>';
            }
            if(topagenumber===totalpagenumber) {
                temp += '<li class="page-item disabled"><a class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
            } else {
                temp += '<li class="page-item next"><a class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
            }
        }
        temp += '</ul>';

        if(jQuery('div.master_pwrapper > div.master_mypagination').length > 0) {
            jQuery('div.master_pwrapper > div.master_mypagination').html(temp);
        }
    }

    dragonvisitzyx987_createPagination(totalpagenumber_onload, pg_onload);

    if(jQuery('div.master_pwrapper').length > 0) {
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).children().first().text())) ? 0 : parseInt(jQuery(this).children().first().text());
                var currentpage;
                if(jQuery(this).hasClass('prev')){
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload, (currentpage+1));
                }
                dragonvisitzyx987_showResultOnReloadedPage('', topagenumber);
            }
        });
    }
    jQuery('p#dragonvisit_message').focus();
});  //end of jQuery(document).ready

function dragonvisitzyx987_searchVisits() {
    dragonvisitzyx987_showResultOnReloadedPage('', 1);
}

function dragonvisitzyx987_resetVisitsSearchParameters() {
    jQuery('input#dragonvisit_visit_name').val('');
    jQuery('input#dragonvisit_visit_reason').val('');
    jQuery('select#dragonvisit_visit_type').val('-1');
    jQuery('input#dragonvisit_visit_fromdate').val('');
    jQuery('input#dragonvisit_visit_todate').val('');
    jQuery('select#dragonvisit_visit_status').val('-1');
    jQuery('select#dragonvisit_visit_itemsperpage').val('-1');
    jQuery('select#dragonvisit_visit_sortby').val('-1');
}

function dragonvisitzyx987_validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

function dragonvisitzyx987_validatePassword(password) {
    var result = true;
    const re = /.{8,}/;
    if(re.test(String(password).toLowerCase()) === false) {
        return false;
    };
    const re2 = /^[0-9a-zA-Z!@#*()$%^&]+$/;
    if(re2.test(String(password).toLowerCase()) === false) {
        return false;
    };
    const re3 = /^[0-9a-zA-Z]+$/;
    if(re3.test(String(password).toLowerCase()) === true) {
        return false;
    };
    return true;
}

function dragonvisitzyx987_capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

function dragonvisitzyx987_emptyParentNode(element) {
    jQuery(element).parent().html('').hide();
}

function dragonvisitzyx987_isNormalInteger(stringvalue) {
    stringvalue = stringvalue.trim();
    if (!stringvalue) {
        return false;
    }
    stringvalue = stringvalue.replace(/^0+/, "") || "0";
    var n = Math.floor(Number(stringvalue));
    return n !== Infinity && String(n) === stringvalue && n > 0;
}

//a - amount per page; o - order (asc, desc); pg - page number; st - sortby; n - search name; d - search description; r - search review notes; status - visit status
//min - min hours; max - max hours; f - from date; t - to date; ap - approved; apid - approved by id; af - approved from date; at - approved to date
function dragonvisitzyx987_createUserPagination(totalpagenumber, topagenumber, itemname) {
    if(totalpagenumber !== parseInt(totalpagenumber, 10) || topagenumber !== parseInt(topagenumber, 10)) {jQuery('div.master_pwrapper > div.master_mypagination').html('');return;}
    var temp = '<ul class="pagination">',i;
    if(topagenumber > totalpagenumber) {topagenumber = 1;totalpagenumber=1;}
    if(totalpagenumber < 7) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a  class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a  class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        for(i=1;i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a  class="page-link" tabindex="0" >' + i + '</a></li>';
        }
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item disabled"><a  class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item next"><a  class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber < 4) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a  class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a  class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        for(i=1;i<=5;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a  class="page-link" tabindex="0" >' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item active" ><a  class="page-link" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a  class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item"><a  class="page-link" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a  class="page-link" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber < (totalpagenumber - 2)) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled"><a  class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item active" ><a  class="page-link" tabindex="0" >1</a></li>';
        } else {
            temp += '<li class="page-item prev"><a  class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li><li class="page-item"><a  class="page-link" tabindex="0" >1</a></li>';
        }
        temp += (topagenumber > 4) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        for(i=(topagenumber-2);i<=((topagenumber+2)>(totalpagenumber-1) ? (totalpagenumber-1) : (topagenumber+2));i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a  class="page-link" tabindex="0" >' + i + '</a></li>';
        }
        temp += ((totalpagenumber - topagenumber) > 3) ? '<li class="noborder"><a class="page-link" >...</a></li>' : '';
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item active" ><a  class="page-link" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item disabled"><a  class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item"><a  class="page-link" tabindex="0" >' + totalpagenumber + '</a></li><li class="page-item next"><a  class="page-link" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    } else if(topagenumber >= (totalpagenumber - 2)) {
        if(topagenumber===1) {
            temp += '<li class="page-item disabled" aria-label="previous page, button is disabled" role="img" ><a class="page-link" aria-label="previous page, button is disabled" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';
        } else {
            temp += '<li class="page-item prev"><a  class="page-link" tabindex="0" aria-label="previous page" role="img" ><span aria-hidden="true">&laquo;</span></a></li>';                
        }
        temp += '<li' + (topagenumber===1 ? ' class="page-item active" ' : ' class="page-item" ') + '><a tabindex="0"  class="page-link" >1</a></li>';
        temp += ((topagenumber - 1) > 3) ? '<li class="page-item noborder"><a class="page-link" >...</a></li>' : '';
        for(i=(totalpagenumber-4);i<=totalpagenumber;i++) {
            temp += '<li' + (topagenumber===i ? ' class="page-item active" ' : ' class="page-item" ') + '><a  class="page-link" tabindex="0" >' + i + '</a></li>';
        }
        if(topagenumber===totalpagenumber) {
            temp += '<li class="page-item disabled"><a  class="page-link" aria-label="next page, button is disabled" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';
        } else {
            temp += '<li class="page-item next"><a  class="page-link" tabindex="0" aria-label="next page" role="img" ><span aria-hidden="true">&raquo;</span></a></li>';                
        }
    }
    temp += '</ul>';
    if(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_' + itemname).length > 0) {
        jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_' + itemname).html(temp);
    }
}

function dragonvisitzyx987_onLoadGetUserDataList() {
    if(jQuery('div.master_pwrapper').length > 0) {
        jQuery('div.master_pwrapper').on( 'click keydown', 'div.master_mypagination.master_mypagination_user_order > ul.pagination > li:not(.noborder):not(.disabled)', function (event) {
            if(dragonvisitzyx987_isClickEnterSpaceEvent(event) === true) {
                var topagenumber = isNaN(parseInt(jQuery(this).children().first().text())) ? 0 : parseInt(jQuery(this).children().first().text());
                var currentpage;
                if(jQuery(this).hasClass('prev')){
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_order > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_order > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.max(1, (currentpage-1));
                } else if (jQuery(this).hasClass('next')){ 
                    currentpage = isNaN(parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_order > ul.pagination > li.active > a').first().text())) ? 0 : parseInt(jQuery('div.master_pwrapper > div.master_mypagination.master_mypagination_user_order > ul.pagination > li.active > a').first().text());
                    topagenumber = Math.min(totalpagenumber_onload_user_order, (currentpage+1));
                }
                var sortby = jQuery("select#dragonvisit_userorder_sortby").val();
                dragonvisitzyx987_showUserResultOnAjaxReloadedPage('', topagenumber, 'order', sortby);
            }
        });
    }
}

function dragonvisitzyx987_showUserResultOnAjaxReloadedPage(type, pagenumber, itemname, sortby) {
    if(itemname === 'order') {
        dragonvisitzyx987_getUserOrdersList(pagenumber);
    }
}
    
function dragonvisitzyx987_closemodal(modalid) {
    jQuery('div#' + modalid + ' div.modal-header button.btn-close').click();
}

function dragonvisitzyx987_readCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
</script>
<style>
div#wpadminbar {
    display: none !important;
}
label, select, textarea, input, a.btn-lg {
    font-size: 2.25rem !important;
}
.bold, div.contentcontainer h3, div#dragonvisit_visit_container {
    font-size: 2.25rem !important;
    font-weight: bold !important;
}
div#dragonvisit_visit_container table thead tr th:first-child {
    min-width: 100px !important;
}
div#dragonvisit_visit_container table thead tr th:nth-child(2) {
    min-width: 50px !important;
}
div#dragonvisit_visit_container table thead tr th:nth-child(3) {
    min-width: 100px !important;
}
div#dragonvisit_visit_container table thead tr th:nth-child(6) {
    min-width: 120px !important;
}
div#dragonvisit_visit_container table thead tr th:nth-child(9) {
    min-width: 70px !important;
}
</style>
<div id="dragonvisit_wrap" class="dragonvisit_wrap">
    <div class="row master_pwrapper">
    <?php if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') { ?>
        <div class="updated col-12" style="<?php echo $dragon_visit_submitform_Result === '' ? 'color:#155724;background-color:#d4edda;padding-top:5px;padding-bottom:5px;' : 'color:#842029;background-color:#f8d7da;padding-top:5px;padding-bottom:5px;'; ?>"><p style="margin-top:5px !important;margin-bottom:5px !important;text-align:center;"><?php echo esc_html($dragon_visit_submitform_Result); ?></p></div>
    <?php } elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {  //GET request page, if there is error message when log in or log out, show error message
        if($dragon_visit_submitform_Result !== '') {
    ?>
        <div class="updated col-12" style="<?php echo $dragon_visit_submitform_Result === '' ? 'color:#155724;background-color:#d4edda;padding-top:5px;padding-bottom:5px;' : 'color:#842029;background-color:#f8d7da;padding-top:5px;padding-bottom:5px;'; ?>"><p style="margin-top:5px !important;margin-bottom:5px !important;text-align:center;"><?php echo esc_html($dragon_visit_submitform_Result); ?></p></div>
    <?php
        }
    } ?>
    </div><br/>
    <p tabindex="0" style="text-align:right !important;margin-right: 1.25rem !important;">You are logged in as <?php echo esc_html($current_user->data->user_login); ?></p>
    <p tabindex="0" style="color:red;font-size:2rem;font-weight:bold;text-align:center;" id="dragonvisit_message">Click the "CREATE VISIT" button to create your visit.</p>
    <p tabindex="0" style="color:red;font-size:2rem;font-weight:bold;text-align:center;">Enter your name and other info to find your visit.</p>
    <p tabindex="0" style="color:red;font-size:2rem;font-weight:bold;text-align:center;">A visit record can be updated only when it is active and timeout is empty.</p>
    <h2 tabindex="0" style="font-weight:bold;">Your Office Visits List:</h2>
    <div id="dragonvisit_visit_container">
        <form name="visitsearch_form" >
            <div class="accordion" id="accordionVisit">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingList">
                        <button tabindex="0" class="accordion-button collapsed" style="font-size:2rem;text-decoration:none;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            Click to hide/show search form
                        </button>
                    </h2>
                    <div id="collapseThree" class="accordion-collapse show" aria-labelledby="headingThree" data-bs-parent="#accordionVisit">
                        <div class="accordion-body">
                            <p><span tabindex="0">Search Visitor Name:</span> <input type="text" aria-label="Search Visitor Name" id="dragonvisit_visit_name" name="dragonvisit_visit_name" class="" value="<?php echo $searchname; ?>" size="50" /></p>
                            <p><span tabindex="0">Search Visit Reason:</span> <input type="text" aria-label="Search Visit Reason" id="dragonvisit_visit_reason" name="dragonvisit_visit_reason" class="" value="<?php echo $searchvisitreason; ?>" size="50" /></p>

                            <p><span tabindex="0">Search Visit Type:</span>
                                <select aria-label="Search Visit Type" id="dragonvisit_visit_type" name="dragonvisit_visit_type"  autocomplete="off" class="form-select form-select-lg">
                                    <option value="-1" >Please choose one...</option>
                                    <?php
                                    if(!empty($visittypes)){
                                        foreach ($visittypes as $type){
                                                $temp1 = empty($type->list) ? array() : explode('|',$type->list);
                                                $myassociatearray = [];
                                                //$typesforme = UserHelpers::getTypesForUserRCUS(UserHelpers::getUID());
                                                foreach($temp1 as $temp2) {
                                                    $temp3 = empty($temp2) ? array('','') : explode('_',$temp2,2);
                                                    //if(in_array($temp3[0], array_keys($typesforme['read']))) {
                                                        $myassociatearray[$temp3[0]] = $temp3[1];
                                                    //}
                                                }

                                            if (count($myassociatearray)){
                                                foreach ($myassociatearray as $k => $v){
                                                   echo "<option value='" . esc_html($k) . "'>" . esc_html($v) . "</option>";
                                                }
                                            }
                                        }
                                    }
                                    ?>
                                </select>

                            <p><span tabindex="0">Search From Date:</span> <input type="text" aria-label="Search From Date" id="dragonvisit_visit_fromdate" name="dragonvisit_visit_fromdate" class="datepicker" value="<?php echo $visitfromdate === '1000-01-01' ? '' : $visitfromdate; ?>" size="50" /></p>
                            <p><span tabindex="0">Search To Date:</span> <input type="text" aria-label="Search To Date" id="dragonvisit_visit_todate" name="dragonvisit_visit_todate" class="datepicker" value="<?php echo $visittodate === '9999-12-31' ? '' : $visittodate; ?>" size="50" /></p>

                            <p><span tabindex="0">Search Visit Status: </span>
                                <select aria-label="Search Visit Status" id="dragonvisit_visit_status" name="dragonvisit_visit_status" autocomplete="off">
                                    <option value="-1" <?php if (intval($visitstatus) === -1){echo 'selected';} ?>>Please choose one...</option>
                                    <option value="1" <?php if (intval($visitstatus) === 1){echo 'selected';} ?>>ACTIVE</option>
                                    <option value="0" <?php if (intval($visitstatus) === 0){echo 'selected';} ?>>NOT ACTIVE</option>
                                </select>
                            </p>

                            <p>
                                <input type="button" aria-label="Search" id="dragonvisit_visit_search" name="dragonvisit_visit_search" class="btn btn-primary btn-lg bold" value="Search" onclick="dragonvisitzyx987_searchVisits();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="button" aria-label="Reset" id="dragonvisit_visit_searchreset" name="dragonvisit_visit_searchreset" class="btn btn-default btn-lg bold" value="Reset" onclick="dragonvisitzyx987_resetVisitsSearchParameters();" style="background-color:grey;"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row master_pwrapper">
                <div class="col-12 col-sm-12 col-md-6 master_amountperpage" style="display: inline-block;">
                    <label tabindex="0" for="dragonvisit_visit_itemsperpage">Items per Page:</label> 
                    <select aria-label="Items per Page" id="dragonvisit_visit_itemsperpage" name="dragonvisit_visit_itemsperpage" class="form-select form-select-lg" onchange="dragonvisitzyx987_searchVisits();" autocomplete="off">
                        <option value="-1">Please choose one...</option>
                        <option value="10" <?php if (intval($amountperpage) === 10){echo 'selected';} ?> >10</option>
                        <option value="20" <?php if (intval($amountperpage) === 20){echo 'selected';} ?> >20</option>
                        <option value="40" <?php if (intval($amountperpage) === 40){echo 'selected';} ?> >40</option>
                        <option value="60" <?php if (intval($amountperpage) === 60){echo 'selected';} ?> >60</option>
                        <option value="80" <?php if (intval($amountperpage) === 80){echo 'selected';} ?> >80</option>
                        <option value="100" <?php if (intval($amountperpage) === 100){echo 'selected';} ?> >100</option>
                    </select>
                </div>
                <div class="col-12 col-sm-12 col-md-6 master_mysort" style="display: inline-block;">
                    <label tabindex="0" for="dragonvisit_visit_sortby">Sort By:</label>
                    <select aria-label="Sort By" id="dragonvisit_visit_sortby" name="dragonvisit_visit_sortby" class="form-select form-select-lg" onchange="dragonvisitzyx987_searchVisits();" autocomplete="off">
                        <option value="-1">Please choose one...</option>
                        <option value="id|asc" <?php if ($mysortby . '|' . $myorder === 'id|asc'){echo 'selected';} ?> >ID low-high</option>
                        <option value="id|desc" <?php if ($mysortby . '|' . $myorder === 'id|desc'){echo 'selected';} ?> >ID high-low</option>
                        <option value="date|asc" <?php if ($mysortby . '|' . $myorder === 'date|asc'){echo 'selected';} ?> >Visit date old-new</option>
                        <option value="date|desc" <?php if ($mysortby . '|' . $myorder === 'date|desc'){echo 'selected';} ?> >Visit date new-old</option>
                    </select>
                </div>
            </div><br/>
        </form>
        <p>
            <a href="<?php
                    $urlparts = wp_parse_url(home_url());
                    $protocol = esc_html($urlparts['scheme']);
                    $domain = esc_html($urlparts['host']);
                    $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                    $myurl = str_replace("&amp;", "&", $myurl);
                    $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                    if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}
                    echo esc_html(add_query_arg(array('action' => 'create'), $myurl)); ?>" role="button" tabindex="0" aria-label="create visit" id="dragonvisit_visit_create" name="dragonvisit_visit_create" class="btn btn-success btn-lg" >CREATE VISIT</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
        <span tabindex="0">Total visits: </span><span tabindex="0" id="totalvisitquantity" aria-label="Total visits number is <?php echo $total; ?>" ><?php echo $total; ?></span><img src="<?php echo plugin_dir_url( __FILE__ );  ?>images/loading.gif" id="admin_visitlist_loader" alt="loading" style="display:none;" />

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_visit" style="display: inline-block;"></div>
        </div>

        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th tabindex="0">ID</th>
                    <th tabindex="0">Visit Type</th>
                    <th tabindex="0">Visitor Name</th>
                    <th tabindex="0">Reason For Visit</th>
                    <th tabindex="0">Visit Date</th>
                    <th tabindex="0">Time In</th>
                    <th tabindex="0">Time Out</th>
                    <th tabindex="0">Status</th>    
                    <th tabindex="0">User Name</th>
                    <th tabindex="0">User Name 2</th>
                    <th tabindex="0">User Id</th>
                </tr>
            </thead>
            <tbody id="dragonvisit_visit">
            <?php
                if(count($visits) > 0) {
                    $tempRows = '';
                    for ($i = 0; $i < count($visits); $i++) {
                        $temp_button = '';
                        if(intval($visits[$i]["status"]) === 1 && ($visits[$i]["timeout"] === '' || $visits[$i]["timeout"] === null)) {
                            $urlparts = wp_parse_url(home_url());
                            $protocol = esc_html($urlparts['scheme']);
                            $domain = esc_html($urlparts['host']);
                            $myurl = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
                            $myurl = str_replace("&amp;", "&", $myurl);
                            $myurl = remove_query_arg(array('action','id','pg','st','o','a','n','r','f','t','tid','status'), $myurl);
                            $myurl = esc_html(add_query_arg(array('action' => 'edit', 'id' => esc_html($visits[$i]["id"])), $myurl));
                            if(substr($myurl, -1) === '/') {$myurl = substr($myurl, 0, -1);}

                            $temp_button .= '<td style="min-width:80px !important;"><a href="' . $myurl . '" role="button" tabindex="0" aria-label="edit" class="btn btn-primary btn-lg" >EDIT</a>';
                            $temp_button .= '&nbsp;&nbsp;<a href="javascript:void(0);" role="button" tabindex="0" aria-label="delete" onclick="master_delete(this, ' . esc_html($visits[$i]["id"]) . ', \'visit\', pluginurl, ajaxurl, dragonvisitzyx987_deleteVisit_nonce);" class="btn btn-danger btn-lg dragonvisit_visit_container_' . esc_html($visits[$i]["id"]) . '" >DELETE</a></td>';
                        } else {
                            $temp_button .= '<td></td>';
                        }
                        $tempRows .= '<tr>' . $temp_button . '<td><span tabindex="0">' . esc_html($visits[$i]["id"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["visittypename"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["visitorname"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["visitreason"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["visitdate"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["timein"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["timeout"]) . '</span></td>';
                        $tempRows .= '<td>' . (esc_html($visits[$i]["status"]) === '1' ? '<span tabindex="0" style="color:green;">Active</span>' : '<span tabindex="0" style="color:red;">Inactive</span>');
                        //$tempRows .= '<div style="display:none;" class="dragonvisit_visit_container_' . esc_html($visits[$i]["id"]) . '" ></div>';
                        $tempRows .= '</td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["username"]) . '</span></td>';
                        $tempRows .= '<td><span tabindex="0">' . esc_html($visits[$i]["username2"]) . '</span></td>';
                        $tempRows .= '<td><span aria-label="user id is ' . esc_html($visits[$i]["userid"]) . '" tabindex="0">' . esc_html($visits[$i]["userid"]) . '</span></td>';
                        $tempRows .= '</tr>';
                    }
                    echo $tempRows;
                } else {
                    echo '<tr><td colspan="12" style="color:red;text-align:center;"><span tabindex="0">NO DATA</span></td></tr>';
                }
            ?>
            </tbody>
        </table>

        <div class="row master_pwrapper">
            <div class="col-xs-12 master_mypagination master_mypagination_visit" style="display: inline-block;"></div>
        </div>
    </div>
    <hr/>

    <div class="copyright">
        <h4 tabindex="0">© <?php echo date("Y"); ?> <?php echo empty($settings["COMPANY_NAME"]) ? '' : esc_html($settings["COMPANY_NAME"]); ?>. All rights reserved.</h4>
        <h4 tabindex="0"><?php echo empty($settings["COMPANY_ADDRESS"]) ? '' : esc_html($settings["COMPANY_ADDRESS"]); ?></h4>
    </div>
</div>
<div id="loading" style="display:none;"></div>
</body>
</html>
<?php  exit;  ?>