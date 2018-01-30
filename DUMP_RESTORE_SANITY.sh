###########################################################################
# RUN COMMAND LIKE THAT IF YOU DONT WANT TO SEE THE ERROR BELOW
# Warning: Using a password on the command line interface can be insecure.
#
# sh contexualdata.sh 2>&1 | grep -v "Warning: Using a password"
#
###########################################################################


# DUMP TABLES FROM DEV SERVER 10.200.10.10

echo "DUMP FROM SOURCE SERVER DEV SERVER 10.200.10.10............"
mysqldump -u user -passwd -h 10.200.10.10 --compress dev googlecategory > googlecategory.sql
mysqldump -u user -passwd -h 10.200.10.10 --compress dev googlecategory_combine > googlecategory_combine.sql
mysqldump -u user -passwd -h 10.200.10.10 --compress dev googlecategory_country > googlecategory_country.sql
mysqldump -u user -passwd -h 10.200.10.10 --compress dev zvelocategory > zvelocategory.sql
mysqldump -u user -passwd -h 10.200.10.10 --compress dev zvelocategory_combine > zvelocategory_combine.sql
mysqldump -u user -passwd -h 10.200.10.10 --compress dev zvelocategory_country > zvelocategory_country.sql

echo "RESTORE DUMP ON 10.200.40.70 DATATABASE TEMP............."

#RESTORE DUMP ON TEMP DATABASE 
mysql -passwd test < googlecategory.sql
mysql -passwd test < googlecategory_combine.sql
mysql -passwd test < googlecategory_country.sql
mysql -passwd test < zvelocategory.sql
mysql -passwd test < zvelocategory_combine.sql
mysql -passwd test < zvelocategory_country.sql

echo "DOING THE SANITY CHECK ....................AND RESTORE"

	a1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.googlecategory\G" | awk '/COUNT/{print $2}'`
	a=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.googlecategory\G" | awk '/COUNT/{print $2}'`

	b1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.googlecategory_combine\G" | awk '/COUNT/{print $2}'`
	b=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.googlecategory_combine\G" | awk '/COUNT/{print $2}'`

	c1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.googlecategory_country\G" | awk '/COUNT/{print $2}'`
	c=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.googlecategory_country\G" | awk '/COUNT/{print $2}'`

	d1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.zvelocategory\G" | awk '/COUNT/{print $2}'`
	d=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.zvelocategory\G" | awk '/COUNT/{print $2}'`

	e1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.zvelocategory_combine\G" | awk '/COUNT/{print $2}'`
	e=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.zvelocategory_combine\G" | awk '/COUNT/{print $2}'`

	f1=`mysql -passwd -e  "SELECT COUNT(*) FROM test.zvelocategory_country\G" | awk '/COUNT/{print $2}'`
	f=`mysql -u user -passwd -h 10.200.10.10 -e  "SELECT COUNT(*) FROM db.zvelocategory_country\G" | awk '/COUNT/{print $2}'`


	if [[ "$a" -ge "$a1" ]];then
                echo "TABLE googlecategory IS OK $a=$a1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < googlecategory.sql
                

else
                echo "problem with googlecategory $a=$a1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com

exit
fi
	if [[ "$b" -ge "$b1" ]];then
                echo "TABLE googlecategory_combine IS OK $b=$b1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < googlecategory_combine.sql
                
        else
                echo "problem with googlecategory_combine $b=$b1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com
exit
fi
	if [[ "$c" -ge "$c1" ]];then
                echo "TABLE googlecategory_country IS OK $c=$c1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < googlecategory_country.sql
                
        else
                echo "problem with googlecategory_country $c=$c1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com
exit
fi
	if [[ "$e" -ge "$e1" ]];then
                echo "TABLE zvelocategory IS OK $d=$d1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < zvelocategory.sql
               
        else
                echo "problem with zvelocategory $d=$d1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com
exit
fi
	if [[ "$d" -ge "$d1" ]];then
                echo "TABLE zvelocategory_combine IS OK $e=$e1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < zvelocategory_combine.sql
                
        else
                echo "problem with zvelocategory_combine $e=$e1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com
exit
fi

	if [[ "$f" -ge "$f1" ]];then
                echo "TABLE zvelocategory_country IS OK $f=$f1 HAS BEEN RESTORED......."
                mysql -u user -passwd -h 10.200.10.20 user_campaign_beta_2_0 < zvelocategory_country.sql
                
        else
                echo "problem with zvelocategory_country $f=$f1" | /usr/bin/mail -s "PROBLEM WITH CONTEXDUALDATA IMPORT" name.lastname@domain.com
exit
fi