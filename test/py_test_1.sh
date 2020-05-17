echo "EXPECTED: test_1"
p "print('test_1 pass')"

echo "#############################"

echo "EXPECTED:
a
d
g"
p "for c in 'adg':
  print(c)"

echo "#############################"

echo "EXPECTED:
stage 1
0
1
2
3
exec"
pw "print('stage 1')"
pw "for i in range(4):"
pw "  print(i)"
p "print('exec')"
