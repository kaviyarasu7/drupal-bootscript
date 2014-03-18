#!/usr/bin/env bash

echo "Updating System...."
cmd="apt-get update"
su -c "$cmd"

echo "Installing LAMP stack...."
cmd="sudo apt-get install lamp-server^"
su -c "$cmd"

echo "Installing php gd shell...."
cmd="sudo apt-get install php5-gd"
su -c "$cmd"

echo "Installing Enable apache2 rewrite...."
cmd="a2enmod rewrite"
su -c "$cmd"

echo "Installing apache restart...."
cmd="service apache2 restart"
su -c "$cmd"

echo "Installing Drush..."
cmd="apt-get install drush"
su -c "$cmd"

echo "Enter folder to of drupal:"
read f_name
echo "Drupal folder name is:$f_name"

echo "Going to /var/www.."
cd /var/www

echo "Installing Drupal..."
cmd="drush dl drupal --drupal-project-rename=$f_name"
su -c "$cmd"

echo "Going into $f_name ..."
cd $f_name

echo "Enter Db user name:"
read db_user
echo "Enter Db user pwd:"
read db_pwd
echo "Enter Db name:"
read db_name
echo "Enter Site user name:"
read site_user
echo "Enter site  pwd:"
read site_pwd


echo "Configuring Drupal..."
cmd="drush site-install standard --db-url=mysql://$db_user:$db_pwd@localhost/$db_name --site-name=$f_name --account-name=$site_user --account-pass=$site_pwd"
su -c "$cmd"

echo "Enable clean URL..."
cmd="drush vset clean_url 0 --yes"
su -c "$cmd"



echo "Download Module..."
cmd="drush dl views,ctools,panels,profile2 -y"
su -c "$cmd"

echo "Enable Module..."
cmd="drush en ctools_custom_content, ctools_access_ruleset, stylizer, term_depth, ctools_plugin_example, ctools_ajax_sample, views_content, bulk_export, page_manager, ctools,panels_node, i18n_panels, panels_ipe, panels_mini, panels,profile2_i18n, profile2_page, profile2_og_access, profile2 -y"
su -c "$cmd"