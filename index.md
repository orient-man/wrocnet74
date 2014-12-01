### Jak nauczyliśmy się programować funkcyjnie nic o tym nie wiedząc

- Twitter: [@orientman](https://twitter.com/orientman)
- GitHub: https://github.com/orient-man
- Blog: https://orientman.wordpress.com/

---

### O mnie

- Tata^2, mąż humanistki, mól książkowy, uparciuch, programista, konferencjoholik.  Don Kichot walczący z entropią. Kocha sprzeczności i humor. Wierzy w przypadek. Piwny filozof. W nielicznych wolnych chwilach harata w gałę (na bramce).

- Basic, Turbo Pascal/C, Assembler, Clipper, MS Access, Visual Basic, Java-XML :), C++, C#, JavaScript, F#...  i ze wszystkiego miałem frajdę, ale nie za wszystkim tęsknię.

- Absolwent informatyki i matematyki na UW. Tech lead w firmie Piątka.

---

### Abstrakt

Elementy programowania funkcyjnego, na długo przed tym, zanim hipsterzy zaczęli zadawać się z monoidami i zapuszczać funktory, pojawiły się w języku C#. U licha! już ładnych kilka lat piszemy funkcyjnie, nic o tym nie wiedząc. Przyjrzymy się długoletniej pracy chochlików na usługach funkcyjnej policji myśli. Punktem startu będzie najczystszy możliwy kod obiektowy zrefaktorowany przez Wujka Boba, który… poprawimy, a może nawet przepiszemy.

***

### Na początku było słowo (pisane)

<!-- .slide: data-background="./images/book.jpg" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

<!-- .element: class="fragment" -->
![Clean Code](./images/clean_code.jpg)

 - Dobry prezent dla każdego programisty w zespole
 - Opublikowana na początku 2007r.
 - Rozdział 14: refaktoring programu Args
 - Port 1-1 z Javy do C#

***

### Args

Każdy kiedyś popełnił parser argumentów :)

```cs
// Example usage: Args.exe -l -p 4444 -d "C:\Windows\Temp"
private static void Main(string[] args)
{
    var schema = "l,p#,d*";
    var arg = new Args(schema, args);
    var logging = arg.GetBoolean('l');
    var port = arg.GetInt('p');
    var directory = arg.GetString('d');
    // ...
}
```

---

### DEMO: CSharpArgs2

 - Alt-Enter i do przodu! :)

***

### Java '07 vs. C# '14

To był nierówny bój...

---
#### C# 2 (2005)

 - Generics
 - Nullable types and ?? operator
 - Generators aka iterators
 - Anonymous delegates

---

#### C# 3 (2007)

 - LINQ
 - Anonymous types
 - Lambda expressions
 - Local variable type inference (var)
 - Object &amp; collection initializers
 - Automatic properties
 - ...

---

#### C# 5.0 &amp; .NET 4.5 (2012)

 - async / await
 - IReadOnlyList<>, IReadOnlyDictionary<>...
 - BCL: ImmutableArray<>...

***

### Unde malum?

![https://twitter.com/dsyme/status/409476721780334592](./images/donsyme.png)

---

> Don Syme is the designer and architect of the F# programming language [...] Earlier, created generics in the .NET Common Language Runtime, including the initial design of generics for the C# programming language [...]

http://en.wikipedia.org/wiki/Don_Syme

***

<!-- .slide: data-background="./images/fp-way-bg.jpg" style="padding: 20px; display: block; background: rgba(0, 0, 0, 0.4);" -->

### Functional way is the right way
#### C# 6.0 (2015)

 - (?) Primary constructors
 - Readonly auto properties
 - Static type using statements
 - Declaration expression (TryParse)
 - Exception filters
 - (?) Pattern matching
 - Monadic null checking aka null propagator (x?.y)
 - Method &amp; property expressions (lambdas as definitions)
 - (?) Constructor type parameter inference (new Tuple(5, ""))

***

<!-- .slide: data-background="./images/skull.png" style="top: -50px !important;" -->
## Gdzie te Monady?

> "Monady – byty duchowe; nie mają charakteru czasowego ani przestrzennego"

---

<!-- .slide: style="top: -100px !important;" -->
![Barbie](./images/barbie_monad.png)

---

### Tako rzecze źródło wszelkiej wiedzy

"Monada jest rodzajem <font color="#fa0">konstruktora abstrakcyjnego typu danych</font> [...] Monady pozwalają programiście <font color="#fa0">sprzęgać ze sobą kolejno wykonywane działania</font> i budować potoki danych, w których każda akcja jest materializacją wzorca <font color="#fa0">dekoratora z dodatkowymi regułami przetwarzającymi</font>.

Formalnie monadę tworzy się definiując dwie operacje – wiązanie (ang. <font color="#fa0">bind</font>) i powrót (ang. <font color="#fa0">return</font>) [...]"

http://pl.wikipedia.org/wiki/Monada_%28programowanie%29

---

<!-- .slide: data-transition="convex" -->
![Ginger](./images/ginger.jpeg)

---

### Ostatnia szansa: przez przykład
```csharp
public static Task<T> ToTask<T>(this T value) // aka "unit" lub "return"
{
    return Task<T>.Factory.StartNew(() => value);
}

public static Task<B> Bind<A, B>(this Task<A> a, Func<A, Task<B>> func)
{
    return a.ContinueWith(b => func(b.Result)).Unwrap();
}

public static Task<C> SelectMany<A, B, C>(
    this Task<A> a, Func<A, Task<B>> func, Func<A, B, C> select)
{
    return a.Bind(
        aval => func(aval).Bind(bval => select(aval, bval).ToTask()));
}
```

---

### Co to robi?

```csharp
Func<Task<int>> compute5 = () => 5.ToTask();
Func<Task<int>> compute7 = () => 7.ToTask();
Func<int, int, Task<int>> add = (x, y) => (x + y).ToTask();

var r =
    from a in compute5()
    from b in compute7()
    from c in add(a, b)
    select c * 2;

r.Result.Should().Be(24);
```

Note: Pokazać konwersję LINQ na fluent

