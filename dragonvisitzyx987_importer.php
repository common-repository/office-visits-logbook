<?php
    /*
    Plugin Name: Office Visits Logbook
    Plugin URI:
    Description: A WordPress plugin to record company office visits. It will save office visitor's name, visit reason, visit type, visit date, time in and time out into database. After plugin activation, go to the "Settings" menu to find the plugin admin page. By default, when you activate this plugin, it will automatically create a visit landing page for you. For some themes, if it does not automatically create a visit landing page for you, add this plugin root folder template-officevisitslogbook.php file to your template folder. For example, if you are using theme twentytwenty, then add the template-officevisitslogbook.php file to this folder: wordpress\wp-content\themes\twentytwenty\templates. Then you can create a new page (not a new post) using this template. When you use the template method to create a new visit page, do not set the page title to "officevisitslogbook". If you set the page title to "officevisitslogbook", it could conflict with the page automatically created when you activate this plugin. Please read the documents in the admin plugin setting page before using this software.
    Author: Ming's IT Services Ltd.
    Year: 2020-05-07
    Version: 1.1.2
    All rights reserved.
    Author URI: https://www.mingsitservices.com/
    Disclaimer: While Ming's IT Services Ltd. makes every effort to deliver high quality products, we do not 
                guarantee that our products are free from defects. Our software is provided “as is," and you use the 
                software at your own risk.
                We make no warranties as to performance, merchantability, fitness for a particular purpose, or any 
                other warranties whether expressed or implied.
                No oral or written communication from or information provided by Ming's IT Services Ltd. 
                shall create a warranty.
                Under no circumstances shall Ming's IT Services Ltd. be liable for direct, indirect, special, 
                incidental, or consequential damages resulting from the use, misuse, or inability to use this software, 
                even if Ming's IT Services Ltd. has been advised of the possibility of such damages.
    */
global $wpdb; global $dragon_visit_dbResult;
$dragon_visit_dbResult = '';
$timezone=get_option('timezone_string');
if(!empty($timezone)){date_default_timezone_set($timezone);}
$wp_dragonvisitzyx987_table_name = 'wp_dragonvisitzyx987';
$charset_collate = $wpdb->get_charset_collate();

function dragonvisitzyx987_getOneUser($userid = 0)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    return $results;
}

function dragonvisitzyx987_users_already_has_admin_user()
{
    global $wpdb;
    $table_name = "wp_dragonvisitzyx987_users";
    $results = $wpdb->get_results("SELECT userid FROM $table_name WHERE status = 1");
    if(count($results) > 0){
        $has_admin_user = false;
        foreach($results as $result) {
            if(intval($result->userid) > 0 ){
                if(dragonvisitzyx987_user_has_role(intval($result->userid), 'administrator')) {
                    $has_admin_user = true;
                    break;
                }
            }
        }
        return $has_admin_user;
    } else {
        return false;
    }
}

function dragonvisitzyx987_createFirstAdminUser()
{
    global $wpdb;
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo "Invalid User.";exit;
    }    
    $userdetails = dragonvisitzyx987_getOneUser(intval($current_user->data->ID));
    if(count($userdetails) !== 1) {
        if(intval($current_user->data->ID) > 0 && in_array( 'administrator', (array) $current_user->roles )) {
            //if wp_dragonvisitzyx987_users table does not have an admin user yet, add this user to wp_dragonvisitzyx987_users table automatically
            if(!dragonvisitzyx987_users_already_has_admin_user()) {
                require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
                $table_name = 'wp_dragonvisitzyx987_users';
                $firstname = 'admin';
                $lastname = 'admin';
                $userid = intval($current_user->data->ID);
                $canreadinadminpage = 1;
                $cancreateinadminpage = 1;
                $caneditinadminpage = 1;
                $canactivateinadminpage = 1;
                $candeactivateinadminpage = 1;
                $reportto = intval($current_user->data->ID);

                $role_table_name = 'wp_dragonvisitzyx987_role';
                $admin_role_id = $wpdb->get_var("SELECT id FROM " . $role_table_name . " WHERE name = 'admin' LIMIT 1");
                $role = intval($admin_role_id);
                if($role <= 0) {$role = null;}

                $department = null;
                $status = 1;
                $email = null;
                $phone = null;
                $address = null;
                $address2 = null;
                $city = null;
                $province = null;
                $country = null;
                $zip = null;
                $description = null;

                if($userid <= 0 || $reportto <= 0) {
                    echo 'Create a new user: User id, and report to id are required.';
                    exit;
                }

                if($wpdb->use_mysqli) {
                    if($wpdb->dbh->connect_error) {
                        echo "Connection failed: " . esc_html($wpdb->dbh->connect_error);
                        exit;
                    }
                    $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE userid = ?");
                    $stmt->bind_param("i", $userid);
                    $stmt->execute();
                    $myresult = $stmt->get_result();
                    $result = $myresult === FALSE ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
                    $stmt->close();

                    if(count($result) === 1) {
                        $temp_row = $result[0];
                        $temp_result = $temp_row["countresult"];
                        $dbcount = $temp_result === null ? 0 : intval($temp_result);
                        if($dbcount !== 0) {
                            echo "Create a new user: your user id " . $userid . " already exists in the table.";
                            exit;
                        }
                    } else {
                        echo "Create a new user: user id " . $userid . " query has error. Not saved.";
                        exit;
                    }

                    $query = "INSERT INTO $table_name (`userid`,`firstname`,`lastname`,`phone`,`address`,`address2`,`city`,`province`,`country`,`zip`,`reportto`,`email`,`description`,`departmentid`,`roleid`,`canreadinadminpage`,`cancreateinadminpage`,`caneditinadminpage`,`canactivateinadminpage`,`candeactivateinadminpage`,`status`,`createtimeutc`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,UTC_TIMESTAMP())";
                    $stmt = $wpdb->dbh->prepare($query);
                    $types = '';
                    $parameterArray = array('');

                    $types .= 'i';
                    $parameterArray[] = &$userid;

                    $types .= 's';
                    $parameterArray[] = &$firstname;

                    $types .= 's';
                    $parameterArray[] = &$lastname;

                    $types .= 's';
                    $parameterArray[] = &$phone;

                    $types .= 's';
                    $parameterArray[] = &$address;

                    $types .= 's';
                    $parameterArray[] = &$address2;

                    $types .= 's';
                    $parameterArray[] = &$city;

                    $types .= 's';
                    $parameterArray[] = &$province;

                    $types .= 's';
                    $parameterArray[] = &$country;

                    $types .= 's';
                    $parameterArray[] = &$zip;

                    $types .= 'i';
                    $parameterArray[] = &$reportto;

                    $types .= 's';
                    $parameterArray[] = &$email;

                    $types .= 's';
                    $parameterArray[] = &$description;

                    $types .= 'i';
                    $parameterArray[] = &$departmentid;

                    $types .= 'i';
                    $parameterArray[] = &$role;

                    $types .= 'i';
                    $parameterArray[] = &$canreadinadminpage;

                    $types .= 'i';
                    $parameterArray[] = &$cancreateinadminpage;

                    $types .= 'i';
                    $parameterArray[] = &$caneditinadminpage;

                    $types .= 'i';
                    $parameterArray[] = &$canactivateinadminpage;

                    $types .= 'i';
                    $parameterArray[] = &$candeactivateinadminpage;

                    $parameterArray[0] = $types;
                    call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                    $stmt->execute();
                    $myresult = $stmt->insert_id;
                    $stmt->close();

                    if($myresult <= 0) {
                        echo 'Error adding a user into table ' . $table_name . ". ";
                        exit;
                    }
                    $userdetails = dragonvisitzyx987_getOneUser(intval($current_user->data->ID));
                } else {
                    echo 'Mysqli is not supported by your system. ';
                    exit;
                }
            }
        } else {
            echo "Invalid User. Please contact web admin to add you to this plugin's user list: wp_dragonvisitzyx987_users table. You need to enter your first name, last name, and createtimeutc (e.g. ‘2022-01-01’). You also need to set canreadinadminpage, cancreateinadminpage, caneditinadminpage, canactivateinadminpage, candeactivateinadminpage to 1. You can also set reportto to your supervisor’s ID in the wp_users table. Then add this record to wp_dragonvisitzyx987_users table. See the root folder, documentation_dragonvisit.pdf file for details.";
            exit;
        }
    }
}

function dragonvisitzyx987_additional_creation()
{
}

function dragonvisitzyx987_createStoredProcedure()
{
    include_once __DIR__ . '/dragonvisitzyx987_storedprocedures.php';
}

function dragonvisitzyx987_createTable_constant()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_constant (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `name` varchar(255) NOT NULL,
          `value` text NOT NULL,
          `status` tinyint(1) NOT NULL DEFAULT 1,
          `createtimeutc` DATETIME,
          `updatetimeutc` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);

    $constant_name = 'AMOUNT_PER_PAGE';
    $constant_description = '10';
    $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT '" . $constant_name . "' as name,'" . $constant_description . "' as value,1 as status,UTC_TIMESTAMP() as createtimeutc) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= '" . $constant_name . "') LIMIT 1;"));
    //$sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'COMPANY_TIMEZONE' as name, 'America/New_York' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'COMPANY_TIMEZONE') LIMIT 1;";
    //dbDelta($sql);    
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'LANGUAGE' as name, 'en' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'LANGUAGE') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'COMPANY_NAME' as name,'' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'COMPANY_NAME') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'COMPANY_ADDRESS' as name,'' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'COMPANY_ADDRESS') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'USE_BOOTSTRAP_JS' as name,'1' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'USE_BOOTSTRAP_JS') LIMIT 1;";
    dbDelta($sql);	
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'USE_BOOTSTRAP_CSS' as name,'1' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'USE_BOOTSTRAP_CSS') LIMIT 1;";
    dbDelta($sql);	
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_constant (`name`,`value`,`status`,`createtimeutc`) SELECT * FROM (SELECT 'SHOW_ALL_VISITS_WHEN_NOT_SEARCH' as name,'1' as value,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_constant WHERE `name`= 'SHOW_ALL_VISITS_WHEN_NOT_SEARCH') LIMIT 1;";
    dbDelta($sql);	
}

function dragonvisitzyx987_createTable_department()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_department (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `name` varchar(255) NOT NULL,
          `description` varchar(255) NOT NULL,
          `status` tinyint(1) NOT NULL DEFAULT 1,
          `createtimeutc` DATETIME,
          `updatetimeutc` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);
    $department_name = 'admin';
    $department_description = 'admin';
    $dbmyid = $wpdb->get_var("SELECT id FROM " . $wp_dragonvisitzyx987_table_name . "_department WHERE name = '" . $department_name . "'");
    if(intval($dbmyid) > 0) {
    } else {
        $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_department (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 1 as 'id', %s as 'name', %s as 'description', 1 as 'status', UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_department WHERE `name`= '" . $department_name . "') LIMIT 1", array($department_name, $department_description)));
    }
}

function dragonvisitzyx987_createTable_log()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_log (
        id INTEGER NOT NULL AUTO_INCREMENT,
        processname TEXT CHARSET utf8,
        type TEXT CHARSET utf8,
        userid INTEGER,
        description TEXT CHARSET utf8,
        createtimeutc DATETIME NOT NULL,
        status TINYINT NOT NULL DEFAULT 1,
        PRIMARY KEY (id)
    ) $charset_collate;";
    dbDelta($sql);
}

function dragonvisitzyx987_createTable_role()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_role (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `name` varchar(255) NOT NULL,
          `description` varchar(255) NOT NULL,
          `status` tinyint(1) NOT NULL DEFAULT 1,
          `createtimeutc` DATETIME,
          `updatetimeutc` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);
    $role_name = 'admin';
    $role_description = 'admin';
    $dbmyid = $wpdb->get_var("SELECT id FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE name = '" . $role_name . "'");
    if(intval($dbmyid) > 0) {
    } else {    
        $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_role (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 1 as 'id', %s as 'name', %s as 'description', 1 as 'status', UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE `name`= '" . $role_name . "') LIMIT 1", array($role_name, $role_description)));
    }

    $role_name = 'superuser';
    $role_description = 'superuser';
    $dbmyid = $wpdb->get_var("SELECT id FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE name = '" . $role_name . "'");
    if(intval($dbmyid) > 0) {
    } else {
        $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_role (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 2 as 'id', %s as 'name', %s as 'description', 1 as 'status', UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE `name`= '" . $role_name . "') LIMIT 1", array($role_name, $role_description)));
    }

    $role_name = 'manager';
    $role_description = 'manager';
    $dbmyid = $wpdb->get_var("SELECT id FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE name = '" . $role_name . "'");
    if(intval($dbmyid) > 0) {
    } else {
        $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_role (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 3 as 'id', %s as 'name', %s as 'description', 1 as 'status', UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE `name`= '" . $role_name . "') LIMIT 1", array($role_name, $role_description)));
    }

    $role_name = 'user';
    $role_description = 'user';
    $dbmyid = $wpdb->get_var("SELECT id FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE name = '" . $role_name . "'");
    if(intval($dbmyid) > 0) {
    } else {
        $mytemp = $wpdb->query($wpdb->prepare("INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_role (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 4 as 'id', %s as 'name', %s as 'description', 1 as 'status', UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_role WHERE `name`= '" . $role_name . "') LIMIT 1", array($role_name, $role_description)));
    }
}

function dragonvisitzyx987_createTable_visit()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_visit (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `userid` BIGINT unsigned NOT NULL,
          `visittypeid` BIGINT unsigned NOT NULL,
          `visitorname` varchar(45) not null,
          `visitreason` varchar(250),
          `visitdate` DATE not null,
          `timein` varchar(45) not null, 
          `timeout` varchar(45),
          `status` tinyint(1) NOT NULL DEFAULT '1',
          `created` DATETIME,
          `lastupdated` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);
}

function dragonvisitzyx987_createTable_typecategory()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_typecategory (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `name` varchar(250) NOT NULL, 
          `description` varchar(250),  
          `status` tinyint(1) NOT NULL DEFAULT 1,
          `createtimeutc` DATETIME,
          `updatetimeutc` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);

    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_typecategory (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 1 as id, 'Human Resources' as name, 'Human Resources' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_typecategory WHERE `name`= 'Human Resources') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_typecategory (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 2 as id, 'Business' as name, 'Business' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_typecategory WHERE `name`= 'Business') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_typecategory (`id`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 3 as id, 'Other' as name, 'Other' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_typecategory WHERE `name`= 'Other') LIMIT 1;";
    dbDelta($sql);
}

function dragonvisitzyx987_createTable_type()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_type (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `typecategoryid` BIGINT unsigned NOT NULL,
          `name` varchar(250) NOT NULL,
          `description` varchar(250),
          `status` tinyint(1) NOT NULL DEFAULT 1,
          `createtimeutc` DATETIME,
          `updatetimeutc` DATETIME,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_type (`id`,`typecategoryid`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 1 as id, 1 as typecategoryid, 'Interview' as name, 'Interview' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_type WHERE `name`= 'Interview') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_type (`id`,`typecategoryid`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 2 as id, 2 as typecategoryid, 'Visit' as name, 'Visit' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_type WHERE `name`= 'Visit') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_type (`id`,`typecategoryid`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 3 as id, 2 as typecategoryid, 'Business' as name, 'Business' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_type WHERE `name`= 'Business') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_type (`id`,`typecategoryid`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 4 as id, 2 as typecategoryid, 'Meeting' as name, 'Meeting' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_type WHERE `name`= 'Meeting') LIMIT 1;";
    dbDelta($sql);
    $sql = "INSERT INTO " . $wp_dragonvisitzyx987_table_name . "_type (`id`,`typecategoryid`,`name`,`description`,`status`,`createtimeutc`) SELECT * FROM (SELECT 5 as id, 3 as typecategoryid, 'Other' as name, 'Other' as description,1 as status,UTC_TIMESTAMP()) AS tmp WHERE NOT EXISTS (SELECT * FROM " . $wp_dragonvisitzyx987_table_name . "_type WHERE `name`= 'Other') LIMIT 1;";
    dbDelta($sql);
}

function dragonvisitzyx987_createTable_users()
{
    global $wp_dragonvisitzyx987_table_name;global $charset_collate;global $wpdb;
    $sql = "CREATE TABLE IF NOT EXISTS " . $wp_dragonvisitzyx987_table_name . "_users (
          `id` BIGINT unsigned NOT NULL AUTO_INCREMENT,
          `userid` BIGINT unsigned NOT NULL,
          `firstname` varchar(45) NOT NULL,
          `lastname` varchar(45) NOT NULL,
          `phone` varchar(45),
          `address` varchar(45),
          `address2` varchar(45),
          `city` varchar(45),
          `province` varchar(45),
          `country` varchar(250),
          `zip` varchar(45),
          `reportto` BIGINT unsigned,
          `picture` varchar(45),
          `email` varchar(250),
          `description` varchar(250),
          `departmentid` BIGINT unsigned,
          `roleid` BIGINT unsigned,
          `canreadinadminpage` tinyint(1) NOT NULL DEFAULT 0,
          `cancreateinadminpage` tinyint(1) NOT NULL DEFAULT 0,
          `caneditinadminpage` tinyint(1) NOT NULL DEFAULT 0,
          `canactivateinadminpage` tinyint(1) NOT NULL DEFAULT 0,
          `candeactivateinadminpage` tinyint(1) NOT NULL DEFAULT 0,
          `hourlyrate` DECIMAL(19,2),
          `yearlyrate` DECIMAL(19,2),
          `createtimeutc` DATETIME NOT NULL,
          `updatetimeutc` DATETIME,
          `endedat` DATETIME,
          `token` varchar(250),
          `tokenvalidto` DATETIME,
          `remembertoken` varchar(100),
          `remembertokenvalidto` DATETIME,
          `status` tinyint(1) NOT NULL DEFAULT 1,
          PRIMARY KEY (`id`)
    ) $charset_collate;";
    dbDelta($sql);
}

function dragonvisitzyx987_createView()
{
}

function dragonvisitzyx987_createWebpage()
{
    global $wpdb;
    $title = "Office Visits Log Book";
    $slug = 'officevisitslogbook';

    // Search for an existing page with the specified page slug.
    $valid_page_found = $wpdb->get_var( $wpdb->prepare( "SELECT ID FROM $wpdb->posts WHERE post_type='page' AND post_status NOT IN ( 'pending', 'trash', 'future', 'auto-draft' )  AND post_name = %s LIMIT 1;", $slug ) );
    if ( $valid_page_found ) {
        return $valid_page_found;
    }
    
    // Search for a matching valid trashed page with the specified page slug.
    $trashed_page_found = $wpdb->get_var( $wpdb->prepare( "SELECT ID FROM $wpdb->posts WHERE post_type='page' AND post_status = 'trash' AND post_name = %s LIMIT 1;", $slug ) );

    if ( $trashed_page_found ) {
        $page_id   = $trashed_page_found;
        $page_data = array(
            'ID'          => $page_id,
            'post_status' => 'publish',
        );
        wp_update_post( $page_data );
        return $page_id;
    } else {
        $postData = array(
            'post_title' => $title,
            'post_name' => $slug,
            'post_status' => 'publish',
            'post_content' => '',
            'post_author' => $current_user->data->ID,
            'post_type'   => 'page',
            'post_category' => array()
        );
        $page_id = wp_insert_post($postData);	
        return $page_id;
    }
}

function dragonvisitzyx987_create_db()
{
    global $wpdb;global $wp_dragonvisitzyx987_table_name;global $charset_collate;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $wp_dragonvisitzyx987_table_name = 'wp_dragonvisitzyx987';
    dragonvisitzyx987_createTable_constant();
    dragonvisitzyx987_createTable_department();
    dragonvisitzyx987_createTable_log();
    dragonvisitzyx987_createTable_role();
    dragonvisitzyx987_createTable_visit();
    dragonvisitzyx987_createTable_typecategory();
    dragonvisitzyx987_createTable_type();
    dragonvisitzyx987_createTable_users();

    dragonvisitzyx987_createView();
    dragonvisitzyx987_createStoredProcedure();
    dragonvisitzyx987_createFirstAdminUser();
    dragonvisitzyx987_additional_creation();

    //create a new web page for this plugin
    dragonvisitzyx987_createWebpage();
}

register_activation_hook(__FILE__, 'dragonvisitzyx987_create_db');

function dragonvisitzyx987_admin()
{
    include_once 'dragonvisitzyx987_admin.php';
}

function dragonvisitzyx987_admin_actions()
{
    add_options_page("Office Visits Logbook", "Office Visits Logbook", 1, "Office Visits Logbook", "dragonvisitzyx987_admin");
}

add_action('admin_menu', 'dragonvisitzyx987_admin_actions');

function dragonvisitzyx987_load_landing_page()
{
    $urlparts = wp_parse_url(home_url());
    $protocol = esc_html($urlparts['scheme']);
    $domain = esc_html($urlparts['host']);
    $actual_url = $protocol . "://" . $domain . esc_html($_SERVER['REQUEST_URI']);
    $actual_url = str_replace("&amp;", "&", $actual_url);
    $post_id = url_to_postid($actual_url);
    if($post_id <= 0) {return;}
    $currentpost = get_post($post_id);
    //error_log("at 550, actual_url: " . $actual_url);
    //error_log("at 551, post_id: " . $post_id);
    //error_log("at 552, current Post: " . json_encode($currentpost));
    if($currentpost->post_name !== 'officevisitslogbook') {return;}

    dragonvisitzyx987_showLandingPage();
}
add_action('init', 'dragonvisitzyx987_load_landing_page');

function dragonvisitzyx987_validateDate($date, $format = 'Y-m-d H:i:s')
{
    $d = DateTime::createFromFormat($format, $date);
    return $d && $d->format($format) == $date;
}

function dragonvisitzyx987_stripAllBackSlashes($str)
{
    if($str===null) {return '';
    }
    return str_replace('\\', '', $str);
}

function dragonvisitzyx987_upload_folder()
{ 
    $upload = wp_upload_dir();
    $upload_dir = $upload['basedir'];
    $upload_dir = $upload_dir . '/dragonvisit';
    if (!is_dir($upload_dir)) {
        mkdir($upload_dir, 0700);  //0755 );
    } else {        
        chmod($upload_dir, 0700);  //0755 );
    }
    return $upload_dir;
}

function dragonvisitzyx987_upload_url()
{ 
    $upload = wp_upload_dir();
    $upload_url = $upload['baseurl'];
    $upload_url = $upload_url . '/dragonvisit';
    return $upload_url;
}

function dragonvisitzyx987_getVisits_not_by_ajax($amountperpage, $pagenumber, $myoffset, $mysortby, $myorder, $visittypeid, $searchname, $searchvisitreason, $fromdate, $todate, $visitstatus)
{
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return [];
    }
    global $wpdb;global $wp_dragonvisitzyx987_table_name;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name1 = $wp_dragonvisitzyx987_table_name . '_visit';
    $table_name3 = $wp_dragonvisitzyx987_table_name . '_constant';
    $table_name5 = $wp_dragonvisitzyx987_table_name . '_type';
    $storedprocedure_name = $wp_dragonvisitzyx987_table_name. '_getVisitList';
    $fromdate = $fromdate === '' ? '1000-01-01' : $fromdate;
    $todate = $todate === '' ? '9999-12-31' : $todate;
    $needToCallStoredProcedure = true;
    $table_name = $table_name_prefix . '_users';
    $sql = "SELECT value FROM $table_name3 WHERE status = 1 AND name = 'SHOW_ALL_VISITS_WHEN_NOT_SEARCH' LIMIT 1 ";
    $temp = $wpdb->get_results($sql);
    if(!empty($temp)) {
        $needToCallStoredProcedure = (($temp[0]->value) === '1' ? true : false);
    }	
    if($searchname !== '' || $searchvisitreason !== '' || $visittypeid > 0 || $visitstatus >= 0 || $fromdate !== '1000-01-01' || $todate !== '9999-12-31') {
        $needToCallStoredProcedure = true;
    }
    if($wpdb->use_mysqli) {
        if($wpdb->dbh->connect_error) {
            die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
        }
        $total = "0";
        $visits = array();

        $query = "SELECT name, value from $table_name3 WHERE status = 1";
        $stmt3 = $wpdb->dbh->prepare($query);
        $stmt3->execute();
        $myresult = $stmt3->get_result();
        $result3 = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
        $stmt3->close();

        if($needToCallStoredProcedure) {
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue);";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $wpprefix = $wpdb->prefix;
            $parameterArray[] = &$wpprefix;

            $types .= 'i'; //show all users' visits list
            $userid = -1;  //intval($current_user->data->ID);
            $parameterArray[] = &$userid;

            $types .= 'i';
            $parameterArray[] = &$visittypeid;

            $types .= 's';
            $parameterArray[] = &$searchname;

            $types .= 's';
            $parameterArray[] = &$searchvisitreason;

            $types .= 's';
            $parameterArray[] = &$fromdate;

            $types .= 's';
            $parameterArray[] = &$todate;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$visitstatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $visits = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($visits as $visit) {
                foreach ($visit as $key => $value) {
                    $visit[$key] = $value === null ? '' : deslash($value);
                }
            }
        }
        //error_log("at 641, visits: " . json_encode($visits));
        $result = [];
        $result["visit"] = $visits;
        $result["total"] = $total;
        $result["settings"] = $result3;
        //error_log("at 646, result: " . json_encode($result));
        return $result;
    }
    return [];
}

function dragonvisitzyx987_userCanReadInAdminPage()
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return false;
    }
    $userid = intval($current_user->data->ID);
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    if(count($results) !== 1) {return false;
    }
    if($results[0]->canreadinadminpage === '1') {
        return true;
    }
    return false;
}

function dragonvisitzyx987_userCanCreateInAdminPage()
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return false;
    }
    $userid = intval($current_user->data->ID);
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    if(count($results) !== 1) {return false;
    }
    if($results[0]->cancreateinadminpage === '1') {
        return true;
    }
    return false;
}

function dragonvisitzyx987_userCanEditInAdminPage()
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return false;
    }
    $userid = intval($current_user->data->ID);
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    if(count($results) !== 1) {return false;
    }
    if($results[0]->caneditinadminpage === '1') {
        return true;
    }
    return false;
}

function dragonvisitzyx987_userCanActivateInAdminPage()
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return false;
    }
    $userid = intval($current_user->data->ID);
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    if(count($results) !== 1) {return false;
    }
    if($results[0]->canactivateinadminpage === '1') {
        return true;
    }
    return false;
}

function dragonvisitzyx987_userCanDeactivateInAdminPage()
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return false;
    }
    $userid = intval($current_user->data->ID);
    $results = array();
    if(intval($userid) > 0) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 and userid = " . intval($userid));
        foreach($results as $result) {
            foreach($result as $key => $value) {
                $result->$key = deslash($value);
            }
        }
    }
    if(count($results) !== 1) {return false;
    }
    if($results[0]->candeactivateinadminpage === '1') {
        return true;
    }
    return false;
}

function dragonvisitzyx987_getAllVisits($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_visit';
    if($onlyActive) {    
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1");
    } else {
        $results = $wpdb->get_results("SELECT * FROM $table_name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_getAllVisitTypes($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_type';
    $table_name2 = 'wp_dragonvisitzyx987_typecategory';
    if($onlyActive) {
        $results = $wpdb->get_results("SELECT t.*,tc.name as typecategoryname FROM $table_name t JOIN $table_name2 tc ON t.typecategoryid = tc.id WHERE t.status = 1");
    } else {
        $results = $wpdb->get_results("SELECT t.*,tc.name as typecategoryname FROM $table_name t JOIN $table_name2 tc ON t.typecategoryid = tc.id ");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_validateTime($mytime)
{
    $timevalid = true;
    $dateOk=preg_match('/^[0-2][0-9][:][0-5][0-9]$/', $mytime);
    if(!$dateOk) {
        $timevalid = false;
    }
    $temp01 = floatval(str_replace(":", ".", $mytime));
    if($temp01 < 0 || $temp01 > 24.0) {
        $timevalid = false;
    }
    return $timevalid;
}

//only for admin page
add_action('wp_ajax_dragonvisitzyx987_getVisits', 'dragonvisitzyx987_getVisits');
function dragonvisitzyx987_getVisits()
{
    check_ajax_referer('dragonvisitzyx987_getVisits', 'dragonvisitzyx987_hidden_security_getvisits');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    //check user_role table to see if this user can read visits
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {echo 'You are not authorized to read visits. Please contact web admin.';exit();
    }

    if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getVisitList';

        $userid_temp = sanitize_text_field(strip_tags($_POST['userid']));
        $userid = empty($userid_temp) ? '-1' : $userid_temp;
        $userid = sanitize_text_field($userid);
        $userid = intval($userid);

        $visittypeid_temp = sanitize_text_field(strip_tags($_POST['visittypeid']));
        $visittypeid = empty($visittypeid_temp) ? '-1' : $visittypeid_temp;
        $visittypeid = sanitize_text_field($visittypeid);
        $visittypeid = intval($visittypeid);

        $mystatus_post = sanitize_text_field(strip_tags($_POST['mystatus']));
        $mystatus_temp = $mystatus_post === null ? '' : $mystatus_post;
        $mystatus_temp = sanitize_text_field($mystatus_temp);
        $mystatus = $mystatus_temp === '' ? 0 : intval($mystatus_temp);

        $amountperpage_temp = sanitize_text_field(strip_tags($_POST['amountperpage']));
        $amountperpage = empty($amountperpage_temp) ? '10' : $amountperpage_temp;
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);
        if($amountperpage === -1) {$amountperpage = 10;
        };

        $pagenumber_temp = sanitize_text_field(strip_tags($_POST['pagenumber']));
        $pagenumber = empty($pagenumber_temp) ? '1' : $pagenumber_temp;
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);
        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby_temp = sanitize_text_field(strip_tags($_POST['sortby']));
        $mysortby = empty($mysortby_temp) ? '' : $mysortby_temp;
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = dragonvisitzyx987_stripAllBackSlashes(trim($mysortby));
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder_temp = sanitize_text_field(strip_tags($_POST['order']));
        $myorder = empty($myorder_temp) ? '' : $myorder_temp;
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'desc' : $myorder;

        $fromdate_temp = sanitize_text_field(strip_tags($_POST['fromdate']));
        $fromdate = empty($fromdate_temp) ? '1000-01-01' : $fromdate_temp;
        $fromdate = sanitize_text_field($fromdate);

        $todate_temp = sanitize_text_field(strip_tags($_POST['todate']));
        $todate = empty($todate_temp) ? '9999-12-31' : $todate_temp;
        $todate = sanitize_text_field($todate);

        if(dragonvisitzyx987_validateDate($fromdate, 'Y-m-d') && dragonvisitzyx987_validateDate($todate, 'Y-m-d')) {
            if($fromdate > $todate) {
                echo "Error. From date is later than to date.";exit();
            }
        }else{
            echo "Error. Please enter a valid date.";exit();
        }

        $searchname_temp = (empty($_POST['searchname']) || trim($_POST['searchname']) === '') ? '' : strip_tags($_POST['searchname']);
        $searchname_temp = sanitize_text_field($searchname_temp);
        $searchname_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchname_temp);
        $searchname = trim($searchname_temp) === '' ? '' : $searchname_temp;

        $searchvisitreason_temp = (empty($_POST['searchvisitreason']) || trim($_POST['searchvisitreason']) === '') ? '' : strip_tags($_POST['searchvisitreason']);
        $searchvisitreason_temp = sanitize_text_field($searchvisitreason_temp);
        $searchvisitreason_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchvisitreason_temp);
        $searchvisitreason = trim($searchvisitreason_temp) === '' ? '' : $searchvisitreason_temp;
        
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }            
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue);";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $wpprefix = $wpdb->prefix;
            $parameterArray[] = &$wpprefix;

            $types .= 'i';
            //$userid = -1;  //intval($current_user->data->ID);
            $parameterArray[] = &$userid;

            $types .= 'i';
            $parameterArray[] = &$visittypeid;

            $types .= 's';
            $parameterArray[] = &$searchname;

            $types .= 's';
            $parameterArray[] = &$searchvisitreason;

            $types .= 's';
            $parameterArray[] = &$fromdate;

            $types .= 's';
            $parameterArray[] = &$todate;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$mystatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $visits = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach($visits as $visit) {
                foreach($visit as $key => $value) {
                    $visit[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["visit"] = $visits;
            $result["total"] = $total;
            //error_log("at 1001, result: " . json_encode($result));
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");    
    exit();
}

function dragonvisitzyx987_addTypecategory()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_addTypecategory') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanCreateInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to create data in admin page. Please contact web admin. ';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_typecategory';
        $name = trim(sanitize_text_field($_POST['dragonvisitzyx987_addtypecategoryname']));
        $description = trim(sanitize_text_field($_POST['dragonvisitzyx987_addtypecategorydescription']));        
        if($name === '') {$dragon_visit_dbResult .= 'Create a new type category: type category name is required. Not saved. ';return;
        }

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ?");
            $stmt->bind_param("s", $name);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {$dragon_visit_dbResult .= "Create a new type category: type category name \"" . $name . "\" already exists in the table. Not saved. ";return;
                }
            } else {
                $dragon_visit_dbResult .= "Create a new type category: type category name \"" . $name . "\" query has error. Not saved. ";return;
            }

            $query = "INSERT INTO " . $table_name . " (`name`,`description`,`createtimeutc`) VALUES (?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$name;

            $types .= 's';
            $parameterArray[] = &$description;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();

            if($myresult <= 0) {
                $dragon_visit_dbResult .= 'Error adding a type category into table ' . $table_name . ". ";return;
            }
        } else {
            $dragon_visit_dbResult .= 'Mysqli is not supported by your system. ';return;
        }
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_getAllTypecategories($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_typecategory';
    if($onlyActive) {    
        $results = $wpdb->get_results("SELECT * from $table_name WHERE status = 1 order by name");
    } else {
        $results = $wpdb->get_results("SELECT * from $table_name order by name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

add_action('wp_ajax_dragonvisitzyx987_saveTypecategory', 'dragonvisitzyx987_saveTypecategory');
function dragonvisitzyx987_saveTypecategory()
{
    check_ajax_referer('dragonvisitzyx987_saveTypecategory', 'dragonvisitzyx987_hidden_security_savetypecategory');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $typecategoryid = empty($_POST['id']) ? 0 : intval($_POST['id']);

        if($typecategoryid <= 0 || $_POST['status'] === null || $_POST['status'] === '') {
            echo "Invalid id.";exit();
        }

        $typecategoryname_temp = $_POST['name'] === null ? '' : strip_tags($_POST['name']);
        $typecategoryname_temp = sanitize_text_field($typecategoryname_temp);
        $typecategoryname = dragonvisitzyx987_stripAllBackSlashes($typecategoryname_temp);

        $typecategorydescription_temp = $_POST['description'] === null ? '' : strip_tags($_POST['description']);
        $typecategorydescription_temp = sanitize_text_field($typecategorydescription_temp);
        $typecategorydescription = dragonvisitzyx987_stripAllBackSlashes($typecategorydescription_temp);

        $typecategorystatus_temp = $_POST['status'] === null ? '' : strip_tags($_POST['status']);
        $typecategorystatus_temp = sanitize_text_field($typecategorystatus_temp);
        $typecategorystatus = $typecategorystatus_temp === '' ? 0 : intval($typecategorystatus_temp);

        if($typecategoryname === '' && $typecategorydescription === '' && $typecategorystatus !== 0 && $typecategorystatus !== 1) {
            echo "Please enter a value.";exit();
        }
        if($typecategoryname === '' || ($typecategorystatus !== 0 && $typecategorystatus !== 1)) {
            echo "Name and status are required.";exit();
        }
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_typecategory';
        $finalresult = 'Success';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? and id != ?");
            $stmt->bind_param("si", $typecategoryname, $typecategoryid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {echo "Edit a type category: type category name \"" . $typecategoryname . "\" already exists in the table. Not saved.";exit();
                }
            } else {
                echo "Edit a type category: type category name \"" . $typecategoryname . "\" query has error. Not saved.";exit();
            }

            $stmt=null;
            $sqlColumnsArray = array();
            if($rolename !== '') {
                $sqlColumnsArray['name|s'] = $typecategoryname;
            }
            $sqlColumnsArray['description|s'] = $typecategorydescription;
            if($typecategorystatus === 0 || $typecategorystatus === 1) {
                $sqlColumnsArray['status|i'] = $typecategorystatus;
            }
            if(count($sqlColumnsArray) > 0) {
                $query = "UPDATE $table_name SET ";
                $types = '';
                $parameterArray = array('');
                foreach($sqlColumnsArray as $key => $value) {
                    $temp = explode('|', $key, 2);

                    $types .= $temp[1];
                    $query .= ' ' . $temp[0] . ' = ?, ';
                    if($temp[0] === 'name') {
                        $parameterArray[] = &$typecategoryname;
                    } elseif($temp[0] === 'description') {
                        $parameterArray[] = &$typecategorydescription;
                    } elseif($temp[0] === 'status') {
                        $parameterArray[] = &$typecategorystatus;
                    }
                }
                $query .= " updatetimeutc = UTC_TIMESTAMP() WHERE id = ? ";
                $types .= 'i';
                $parameterArray[] = &$typecategoryid;
                $parameterArray[0] = $types;
                $stmt = $wpdb->dbh->prepare($query);
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult = 'Edit type category failed';
                }
                $stmt->close();
            } else {
                $finalresult = 'Nothing is updated';
            }
            echo $finalresult;
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

function dragonvisitzyx987_addType()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_addType') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanCreateInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to create data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_type';
        $name = sanitize_text_field($_POST['dragonvisitzyx987_addtypename']);
        $name = dragonvisitzyx987_stripAllBackSlashes($name);
        $description = sanitize_text_field($_POST['dragonvisitzyx987_addtypedescription']);
        $description = dragonvisitzyx987_stripAllBackSlashes($description);
        $typecategoryid = intval(sanitize_text_field($_POST['dragonvisitzyx987_addtypetypecategory']));

        if($name === '' || $typecategoryid < 1) {$dragon_visit_dbResult .= 'Create a new type: type category and type name are required. Not saved. ';return;
        }
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? and typecategoryid = ?");
            $stmt->bind_param("si", $name, $typecategoryid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {$dragon_visit_dbResult .= "Create a new type: type name \"" . $name . "\" already exists for that type category in the table. Not saved. ";return;
                }
            } else {
                $dragon_visit_dbResult .= "Create a new type: type name \"" . $name . "\" query has error. Not saved. ";return;
            }
            $query = "INSERT INTO " . $table_name . " (`typecategoryid`,`name`,`description`,`createtimeutc`) VALUES (?,?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$typecategoryid;

            $types .= 's';
            $parameterArray[] = &$name;

            $types .= 's';
            $parameterArray[] = &$description;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();

            if($myresult <= 0) {
                $dragon_visit_dbResult .= 'Error adding a type into table ' . $table_name . ". ";return;
            }
        } else {
            $dragon_visit_dbResult .= 'Mysqli is not supported by your system. ';return;
        }
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_getAllTypes($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_type';
    if($onlyActive) {
        $results = $wpdb->get_results("SELECT * from $table_name WHERE status = 1 order by name");
    } else {
        $results = $wpdb->get_results("SELECT * from $table_name order by name");
    }        
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

add_action('wp_ajax_dragonvisitzyx987_saveType', 'dragonvisitzyx987_saveType');
function dragonvisitzyx987_saveType()
{
    check_ajax_referer('dragonvisitzyx987_saveType', 'dragonvisitzyx987_hidden_security_savetype');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $typeid_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $typeid_temp = sanitize_text_field($typeid_temp);
        $typeid = intval($typeid_temp);
        
        if($typeid <= 0 || $_POST['status'] === null || $_POST['status'] === '') {echo "Invalid id.";exit();
        }

        $typename_temp = $_POST['name'] === null ? '' : strip_tags($_POST['name']);
        $typename_temp = sanitize_text_field($typename_temp);
        $typename = dragonvisitzyx987_stripAllBackSlashes($typename_temp);

        $typedescription_temp = $_POST['description'] === null ? '' : strip_tags($_POST['description']);
        $typedescription_temp = sanitize_text_field($typedescription_temp);
        $typedescription = dragonvisitzyx987_stripAllBackSlashes($typedescription_temp);

        $typecategoryid_temp = $_POST['typecategoryid'] === null ? '' : strip_tags($_POST['typecategoryid']);
        $typecategoryid_temp = sanitize_text_field($typecategoryid_temp);
        $typecategoryid = $typecategoryid_temp === '' ? 0 : intval($typecategoryid_temp);

        $typestatus_temp = $_POST['status'] === null ? '' : strip_tags($_POST['status']);
        $typestatus_temp = sanitize_text_field($typestatus_temp);
        $typestatus = $typestatus_temp === '' ? 0 : intval($typestatus_temp);

        if($typename === '' && $typedescription === '' && $typecategoryid <= 0 && ($typestatus !== 0 && $typestatus !== 1)) {
            echo "Please enter a value.";exit();
        }
        if($typename === '' || ($typestatus !== 0 && $typestatus !== 1) || $typecategoryid <= 0) {
            echo "Name, type category, and status are required.";exit();
        }

        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_type';
        $finalresult = 'Success';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? and id != ?");
            $stmt->bind_param("si", $typename, $typeid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {echo "Edit a type: type name \"" . esc_html($typename) . "\" already exists in the table. Not saved.";exit();
                }
            } else {
                echo "Edit a type: type name \"" . esc_html($typename) . "\" query has error. Not saved.";exit();
            }

            $stmt=null;
            $sqlColumnsArray = array();
            if($rolename !== '') {
                $sqlColumnsArray['name|s'] = $typename;
            }
            $sqlColumnsArray['description|s'] = $typedescription;
            if($typecategoryid > 0) {
                $sqlColumnsArray['typecategoryid|i'] = $typecategoryid;
            }
            if($typestatus === 0 || $typestatus === 1) {
                $sqlColumnsArray['status|i'] = $typestatus;
            }
            if(count($sqlColumnsArray) > 0) {
                $query = "UPDATE $table_name SET ";
                $types = '';
                $parameterArray = array('');
                foreach($sqlColumnsArray as $key => $value) {
                    $temp = explode('|', $key, 2);

                    $types .= $temp[1];
                    $query .= ' ' . $temp[0] . ' = ?, ';
                    if($temp[0] === 'name') {
                        $parameterArray[] = &$typename;
                    } elseif($temp[0] === 'description') {
                        $parameterArray[] = &$typedescription;
                    } elseif($temp[0] === 'typecategoryid') {
                        if($typecategoryid > 0) {
                            $parameterArray[] = &$typecategoryid;
                        }
                    } elseif($temp[0] === 'status') {
                        $parameterArray[] = &$typestatus;
                    }
                }
                $query .= " updatetimeutc = UTC_TIMESTAMP() WHERE id = ? ";
                $types .= 'i';
                $parameterArray[] = &$typeid;                
                $parameterArray[0] = $types;    
                $stmt = $wpdb->dbh->prepare($query);
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult = 'Edit type failed';
                }
                $stmt->close();
            } else {
                $finalresult = 'Nothing is updated';
            }
            echo esc_html($finalresult);
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

function dragonvisitzyx987_addRole()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_addRole') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanCreateInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to create data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {    
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_role';
        $name = sanitize_text_field($_POST['dragonvisitzyx987_addrolename']);
        $name = dragonvisitzyx987_stripAllBackSlashes($name);
        $description = sanitize_text_field($_POST['dragonvisitzyx987_addroledescription']);
        $description = dragonvisitzyx987_stripAllBackSlashes($description);
        if($name === '') {$dragon_visit_dbResult .= 'Create a new role: role name are required. Not saved. ';return;
        }
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? ");
            $stmt->bind_param("s", $name);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {$dragon_visit_dbResult .= "Create a new role: role name \"" . $name . "\" already exists in the table. Not saved. ";return;
                }
            } else {
                $dragon_visit_dbResult .= "Create a new role: role name \"" . $name . "\" query has error. Not saved. ";return;
            }
            $query = "INSERT INTO " . $table_name . " (`name`,`description`,`createtimeutc`) VALUES (?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$name;

            $types .= 's';
            $parameterArray[] = &$description;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();

            if($myresult <= 0) {
                $dragon_visit_dbResult .= 'Error adding a role into table ' . $table_name . ". ";return;
            }
        } else {
            $dragon_visit_dbResult .= 'Mysqli is not supported by your system. ';return;
        }
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

add_action('wp_ajax_dragonvisitzyx987_saveRole', 'dragonvisitzyx987_saveRole');
function dragonvisitzyx987_saveRole()
{
    check_ajax_referer('dragonvisitzyx987_saveRole', 'dragonvisitzyx987_hidden_security_saverole');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $roleid_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $roleid_temp = sanitize_text_field($roleid_temp);
        $roleid = intval($roleid_temp);

        if($roleid <= 0 || $_POST['status'] === null || $_POST['status'] === '') {echo "Invalid id.";exit();
        }

        $rolename_temp = $_POST['name'] === null ? '' : strip_tags($_POST['name']);
        $rolename_temp = sanitize_text_field($rolename_temp);
        $rolename = dragonvisitzyx987_stripAllBackSlashes($rolename_temp);

        $roledescription_temp = $_POST['description'] === null ? '' : strip_tags($_POST['description']);
        $roledescription_temp = sanitize_text_field($roledescription_temp);
        $roledescription = dragonvisitzyx987_stripAllBackSlashes($roledescription_temp);

        $rolestatus_temp = $_POST['status'] === null ? '' : strip_tags($_POST['status']);
        $rolestatus_temp = sanitize_text_field($rolestatus_temp);
        $rolestatus = $rolestatus_temp === '' ? 0 : intval($rolestatus_temp);

        if($rolename === '' && $roledescription === '' && $rolestatus !== 0 && $rolestatus !== 1) {
            echo "Please enter a value.";exit();
        }
        if($rolename === '' || ($rolestatus !== 0 && $rolestatus !== 1)) {
            echo "Name and status are required.";exit();
        }
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_role';
        $finalresult = 'Success';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? and id != ?");
            $stmt->bind_param("si", $departmentname, $departmentid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {echo "Edit a role: role name \"" . $rolename . "\" already exists in the table. Not saved.";exit();
                }
            } else {
                echo "Edit a role: role name \"" . $rolename . "\" query has error. Not saved.";exit();
            }

            $stmt=null;
            $sqlColumnsArray = array();
            if($rolename !== '') {
                $sqlColumnsArray['name|s'] = $rolename;
            }
            $sqlColumnsArray['description|s'] = $roledescription;
            if($rolestatus === 0 || $rolestatus === 1) {
                $sqlColumnsArray['status|i'] = $rolestatus;
            }
            if(count($sqlColumnsArray) > 0) {
                $query = "UPDATE $table_name SET ";
                $types = '';
                $parameterArray = array('');
                foreach($sqlColumnsArray as $key => $value) {
                    $temp = explode('|', $key, 2);

                    $types .= $temp[1];
                    $query .= ' ' . $temp[0] . ' = ?, ';
                    if($temp[0] === 'name') {
                        $parameterArray[] = &$rolename;
                    } elseif($temp[0] === 'description') {
                        $parameterArray[] = &$roledescription;
                    } elseif($temp[0] === 'status') {
                        $parameterArray[] = &$rolestatus;
                    }
                }
                $query .= " updatetimeutc = UTC_TIMESTAMP() WHERE id = ? ";
                $types .= 'i';
                $parameterArray[] = &$roleid;
                $parameterArray[0] = $types;
                $stmt = $wpdb->dbh->prepare($query);
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult = 'Edit role failed';
                }
                $stmt->close();
            } else {
                $finalresult = 'Nothing is updated';
            }
            echo $finalresult;
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

function dragonvisitzyx987_getAllRoles($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_role';
    if($onlyActive) {
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1");
    } else {
        $results = $wpdb->get_results("SELECT * FROM $table_name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_getAllWPUsers($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $prefix = $wpdb->prefix;
    $table_name = $prefix . 'users';
    $table_name2 = $prefix . 'usermeta';
    $query = "SELECT u.*, concat(IFNULL(m.meta_value, ''), ' ', IFNULL(m2.meta_value, '')) 'fullname' FROM $table_name u "
             . " LEFT JOIN $table_name2 m "
             . " ON u.ID = m.user_id "
             . " AND m.meta_key = 'first_name' "
             . " LEFT JOIN $table_name2 m2 "
             . " ON u.ID = m2.user_id "
             . " AND m2.meta_key = 'last_name' order by fullname";
    if($onlyActive) {
        $results = $wpdb->get_results($query);
    } else {
        $results = $wpdb->get_results($query);        
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_getAllUsers($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = "wp_dragonvisitzyx987_users";
    if($onlyActive) {    
        $results = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1");
    } else {
        $results = $wpdb->get_results("SELECT * FROM $table_name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

add_action('wp_ajax_dragonvisitzyx987_getUsertypes', 'dragonvisitzyx987_getUsertypes');
function dragonvisitzyx987_getUsertypes()
{
    check_ajax_referer('dragonvisitzyx987_getUsertypes', 'dragonvisitzyx987_hidden_security_getusertypes');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    //check wp_dragonvisitzyx987_users table to see if this user can read data in admin page
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {    
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getUsertypeList';

        $userid_temp = empty($_POST['userid']) ? '-1' : strip_tags($_POST['userid']);
        $userid_temp = sanitize_text_field($userid_temp);
        $userid = intval($userid_temp);

        $mystatus = -1;

        $typeid_temp = empty($_POST['typeid']) ? '-1' : strip_tags($_POST['typeid']);
        $typeid_temp = sanitize_text_field($typeid_temp);
        $typeid = intval($typeid_temp);

        $typecategoryid_temp = empty($_POST['typecategoryid']) ? '-1' : strip_tags($_POST['typecategoryid']);
        $typecategoryid_temp = sanitize_text_field($typecategoryid_temp);
        $typecategoryid = intval($typecategoryid_temp);

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);
        if($amountperpage === -1) {$amountperpage = 10;
        };

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);;
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);
        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'userid' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $searchuserlogin_temp = (empty($_POST['loginname']) || trim($_POST['loginname']) === '') ? '' : strip_tags($_POST['loginname']);
        $searchuserlogin_temp = sanitize_text_field($searchuserlogin_temp);
        $searchuserlogin_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchuserlogin_temp);
        $searchuserlogin = trim($searchuserlogin_temp) === '' ? '' : $searchuserlogin_temp;

        $searchfullname_temp = (empty($_POST['fullname']) || trim($_POST['fullname']) === '') ? '' : strip_tags($_POST['fullname']);
        $searchfullname_temp = sanitize_text_field($searchfullname_temp);
        $searchfullname_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchfullname_temp);
        $searchfullname = trim($searchfullname_temp) === '' ? '' : $searchfullname_temp;

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue);";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;
            
            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $wpprefix = $wpdb->prefix;
            $parameterArray[] = &$wpprefix;

            $types .= 'i';
            $parameterArray[] = &$userid;

            $types .= 'i';
            $parameterArray[] = &$typeid;

            $types .= 'i';
            $parameterArray[] = &$typecategoryid;

            $types .= 's';
            $parameterArray[] = &$searchuserlogin;

            $types .= 's';
            $parameterArray[] = &$searchfullname;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$mystatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $usertypes = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach($usertypes as $usertype) {
                foreach($usertype as $key => $value) {                
                    $usertype[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["usertype"] = $usertypes;
            $result["total"] = $total;
            //error_log("at 1827, result: " . json_encode($result));
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");    
    exit();
}

function dragonvisitzyx987_addUser()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_addUser') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanCreateInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to create data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_users';         
        $firstname = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserfirstname']));
        $lastname = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserlastname']));

        $userid_temp = empty($_POST['dragonvisitzyx987_adduserid']) ? '-1' : strip_tags($_POST['dragonvisitzyx987_adduserid']);
        $userid_temp = sanitize_text_field($userid_temp);
        $userid = intval($userid_temp);

        $canreadinadminpage_temp = empty($_POST['dragonvisitzyx987_addusercanreadinadminpage']) ? '0' : strip_tags($_POST['dragonvisitzyx987_addusercanreadinadminpage']);
        $canreadinadminpage_temp = sanitize_text_field($canreadinadminpage_temp);
        $canreadinadminpage = intval($canreadinadminpage_temp);
        if($canreadinadminpage === -1) {$canreadinadminpage = 0;
        }

        $cancreateinadminpage_temp = empty($_POST['dragonvisitzyx987_addusercancreateinadminpage']) ? '0' : strip_tags($_POST['dragonvisitzyx987_addusercancreateinadminpage']);
        $cancreateinadminpage_temp = sanitize_text_field($cancreateinadminpage_temp);
        $cancreateinadminpage = intval($cancreateinadminpage_temp);
        if($cancreateinadminpage === -1) {$cancreateinadminpage = 0;
        }

        $caneditinadminpage_temp = empty($_POST['dragonvisitzyx987_addusercaneditinadminpage']) ? '0' : strip_tags($_POST['dragonvisitzyx987_addusercaneditinadminpage']);
        $caneditinadminpage_temp = sanitize_text_field($caneditinadminpage_temp);
        $caneditinadminpage = intval($caneditinadminpage_temp);
        if($caneditinadminpage === -1) {$caneditinadminpage = 0;
        }

        $canactivateinadminpage_temp = empty($_POST['dragonvisitzyx987_addusercanactivateinadminpage']) ? '0' : strip_tags($_POST['dragonvisitzyx987_addusercanactivateinadminpage']);
        $canactivateinadminpage_temp = sanitize_text_field($canactivateinadminpage_temp);
        $canactivateinadminpage = intval($canactivateinadminpage_temp);
        if($canactivateinadminpage === -1) {$canactivateinadminpage = 0;
        }

        $candeactivateinadminpage_temp = empty($_POST['dragonvisitzyx987_addusercandeactivateinadminpage']) ? '0' : strip_tags($_POST['dragonvisitzyx987_addusercandeactivateinadminpage']);
        $candeactivateinadminpage_temp = sanitize_text_field($candeactivateinadminpage_temp);
        $candeactivateinadminpage = intval($candeactivateinadminpage_temp);
        if($candeactivateinadminpage === -1) {$candeactivateinadminpage = 0;
        }

        $reportto_temp = empty($_POST['dragonvisitzyx987_adduserreportto']) ? '-1' : strip_tags($_POST['dragonvisitzyx987_adduserreportto']);
        $reportto_temp = sanitize_text_field($reportto_temp);
        $reportto = intval($reportto_temp);

        $role_temp = empty($_POST['dragonvisitzyx987_adduserrole']) ? '-1' : strip_tags($_POST['dragonvisitzyx987_adduserrole']);
        $role_temp = sanitize_text_field($role_temp);
        $role = intval($role_temp);
        if($role <= 0) {$role = null;
        }

        $department_temp = empty($_POST['dragonvisitzyx987_adduserdepartment']) ? '-1' : strip_tags($_POST['dragonvisitzyx987_adduserdepartment']);
        $department_temp = sanitize_text_field($department_temp);
        $department = intval($department_temp);
        if($department <= 0) {$department = null;
        }

        $status_temp = $_POST['dragonvisitzyx987_adduserstatus'] === null ? '' : strip_tags($_POST['dragonvisitzyx987_adduserstatus']);
        $status_temp = sanitize_text_field($status_temp);
        $status = $status_temp === '' ? 0 : intval($status_temp);
        if($status === -1) {$status = 1;
        }

        $email = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduseremail']));
        if($email === '') {$email = null;
        }
        $phone = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserphone']));
        if($phone === '') {$phone = null;
        }
        $address = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduseraddress']));
        if($address === '') {$address = null;
        }
        $address2 = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduseraddress2']));
        if($address2 === '') {$address2 = null;
        }
        $city = trim(sanitize_text_field($_POST['dragonvisitzyx987_addusercity']));
        if($city === '') {$city = null;
        }
        $province = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserprovince']));
        if($province === '') {$province = null;
        }
        $country = trim(sanitize_text_field($_POST['dragonvisitzyx987_addusercountry']));
        if($country === '') {$country = null;
        }
        $zip = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserzip']));
        if($zip === '') {$zip = null;
        }
        $description = trim(sanitize_text_field($_POST['dragonvisitzyx987_adduserdescription']));
        if($description === '') {$description = null;
        }
        
        if($firstname === '' || $lastname === '' || $userid <= 0 || $reportto <= 0) {$dragon_visit_dbResult .= 'Create a new user: User first name, last name, user id, and report to id are required. Not saved. ';return;
        }

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE userid = ?");
            $stmt->bind_param("i", $userid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {$dragon_visit_dbResult .= "Create a new user: user id " . $userid . " already exists in the table. Not saved. ";return;
                }
            } else {
                $dragon_visit_dbResult .= "Create a new user: user id " . $userid . " query has error. Not saved. ";return;
            }

            $query = "INSERT INTO $table_name (`userid`,`firstname`,`lastname`,`phone`,`address`,`address2`,`city`,`province`,`country`,`zip`,`reportto`,`email`,`description`,`departmentid`,`roleid`,`canreadinadminpage`,`cancreateinadminpage`,`caneditinadminpage`,`canactivateinadminpage`,`candeactivateinadminpage`,`status`,`createtimeutc`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$userid;

            $types .= 's';
            $parameterArray[] = &$firstname;

            $types .= 's';
            $parameterArray[] = &$lastname;

            $types .= 's';
            $parameterArray[] = &$phone;

            $types .= 's';
            $parameterArray[] = &$address;

            $types .= 's';
            $parameterArray[] = &$address2;

            $types .= 's';
            $parameterArray[] = &$city;

            $types .= 's';
            $parameterArray[] = &$province;

            $types .= 's';
            $parameterArray[] = &$country;

            $types .= 's';
            $parameterArray[] = &$zip;

            $types .= 'i';
            $parameterArray[] = &$reportto;

            $types .= 's';
            $parameterArray[] = &$email;

            $types .= 's';
            $parameterArray[] = &$description;

            $types .= 'i';
            $parameterArray[] = &$departmentid;

            $types .= 'i';
            $parameterArray[] = &$roleid;

            $types .= 'i';
            $parameterArray[] = &$canreadinadminpage;

            $types .= 'i';
            $parameterArray[] = &$cancreateinadminpage;

            $types .= 'i';
            $parameterArray[] = &$caneditinadminpage;

            $types .= 'i';
            $parameterArray[] = &$canactivateinadminpage;

            $types .= 'i';
            $parameterArray[] = &$candeactivateinadminpage;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();

            if($myresult <= 0) {
                $dragon_visit_dbResult .= 'Error adding a user into table ' . $table_name . ". ";return;
            }
        } else {
            $dragon_visit_dbResult .= 'Mysqli is not supported by your system. ';return;
        }
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

add_action('wp_ajax_dragonvisitzyx987_saveUser', 'dragonvisitzyx987_saveUser');
function dragonvisitzyx987_saveUser()
{
    check_ajax_referer('dragonvisitzyx987_saveUser', 'dragonvisitzyx987_hidden_security_saveuser');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $firstname_temp = $_POST['firstname'] === null ? '' : strip_tags($_POST['firstname']);
        $firstname_temp = sanitize_text_field($firstname_temp);
        $firstname = dragonvisitzyx987_stripAllBackSlashes($firstname_temp);

        $lastname_temp = $_POST['lastname'] === null ? '' : strip_tags($_POST['lastname']);
        $lastname_temp = sanitize_text_field($lastname_temp);
        $lastname = dragonvisitzyx987_stripAllBackSlashes($lastname_temp);

        //record id
        $id_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $id_temp = sanitize_text_field($id_temp);
        $id = intval($id_temp);

        //new user id
        $userid_temp = empty($_POST['userid']) ? 0 : strip_tags($_POST['userid']);
        $userid_temp = sanitize_text_field($userid_temp);
        $userid = intval($userid_temp);

        $reportto_temp = empty($_POST['reportto']) ? 0 : strip_tags($_POST['reportto']);
        $reportto_temp = sanitize_text_field($reportto_temp);
        $reportto = intval($reportto_temp);

        $status_temp = $_POST['status'] === null ? '' : strip_tags($_POST['status']);
        $status_temp = sanitize_text_field($status_temp);
        $status = $status_temp === '' ? 0 : intval($status_temp);

        if($firstname === '' || $lastname === '' || $id <= 0 || $userid <= 0 || $reportto <= 0 || ($status !== 0 && $status !== 1)) {echo "First name, last name, user id, report to id, and status are required.";exit();
        }

        $canreadinadminpage_temp = empty($_POST['canreadinadminpage']) ? '-1' : strip_tags($_POST['canreadinadminpage']);
        $canreadinadminpage_temp = sanitize_text_field($canreadinadminpage_temp);
        $canreadinadminpage = intval($canreadinadminpage_temp);
        if($canreadinadminpage === -1) {$canreadinadminpage=0;
        }

        $cancreateinadminpage_temp = empty($_POST['cancreateinadminpage']) ? '-1' : strip_tags($_POST['cancreateinadminpage']);
        $cancreateinadminpage_temp = sanitize_text_field($cancreateinadminpage_temp);
        $cancreateinadminpage = intval($cancreateinadminpage_temp);
        if($cancreateinadminpage === -1) {$cancreateinadminpage=0;
        }

        $caneditinadminpage_temp = empty($_POST['caneditinadminpage']) ? '-1' : strip_tags($_POST['caneditinadminpage']);
        $caneditinadminpage_temp = sanitize_text_field($caneditinadminpage_temp);
        $caneditinadminpage = intval($caneditinadminpage_temp);
        if($caneditinadminpage === -1) {$caneditinadminpage=0;
        }

        $canactivateinadminpage_temp = empty($_POST['canactivateinadminpage']) ? '-1' : strip_tags($_POST['canactivateinadminpage']);
        $canactivateinadminpage_temp = sanitize_text_field($canactivateinadminpage_temp);
        $canactivateinadminpage = intval($canactivateinadminpage_temp);
        if($canactivateinadminpage === -1) {$canactivateinadminpage=0;
        }

        $candeactivateinadminpage_temp = empty($_POST['candeactivateinadminpage']) ? '-1' : strip_tags($_POST['candeactivateinadminpage']);
        $candeactivateinadminpage_temp = sanitize_text_field($candeactivateinadminpage_temp);
        $candeactivateinadminpage = intval($candeactivateinadminpage_temp);    
        if($candeactivateinadminpage === -1) {$candeactivateinadminpage=0;
        }

        $roleid_temp = empty($_POST['roleid']) ? 0 : strip_tags($_POST['roleid']);
        $roleid_temp = sanitize_text_field($roleid_temp);
        $roleid = intval($roleid_temp);

        $departmentid_temp = empty($_POST['departmentid']) ? 0 : strip_tags($_POST['departmentid']);
        $departmentid_temp = sanitize_text_field($departmentid_temp);
        $departmentid = intval($departmentid_temp);

        $email_temp = $_POST['email'] === null ? '' : strip_tags($_POST['email']);
        $email_temp = sanitize_text_field($email_temp);
        $email = dragonvisitzyx987_stripAllBackSlashes($email_temp);

        $phone_temp = $_POST['phone'] === null ? '' : strip_tags($_POST['phone']);
        $phone_temp = sanitize_text_field($phone_temp);
        $phone = dragonvisitzyx987_stripAllBackSlashes($phone_temp);

        $address_temp = $_POST['address'] === null ? '' : strip_tags($_POST['address']);
        $address_temp = sanitize_text_field($address_temp);
        $address = dragonvisitzyx987_stripAllBackSlashes($address_temp);

        $address2_temp = $_POST['address2'] === null ? '' : strip_tags($_POST['address2']);
        $address2_temp = sanitize_text_field($address2_temp);
        $address2 = dragonvisitzyx987_stripAllBackSlashes($address2_temp);

        $city_temp = $_POST['city'] === null ? '' : strip_tags($_POST['city']);
        $city_temp = sanitize_text_field($city_temp);
        $city = dragonvisitzyx987_stripAllBackSlashes($city_temp);

        $province_temp = $_POST['province'] === null ? '' : strip_tags($_POST['province']);
        $province_temp = sanitize_text_field($province_temp);
        $province = dragonvisitzyx987_stripAllBackSlashes($province_temp);

        $country_temp = $_POST['country'] === null ? '' : strip_tags($_POST['country']);
        $country_temp = sanitize_text_field($country_temp);
        $country = dragonvisitzyx987_stripAllBackSlashes($country_temp);

        $zip_temp = $_POST['zip'] === null ? '' : strip_tags($_POST['zip']);
        $zip_temp = sanitize_text_field($zip_temp);
        $zip = dragonvisitzyx987_stripAllBackSlashes($zip_temp);

        $description_temp = $_POST['description'] === null ? '' : strip_tags($_POST['description']);
        $description_temp = sanitize_text_field($description_temp);
        $description = dragonvisitzyx987_stripAllBackSlashes($description_temp);

        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_users';
        $finalresult = 'Success';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE id = ? OR userid = ?");
            $stmt->bind_param("ii", $id, $userid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 1) {echo "Edit a user: id $id or user id $userid record(s) exist(s) $dbcount time(s) in the $table_name table. Not saved.";exit();
                }
            } else {
                echo "Edit a user: id $id, user id $userid query has error. Not saved.";exit();
            }

            $stmt=null;
            $sqlColumnsArray = array();
            if($firstname !== '') {
                $sqlColumnsArray['firstname|s'] = $firstname;
            }
            if($lastname !== '') {
                $sqlColumnsArray['lastname|s'] = $lastname;
            }
            if($userid > 0) {
                $sqlColumnsArray['userid|i'] = $userid;
            }
            if($reportto > 0) {
                $sqlColumnsArray['reportto|i'] = $reportto;
            }
            if($canreadinadminpage === 0 || $canreadinadminpage === 1) {
                $sqlColumnsArray['canreadinadminpage|i'] = $canreadinadminpage;
            }
            if($cancreateinadminpage === 0 || $cancreateinadminpage === 1) {
                $sqlColumnsArray['cancreateinadminpage|i'] = $cancreateinadminpage;
            }
            if($caneditinadminpage === 0 || $caneditinadminpage === 1) {
                $sqlColumnsArray['caneditinadminpage|i'] = $caneditinadminpage;    
            }
            if($canactivateinadminpage === 0 || $canactivateinadminpage === 1) {
                $sqlColumnsArray['canactivateinadminpage|i'] = $canactivateinadminpage;
            }
            if($candeactivateinadminpage === 0 || $candeactivateinadminpage === 1) {
                $sqlColumnsArray['candeactivateinadminpage|i'] = $candeactivateinadminpage;
            }
            $sqlColumnsArray['roleid|i'] = $roleid;
            $sqlColumnsArray['departmentid|i'] = $departmentid;
            $sqlColumnsArray['email|s'] = $email;
            $sqlColumnsArray['phone|s'] = $phone;
            $sqlColumnsArray['address|s'] = $address;
            $sqlColumnsArray['address2|s'] = $address2;
            $sqlColumnsArray['city|s'] = $city;
            $sqlColumnsArray['province|s'] = $province;
            $sqlColumnsArray['country|s'] = $country;
            $sqlColumnsArray['zip|s'] = $zip;
            $sqlColumnsArray['description|s'] = $description;
            if($status === 0 || $status === 1) {
                $sqlColumnsArray['status|i'] = $status;
            }

            if(count($sqlColumnsArray) > 0) {
                $query = "UPDATE $table_name SET ";
                $types = '';
                $parameterArray = array('');
                foreach($sqlColumnsArray as $key => $value) {
                    $temp = explode('|', $key, 2);
                    if($temp[0] === 'roleid' && $sqlColumnsArray['roleid|i'] <= 0) {
                        $query .= ' ' . $temp[0] . ' = null, ';
                    } elseif($temp[0] === 'departmentid' && $sqlColumnsArray['departmentid|i'] <= 0) {
                        $query .= ' ' . $temp[0] . ' = null, ';
                    } else {
                        $types .= $temp[1];
                        $query .= ' ' . $temp[0] . ' = ?, ';
                    }

                    if($temp[0] === 'roleid') {
                        if($sqlColumnsArray['roleid|i'] > 0) {
                            $parameterArray[] = &$sqlColumnsArray['roleid|i'];
                        }
                    } elseif($temp[0] === 'departmentid') {
                        if($sqlColumnsArray['departmentid|i'] > 0) {
                            $parameterArray[] = &$sqlColumnsArray['departmentid|i'];
                        }
                    } else {
                        $parameterArray[] = &$sqlColumnsArray[$key];
                    }
                }
                $query .= " updatetimeutc = UTC_TIMESTAMP() WHERE userid = ? ";
                $types .= 'i';
                $parameterArray[] = &$userid;                
                $parameterArray[0] = $types;    
                $stmt = $wpdb->dbh->prepare($query);
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult = 'Edit user failed';
                }
                $stmt->close();
            } else {
                $finalresult = 'Nothing is updated';
            }
            echo $finalresult;
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getUsers', 'dragonvisitzyx987_getUsers');
function dragonvisitzyx987_getUsers()
{
    check_ajax_referer('dragonvisitzyx987_getUsers', 'dragonvisitzyx987_hidden_security_getusers');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");    
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getUserList';

        $userid = (!isset($_POST['userid'])) ? '-1' : strip_tags($_POST['userid']);
        $userid = sanitize_text_field($userid);
        $userid = intval($userid);

        $userstatus = (!isset($_POST['userstatus'])) ? '-1' : strip_tags($_POST['userstatus']);
        $userstatus = sanitize_text_field($userstatus);
        $userstatus = intval($userstatus);    

        $amountperpage_temp = sanitize_text_field(strip_tags($_POST['amountperpage']));
        $amountperpage = empty($amountperpage_temp) ? '10' : $amountperpage_temp;
        $amountperpage = intval($amountperpage);
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber_temp = sanitize_text_field(strip_tags($_POST['pagenumber']));
        $pagenumber = empty($pagenumber_temp) ? '1' : $pagenumber_temp;;
        $pagenumber = intval($pagenumber);

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby_temp = sanitize_text_field(strip_tags($_POST['sortby']));
        $mysortby = empty($mysortby_temp) ? '' : $mysortby_temp;
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder_temp = sanitize_text_field(strip_tags($_POST['order']));
        $myorder = empty($myorder_temp) ? '' : $myorder_temp;
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $userfullname = empty($_POST['userfullname']) ? '' : strip_tags($_POST['userfullname']);
        $userfullname = sanitize_text_field($userfullname);
        $email = empty($_POST['email']) ? '' : strip_tags($_POST['email']);
        $email = sanitize_text_field($email);

        $reportto = (!isset($_POST['reportto'])) ? '-1' : strip_tags($_POST['reportto']);
        $reportto = sanitize_text_field($reportto);
        $reportto = intval($reportto);

        $canreadinadminpage = (!isset($_POST['canreadinadminpage'])) ? '-1' : strip_tags($_POST['canreadinadminpage']);
        $canreadinadminpage = sanitize_text_field($canreadinadminpage);
        $canreadinadminpage = intval($canreadinadminpage);
        if($canreadinadminpage !== 0 && $canreadinadminpage !== 1 && $canreadinadminpage !== -1) {$canreadinadminpage = -1;
        }

        $cancreateinadminpage = (!isset($_POST['cancreateinadminpage'])) ? '-1' : strip_tags($_POST['cancreateinadminpage']);
        $cancreateinadminpage = sanitize_text_field($cancreateinadminpage);
        $cancreateinadminpage = intval($cancreateinadminpage);
        if($cancreateinadminpage !== 0 && $cancreateinadminpage !== 1 && $cancreateinadminpage !== -1) {$cancreateinadminpage = 0;
        }

        $caneditinadminpage = (!isset($_POST['caneditinadminpage'])) ? '-1' : strip_tags($_POST['caneditinadminpage']);
        $caneditinadminpage = sanitize_text_field($caneditinadminpage);
        $caneditinadminpage = intval($caneditinadminpage);
        if($caneditinadminpage !== 0 && $caneditinadminpage !== 1 && $caneditinadminpage !== -1) {$caneditinadminpage = 0;
        }

        $canactivateinadminpage = (!isset($_POST['canactivateinadminpage'])) ? '-1' : strip_tags($_POST['canactivateinadminpage']);
        $canactivateinadminpage = sanitize_text_field($canactivateinadminpage);
        $canactivateinadminpage = intval($canactivateinadminpage);
        if($canactivateinadminpage !== 0 && $canactivateinadminpage !== 1 && $canactivateinadminpage !== -1) {$canactivateinadminpage = 0;
        }

        $candeactivateinadminpage = (!isset($_POST['candeactivateinadminpage'])) ? '-1' : strip_tags($_POST['candeactivateinadminpage']);
        $candeactivateinadminpage = sanitize_text_field($candeactivateinadminpage);
        $candeactivateinadminpage = intval($candeactivateinadminpage);
        if($candeactivateinadminpage !== 0 && $candeactivateinadminpage !== 1 && $candeactivateinadminpage !== -1) {$candeactivateinadminpage = 0;
        }

        $roleid = (!isset($_POST['roleid'])) ? '-1' : strip_tags($_POST['roleid']);
        $roleid = sanitize_text_field($roleid);
        $roleid = intval($roleid);

        $departmentid = (!isset($_POST['departmentid'])) ? '-1' : strip_tags($_POST['departmentid']);
        $departmentid = sanitize_text_field($departmentid);
        $departmentid = intval($departmentid);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 'i';
            $parameterArray[] = &$userid;

            $types .= 's';
            $parameterArray[] = &$userfullname;

            $types .= 's';
            $parameterArray[] = &$email;

            $types .= 'i';
            $parameterArray[] = &$reportto;

            $types .= 'i';
            $parameterArray[] = &$canreadinadminpage;

            $types .= 'i';
            $parameterArray[] = &$cancreateinadminpage;

            $types .= 'i';
            $parameterArray[] = &$caneditinadminpage;

            $types .= 'i';
            $parameterArray[] = &$canactivateinadminpage;

            $types .= 'i';
            $parameterArray[] = &$candeactivateinadminpage;

            $types .= 'i';
            $parameterArray[] = &$roleid;

            $types .= 'i';
            $parameterArray[] = &$departmentid;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$userstatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $users = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($users as $user) {
                foreach ($user as $key => $value) {
                    $user[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["user"] = $users;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

function dragonvisitzyx987_addDepartment()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_addDepartment') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanCreateInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to create data in admin page. Please contact web admin.';
        return;        
    }    
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_department';
        $name = trim(sanitize_text_field($_POST['dragonvisitzyx987_adddepartmentname']));
        $description = trim(sanitize_text_field($_POST['dragonvisitzyx987_adddepartmentdescription']));

        if($name === '') {$dragon_visit_dbResult .= 'Create a new department: Department name is required. Not saved. ';return;
        }

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ?");
            $stmt->bind_param("s", $name);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {$dragon_visit_dbResult .= "Create a new department: department name \"" . $name . "\" already exists in the table. Not saved. ";return;
                }
            } else {
                $dragon_visit_dbResult .= "Create a new department: department name \"" . $name . "\" query has error. Not saved. ";return;
            }

            $query = "INSERT INTO " . $table_name . " (`name`,`description`,`createtimeutc`) VALUES (?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$name;

            $types .= 's';
            $parameterArray[] = &$description;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();

            if($myresult <= 0) {
                $dragon_visit_dbResult .= 'Error adding a department into table ' . $table_name . ". ";return;
            }
        } else {
            $dragon_visit_dbResult .= 'Mysqli is not supported by your system. ';return;
        }
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }    
}

function dragonvisitzyx987_getAllSettings($onlyActive = false) {
    global $wpdb; global $dragon_visit_dbResult; $results;
    require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
    $table_name = 'wp_dragonvisitzyx987_constant';
    if($onlyActive) {
        $results = $wpdb->get_results("SELECT * from $table_name WHERE status = 1 order by name");
    } else {
        $results = $wpdb->get_results("SELECT * from $table_name order by name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_getAllDepartments($onlyActive = false)
{
    global $wpdb; global $dragon_visit_dbResult; $results;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_department';
    if($onlyActive) {
        $results = $wpdb->get_results("SELECT * from $table_name WHERE status = 1 order by name");
    } else {
        $results = $wpdb->get_results("SELECT * from $table_name order by name");
    }
    foreach($results as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

add_action('wp_ajax_dragonvisitzyx987_saveDepartment', 'dragonvisitzyx987_saveDepartment');
function dragonvisitzyx987_saveDepartment()
{
    check_ajax_referer('dragonvisitzyx987_saveDepartment', 'dragonvisitzyx987_hidden_security_savedepartment');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $departmentid_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $departmentid_temp = sanitize_text_field($departmentid_temp);
        $departmentid = intval($departmentid_temp);

        if($departmentid <= 0 || $_POST['status'] === null || $_POST['status'] === '') {echo "Invalid id.";exit();
        }

        $departmentname_temp = $_POST['name'] === null ? '' : strip_tags($_POST['name']);
        $departmentname_temp = sanitize_text_field($departmentname_temp);
        $departmentname = dragonvisitzyx987_stripAllBackSlashes($departmentname_temp);

        $departmentdescription_temp = $_POST['description'] === null ? '' : strip_tags($_POST['description']);
        $departmentdescription_temp = sanitize_text_field($departmentdescription_temp);
        $departmentdescription = dragonvisitzyx987_stripAllBackSlashes($departmentdescription_temp);
        
        $departmentstatus_temp = $_POST['status'] === null ? '' : strip_tags($_POST['status']);
        $departmentstatus_temp = sanitize_text_field($departmentstatus_temp);
        $departmentstatus = $departmentstatus_temp === '' ? 0 : intval($departmentstatus_temp);

        if($departmentname === '' && $departmentdescription === '' && $departmentstatus !== 0 && $departmentstatus !== 1) {
            echo "Please enter a value.";exit();
        }
        if($departmentname === '' || ($departmentstatus !== 0 && $departmentstatus !== 1)) {
            echo "Name and status are required.";exit();
        }
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_department';
        $finalresult = 'Success';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $stmt = $wpdb->dbh->prepare("SELECT COUNT(*) countresult FROM $table_name WHERE name = ? and id != ?");
            $stmt->bind_param("si", $departmentname, $departmentid);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            if(count($result) === 1) {
                $temp_row = $result[0];
                $temp_result = $temp_row["countresult"];
                $dbcount = $temp_result === null ? 0 : intval($temp_result);
                if($dbcount !== 0) {echo "Edit a department: department name \"" . $departmentnamename . "\" already exists in the table. Not saved.";exit();
                }
            } else {
                echo "Edit a department: department name \"" . $departmentnamename . "\" query has error. Not saved.";exit();
            }

            $stmt=null;
            $sqlColumnsArray = array();
            if($departmentname !== '') {
                $sqlColumnsArray['name|s'] = $departmentname;
            }
            $sqlColumnsArray['description|s'] = $departmentdescription;
            if($departmentstatus === 0 || $departmentstatus === 1) {
                $sqlColumnsArray['status|i'] = $departmentstatus;
            }
            if(count($sqlColumnsArray) > 0) {
                $query = "UPDATE $table_name SET ";
                $types = '';
                $parameterArray = array('');
                foreach($sqlColumnsArray as $key => $value) {
                    $temp = explode('|', $key, 2);

                    $types .= $temp[1];
                    $query .= ' ' . $temp[0] . ' = ?, ';
                    if($temp[0] === 'name') {
                        $parameterArray[] = &$departmentname;
                    } elseif($temp[0] === 'description') {
                        $parameterArray[] = &$departmentdescription;
                    } elseif($temp[0] === 'status') {
                        $parameterArray[] = &$departmentstatus;
                    }
                }
                $query .= " updatetimeutc = UTC_TIMESTAMP() WHERE id = ? ";
                $types .= 'i';
                $parameterArray[] = &$departmentid;                
                $parameterArray[0] = $types;    
                $stmt = $wpdb->dbh->prepare($query);
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult = 'Edit department failed';
                }
                $stmt->close();
            } else {
                $finalresult = 'Nothing is updated';
            }
            echo $finalresult;
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_editConstantvalue', 'dragonvisitzyx987_editConstantvalue');
function dragonvisitzyx987_editConstantvalue()
{
    check_ajax_referer('dragonvisitzyx987_editConstantvalue', 'dragonvisitzyx987_hidden_security_editconstantvalue');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        echo 'You are not authorized to edit data in admin page. Please contact web admin.';
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $constantid_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $constantid_temp = sanitize_text_field($constantid_temp);
        $constantid = intval($constantid_temp);

        if($constantid <= 0 || $_POST['value'] === null) {echo "Invalid id.";exit();
        }

        $constantname_temp = sanitize_text_field(strip_tags($_POST['name'])) === null ? '' : strip_tags($_POST['name']);
        $constantname_temp = sanitize_text_field($constantname_temp);
        $constantname = $constantname_temp;

        $constantvalue_temp = sanitize_text_field(strip_tags($_POST['value'])) === null ? '' : strip_tags($_POST['value']);
        $constantvalue_temp = sanitize_text_field($constantvalue_temp);
        $constantvalue = $constantvalue_temp;

        $constantvalue2 = "";
        //if($constantname === 'COMPANY_TIMEZONE' && ($constantvalue === '-1' || $constantvalue === '')) {
        //    echo "Please choose a timezone.";exit();
        //}
        //if($constantname === 'COMPANY_TIMEZONE') {
        //    $temp = explode("|", $constantvalue);
        //    $constantvalue = $temp[0];
        //    $constantvalue2 = $temp[1];
        //}
        if($constantvalue2 === "" || $constantvalue2 === null) {
            $constantvalue2 = "+00:00";
        }
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_constant';
        $finalresult = '';            
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "UPDATE $table_name SET value = ?, updatetimeutc = UTC_TIMESTAMP() WHERE id = ? ";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$constantvalue;

            $types .= 'i';
            $parameterArray[] = &$constantid;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                $finalresult .= 'Edit constant id: ' . $constantid . ' failed. ';
            }
            $stmt->close();

            /*if($constantname === 'COMPANY_TIMEZONE' && $constantvalue2 !== '') {
                $query = "UPDATE $table_name SET value = ?, updatetimeutc = UTC_TIMESTAMP() WHERE name='COMPANY_TIMEZONE_HOURS' ";
                $stmt = $wpdb->dbh->prepare($query);
                $types = '';
                $parameterArray = array('');

                $types .= 's';
                $parameterArray[] = &$constantvalue2;

                $parameterArray[0] = $types;
                call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
                $stmt->execute();
                if($wpdb->dbh->errno > 0 || $stmt->errno > 0) {
                    $finalresult .= 'Edit constant COMPANY_TIMEZONE_HOURS failed. ';
                }
                $stmt->close();
            }*/
            if($finalresult === '') {$finalresult = 'Success';
            }
            echo $finalresult;
            exit();
        } else {
            echo 'This website can not use mysqli. Please contact website admin.';
            exit();
        }
    }
    echo "Invalid data.";
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getVisitdetails', 'dragonvisitzyx987_getVisitdetails');
function dragonvisitzyx987_getVisitdetails()
{
    check_ajax_referer('dragonvisitzyx987_getVisitdetails', 'dragonvisitzyx987_hidden_security_getvisitdetails');
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getVisitDetailsList';

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);
        if($amountperpage === -1) {$amountperpage = 10;
        };

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);;
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);
        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'desc' : $myorder;

        $fromdate = empty($_POST['fromdate']) ? '1000-01-01 00:00:00' : strip_tags($_POST['fromdate']);
        $fromdate = sanitize_text_field($fromdate);
        $todate = empty($_POST['todate']) ? '9999-12-31 23:59:59' : strip_tags($_POST['todate']);
        $todate = sanitize_text_field($todate);

        if(dragonvisitzyx987_validateDate($fromdate) && dragonvisitzyx987_validateDate($todate)) {
            if($fromdate > $todate) {
                echo "Error. From date is later than to date.";exit();
            }
        }else{
            echo "Error. Please enter a valid date.";exit();
        }

        $searchtypename_temp = (empty($_POST['typename']) || trim($_POST['typename']) === '') ? '' : strip_tags($_POST['typename']);
        $searchtypename_temp = sanitize_text_field($searchtypename_temp);
        $searchtypename_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchtypename_temp);
        $searchtypename = trim($searchtypename_temp) === '' ? '' : $searchtypename_temp;

        $searchtypecategoryname_temp = (empty($_POST['typecategoryname']) || trim($_POST['typecategoryname']) === '') ? '' : strip_tags($_POST['typecategoryname']);
        $searchtypecategoryname_temp = sanitize_text_field($searchtypecategoryname_temp);
        $searchtypecategoryname_temp = preg_replace('/[^a-zA-Z0-9\/()$@?!\[\]{}#%^*+|~]/', '%', $searchtypecategoryname_temp);
        $searchtypecategoryname = trim($searchtypecategoryname_temp) === '' ? '' : $searchtypecategoryname_temp;

        $visitid = empty($_POST['visitid']) ? '-1' : strip_tags($_POST['visitid']);;
        $visitid = sanitize_text_field($visitid);
        $visitid = intval($visitid);

        $userid = empty($_POST['userid']) ? '-1' : strip_tags($_POST['userid']);;
        $userid = sanitize_text_field($userid);
        $userid = intval($userid);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue);";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 'i';
            $parameterArray[] = &$visitid;

            $types .= 'i';
            $parameterArray[] = &$userid;

            $types .= 's';
            $parameterArray[] = &$searchtypename;

            $types .= 's';
            $parameterArray[] = &$searchtypecategoryname;

            $types .= 's';
            $parameterArray[] = &$fromdate;

            $types .= 's';
            $parameterArray[] = &$todate;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $visits = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach($visits as $visit) {
                foreach($visit as $key => $value) {
                    $visit[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["visitdetails"] = $visits;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getTypecategories', 'dragonvisitzyx987_getTypecategoriesByAjax');
function dragonvisitzyx987_getTypecategoriesByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getTypecategories', 'dragonvisitzyx987_hidden_security_gettypecategories');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");    
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");    
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getTypecategoryList';

        $typecategorystatus = (!isset($_POST['typecategorystatus'])) ? '-1' : strip_tags($_POST['typecategorystatus']);
        $typecategorystatus = sanitize_text_field($typecategorystatus);
        $typecategorystatus = intval($typecategorystatus);    

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);    

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $searchwords = empty($_POST['searchwords']) ? '' : strip_tags($_POST['searchwords']);
        $searchwords = sanitize_text_field($searchwords);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $parameterArray[] = &$searchwords;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$typecategorystatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $typecategories = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($typecategories as $typecategory) {
                foreach ($typecategory as $key => $value) {
                    $typecategory[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["typecategory"] = $typecategories;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");    
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getTypes', 'dragonvisitzyx987_getTypesByAjax');
function dragonvisitzyx987_getTypesByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getTypes', 'dragonvisitzyx987_hidden_security_gettypes');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");    
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getTypeList';

        $typestatus = (!isset($_POST['typestatus'])) ? '-1' : strip_tags($_POST['typestatus']);
        $typestatus = sanitize_text_field($typestatus);
        $typestatus = intval($typestatus);    

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);    
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);;
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $searchwords = empty($_POST['searchwords']) ? '' : strip_tags($_POST['searchwords']);
        $searchwords = sanitize_text_field($searchwords);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $parameterArray[] = &$searchwords;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$typestatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $types = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($types as $type) {
                foreach ($type as $key => $value) {
                    $type[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["type"] = $types;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getRoles', 'dragonvisitzyx987_getRolesByAjax');
function dragonvisitzyx987_getRolesByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getRoles', 'dragonvisitzyx987_hidden_security_getroles');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getRoleList';

        $rolestatus = (!isset($_POST['rolestatus'])) ? '-1' : strip_tags($_POST['rolestatus']);
        $rolestatus = sanitize_text_field($rolestatus);
        $rolestatus = intval($rolestatus);    

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);    
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $searchwords = empty($_POST['searchwords']) ? '' : strip_tags($_POST['searchwords']);
        $searchwords = sanitize_text_field($searchwords);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $parameterArray[] = &$searchwords;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$rolestatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $roles = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($roles as $role) {
                foreach ($role as $key => $value) {
                    $role[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["role"] = $roles;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getDepartments', 'dragonvisitzyx987_getDepartmentsByAjax');
function dragonvisitzyx987_getDepartmentsByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getDepartments', 'dragonvisitzyx987_hidden_security_getdepartments');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getDepartmentList';

        $departmentstatus = (!isset($_POST['departmentstatus'])) ? '-1' : strip_tags($_POST['departmentstatus']);
        $departmentstatus = sanitize_text_field($departmentstatus);
        $departmentstatus = intval($departmentstatus);    

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);    
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'asc' : $myorder;

        $searchwords = empty($_POST['searchwords']) ? '' : strip_tags($_POST['searchwords']);
        $searchwords = sanitize_text_field($searchwords);

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $parameterArray[] = &$searchwords;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$departmentstatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $departments = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();

            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($departments as $department) {
                foreach ($department as $key => $value) {
                    $department[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["department"] = $departments;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");    
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getConstants', 'dragonvisitzyx987_getConstantsByAjax');
function dragonvisitzyx987_getConstantsByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getConstants', 'dragonvisitzyx987_hidden_security_getconstants');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $startDate = empty($_POST['start']) ? '' : strip_tags($_POST['start']);
        $startDate = sanitize_text_field(str_ireplace("T", " ", $startDate));
        $startDate = sanitize_text_field(str_ireplace("Z", "", $startDate));

        $endDate = empty($_POST['end']) ? '' : strip_tags($_POST['end']);
        $endDate = sanitize_text_field(str_ireplace("T", " ", $endDate));
        $endDate = sanitize_text_field(str_ireplace("Z", "", $endDate));

        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987_constant';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "SELECT * FROM $table_name;";
            $stmt = $wpdb->dbh->prepare($query);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $constants = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();
            $counter = 0;
            foreach ($constants as $constant) {
                foreach ($constant as $key => $value) {
                    $constant[$key] = $value === null ? '' : deslash($value);
                    //if($key === 'name' && $value === 'COMPANY_TIMEZONE' && $constants[$counter]['value'] !== null && $constants[$counter]['value'] !== '') {
                    //    date_default_timezone_set($constants[$counter]['value']);
                    //    $timezone = $constants[$counter]['value'];
                    //}
                }
                $counter++;
            }
            $result = [];
            $result["total"] = count($constants);
            $result["constant"] = $constants;
            header("Content-Type: application/json");
            echo json_encode($result);    
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

add_action('wp_ajax_dragonvisitzyx987_getLogs', 'dragonvisitzyx987_getLogsByAjax');
function dragonvisitzyx987_getLogsByAjax()
{
    check_ajax_referer('dragonvisitzyx987_getLogs', 'dragonvisitzyx987_hidden_security_getlogs');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        header("Content-Type: application/json");
        echo json_encode("{}");
        exit();
    }
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        header("Content-Type: application/json");
        echo json_encode("{}");    
        exit();
    }
    if((in_array('administrator', (array) $current_user->roles)) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $temp = '';
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';

        $table_name = 'wp_dragonvisitzyx987_log';
        $storedprocedure_name = 'wp_dragonvisitzyx987_getLogList';

        $logstatus = (!isset($_POST['logstatus'])) ? '1' : strip_tags($_POST['logstatus']);
        $logstatus = sanitize_text_field($logstatus);
        $logstatus = intval($logstatus);    

        $amountperpage = empty($_POST['amountperpage']) ? '10' : strip_tags($_POST['amountperpage']);
        $amountperpage = sanitize_text_field($amountperpage);
        $amountperpage = intval($amountperpage);    
        if($amountperpage === -1) {$amountperpage = 10;
        }

        $pagenumber = empty($_POST['pagenumber']) ? '1' : strip_tags($_POST['pagenumber']);
        $pagenumber = sanitize_text_field($pagenumber);
        $pagenumber = intval($pagenumber);    

        $myoffset = ($pagenumber - 1) * $amountperpage;

        $mysortby = empty($_POST['sortby']) ? '' : strip_tags($_POST['sortby']);
        $mysortby = sanitize_text_field($mysortby);
        $mysortby = $mysortby === '' ? 'id' : $mysortby;

        //this is order the SQL result asc or desc, not the order table
        $myorder = empty($_POST['order']) ? '' : strip_tags($_POST['order']);
        $myorder = sanitize_text_field($myorder);
        $myorder = $myorder === '' ? 'desc' : $myorder;

        $searchwords = empty($_POST['searchwords']) ? '' : strip_tags($_POST['searchwords']);
        $searchwords = sanitize_text_field($searchwords);

        $searchtype_temp = (!isset($_POST['searchtype'])) ? '' : strip_tags($_POST['searchtype']);
        $searchtype = sanitize_text_field($searchtype_temp);
        if($searchtype === '-1') {$searchtype = "";
        }

        $processname_temp = (!isset($_POST['processname'])) ? '' : strip_tags($_POST['processname']);
        $processname = sanitize_text_field($processname_temp);
        if($processname === '-1') {$processname = "";
        }

        $userid_temp = (!isset($_POST['userid'])) ? '0' : strip_tags($_POST['userid']);
        $userid_temp = sanitize_text_field($userid_temp);
        $userid = intval($userid_temp);
        if($userid === -1) {$userid = 0;
        }

        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            $query = "CALL " . $storedprocedure_name . "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @outvalue );";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 'i';
            $parameterArray[] = &$pagenumber;

            $types .= 'i';
            $parameterArray[] = &$amountperpage;

            $types .= 'i';
            $parameterArray[] = &$myoffset;

            $types .= 's';
            $parameterArray[] = &$mysortby;

            $types .= 's';
            $parameterArray[] = &$myorder;

            $types .= 's';
            $parameterArray[] = &$searchwords;

            $types .= 's';
            $parameterArray[] = &$searchtype;

            $types .= 's';
            $parameterArray[] = &$processname;

            $types .= 'i';
            $parameterArray[] = &$userid;

            $types .= 'i'; //0: inactive, 1: active, -1: both
            $parameterArray[] = &$logstatus;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->get_result();
            $logs = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
            $stmt->close();

            $stmt2 = $wpdb->dbh->prepare('SELECT @outvalue');
            $stmt2->execute();
            $myresult2 = $stmt2->get_result();
            $totalObjArr = $myresult2 === false ? array() : $myresult2->fetch_all(MYSQLI_ASSOC);
            $stmt2->close();
            $total = "0";
            foreach ($totalObjArr[0] as $key => $value) {
                if($key === '@outvalue') {
                    $total = $value == null ? "0" : $value;
                }
            }
            foreach ($logs as $log) {
                foreach ($log as $key => $value) {
                    $log[$key] = $value === null ? '' : deslash($value);
                }
            }
            $result = [];
            $result["log"] = $logs;
            $result["total"] = $total;
            header("Content-Type: application/json");
            echo json_encode($result);
            exit();
        }
    }
    header("Content-Type: application/json");
    echo json_encode("{}");
    exit();
}

function dragonvisitzyx987_setCookie_not_by_ajax()
{
    check_ajax_referer('dragonvisitzyx987_createcookie', 'dragonvisitzyx987_hidden_security_createcookie');
    if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $value = empty($_POST['dragonvisitzyx987_orderitems']) ? '' : sanitize_text_field($_POST['dragonvisitzyx987_orderitems']);
        $value = strip_tags($value);
        $value = dragonvisitzyx987_stripAllBackSlashes($value);

        $dragonvisitzyx987_orderitems = empty($_POST['dragonvisitzyx987_orderitems']) ? '' : sanitize_text_field($_POST['dragonvisitzyx987_orderitems']);
        $_SESSION['dragonvisitzyx987_orderitems'] = $dragonvisitzyx987_orderitems;
        $setcookieresult = setcookie('dragonvisitzyx987_orderitems', dragonvisitzyx987_stripAllBackSlashes($dragonvisitzyx987_orderitems), 0, '/', '', true, true);
        if($setcookieresult) {
            return "success";
        } else {
            return "Set cookie failed.";
        }
    }
    return "Invalid details. Cookie is not set.";
}

function dragonvisitzyx987_sanitizeEmailAddress($v)
{
    return sanitize_email($v);
}

function dragonvisitzyx987_sanitizeEmailAddressAndPassword($v)
{
    $temp = explode("|", $v);
    return sanitize_email($temp[0]) . '|' . sanitize_text_field($temp[1]);
}

function dragonvisitzyx987_reloadPageAfterPost()
{
    echo "<meta http-equiv='refresh' content='0'>";
    exit();
}

function dragonvisitzyx987_getConstantRowPerTable()
{
    global $wpdb; global $dragon_visit_dbResult;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    $table_name = 'wp_dragonvisitzyx987_constant';
    $result = $wpdb->get_var("SELECT value FROM $table_name WHERE name = 'AMOUNT_PER_PAGE'");
    return $result === null ? 0 : intval($result);
}

function dragonvisitzyx987_dropConstantTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropConstantTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_constant;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_constant();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropDepartmentTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropDepartmentTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_department;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_department();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropLogTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropLogTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_log;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_log();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropLogCreateNewLogTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropLogCreateNewLogTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_log;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_log();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropRoleTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropRoleTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_role;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_role();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropVisitTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropVisitTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_visit;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_visit();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropTypeTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropTypeTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_type;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_type();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropTypecategoryTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropTypecategoryTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_typecategory;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_typecategory();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropUsersTable()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropUsersTable') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();    
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_users;";
        $wpdb->query($sql);
        dragonvisitzyx987_createTable_users();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

//Drop and create all stored procedures
function dragonvisitzyx987_dropAllStoredprocedures()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropAllStoredprocedures') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        dragonvisitzyx987_createStoredProcedure();
        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_dropAllTables()
{
    global $dragon_visit_dbResult;
    $mynonce = empty($_POST['dragonvisitzyx987_hidden_security']) ? '' : strip_tags($_POST['dragonvisitzyx987_hidden_security']);
    $mynonce = sanitize_text_field($mynonce);
    if(wp_verify_nonce($mynonce, 'dragonvisitzyx987_dropAllTables') !== 1) {$dragon_visit_dbResult .= 'Invalid data. ';return;
    }
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        $dragon_visit_dbResult .= 'Invalid user info.';
        return;
    }
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        $dragon_visit_dbResult .= 'You are not authorized to edit data in admin page. Please contact web admin.';
        return;
    }
    if(in_array('administrator', (array) $current_user->roles) && (!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $table_name = 'wp_dragonvisitzyx987';
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_constant;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_department;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_log;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_role;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_visit;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_type;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_typecategory;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_user_type;";
        $wpdb->query($sql);
        $sql = "DROP TABLE IF EXISTS " . $table_name . "_users;";
        $wpdb->query($sql);

        dragonvisitzyx987_createTable_constant();
        dragonvisitzyx987_createTable_department();
        dragonvisitzyx987_createTable_log();
        dragonvisitzyx987_createTable_role();
        dragonvisitzyx987_createTable_visit();
        dragonvisitzyx987_createTable_typecategory();
        dragonvisitzyx987_createTable_type();
        dragonvisitzyx987_createTable_users();
        dragonvisitzyx987_additional_creation();

        $dragon_visit_dbResult .= 'Success.';
    } else {
        $dragon_visit_dbResult .= 'Invalid data.';
    }
}

function dragonvisitzyx987_showLandingPage()
{
    include_once dirname(__FILE__) . '/' . "dragonvisitzyx987_landingpage.php";
}

function dragonvisitzyx987_saveToLogTable($message, $processname  = '', $type = 'info', $userid = null)
{
    global $wpdb;
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    if(!dragonvisitzyx987_userCanEditInAdminPage()) {
        return 'You are not authorized to edit data in admin page. Please contact web admin.';
    }
    if($wpdb->use_mysqli) {
        if($wpdb->dbh->connect_error) {
            return "Connection failed: " . esc_html($wpdb->dbh->connect_error);
        }
        $table_name = 'wp_dragonvisitzyx987_log';
        if($userid === null) {
            $query = "INSERT INTO " . $table_name . " (`processname`,`type`,`description`,`createtimeutc`) VALUES (?,?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$processname;
            
            $types .= 's';
            $parameterArray[] = &$type;

            $types .= 's';
            $parameterArray[] = &$message;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();
            if($myresult <= 0) {
                return 'Error adding a message into table ' . $table_name . ". ";
            }
            return 'Success';
        } else {
            $query = "INSERT INTO " . $table_name . " (`processname`,`userid`,`type`,`description`,`createtimeutc`) VALUES (?,?,?,?,UTC_TIMESTAMP())";
            $stmt = $wpdb->dbh->prepare($query);
            $types = '';
            $parameterArray = array('');

            $types .= 's';
            $parameterArray[] = &$processname;

            $types .= 'i';
            $userid2 = intval($userid);
            $parameterArray[] = &$userid2;

            $types .= 's';
            $parameterArray[] = &$type;

            $types .= 's';
            $parameterArray[] = &$message;

            $parameterArray[0] = $types;
            call_user_func_array(array($stmt, 'bind_param'), $parameterArray);
            $stmt->execute();
            $myresult = $stmt->insert_id;
            $stmt->close();
            if($myresult <= 0) {
                return 'Error adding a message into table ' . $table_name . ". ";
            }
            return 'Success';
        }
    }
    return 'Mysqli is not supported.';
}

function dragonvisitzyx987_getAllLogtypesProcessnamesUserids($onlyActive = true)
{
    global $wpdb; global $dragon_visit_dbResult; $results = array();
    include_once ABSPATH . 'wp-admin/includes/upgrade.php';
    if(!dragonvisitzyx987_userCanReadInAdminPage()) {
        return array();
    }
    $table_name = 'wp_dragonvisitzyx987_log';
    if($onlyActive) {
        $results["type"] = $wpdb->get_results("SELECT distinct type from $table_name WHERE type is not null and status = 1 order by type");
    } else {
        $results["type"] = $wpdb->get_results("SELECT distinct type from $table_name WHERE type is not null order by type");
    }
    foreach($results["type"] as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }

    if($onlyActive) {
        $results["processname"] = $wpdb->get_results("SELECT distinct processname from $table_name WHERE processname is not null and status = 1 order by processname");
    } else {
        $results["processname"] = $wpdb->get_results("SELECT distinct processname from $table_name WHERE processname is not null order by processname");
    }
    foreach($results["processname"] as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }

    if($onlyActive) {
        $results["userid"] = $wpdb->get_results("SELECT distinct userid from $table_name WHERE userid is not null and status = 1 order by userid");
    } else {
        $results["userid"] = $wpdb->get_results("SELECT distinct userid from $table_name WHERE userid is not null order by userid");
    }
    foreach($results["userid"] as $result) {
        foreach($result as $key => $value) {
            $result->$key = deslash($value);
        }
    }
    return $results;
}

function dragonvisitzyx987_getConstants($key)
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_constant';
    $stmt = $wpdb->dbh->prepare("SELECT value FROM $table_name WHERE name = ? LIMIT 1 ");
    $stmt->bind_param("s", $key);
    $stmt->execute();
    $myresult = $stmt->get_result();
    $result = $myresult === false ? array() : $myresult->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
    if(empty($result)) {
        return "";
    } else {
        return $result[0]["value"];
    }
}

function dragonvisitzyx987_getAssociatesForManager($managerid)
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $temps = $wpdb->get_results("SELECT userid from $table_name WHERE status = 1 and reportto = " . intval($managerid) . " ORDER BY userid");
    $users = array();
    foreach($temps as $temp) {
        $users[] = $temp["userid"];
    }
    return $users;
}

function dragonvisitzyx987_getUID()
{
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        return 0;
    }
    return intval($current_user->data->ID);
}

function dragonvisitzyx987_getUserRoleName()
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $table_name2 = $table_name_prefix . '_role';
    $sql = "SELECT r.name as rolename FROM $table_name t LEFT JOIN $table_name2 r ON r.id = t.roleid ";
    $sql .= " WHERE t.status = 1 AND t.userid = " . dragonvisitzyx987_getUID() . " LIMIT 1";
    $temp = $wpdb->get_results($sql);
    if(!empty($temp)) { return $temp[0]->rolename;
    } else {return '';
    }
}

function dragonvisitzyx987_getAssociatesAndSelfForManager($managerid)
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $temps = $wpdb->get_results("SELECT userid from $table_name WHERE status = 1 and reportto = " . intval($managerid) . " ORDER BY userid");
    $users = array();
    $users[] = $managerid;
    foreach($temps as $temp) {
        $users[] = $temp["id"];
    }
    return $users;
}

function dragonvisitzyx987_hasAssociates($id)
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $temps = $wpdb->get_results("SELECT userid from $table_name WHERE status = 1 AND reportto = " . intval($id) . " ORDER BY userid");
    if(count($temps)) {return true;
    }
    return false;
}

function dragonvisitzyx987_getUsername()
{
    global $wpdb;$table_name = $wpdb->prefix . 'users';
    $temp = $wpdb->get_results("SELECT user_login from $table_name WHERE id = " . dragonvisitzyx987_getUID() . " LIMIT 1 ");
    if(!empty($temp)) { return $temp;
    } else {return '';
    }
}

function dragonvisitzyx987_getUserrole()
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $temp = $wpdb->get_results("SELECT roleid from $table_name WHERE status = 1 AND id = " . dragonvisitzyx987_getUID() . " LIMIT 1 ");
    if(!empty($temp) && $temp[0]->roleid !== null) { return intval($temp[0]->roleid);
    } else {return 0;
    }
}

function dragonvisitzyx987_getUserEmailAddress()
{
    global $wpdb;$table_name = $wpdb->prefix . 'users';
    $temp = $wpdb->get_results("SELECT user_email from $table_name WHERE id = " . dragonvisitzyx987_getUID() . " LIMIT 1 ");
    if(empty($temp)) {
        return "";
    } else {
        return $temp[0]->user_email;
    }
}

function dragonvisitzyx987_doesThisVisitUserReportToThisUser($visitid, $managerid)
{
    if(intval($visitid) <= 0 || intval($managerid) <= 0 ) {return false;
    }
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_visit';
    $table_name2 = $table_name_prefix . '_users';
    $temp = $wpdb->get_results("SELECT u.reportto from $table_name t JOIN $table_name2 u ON t.userid = u.userid AND t.id = " . intval($visitid) . " LIMIT 1 ");
    if(empty($temp)) {
        return false;
    } else {
        return intval($temp[0]->reportto) === intval($managerid);
    }
}

function dragonvisitzyx987_getManagerUID()
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $temp = $wpdb->get_results("SELECT reportto from $table_name WHERE status = 1 AND id = " . dragonvisitzyx987_getUID() . " LIMIT 1 ");
    if(empty($temp)) {
        return 0;
    } else {
        return intval($temp[0]->reportto);
    }
}

function dragonvisitzyx987_getManagerEmailAddress()
{
    global $wpdb;$table_name_prefix = 'wp_dragonvisitzyx987';
    $table_name = $table_name_prefix . '_users';
    $sql = "SELECT a.email FROM $table_name t LEFT JOIN $table_name a ON t.reportto = a.id ";
    $sql .= " WHERE a.status = 1 AND t.status = 1 AND t.userid = " . dragonvisitzyx987_getUID() . " LIMIT 1 ";
    $temp = $wpdb->get_results($sql);
    if(empty($temp)) {
        return "";
    } else {
        return $temp[0]->email;
    }
}

function dragonvisitzyx987_removeAssociatesFromUserArray($userid, $users)
{
    $associatesArr = dragonvisitzyx987_getAssociatesForManager(intval($userid));
    $usersArr = explode(",", $users);
    $temp = array();
    foreach($usersArr as $k) {
        if(!in_array($k, $associatesArr)) {
            $temp[] = $k;
        }
    }
    return implode(",", $temp);
}

//This is for user page, not admin page
add_action('wp_ajax_dragonvisitzyx987_deleteVisit', 'dragonvisitzyx987_deleteVisit');
function dragonvisitzyx987_deleteVisit()
{
    check_ajax_referer('dragonvisitzyx987_deleteVisit', 'dragonvisitzyx987_hidden_security_deletevisit');
    $current_user = wp_get_current_user();
    if($current_user === null || $current_user->data->ID === null || intval($current_user->data->ID) <= 0) {
        echo 'Invalid user info.';
        exit();
    }
    if((!empty($_POST['dragonvisitzyx987_hidden'])) && $_POST['dragonvisitzyx987_hidden'] === 'Y') {
        $visitid_temp = empty($_POST['id']) ? 0 : strip_tags($_POST['id']);
        $visitid_temp = sanitize_text_field($visitid_temp);
        $visitid = intval($visitid_temp);
        if($visitid <= 0) {echo "Invalid id.";exit();
        }
        global $wpdb;
        include_once ABSPATH . 'wp-admin/includes/upgrade.php';
        $finalresult = '';
        if($wpdb->use_mysqli) {
            if($wpdb->dbh->connect_error) {
                die("Connection failed: " . esc_html($wpdb->dbh->connect_error));
            }
            try{
                $table_name_prefix = 'wp_dragonvisitzyx987';
                $table_name = $table_name_prefix . '_visit';
                $visit = $wpdb->get_results("SELECT * FROM $table_name WHERE status = 1 AND id = $visitid LIMIT 1");
                $visit2 = $wpdb->get_results("SELECT * FROM $table_name WHERE id = $visitid LIMIT 1");
                //error_log("at 4301, visit: " . json_encode($visit) . ", visit2: " . json_encode($visit2));
                //error_log("at 4302, count visit2: ". count($visit2).", and count visit:" . count($visit) . ", userid: " . $visit->userid);
                if(count($visit2) > 0 && count($visit) > 0 && intval($visit[0]->userid) === dragonvisitzyx987_getUID()) {
                    $wpdb->dbh->begin_transaction();
                    $result = $wpdb->query($wpdb->prepare("UPDATE $table_name SET status = 0 WHERE id = %d", $visitid));
                    if($result === false) {
                        throw new Exception($finalresult);
                    }
                    $wpdb->dbh->commit();
                } else {
                    $finalresult .= "This visit is not yours.";
                }
            } catch(Exception $e) {
                $wpdb->dbh->rollback();
                $finalresult .= 'Delete visit from DB: Exception Message: ' .$e->getMessage();
            }
            if($finalresult === '') {
                $finalresult = 'Success';
            } else {
                dragonvisitzyx987_saveToLogTable($finalresult, 'Delete visit', 'error', intval($current_user->data->ID));
            }
            echo esc_html($finalresult);
            exit();
        } else {
            $msg = 'This website can not use mysqli. Please contact website admin.';
            dragonvisitzyx987_saveToLogTable($msg, 'Delete visit', 'error', intval($current_user->data->ID));
            echo esc_html($msg);
            exit();
        }
    }
    $msg = "Invalid data.";
    dragonvisitzyx987_saveToLogTable($msg, 'Delete visit', 'error', intval($current_user->data->ID));
    echo esc_html($msg);
    exit();
}

function dragonvisitzyx987_user_has_role($user_id, $role_name)
{
    $user_meta = get_userdata($user_id);
    $user_roles = $user_meta->roles;
    return in_array($role_name, $user_roles);
}
?>