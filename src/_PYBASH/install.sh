MODULE_NAME="_PYBASH"
MODULE_DATA_DIR=$PYBASH_DATA_DIR/$module_name
if [ ! -e $MODULE_DATA_DIR ]; then
  mkdir $MODULE_DATA_DIR
fi

MODULE_LIST_PATH=$MODULE_DATA_DIR/installed_modules.txt
if [ -n -e $MODULE_LIST_PATH ]; then
  echo $MODULE_NAME >> $MODULE_LIST_PATH
fi
