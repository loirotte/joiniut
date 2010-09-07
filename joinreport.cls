%%%%%%
% joinreport
% (C) Jonathan Aceituno
% You can do what you want with this, but if you say it is your work, then
% you've got a problem with your mind.
%%%%%%

%%
%% Généralités
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{joinreport}

%\XeTeXdefaultencoding utf-8

% On se base sur le report de KOMA-Script
\LoadClass[a4paper,11pt]{scrreprt}
%\LoadClass[a4paper,11pt]{scrbook}

% Des fontes qu'il faut charger de suite pour ne pas avoir d'erreurs
% plus tard dans la compilation (même si elle ne sont pas utilisées
% par tous les fichiers)
\RequirePackage{amssymb}

% Support du français
\RequirePackage[francais]{babel}

% Modification des titres
\RequirePackage[explicit]{titlesec}
\RequirePackage{fancyhdr,setspace,titletoc}
\RequirePackage{ifthen}

% Graphiques de base et symboles AMS
%\RequirePackage{graphicx}
%\RequirePackage{amssymb}

% Graphiques avancés
\RequirePackage{tikz, float, caption}
\usetikzlibrary{shapes}

% Gestion de polices OpenType avec XeTeX, gestion de l'Unicode
%\RequirePackage{fontspec,xltxtra,xunicode}
\RequirePackage{fontspec,xltxtra}




%%
%% Polices par défaut
%%

% Ensemble de polices courantes sous Linux et pas trop moches
\newcommand{\fontslinux}{
	\setmainfont{Liberation Serif}
	\setsansfont{Liberation Sans}
	\setmonofont{Liberation Mono}
	\newfontfamily{\hwfont}{Comic Sans MS}
	\newfontfamily{\fatfont}{Arial Black}
	\newfontfamily{\authorfont}{Liberation Serif}
}
% Ensemble de polices installées sur Mac OS X
\newcommand{\fontsmac}{
	\setmainfont[BoldFont={Optima Bold}]{Optima}
	\setsansfont[BoldFont={Kozuka Gothic Pro B}]{Kozuka Gothic Pro M}
	\setmonofont[BoldFont={Courier Bold}]{Courier}
	\newfontfamily{\hwfont}{Marker Felt}
	\newfontfamily{\fatfont}{Kozuka Gothic Pro H}
	\newfontfamily{\authorfont}{Zapfino}
}
% Uniquement des polices de LaTeX, pas de pignolette de fontspec
\newcommand{\fontslatex}{
	\newcommand{\hwfont}{\sffamily}
	\newcommand{\fatfont}{\bfseries\sffamily}
	\newcommand{\authorfont}{}
}
% Ensemble de polices so Windows des 90's (c'est moche)
\newcommand{\fontswindows}{
	\setmainfont{Times New Roman}
	\setsansfont{Arial}
	\setmonofont{Courier New}
	\newfontfamily{\hwfont}{Comic Sans MS}
	\newfontfamily{\fatfont}{Arial Black}
	\newfontfamily{\authorfont}{Times New Roman}
}
% Ensemble de polices professionnelles
\newcommand{\fontsclasses}{
	\setmainfont{Optima LT Std}
	\setsansfont{Myriad Pro}
	\setmonofont[BoldFont={ITC American Typewriter Std Bold}]{ITC American Typewriter Std Medium}
	\newfontfamily{\hwfont}{Marker Felt Thin}
	\newfontfamily{\fatfont}{Myriad Pro Black}
	\newfontfamily{\authorfont}{Trajan Pro Bold}
}

% Ensemble de polices Phil
\newcommand{\fontsphil}{
	\setmainfont{Liberation Serif}
	\setsansfont{Liberation Sans}
	\setmonofont[Scale=.8]{Liberation Mono}
	\newfontfamily{\hwfont}{Comic Sans MS}
	\newfontfamily{\fatfont}{Arial Black}
	\newfontfamily{\authorfont}{Liberation Serif}
%        \fontspec[SmallCapsFont=LMRoman10 Caps]{Palatino}
%        \fontspec[SmallCapsFeatures={Letters=SmallCaps}]{Liberation Serif}
        \fontspec[SmallCapsFont={Arial Black}]{Arial Black}
}

% Voici le choix par défaut
%\fontslinux
\fontsphil
%\fontsclasses
%\fontslatex
%\fontswindows

% On traite les options pour mettre le choix de police par défaut
\DeclareOption{fontsclasses}{\fontsclasses}
\DeclareOption{fontswindows}{\fontswindows}
\DeclareOption{fontslinux}{\fontslinux}
\DeclareOption{fontsmac}{\fontsmac}
\ProcessOptions


%%
%% Couleurs
%%
\definecolor{colortt}{RGB}{245,190,0}
\definecolor{colorcomment}{RGB}{130,130,130}
\definecolor{colortoc}{RGB}{100,100,100}
\definecolor{colorfoot}{RGB}{100,100,100}
\definecolor{colorgrey}{RGB}{100,100,100}
\definecolor{colorlistnumb}{RGB}{100,100,100}
\definecolor{color1}{RGB}{190,190,190}
\definecolor{color2}{RGB}{255,190,0}
\definecolor{color3}{RGB}{104,142,255}
\definecolor{codebackground}{RGB}{248,248,248}
\definecolor{codekeywords}{RGB}{59,40,192}
\definecolor{codestring}{RGB}{70,123,191}



%%
%% Listings de code
%%
\RequirePackage{listingsutf8}
\lstset{%
        extendedchars=\true,
        inputencoding=utf8,
        extendedchars=false,
	basicstyle=\ttfamily\upshape,
	stringstyle=\bfseries\textcolor{codestring},
	commentstyle=\textcolor{colorcomment},
        keywordstyle=\bfseries,
	tabsize=8,
	numbers=left,
	numberstyle=\footnotesize\sffamily\textcolor{colorlistnumb},
	breaklines=true,
	showstringspaces=false,
        backgroundcolor=\color{codebackground}
}


%%
%% Fonctions
%%

% Création d'une boîte colorée avec du texte dedans (pas plus d'une ligne !)
% On ne peut pas mettre plus d'une ligne car TikZ ne sait pas faire du
% multiligne avec des noeuds si on ne lui fixe pas la largeur de la boîte.
% Je pourrais tenter de résoudre ce problème un jour, en utilisant
% \ifthenelse, mais on ne pourra pas insérer ce genre de boîtes naturellement
% dans le texte.
\newcommand{\emboiter}[3][4pt]{%
\begin{tikzpicture}[baseline=-0.1cm]
% Rectangle
  \node[rectangle,draw=#2,fill,top color=#2!30, bottom color=#2!90,rounded corners=#1] {{#3}};
\end{tikzpicture}%\xspace%
}




%%
%% En-têtes et pieds de porc
%%

\newcommand{\piedpage}[2][lightgray]{
	\begin{tikzpicture}[baseline=-0.13cm]
		\node[circle, draw=#1, fill, color=#1, text=black]{\bfseries#2};
	\end{tikzpicture}
}


% Pas de lignes noires moches
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Juste le chapitre centré
% \newcommand{\entetespiedspage}{%
% 	\fancyhead[L,C,R]{}
%         \fancyhead[C]{\small\textcolor{lightgray}\leftmark}
% 	\fancyfoot[L,C,R]{}
% 	\fancyfoot[LO,RE]{\small\textcolor{lightgray}\@author}
% 	\fancyfoot[RO,LE]{\hspace*{-1.4cm}\piedpage{\thepage}\hspace*{-1.4cm}}%
% }
\newcommand{\entetespiedspage}{%
	\fancyhead[L,C,R]{}
	\fancyfoot[L,C,R]{}
	\fancyfoot[LO,RE]{\small\textcolor{lightgray}\@author}
	\fancyfoot[RO]{\fatfont\footnotesize\hspace*{-1.3cm}\rightmark~~|~~\thepage\hspace*{-1.3cm}}%
	\fancyfoot[LE]{\fatfont\footnotesize\hspace*{-1.3cm}\thepage~~|~~\leftmark\hspace*{-1.3cm}}%
}
\newcommand{\entetespiedspageplain}{%
	\fancyhead[L,C,R]{}
	\fancyfoot[L,C,R]{}
	\fancyfoot[LO,RE]{\small\textcolor{lightgray}\@author}
	\fancyfoot[RO,LE]{\fatfont\footnotesize\hspace*{-1.3cm}\textbf{\thepage}\hspace*{-1.3cm}}%
}

% On enlève tout en haut, on remplace par le nom du chapitre.
\fancypagestyle{plain}{\entetespiedspageplain}

% Personnalisation du style par défaut
\pagestyle{fancy}
% Pas de titre de chapitre en majuscule
\renewcommand{\chaptermark}[1]{%
\markboth{{\chaptername\ \thechapter. #1}}{}}
% Pas de titre de section en majuscule
\renewcommand{\sectionmark}[1]{%
\markright{{Section\ \thesection. #1}}{}}
\entetespiedspage



%%
%% Redéfinitions de style
%%

% Descriptions
\renewcommand{\descriptionlabel}[1]{
\emboiter[5pt, top color=color1, bottom color=color1, color=black, draw=color1]{color1}{\sffamily\bfseries{}#1}
}

% Notes de bas de page
\makeatletter
% Numéro apparu dans le texte
\renewcommand{\@makefnmark}{%
	\begin{tikzpicture}[baseline=-6pt]\node[rectangle, rounded corners=4pt, fill, color=gray, inner sep=1.5pt, text=white]{\sffamily\bfseries\scriptsize{\@thefnmark}};\end{tikzpicture}
}
% Texte en bas de la page
\renewcommand\@makefntextFB[1]{% 
    \parindent 1em% 
    \begin{tikzpicture}[baseline=-0.1cm]\node[rectangle, rounded corners=4pt, fill, color=gray, inner sep=1.5pt, text=white]{\sffamily\bfseries\scriptsize{\@thefnmark}};\end{tikzpicture}~\textcolor{colorfoot}{#1}}
\makeatother


% Mathématiques (conventions françaises sur l'apparence de ≤ et ≥)
\renewcommand{\leq}{\ensuremath{\leqslant}}
\renewcommand{\geq}{\ensuremath{\geqslant}}


% Texte machine à écrire
\renewcommand{\texttt}[1]{\emboiter[4pt, inner sep=3pt]{colortt}{{\fontsize{11}{11}\ttfamily{}#1}}}

% Texte manuscrit
\newcommand{\texthw}[1]{{\hwfont#1}}


% Etiquette de flottant
\newcommand{\captionfonts}{\sffamily}
\makeatletter 
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\captionfonts\emboiter[8pt, inner sep=5pt,
  text=white, top color=gray, bottom color=gray,
  draw=gray]{black}{\footnotesize{}\textbf{#1}\ifthenelse{\equal{#1}{}}{}{~: }#2}}}%
  \ifdim \wd\@tempboxa >\hsize
    {\captionfonts\emboiter[8pt, text=white, top color=gray, bottom color=gray, draw=gray]{black}{\sffamily\bfseries{}#1} \footnotesize{}#2\par}
  \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\makeatother  


% Items de liste
\renewcommand{\labelitemi}{•}








%%
%% Titres de sections
%%
\setcounter{secnumdepth}{3}

\def\thesection{\arabic{section}}
\def\thesubsection{\arabic{subsection}}
\def\thesubsubsection{\alph{subsubsection}}

\titleformat{\chapter}[display]%
%	{\filleft\normalfont\bfseries\Huge}
	{\filleft\sffamily\bfseries\fontsize{36}{36}\selectfont}
	{\begin{tikzpicture}[overlay]
	% Rectangle
      \draw[rounded corners=15pt,draw=white,fill,top color=color1!30, bottom color=color1] (-3.5cm,1.75cm) rectangle (0.5cm,-2.25cm);
      \draw[color=white] (-1.4cm,0cm) node {\sffamily\fontsize{54}{54}\fatfont\thechapter};
      \draw[color=black] (-1.47cm,1.12cm) node {\sffamily\small{}\MakeUppercase{\chaptertitlename}};
    \end{tikzpicture}}%
	{8pt}{#1}{}

% \titleformat{\section}[display]%
% 	{\bfseries\LARGE }
% 	{\begin{tikzpicture}[overlay]
%       \draw[rounded corners=5pt,draw=white,fill,top color=color3!30, bottom color=color3] (-1.8cm,-0.2cm) rectangle (-0.3cm,-1.8cm);
%       \draw[color=white] (-1.06cm,-1.45cm) node { \fontsize{32}{32}\fatfont{}\thesection };
%       \draw[color=color3!50] (-1.02cm,-0.1cm) node {\tiny{}SECTION};
%     \end{tikzpicture}}%
% 	{0pt}{#1}{}
	
% \titleformat{\section}[display]%
% 	{\bfseries\LARGE }
% 	{\begin{tikzpicture}[overlay]
%       \draw[rounded corners=5pt,draw=white,fill,top color=color3!30, bottom color=color3] (-1.5cm,-0.2cm) rectangle (-0.3cm,-1.4cm);
%       \draw[color=white] (-0.89cm,-1.05cm) node { \fontsize{32}{32}\fatfont{}\thesection };
%       \draw[color=color3!50] (-0.89cm,-0.1cm) node {\tiny{}SECTION};
%     \end{tikzpicture}}%
% 	{0pt}{#1}{}

\titleformat{\section}[display]%
	{\bfseries\LARGE\sffamily }
	{\begin{tikzpicture}[overlay]
      \draw[rounded corners=5pt,draw=white,fill,top color=color3!30, bottom color=color3] (-0.7cm,-0.2cm) rectangle (0.9cm,-1.4cm);
      \draw[color=white] (0.11cm,-0.95cm) node { \fontsize{32}{32}\fatfont{}\thesection };
      \draw[color=color3!50] (0.11cm,-0.1cm) node {\sffamily\tiny{}SECTION};
    \end{tikzpicture}}%
	{0cm}{\hspace*{1cm}#1}{}


\titleformat{\subsection}%
	{\bfseries\fontsize{13}{13}\sffamily}%
	{}%
	{0pt}{%\emboiter[8pt]{color2}{
		\begin{tikzpicture}[baseline=-0.14cm]
			\node[inner sep=4pt, rectangle, rounded corners=8pt, draw=black, fill, color=black, text=white]{\sffamily\bfseries{}\thesubsection};
		\end{tikzpicture}\thinspace\thinspace #1
	%}
	}{}
	

\titleformat{name=\subsubsection}[hang]%
%	{\sffamily\large}%
	{\small\sffamily}%
	{}%
	{10pt}{\emboiter[5pt,top color=lightgray, bottom color=lightgray]{lightgray}{
		\begin{tikzpicture}[overlay,baseline=-0.14cm]
			\node[circle, inner sep=3pt, draw=gray, fill, color=gray, text=white]{\bfseries\thesubsubsection};
		\end{tikzpicture}\quad\thinspace #1
	}}{}
	
\titleformat{name=\subsubsection,numberless}[hang]%
%	{\sffamily\large}%
	{\small\sffamily}%
	{}%
	{10pt}{\emboiter[5pt,top color=lightgray, bottom color=lightgray]{lightgray}{#1}}{}



%%
%% Page de garde
%%
\definecolor{colortitle}{RGB}{255,209,187}
\makeatletter
\renewcommand{\maketitle}{
\renewcommand{\and}{\\}
\begin{titlepage}
		\vfill
		~
		\vfill
		\begin{flushright}
		\emboiter[30pt, inner sep=1cm,text width=14cm, text=white, top color=lightgray, bottom color=lightgray, draw=lightgray, text=white]{colortitle}{\begin{flushright}\fontsize{36}{36}\bfseries\sffamily\@title\end{flushright}}
		\end{flushright}
		\vfill
		\begin{doublespace}{\LARGE\authorfont\@author}\end{doublespace}
		\@date
\end{titlepage}
\renewcommand{\and}{ • }
}
\makeatother

% A utiliser correctement !
\newcommand{\entetegraphique}[4]{%
\date{%
\begin{tikzpicture}[overlay]
	\draw[color=color1] (8cm,-1cm) -- (8cm, 9cm);
    \draw[rectangle, fill, draw=black, color=color1, text width=10cm] (13.5cm,-0cm) node {\Large{}#2\\\textbf{#3}\\\large{#4}};
\end{tikzpicture}\includegraphics{#1}
}
}





%%
%% Table des matières
%%
% Pas plus que les chapitres et les sections
\setcounter{tocdepth}{2}

% La table des matières s'appelle sommaire
\addto\captionsfrench{\renewcommand{\contentsname}{Sommaire}}

\titlecontents{section} [2.85em]
{}
{{\sffamily\contentslabel{1.3em}}}
{\hspace*{-1.3em}}
{\textcolor{lightgray}{\titlerule*[1pc]{.}}\textcolor{colortoc}{\contentspage}}

\titlecontents{subsection} [4.2em]
{} 
{{\sffamily\contentslabel{1.3em}}}
{\hspace*{-1.3em}}
{\textcolor{lightgray}{\titlerule*[1pc]{.}}\textcolor{colortoc}{\contentspage}}

