#include <functional>
#include <iostream>

// типов синоним на едноместна функция, която приема
// аргумент от тип Arg и връща нещо от тип Result
template<typename Arg, typename Result>
using UnaryFunction = std::function<Result(Arg)>;

// искаме да дефинираме композиция
// o: (B -> C) x (A -> B) -> (A -> C)

// compose*
template<typename A, typename B, typename C>
C composeStar(UnaryFunction<B, C> const &f, UnaryFunction<A, B> const &g, A x) {
  return f(g(x));
}

// compose
template<typename A, typename B, typename C>
UnaryFunction<A, C> compose(UnaryFunction<B, C> const &f, UnaryFunction<A, B> const &g) {
  return [&f, &g](A x) -> C { return f(g(x)); };
}

int add1(int x) { return x + 1; }
int mul3(int x) { return x * 3; }

int main() {

  // (compose* 1+ 3* 2)
  std::cout << composeStar<int, int, int>(add1, mul3, 2) << std::endl;

  // ((compose 1+ 3*) 2)
  std::cout << compose<int, int, int>(add1, mul3)(2) << std::endl;

  return 0;
}
