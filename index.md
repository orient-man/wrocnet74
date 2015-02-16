## Jak nauczyliśmy się programować funkcyjnie nic o tym nie wiedząc

Marcin Malinowski

- Twitter: [@orientman](https://twitter.com/orientman)
- GitHub: https://github.com/orient-man
- Blog: https://orientman.wordpress.com/

---

## Abstrakt

Elementy programowania funkcyjnego, na długo przed tym, zanim hipsterzy zaczęli zadawać się z monoidami i zapuszczać funktory, pojawiły się w języku C#. U licha! już ładnych kilka lat piszemy funkcyjnie, nic o tym nie wiedząc. Przyjrzymy się długoletniej pracy chochlików na usługach funkcyjnej policji myśli. Punktem startu będzie najczystszy możliwy kod obiektowy zrefaktorowany przez Wujka Boba, który… poprawimy, a może nawet przepiszemy.

---

## O mnie

- Tata^2, mąż humanistki, mól książkowy, uparciuch, programista, konferencjoholik.  Don Kichot walczący z entropią. Kocha sprzeczności i humor. Wierzy w przypadek. Piwny filozof. W nielicznych wolnych chwilach harata w gałę (na bramce).

- Basic, Turbo Pascal/C, Assembler, Clipper, MS Access, Visual Basic, Java-XML :), C++, C#, JavaScript, F#...  i ze wszystkiego miałem frajdę, ale nie za wszystkim tęsknię.

- Absolwent informatyki i matematyki na UW. Tech lead w firmie Piątka.

***

## Spis rzeczy

1. Czysty kod obiektowy
2. Kod przyprawiony funkcyjnie
3. Spojrzenie za siebie
4. Spojrzenie przed siebie
5. Programowanie funkcyjne w pigułce
6. Zagraj to jeszcze raz, Sam
7. Podsumowanie

***

## Na początku było słowo

<!-- .slide: data-background="./images/book.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

<!-- .element: class="fragment" -->
![Clean Code](./images/clean_code.jpg)

- Dobry prezent dla każdego nowego programisty w zespole
- Opublikowana na początku 2007r.
- Rozdział 14: refaktoring programu Args
- Port 1-1 z Javy do C#

***

## DEMO: Args w C# ##

Note:

- dobre OOP, unit testy, top-down, krótkie metody, dobre nazwy, SRP, łatwo rozszerzalny
- Alt-Enter i do przodu!
- lambdy i factory method (na górę kod, który będzie rozszerzany)
- ``Get<T>`` zamiast GetDouble... (nadal nie podoba mi się object)
- 1 zamiast 5 "zmiennych" instancji
- "zmienna", a raczej wartość bo się nie zmienia
- pure functions
- klasa Args stała się "workiem" na funkcje
- marshaller też jest w zasadzie funkcją
- IEnumerator jedynym stanem

---

<!-- .slide: data-background="./images/spices.jpg" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

## Podsumowanie
### Kod przyprawiony funkcyjnie

- mniej stanu, mniej drapania się po głowie
- funkcje bez efektów ubocznych (wyjątek: ``IEnumerator``)
- o działaniu czystych funkcji można wnioskować z samej deklaracji
- LINQ, generics, lambdy, var...

<!-- .element: class="fragment" -->
Java '06 vs. C# '14 - bój był nierówny...

***

<!-- .slide: data-background="./images/features1.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->
## Teza: C# z każdą wersją zawiera coraz więcej "przypraw" funkcyjnych i to nie jest przypadek

Note:
- za chwilę: stronniczy przegląd zmian w języku C#

---

<!-- .slide: data-background="./images/features2.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

## C# 2 (2005)

- Generics
- Nullable types and ?? operator
- Generators aka iterators
- Anonymous delegates
- Static classes
- ...

---

<!-- .slide: data-background="./images/features3.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->
## C# 3 (2007)

- LINQ
- Anonymous types
- Lambda expressions
- Local variable type inference (var)
- Object &amp; collection initializers
- Automatic properties
- ...

---

<!-- .slide: data-background="./images/features4.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->
## C# 5.0 &amp; .NET 4.5 (2012)

- async / await
- ``IReadOnlyList<>``, ``IReadOnlyDictionary<>``...
- Microsoft.Bcl.Immutable

---

## C# 6.0 (2015)
<!-- .slide: data-background="./images/features5.png" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

- (?) Primary constructors
- Readonly auto properties
- Static type using statements
- (?) Declaration expressions
- Exception filters
- (?) Pattern matching
- Monadic null checking aka null propagator
- Method &amp; property expressions
- (?) Constructor type parameter inference

Note:
 - skąd się to wzięło, kto nam tak język komplikuje?
 - (?) - C# 7
 - inne: semicolon operator: var y = (var x = Foo(); Write(x); x * x))

***

## Unde malum?

![https://twitter.com/dsyme/status/409476721780334592](./images/donsyme.png)

---

> Don Syme is the designer and architect of the F# programming language [...] Earlier, created generics in the .NET Common Language Runtime, including the initial design of generics for the C# programming language [...]

http://en.wikipedia.org/wiki/Don_Syme

***

<!-- .slide: data-background="./images/fp-way-bg.jpg" -->

# C# 6

# Functional way is the right way

---

### Primary constructors / Readonly auto properties

F# dziś:
```fsharp
type Point(x, y) =
    member this.X = x
    member this.Y = y
```

C# 2015:
```csharp
public class Point(int x, int y)
{
    private int x, y;
}
```

```csharp
public class Point(int x, int y)
{
    public int X { get; } = x;
    public int Y { get; } = y;
}
```

---

### Static type using statements

F# dziś:
```fsharp
module Math =
    let Add x y = x + y

Math.Add 2 2
open Math
Add 2 2
```

C# 2015:
```csharp
public static class Math
{
    public static int Add(int x, int y) { return x + y; }
}

using Math;

Add(2, 2);
```

Note: czyli używajmy funkcji jak ludzie

---

###  Declaration expressions

F# dziś:
```fsharp
let success, x = Int32.TryParse("123")
// lub
match TryParse("123") with true, x -> ... | _ -> ...
```

C# 2015:
```csharp
if (int.TryParse("123", out int x)) ... else ...
```

---

### Exception filters

F# dziś:
```fsharp
type ErrorCode = | UnexpectedArgument | InvalidFormat
exception ArgsException of ErrorCode

try
    raise (ArgsException UnexpectedArgument)
with
  | ArgsException UnexpectedArgument -> printfn "Unexpected argument"
  | ArgsException _ -> printfn "Other parsing error"
```

C# 2015:
```csharp
try
{
    throw new ArgsException(ErrorCode.UnexpectedArgument);
}
catch (ArgsException e) if (e.ErrorCode == ErrorCode.UnexpectedArgument)
{
    // ...
}
```

---

### Pattern matching

F# dziś:
```fsharp
let selfAwareTroll n =
    match n with
    | 1 -> "one"
    | 2 -> "two"
    | (3 | 4) -> "some"
    | a -> sprintf "i can't count to %d" a
```

C# ? - to by było coś...

Draft Spec dla C#: https://onedrive.live.com/view.aspx?resid=4558A04E77D0CF5!5396&app=Word

Note:
- switch na dopingu
- przykłady w F# jeszcze się pojawią :)

---

### Monadic null checking aka null propagator

F# dziś:
```fsharp
let (>>=) x y = Option.bind y x // generalnie mało przydatne
```

C# 2015:
```csharp
var bestValue = points?.FirstOrDefault()?.X ?? -1;
```

---

### Method &amp; property expressions (lambdas as definitions)

F# dziś: ha, ha - wolne żarty

C# 2015:
```csharp
public Point Move(int dx, int dy) => new Point(X + dx, Y + dy);
public double Distance => Math.Sqrt((X * X) + (Y * Y));
```

---

### Constructor type parameter inference

F# dziś:
```fsharp
let tuple = (5, "y")
```

C# 2015:
```csharp
// zamiast new Tuple<int, string>(5, "y") / Tuple.Create(5, "y")
var tuple = new Tuple(5, "y");
// zamiast new KeyValuePair<string, Tuple<int, string>>(...)
var pair = new KeyValuePair("x", tuple);
```

***

## Z ostatniej chwili...

C# 7 Design Meeting Notes (2015-01-21):

> Let’s continue being inspired by functional languages, and in particular other languages – F#, Scala, Swift – that aim to mix functional and object-oriented concepts as smoothly as possible

https://github.com/dotnet/roslyn/issues/98

***

### No dobrze, ale co to właściwie jest programowanie funkcyjne?

Rychło w czas...

Note:
- albo czym się jakościowo różni FP od OOP

---

### Przykład

<!-- .element: class="fragment" -->
![https://twitter.com/gregyoung/status/58816147272896512](./images/foldleft.png)

<!-- .element: class="fragment" -->
DEMO z małym twistem, czyli "right fold" w F#

Note:

- bądźmy maksymalistami
- Playground.fs
- ciegiełkami są funkcje
- ważne są typy
- automatyczna generalizacja

***

### DEMO: Args w F# ###

Note:
- git checkout bang

***

<!-- .slide: data-background="./images/fp_contra_oop.jpg" -->

Note:
- co się spotkało z szybką ripostą Wujka Boba (bibliografia)
- skojarzenie lego Piraci vs. Technics

---

<!-- .slide: data-background="./images/fp_contra_oop.jpg" style="display: block; background: rgba(0, 0, 0, 0.4);" -->

## Samouczek funkcyjny

C# | F#
--- | ---
wyjątki | funkcje dwutorowe (monada ROP)
pętle | funkcje rekurencyjne
zmienne | parametry funkcji (akumulator), monady
składnia *fluent* | częściowa aplikacja argumentów
if/then/else/switch| pattern matching
...

Note:
- co się spotkało z szybką ripostą Wujka Boba (bibliografia)
- F# bez części kompatybilnej z C# byłby małym językiem
- skojarzenie lego Piraci vs. Technics
- ponad różnicami składnowymi, które są oczywiście ważne...

---

## Intuicje zamiast podsumowania

 - <!-- .element: class="fragment" --> C# czerpie pełnymi garściami z języków funkcyjnych
 - <!-- .element: class="fragment" --> prawdopodobnie zawsze pozostanie w kategorii "OOP first"
 - <!-- .element: class="fragment" --> system typów może być pomocą a nie zawalidrogą (*static* vs. *dynamic typing*? *static* + *type inference*!)
 - <!-- .element: class="fragment" --> naturalna ewolucja od monolitu do niezależnych jednostek; najpierw obiektów, potem funkcji
 - <!-- .element: class="fragment" --> małe jednostki łatwiej zrozumieć, są elastyczne i dają szybką pętlę zwrotną (REPL, testy)
 - <!-- .element: class="fragment" --> nie powinniśmy brnąć w kierunku FP za wszelką cenę

Note:

 - FP jest trudne, może boleć głowa ;)
 - nie chodzi o to bym Was nauczył, a zainspirować: programowanie jest fajne!

***

<!-- .slide: data-background="./images/forcsharp1.png" style="top: 300px !important;" -->
## Na koniec

<!-- .element: class="fragment" -->
Co wybrać?

---

<!-- .slide: data-background="./images/forcsharp2.png" data-transition="convex" -->
# F#?

---

<!-- .slide: data-background="./images/forcsharp3.png" data-transition="convex" -->
# C#?

---

<!-- .slide: data-background="./images/forcsharp4.png" data-transition="convex" -->
## Polyglot Programming!

***

![Rękopis znaleziony w Saragossie](./images/rekopis.jpg)

***

## Bibliografia

- Blog: [F# for fun and profit](http://fsharpforfunandprofit.com/) - skarbiec!
- Artykuł: [Why Functional Programming Matters](http://www.cse.chalmers.se/~rjmh/Papers/whyfp.html)
- Książka: [Real-World Functional Programming: With Examples in F# and C# - Petricek & Skeet](http://www.amazon.com/Real-World-Functional-Programming-With-Examples/dp/1933988924)

Materiały:

- Slajdy: http://wrocnet74.orientman.com/
- Źródłowce: https://github.com/orient-man/CleanArgs

---

### Bibligrafia (horyzonty)

- [Don Syme - .NET/C# Generics History](http://blogs.msdn.com/b/dsyme/archive/2011/03/15/net-c-generics-history-some-photos-from-feb-1999.aspx)
- [Jared Parsons - Experiences using F# in VsVim](http://blog.paranoidcoding.com/2014/10/31/experiences-using-fsharp-in-vsvim.html)
- [John Carmack - In-depth: Functional programming in C++](http://gamasutra.com/view/news/169296/Indepth_Functional_programming_in_C.php)
- [Robert C. Martin (Uncle Bob) - OO vs FP](http://blog.cleancoder.com/uncle-bob/2014/11/24/FPvsOO.html)
- Video: [Scott Wlaschin - Railway Oriented Programming -- error handling in functional languages](http://vimeo.com/97344498)

***

# Aaa... pytania?
