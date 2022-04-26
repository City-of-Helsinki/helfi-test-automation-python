echo
echo "#######################################"
echo "# Running portfolio a first time      #"
echo "#######################################"
echo
pabot --testlevelsplit --ordering ./environments/helfi_pabot_order_ci --processes 9 -v PREFIX:/kaupunkiymparisto-ja-liikenne -v BASE_URL:varnish-helfi-kymp.docker.so -v PICCOMPARE:False -v useoriginalname:False -v images_dir:robotframework-resources/screenshots/headlesschrome -v actual_dir:robotframework-reports -A ./environments/ci.args -d robotframework-reports . $@

# we stop the script here if all the tests were OK
if [ $? -eq 0 ]; then
	echo "we don't run the tests again as everything was OK on first try"
	exit 0	
fi
# otherwise we go for another round with the failing tests

# we keep a copy of the first log file
cp robotframework-reports/log.html  robotframework-reports/first_run_log.html

# we launch the tests that failed
echo
echo "#######################################"
echo "# Running again the tests that failed #"
echo "#######################################"
echo
pabot --processes 9 -v PREFIX:/kaupunkiymparisto-ja-liikenne -v BASE_URL:varnish-helfi-kymp.docker.so -v PICCOMPARE:False -v useoriginalname:False -v images_dir:robotframework-resources/screenshots/headlesschrome -v actual_dir:robotframework-reports -A ./environments/ci.args --nostatusrc --rerunfailed robotframework-reports/output.xml --output rerun.xml -d robotframework-reports . $@
# => Robot Framework generates file rerun.xml

# we keep a copy of the second log file
cp robotframework-reports/log.html  robotframework-reports/second_run_log.html

# Merging output files
echo
echo "########################"
echo "# Merging output files #"
echo "########################"
echo
rebot --nostatusrc --outputdir robotframework-reports --output output.xml --merge robotframework-reports/output.xml  robotframework-reports/rerun.xml
# => Robot Framework generates a new output.xml