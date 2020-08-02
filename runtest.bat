robot -d ../reports lesson4/ui/testSuite/testlogin.robot
robot -d ../reports -i demotagLogin  lesson4/ui/testSuite/testlogin.robot
robot -d ../reports -t LoginManager --settag=demotagLogin lesson4/ui/testSuite/testlogin.robot
robot -d ../reports -t LoginManager lesson4/ui/testSuite/testlogin.robot
