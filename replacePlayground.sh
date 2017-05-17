version=`date +"%Y-%m-%d-%H-%M"`

if [ $# -eq 0 ]
	then
		echo "./replacePlayground ip-adress"
			      exit
		      fi

		      scp output/target/nonlinear/playground/playground root@$1:/nonlinear/playground/pg
		      ssh root@$1 "mv /nonlinear/playground/pg /nonlinear/playground/playground"
		      ssh root@$1 "systemctl restart playground"

