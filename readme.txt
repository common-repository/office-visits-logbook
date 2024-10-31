=== Office Visits Logbook Plugin for WordPress ===
Contributors: Ming's IT Services Ltd.
Donate link: https://paypal.me/mingsitservices?country.x=CA&locale.x=en_US
Tags: office, visit, visitor, log, logbook, sign in, sign out, log in, log out, accessibility, plugin, wordpress, PHP, jQuery
Requires at least: 5.4
Tested up to: 6.5.4
Requires PHP: 5.5 or higher
Stable tag: 1.1.2
Copyright: Ming's IT Services Ltd.. All rights reserved.
License: GPLv2 or later


Your company is still using paper log sheets for office visitors? Everything is digital and paperless now. Being paperless can also save trees and protect the environment. We provide you an efficient plugin for your company office visitors to sign in and sign out. Data is saved in the same MySQL database for your WordPress website. You do not need paper office visit logbook any more! And you can search office visit history easily. So efficient and easy to use.
== Description ==
 
Your company is still using paper log sheets for office visitors? Everything is digital and paperless now. Being paperless can also save trees and protect the environment. We provide you an efficient plugin for your company office visitors to sign in and sign out. Data is saved in the same MySQL database for your WordPress website. 

You do not need paper office visit logbook any more! And you can search office visit history easily. So efficient and easy to use.

This office visits logbook plugin is for the sign-in and sign-out of office interview, business, meeting, etc. You can add any new visit type categories and new visit types if you want. For example, for hospitals and clinics, you can add new visit types such as surgery, emergency, ICU. For dental offices, you can add new visit types such as wash teeth, root canal, dental implants, wisdom tooth extraction, reconstructive surgery, and cosmetic surgery. 

By default, this plugin uses Bootstrap (https://getbootstrap.com/) for the formatting. But sometimes you already have your own formatting css files. So you may need to remove these Bootstrap css and javascript files when you use this plugin. If this is the case, you can choose not to use Bootstrap’s css and javascript files by changing the values of USE_BOOTSTRAP_JS and USE_BOOTSTRAP_CSS to no (0) in the constant table.

If you did not find USE_BOOTSTRAP_JS and USE_BOOTSTRAP_CSS in your constant table, please deactivate this plugin and activate it again. Then USE_BOOTSTRAP_JS and USE_BOOTSTRAP_CSS will be automatically added to your constant table.

If you find out that the search result is not showing all the fields' data, you can try to re-create stored procedures in the admin plugin page. Go to admin page, click "Settings", and then click "Office Visits Logbook". Then click tab "Re-create stored procedures", and press the button to re-create all the stored procedures again.

This plugin has the web accessibility feature for the disabled people to listen to the screen reader. The disabled people just need to press the tab key to access the elements on the page. Then use keyboard to input. Then press enter key for submit, reset and cancel. To use this feature, you can download and use any screen reader software such as NVDA (for Windows), VoiceOver (for Apple), etc. Most of this kind of software is free to download and use. 

By default, the landing page shows all the visits. But sometimes you want to protect other visitors' privacy and hide other visits' details when a new visitor is using this landing page. To do this, just set the value of SHOW_ALL_VISITS_WHEN_NOT_SEARCH in your constant table to no (0).

If you did not find SHOW_ALL_VISITS_WHEN_NOT_SEARCH in your constant table, please deactivate this plugin and activate it again. Then SHOW_ALL_VISITS_WHEN_NOT_SEARCH will be automatically added to your constant table.

A visit record can be updated only when it is active and timeout is empty. Deleted visits and finished visits are not available for editing.

This plugin has an access restriction feature. You can give a user access to the visit landing page by adding the user to the wp_dragonvisitzyx987_users table. 

After you are added to the wp_dragonvisitzyx987_users table, you must log in WordPress website to access this plugin’s landing page. On the admin setting page, admin and assigned users can access admin setting page to see table lists. 

This plugin uses a responsive design. You can use it from your cellphone, tablet, laptop, and PC. The layout will change accordingly. 

For the best user experience, we recommend you to use this plugin in a desktop computer with three monitors. Two monitors share the same content. The visitor uses one monitor, keyboard and mouse. The receptionist uses another monitor to watch the visitor’s input and behavior. The receptionist also uses a third monitor showing the dashboard’s plugin setting page. The third monitor is for the receptionist to verify visitor’s input after visitor finishes input.

For this plugin to get your company's current local date, you must set the timezone value correctly. You can edit the timezone at Dashboard -> Settings -> General -> Timezone -> check if the value has been set correctly.

After plugin activation, go to the "Settings" menu to find the plugin admin page. By default, when you activate this plugin, it will automatically create a visit landing page for you. For some themes, if it does not automatically create a visit landing page for you, add this plugin root folder template-officevisitslogbook.php file to your template folder. For example, if you are using theme twentytwenty, then add the template-officevisitslogbook.php file to this folder: wordpress\wp-content\themes\twentytwenty\templates. Then you can create a new page (not a new post) using this template. 

When you use the template method to create a new visit page, do not set the page title to "officevisitslogbook". If you set the page title to "officevisitslogbook", it could conflict with the page automatically created when you activate this plugin. 

Documentation file is in the root folder with the name documentation_officevisitslogbook.pdf. Please follow the instructions in the file to install this plugin.

Donate URL link:
https://paypal.me/mingsitservices?country.x=CA&locale.x=en_US

demo website:

https://mingsitservicesfree.infinityfreeapp.com/officevisitslogbook/

admin page:

https://mingsitservicesfree.infinityfreeapp.com/wp-admin

Log in WordPress admin page using

username:

admin_order

password:

m8Yl*KWKq4nEa5JUDk

Then, go to

https://mingsitservicesfree.infinityfreeapp.com/wp-admin/options-general.php?page=Office+Visits+Logbook

to set up the admin page.

Documentation:

https://mingsitservicesfree.infinityfreeapp.com/wp-content/plugins/office-visits-logbook/documentation_officevisitslogbook.pdf

Platform and Database:

You can run it on any platform: Windows, Mac, Linux.

Database is MySQL. It’s free.

PHP version: PHP >= 5.4

Attention: PHP version and WordPress version may have compatibility issues. For example, WordPress 5.4 may not match PHP 8. Check this website for details: 
https://make.wordpress.org/core/handbook/references/php-compatibility-and-wordpress-versions/

1. PHP has support for the mysqli extension (to used for prepared statement)

2. Must use HTTPS, not http. If website use HTTP, tell the website admin - can not use the dragon ecommerce plugin.

3. Since PHP 5.4 there are constants which can be used by json_encode() to format the json reponse how you want. To remove backslashes use: JSON_UNESCAPED_SLASHES. Like so: json_encode($response, JSON_UNESCAPED_SLASHES);

There is an advanced version on sale here:
https://www.codester.com/items/39162/office-visits-logbook-plugin-for-wordpress
It can export visit records into an Excel file for download. It can also backup your database. The advanced version and this free version have the same database tables and stored procedures. It's easy to migrate from this free version to the advanced version. Remember to backup your free version database before migration.

The visitor management system market is increasing fast. According to this website https://www.globenewswire.com/news-release/2023/06/27/2695465/0/en/Global-Visitor-Management-System-Market-Size-To-Grow-USD-2-7-Billion-By-2032-CAGR-of-18-4.html, 
Spherical Insights & Consulting published a report saying the global visitor management system market size was valued at USD 1.5 billion in 2022 and the worldwide visitor management system market size is expected to reach USD 2.7 billion by 2032.

This plugin is very popular. It has been downloaded over 1000 times in several months:
https://wordpress.org/plugins/office-visits-logbook/advanced/

== Installation ==
 
1. Unzip the file. Copy the folder into your /wp-content/plugins/ folder.

2. Log in to your WordPress admin page. Click “Plugins” and click “Activate” to activate the plugin. http://yourwebsite.com/wp-login.php

3. Hover on left menu’s “Settings” and you will find “Office Visits Logbook” in the sub-menu. Click it and you will see the admin page for Office Visits Logbook.

4. Go to this plugin's root folder. Copy template-officevisitslogbook.php to \wordpress\wp-content\themes\twentytwenty\templates folder.

5. Please refer to the document documentation_officevisitslogbook.pdf for further details.

 
== Frequently Asked Questions ==
 
= A question that someone might have =
 
== Screenshots ==
 
 
== Changelog ==

= 1.1.2 =
* Updated: Now it works for all the permalink settings URL: Plain (https://yourwebsite.com/?p=123), Day and name (https://yourwebsite.com/2024/08/04/officevisitslogbook/), Month and name (https://yourwebsite.com/2024/08/officevisitslogbook/), Numeric (https://yourwebsite.com/archives/123), Post name (https://yourwebsite.com/officevisitslogbook/).

= 1.1.1 =
* Updated: Small changes - 1. Removed white spaces. 2. Replaced sanitize_text_field($_SERVER['REQUEST_URI']) with sanitize_url($_SERVER['REQUEST_URI']).
* Updated: Replaced sanitize_url($_SERVER['REQUEST_URI']) with esc_html($_SERVER['REQUEST_URI']).

= 1.1.0 =
* New: From now on, by default, when you activate this plugin, it will automatically create a visit landing page for you. You do not need to copy the template-officevisitslogbook.php file to this folder: wordpress\wp-content\themes\twentytwenty\templates if you are using the twentytwenty theme. For some themes, if it does not automatically create a visit landing page for you, you still need to add this plugin root folder template-officevisitslogbook.php file to your template folder. 

= 1.0.2 =
* Updated: For this plugin to get your company's current local date, you must set the timezone value correctly. You can edit the timezone at Dashboard -> Settings -> General -> Timezone -> check if the value has been set correctly.
* New: Added a constant SHOW_ALL_VISITS_WHEN_NOT_SEARCH to the constant table. By default, the landing page shows all the visits. But sometimes you want to protect other visitors' privacy and hide other visits' details when a new visitor is using this landing page. To do this, just set the value of SHOW_ALL_VISITS_WHEN_NOT_SEARCH in your constant table to no (0). If you did not find SHOW_ALL_VISITS_WHEN_NOT_SEARCH in your constant table, please deactivate this plugin and activate it again. Then SHOW_ALL_VISITS_WHEN_NOT_SEARCH will be automatically added to your constant table. A visit record can be updated only when it is active and timeout is empty. Deleted visits and finished visits are not available for editing.

= 1.0.1 =
* New: Added the create new page image into the documentation_officevisitslogbook.docx and documentation_officevisitslogbook.pdf files.

 
== Upgrade Notice ==
 
