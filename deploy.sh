version=`date +"%Y-%m-%d-%H-%M"`

if [ $# -eq 0 ]
	  then
		        echo "./deploy ip-adress"
			      exit
		      fi

		      scp -r output/target/nonlinear/playground root@$1:/nonlinear/playground-$version
		      ssh root@$1 "rm /nonlinear/playground"
		      ssh root@$1 "ln -s /nonlinear/playground-$version /nonlinear/playground"
		      ssh root@$1 "systemctl restart playground"

