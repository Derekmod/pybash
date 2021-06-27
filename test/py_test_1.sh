echo "EXPECTED: test_1"
echo "ACTUAL..."
p "print('test_1')"

echo
echo "#############################"
echo

echo "EXPECTED:
a
d
g"
echo "ACTUAL..."
p "for c in 'adg':
  print(c)"

echo
echo "#############################"
echo

echo "EXPECTED:
stage 1
0
1
2
3
exec"
echo "ACTUAL..."
pw "print('stage 1')"
pw "for i in range(4):"
pw "  print(i)"
p "print('exec')"
