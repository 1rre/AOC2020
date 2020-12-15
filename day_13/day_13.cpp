#include <iostream>
#include <vector>
#include <string>
#include <future>

using namespace std;

const vector<pair<int,int>> x = {make_pair(41,20), make_pair(37,56),make_pair(557,62),make_pair(29,64),make_pair(13,75),make_pair(17,79),make_pair(23,85),make_pair(19,19)};


long long int fut(int offset);
bool check(long long int& n);


int main() {
  auto futures = {
    async(fut, 0),
    async(fut, 1),
    async(fut, 2),
    async(fut, 3),
    async(fut, 4),
    async(fut, 5),
    async(fut, 6),
    async(fut, 7)
  };

  while(true) {}
}

long long int fut(int offset) {
  long long int n = 419 * offset;
 l1:
  n += 3352;
  if(!check(n)) goto l1;
 l2:
  cout<<n-73<<endl;
  goto l2;
  return 0;
}

bool check(long long int& n) {
  if (n % 10000000 == 0) cout<<n<<"\n";
  auto it = x.begin();
 l1:
  if (it == x.end()) return true;
  if (n - it -> first % n != it -> second) return false;
  it++;
  goto l1; 
}


