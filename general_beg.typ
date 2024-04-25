#import "@preview/touying:0.4.0": *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.4.3" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import emoji: face
// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Register university theme
// You can remove the theme registration or replace other themes
// it can still work normally
#let s = themes.university.register(aspect-ratio: "16-9")

// Set the numbering of section and subsection
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [Optimal Control],
  subtitle: [MPC Basics: Numerical Optimization \ Sequential Quadratic Programming],
  author: [Erchao Rong],
  date: datetime.today(),
  institution: [Sun Yat-sun University],
)

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let s = (s.methods.append-preamble)(self: s, pdfpc.config(
  duration-minutes: 30,
  start-time: datetime(hour: 14, minute: 10, second: 0),
  end-time: datetime(hour: 14, minute: 40, second: 0),
  last-minutes: 5,
  note-font-size: 12,
  disable-markdown: false,
  default-transition: (
    type: "push",
    duration-seconds: 2,
    angle: ltr,
    alignment: "vertical",
    direction: "inward",
  ),
))

// Theroems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

// Extract methods
#let (init, slides, touying-outline, alert) = utils.methods(s)
#show: init

#show strong: alert

// Extract slide functions
#let (slide, empty-slide) = utils.slides(s)
#show: slides

#let magic(term) = box[#emoji.face *#term*]

= Reference

== Reference 
Numerical Optimization in Robotics by Wang et al.\
Convex Optimization by Boyd et al.\
Convex Optimization by Ryan et al.\
https://www.stat.cmu.edu/~ryantibs/convexopt/

= Convex optimization 

== Problem formulation
#figure(
  image("Figures/convex_optimization.png")
)

== Convex set 
#slide[
  #figure(
  image("Figures/convex_set.png")
)
]

#slide[
  #figure(
  image("Figures/convex_hull.png")
)
]

#slide[
  #figure(
  image("Figures/halfs.png"),
)
  #figure(
  image("Figures/ellipsoid.png"),
)
]

== Operations perserves convexity
+ #magic[Intersection] \ the intersection of (any number of) convex sets is convex
+ #magic[Affine mappings]\ if $f:RR^n -> RR^m $ is affine: $f(x) = A x + b$, $A in RR^{m times n}$ and $b in RR^{m}$
+ #magic[scaling, translation]
+ #magic[projection onto some coordinates]: ${x|(x,y) in S}$
+ #magic[solution set of linear matrix inequality]: \ ${x|x_1 A_1 + ... + x_n A_n + B < 0}$ with $A_i in S^p$ and $B in S^p$
+ #magic[persepctive function] $P : RR^(n+1) -> RR^(n)$, $P(x,t)=x/t $, $t>0$
+ #magic[linear-fractional function] $f : RR^n -> RR^m$:\
  $f(x) = (A x + b) / (c^T x + d)$, $c^T x + d > 0$
== Convex function
  #figure(
  image("Figures/epi.png"),
)
== Operations perserves convexity
  #figure(
  image("Figures/ops_conv.png"),
)

== Proper cone and Generalized inequality
#slide[
    #figure(
  image("Figures/proper_cone.png"),
)
]

#slide[
    #figure(
  image("Figures/gn.png"),
)
]
= Unconstrained Optimization
== Moving strategy
#magic[Given] current point $x_k$ and a direction $p_k$ , how we move to the new iterate $x_(k+1)$ .

+ #magic[Line Search]
  - Exact
  - Inexact
    - Backtracking line serach (Armijo rule)\ 
    $f(x_k + alpha_k p_k) <= f(x_k) + c_1 alpha_k p_k^T nabla f(x_k)$
    - Wolfe conditions (Curvature condition) [$0 < c_1 < c_2 < 1$]
      + Weak wolfe condition: $-p_k^T nabla f(x_k + alpha_k p_k) <= -c_2 p_k^T nabla f(x_k)$
      + Strong wolfe condition: \ $|p_k^T nabla f(x_k + alpha_k p_k)| <= c_2 |p_k^T nabla f(x_k)|$
+ #magic[Trust Region]
the information about $f$ is used to construct a model $m_k$ whose behavior near the current point $x_k$ is similar to that of $f$.

$ min_p m_k (x_k + p)$ where $x_k + p$ lies inside the trust region.
Typically, $m_k (x_k + p) = f_k p^T nabla f_k + 1/2 p^T B_k p$.
== First Order Method
#slide[
+ #magic[Gradient descent]:\ $x^(k) = x^(k-1) - alpha nabla f(x^(k-1))$
+ #magic[Proximal Gradient descent]:\ $x^(+) = arg min_y f(x) + nabla f(x)^T (y - x) + 1/(2 t) ||y-x||^2_2 $
+ Others
]
#slide[
https://towardsdatascience.com/a-visual-explanation-of-gradient-descent-methods-momentum-adagrad-rmsprop-adam-f898b102325c
]

== Motivation
#slide[
#figure(
  image("Figures/sg_draw.png")
)
]
#slide[
#figure(
  image("Figures/cv_ad.png")
)
]

== Second Order Method
+ #magic[Newtion]
+ #magic[BFGS]
+ #magic[LBFGS]
+ #magic[Gaussian-Newtion]

// #slide[
//   We can use `#pause` to #pause display something later.

//   #pause
  
//   Just like this.

//   #meanwhile
  
//   Meanwhile, #pause we can also use `#meanwhile` to #pause display other content synchronously.
// ]


// == Complex Animation

// #slide(repeat: 3, self => [
//   #let (uncover, only, alternatives) = utils.methods(self)

//   At subslide #self.subslide, we can

//   use #uncover("2-")[`#uncover` function] for reserving space,

//   use #only("2-")[`#only` function] for not reserving space,

//   #alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.
// ])


// == Math Equation Animation

// #slide[
//   Touying equation with `pause`:

//   #touying-equation(`
//     f(x) &= pause x^2 + 2x + 1  \
//          &= pause (x + 1)^2  \
//   `)

//   #meanwhile

//   Here, #pause we have the expression of $f(x)$.
  
//   #pause

//   By factorizing, we can obtain this result.
// ]


// == CeTZ Animation

// #slide[
//   CeTZ Animation in Touying:

//   #cetz-canvas({
//     import cetz.draw: *
    
//     rect((0,0), (5,5))

//     (pause,)

//     rect((0,0), (1,1))
//     rect((1,1), (2,2))
//     rect((2,2), (3,3))

//     (pause,)

//     line((0,0), (2.5, 2.5), name: "line")
//   })
// ]


// == Fletcher Animation

// #slide[
//   Fletcher Animation in Touying:

//   #fletcher-diagram(
//     node-stroke: .1em,
//     node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
//     spacing: 4em,
//     edge((-1,0), "r", "-|>", `open(path)`, label-pos: 0, label-side: center),
//     node((0,0), `reading`, radius: 2em),
//     edge((0,0), (0,0), `read()`, "--|>", bend: 130deg),
//     pause,
//     edge(`read()`, "-|>"),
//     node((1,0), `eof`, radius: 2em),
//     pause,
//     edge(`close()`, "-|>"),
//     node((2,0), `closed`, radius: 2em, extrude: (-2.5, 0)),
//     edge((0,0), (2,0), `close()`, "-|>", bend: -40deg),
//   )
// ]


// = Theroems

// == Prime numbers

// #definition[
//   A natural number is called a #highlight[_prime number_] if it is greater
//   than 1 and cannot be written as the product of two smaller natural numbers.
// ]
// #example[
//   The numbers $2$, $3$, and $17$ are prime.
//   @cor_largest_prime shows that this list is not exhaustive!
// ]

// #theorem("Euclid")[
//   There are infinitely many primes.
// ]
// #proof[
//   Suppose to the contrary that $p_1, p_2, dots, p_n$ is a finite enumeration
//   of all primes. Set $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
//   it cannot be prime. Thus, some prime factor $p_j$ divides $P + 1$.  Since
//   $p_j$ also divides $P$, it must divide the difference $(P + 1) - P = 1$, a
//   contradiction.
// ]

// #corollary[
//   There is no largest prime number.
// ] <cor_largest_prime>
// #corollary[
//   There are infinitely many composite numbers.
// ]

// #theorem[
//   There are arbitrarily long stretches of composite numbers.
// ]

// #proof[
//   For any $n > 2$, consider $
//     n! + 2, quad n! + 3, quad ..., quad n! + n #qedhere
//   $
// ]


// = Others

// == Side-by-side

// #slide[
//   First column.
// ][
//   Second column.
// ]


// == Multiple Pages

// #slide[
//   #lorem(200)
// ]


// // appendix by freezing last-slide-number
// #let s = (s.methods.appendix)(self: s)
// #let (slide, empty-slide) = utils.slides(s)

// == Appendix

// #slide[
//   Please pay attention to the current slide number.
// ]