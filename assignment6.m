%% Assignment # 6
% Jarren Ralf
%
% # An individual possesses 3 umbrellas that he employs in going from his
% home to office and vice versa. If he is at home at the beginning of the
% day and it is raining, then he will take an umbrella with him to the
% office, provided there is one to be taken. If he is at the office at the
% end of the day and if it is raining, then he will take an umbrella home,
% provided there is one to be taken. If it is not raining, then he never
% takes an umbrella. Assume that, independent of the past, it rains at the
% beginning (or end) of a day with probability p = 30%. The individual
% wants to create a model to determine the fraction of time he will get
% wet.
%% 1. (a)
% Use the five-step method to answer this question. Use a Markov chain
% (discrete-time) to model the situation.
%
% *Step 1*
%
% <html><table border=1>
% <tr><td> <b> Variable Names </b> </td><td> <b> Descriptions </b>                      </td></tr>
% <tr><td>      <i> X_n </i>       </td><td> The number of umbrellas at time <i> n </i> </td></tr>
% <tr><td>      <i>   n </i>       </td><td> Time (half-days)                           </td></tr>
% <tr><td>     <i> isWet </i>      </td><td> The individual gets wet (true/false)       </td></tr>
% </table></html>
%
% Let $p_{ij}$ represent the transition probabilities for going from $i$ 
% umbrellas in one location to $j$ umbrellas in the other. We will also
% denote this in matrix form by $A = p_{ij}$. We will let $\pi_j$ be the 
% steady state probability for $j$ umbrellas. Note that the steady state
% probability is defined as the following:
%
% $\pi_j = \lim_{n \to \infty} p_{ij}^n$  for  $j \geq 0$.
%
% <html><table border=1>
% <tr><td> <b> Constants </b> </td><td> <b> Value </b> </td><td> <b> Descriptions </b>                                                            </td></tr>
% <tr><td>    <i> p </i>      </td><td>      30%       </td><td> The probability that it rains </td></tr>
% </table></html>
%
% - _Assumptions_ - 
%
% Assume that the individual in question is a bit of a loser and only goes
% between work and home. Assume that he only owns 3 umbrellas. Assume that
% the individual only grabs 1 umbrella (if available) on days that it is
% raining. Assume that none of his umbrella's are broken so that on days it
% rains, if he takes an umbrella, he does not get wet. Assume that if the 
% individual leaves work (or home) when it is not raining, that it will not
% starting raining during his commute, hence catching him without an
% umbrella and getting him wet. Assume that independent of the past, it
% rains at the beginning (or end) of a day with probability 30%, i.e. 
% assume the individual lives in Vancouver, BC. Assume that the probability
% of it raining is independent of the probability of having an umbrella at
% home or work. We will assume that being wet is binary, i.e. you are
% either wet or not. We will assume that we are dealing with proper
% probabilities hence they only take on real number values between 0 and 1
% inclusively. We also have the following domain restrictions 
% $X_n = \{0, 1, 2, 3\}$, similiarly, $i, j = \{0, 1, 2, 3\}$ and
% $n \in N$.
%
% - _Equations_ -
%
% $$p_{ij} = P(X_{n + 1} = j | X_n = i)$$
%
% $$p_{12} = p_{21} = p_{30} = 1 - p$$
%
% $$p_{13} = p_{22} = p_{31} = p$$
%
% $$p_{03} = 1 $$
%
% The rest of the entries in the matrix are 0. From this, we can set up
% our equations for the steady state probabilities.
%
% $$\pi_j = [\pi_0  \  \pi_1  \  \pi_2  \  \pi_3] \cdot p_{ij}$$
%
% $$\sum_{i = 0}^{3} \pi_i = 1$$
%
% $$P(isWet) = p \cap \pi_0$$
%
% - _Objective_ -
%
% We want to determine the fraction of time that the individual will get
% wet. In order to find this probability, we need the long term proportion
% of leaving either the house or work with no umbrella.
%
% *Step 2*
%
% We will use a discrete time Markov chain to model the situation. We
% should note that our Markov chain is ergodic, so this in turn ensures
% that the steady states do indeed exist for this system.
%
% *Step 3*
% 
% We will find the steady state probabilitites in two ways. Firstly we will
% find them by constructing our state transition matrix and raise it to the
% power $n$ and find the solution iteratively for a large value of $n$.
% Next we will compile our steady state equations from above, by expanding
% out the matrix, then plug in our probabilities. This leaves us with
% having to solve the equations below. This should yield the same solution
% as the iterative process.
figure
imshow(imread('1.jpg'))
title('State Transition Diagram')
%%
% $$\pi_0 = 0.7 \pi_3$$
%
% $$\pi_1 = 0.7 \pi_2 + 0.3 \pi_3$$
%
% $$\pi_2 = 0.7 \pi_1 + 0.3 \pi_2$$
%
% $$\pi_3 = \pi_0 + 0.3 \pi_1$$
%
% $$\pi_0 + \pi_1 + \pi_2 + \pi_3 = 1$$
%
% Lastly, to answer the question, we will find $P(isWet)$. Recall our
% assumption that the probability of it raining and the probability of
% having 0 umbrellas is independent. Thus we will compute
%
% $$P(isWet) = 0.3 \pi_0.$$
%
% *Step 4*
clear; clc; close all;
syms pi_0 pi_1 pi_2 pi_3;

% Set constants
p = .3;

% Construct the transition matrix
A = [  0        0        0        1 ; 
       0        0      1 - p      p ; 
       0      1 - p      p        0 ; 
     1 - p      p        0        0];
    
% Iterate A for large n
product = A;
for i = 1:1000
    product = product*A;
end
disp(product);

% Build System of Equations    
eq1 = pi_0 ==                                        pi_3*(1 - p);
eq2 = pi_1 ==                        pi_2*(1 - p)  + pi_3*p;
eq3 = pi_2 ==        pi_1*(1 - p)  + pi_2*p;
eq4 = pi_3 == pi_0 + pi_1*p;
eq5 =    1 == pi_0 + pi_1          + pi_2          + pi_3;

sol = solve([eq1, eq2, eq3, eq4, eq5], [pi_0 pi_1 pi_2 pi_3]);
   
disp(eval(sol.pi_0));
disp(eval(sol.pi_1));
disp(eval(sol.pi_2));
disp(eval(sol.pi_3));
%%
% We have found the proper steady state probabilities because both methods
% produce the same values.
%
% <html><table border=1>
% <tr><td> <b> &pi; </b> </td><td> <b> Percentage </b> </td><td> <b> Fraction </b> </td></tr>
% <tr><td>      0        </td><td>     18.9189189      </td><td>       7/37        </td></tr>
% <tr><td>      1        </td><td>     27.0270270      </td><td>      10/37        </td></tr>
% <tr><td>      2        </td><td>     27.0270270      </td><td>      10/37        </td></tr>
% <tr><td>      3        </td><td>     27.0270270      </td><td>      10/37        </td></tr>
% </table></html>

isWet = p*sol.pi_0;
disp("The probability of getting wet is:");
disp(isWet);
disp(eval(isWet));
%%
% *Step 5*
%
% We can conclude that the probability of getting wet is $\frac{21}{370}$
% or 5.68%. As many people would agree, if you do not have the space to
% carry around an umbrella, it is quite annoying to carry one when it is
% not raining. Thus, The strategy of leaving a various amount at work and
% home is a reasonable one.
%% 1. (b)
% Compute the sensitivity of your answer to the p = 30% assumption. Comment
% on your result.
clear; clc; close all;

% Declare p are a symbolic variable instead of a fixed constant in order to
% compute the sensitivity
syms p pi_0 pi_1 pi_2 pi_3;

% Build System of Equations
eq1 = pi_0 ==                                        pi_3*(1 - p);
eq2 = pi_1 ==                        pi_2*(1 - p)  + pi_3*p;
eq3 = pi_2 ==        pi_1*(1 - p)  + pi_2*p;
eq4 = pi_3 == pi_0 + pi_1*p;
eq5 =    1 == pi_0 + pi_1          + pi_2          + pi_3;
    
sol = solve([eq1, eq2, eq3, eq4, eq5], [pi_0 pi_1 pi_2 pi_3]);
%%
% To compute the sensitivity for this question, we need to take a
% derivative of our desired function, $isWet$ in terms of the variable $p$.
% The sensitivity will be $S(isWet, p) = \frac{p}{isWet}\frac{\emph{d}isWet}{\emph{d}p}$.

isWet = p*sol.pi_0;
% Compute Sensitivity of pi_0
derivative = diff(isWet, p);
sensitivity_symbolic = (p/isWet)*derivative;
sensitivity = eval(subs(sensitivity_symbolic, p, 0.3));
    
disp('Sensitivity');
disp(sensitivity);
%%
% This means that for a 1% increase in the probability of it raining, the
% probability that the individual will get wet increases by 0.6525%. If the
% probability of it raining increases, I would inform the individual that
% it is more likely he gets wet, and hence recommend he does not walk if he
% wants to stay dry. But realistically, a 0.6525% increase is rather
% insignificant. In conclusion, the probability of getting wet is not very
% sensitive to our assumption of the probability of rain to be 30%.
%% 1. (c)
% What value of $p$ maximizes the fraction of time he gets wet.
clear; clc; close all;

% We need to be able to solve for p, thus we make it symbolic again
syms p pi_0 pi_1 pi_2 pi_3;

% Build System of Equations    
eq1 = pi_0 ==                                        pi_3*(1 - p);
eq2 = pi_1 ==                        pi_2*(1 - p)  + pi_3*p;
eq3 = pi_2 ==        pi_1*(1 - p)  + pi_2*p;
eq4 = pi_3 == pi_0 + pi_1*p;
eq5 =    1 == pi_0 + pi_1          + pi_2          + pi_3;
    
sol = solve([eq1, eq2, eq3, eq4, eq5], [pi_0 pi_1 pi_2 pi_3]);
%%
% To maximize the function, we will use calculus I methods of solving for
% critical points by setting the derivative equal to 0 and solving.
isWet = p*sol.pi_0;
criticalPts = solve(diff(isWet));
disp("The critical values for our wet function are:");
disp(eval(criticalPts));
%%
% Recall that our function represents probability. Hence our domain is only
% defined for the interval $[0, 1]$. Since 7.464 does not belong in the
% domain we discard it. We will take 0.5359 and plug it into our function,
% along with the endpoints.
disp(eval(subs(isWet, p, criticalPts(1))));
disp(eval(subs(isWet, p, 0)));
disp(eval(subs(isWet, p, 1)));
%%
% The value of $p$ that maximizes the fraction of time the individual gets
% wet is 53.5898%. Furthermore, the amount of time the individual is wet, 
% ends up being 7.1797%. It is obvious that the value of $p$ would not be
% 0. However, you may have expected the function to reach a max when $p =
% 1$. But with some careful consideration, even if you start off in a state
% with 0 umbrellas, every event from $n = 2$ and onwards would mean that
% you carry around the same umbrella from work to home forever.
%% 1. (d)
% Would buying another umbrella reduce the amount of time he gets wet? If
% so, by how much? Use p = 30% to answer.
figure
imshow(imread('2.jpg'))
title('State Transition Diagram')
%%
clear; clc; close all;

syms pi_0 pi_1 pi_2 pi_3 pi_4;

% Set constants
p = .3;
probabilityWetPartA = 21/370;

% Build System of Equations
eq1 = pi_0 ==                                               pi_4*(1-p);
eq2 = pi_1 ==                                  pi_3*(1-p) + pi_4*p;
eq3 = pi_2 ==                     pi_2*(1-p) + pi_3*p;
eq4 = pi_3 ==        pi_1*(1-p) + pi_2*p;
eq5 = pi_4 == pi_0 + pi_1*p; 
eq6 =    1 == pi_0 + pi_1       + pi_2       + pi_3       + pi_4;

sol = solve([eq1, eq2, eq3, eq4, eq5, eq6], [pi_0 pi_1 pi_2 pi_3 pi_4]);

isWet = p*sol.pi_0;
disp("The probability of getting wet is:");
disp(isWet);
disp(eval(isWet));

disp("The probability of getting wet decreases by:");
disp(probabilityWetPartA - isWet);
disp(eval(probabilityWetPartA - isWet));
%%
% If the individual had an extra umbrella then the probability that he
% would get wet is $\frac{21}{440}$ or 4.468%. This is a decrease of 
% $\frac{21}{1739}$ or 1.208%. This is not too large of a decrease,
% however, for someone who despises the rain, I would recommend buying
% another cheap umbrella (or 2 or 3 ...). 
%%
% 2. A pharmaceutical company wants to determine the effciency of the
% delivery mechanism of an antibiotic for a specific type of bacteria. This
% antibiotic is delivered through molecules which have to attach to a site
% on the surface of the bacteria in order to release the antibiotic into
% the bacteria. For simplicity, let us call the molecules delivering the
% antibiotic the acceptable molecules. The surface of a typical bacteria
% consists of several sites at which foreign molecules--some acceptable and
% some not--become attached. At a typical site, molecules arrive to the
% site at a rate of about 30 per second. For a usual dose of this
% antibiotic given to a patient, acceptable molecules will constitute about
% 2% of all molecules arriving at the site. Unacceptable molecules stay at
% the site for about 0.02 seconds and then are ejected, whereas acceptable
% molecules were designed to stay at the site about four times longer. An
% arriving molecule will become attached only if the site is free of other
% molecules.
%%
% The pharmaceutical company usually employs two metrics to determine the
% efficiency of such a delivery system: the percentage of the time a
% typical site is occupied with an acceptable molecule and the fraction of
% arriving acceptable molecules that become attached. The company has hired
% you to estimate these quantities.
%% 2. (a)
% Use the five-steps method to estimate these quantities. Use a Markov
% process (continuous-time) for your model.
%
% *Step 1*
%
% <html><table border=1>
% <tr><td> <b>Variable Names</b> </td><td> <b> Descriptions </b>                                     </td></tr>
% <tr><td>     <i> X_t </i>      </td><td> The occupancy of a site on a bacteria for time <i> t </i> </td></tr>
% <tr><td>     <i>   t </i>      </td><td> Time (seconds)                                            </td></tr>
% <tr><td>  <i> isAttached </i>  </td><td> The molecules attach to a site on the bacteria(true/false)</td></tr>
% </table></html>
%
% <html><table border=1>
% <tr><td> <b> X </b> </td><td> <b> Description of State </b>                                    </td></tr>
% <tr><td> <i> 0 </i> </td><td> The site on the bacteria is unoccupied                           </td></tr>
% <tr><td> <i> 1 </i> </td><td> The site on the bacteria is occupied by an unacceptable molecule </td></tr>
% <tr><td> <i> 2 </i> </td><td> The site on the bacteria is occupied by an acceptable molecule   </td></tr>
% </table></html>
%
% Let $P_i$ represent the proportion of time spent in state $i$. This is
% defined interms of the steady-state distribution and the associated rates
% for each time inbetween states.
%
% <html><table border=1>
% <tr><td> <b> Constants </b>           </td><td> <b>Value</b> </td><td> <b> Descriptions </b>                                                          </td></tr>
% <tr><td> <i> rateMoleculesArrive </i> </td><td>      30      </td><td> The rate at which the molecules arrive at a site by (1/second)                 </td></tr>
% <tr><td> <i> percentAcceptable   </i> </td><td>     .02      </td><td> Proportion of acceptable molecules that arrive at a site                       </td></tr>
% <tr><td> <i> timeBeforeEjected   </i> </td><td>     .02      </td><td> The time an unacceptable molecule stays at a site for before being ejected (s) </td></tr>
% <tr><td> <i> acceptableArrive    </i> </td><td>     ---      </td><td> The rate of acceptable molecules arriving at a site (1/s)                      </td></tr>
% <tr><td> <i> unAcceptableArrive  </i> </td><td>     ---      </td><td> The rate of unacceptable molecules arriving at a site (1/s)                    </td></tr>
% <tr><td> <i> acceptableEjected   </i> </td><td>     ---      </td><td> The rate of acceptable molecules being ejected from a site (1/s)               </td></tr>
% <tr><td> <i> unAcceptableEjected </i> </td><td>     ---      </td><td> The rate of unacceptable molecules being ejected from a site (1/s)             </td></tr>
% </table></html>
%
% - _Assumptions_ - 
%
% Assume that there are no acceptable molecules already present within the
% patient. Lets assume every site is independent of one another, hence the
% proability of latching onto any site is not affected at all by
% neighbouring sites. Assume that the propabibility of latching onto any
% site is fixed and equal to every other site. Assume that a molecule is
% either acceptable or not acceptable. An addendum to this would be that
% acceptable molecules are never ineffective but rather always potent.
% Assume that a molecule will only every occupy one site at a time. Assume
% that the dosage is consistent with every trial we observe. Assume that
% acceptable molecules do stay on the bacteria four times longer than
% unacceptable ones. Assume that a molecule doesn't attach to a site that
% is already occupied. Assume that the two metrics chosen are indeed a good
% measure of the effectiveness of the antibiotic. Assume that the
% probability of an acceptable molecule arriving and the probability of a
% site being empty are independent. We also have the following domain
% restrictions: $X_t = \{0, 1, 2\}$, $t \in \{R|t \geq 0 \}$. Lastly assume
% that isAttached is a binary variable such that a molecule is either
% attached or not attached.
%
% - _Equations_ -
%
% $P_i = \frac{(\pi_i/\lambda_i)}{(\pi_0/\lambda_0) + (\pi_1/\lambda_1) +
% (\pi_2/\lambda_2)}$ for $i = 1, 2, 3$
%
% $$\sum_{i = 0}^{2} P_i = 1$$
%
% To simplify our work, let us set up the following equations.
%
% $$acceptableArrive = rateMoleculesArrive(1 - percentAcceptable)$$
%
% $$unAcceptableArrive = rateMoleculesArrive \cdot percentAcceptable$$
%
% $$acceptableEjected = \frac{1}{timeBeforeEjected}$$
%
% $$unAcceptableEjected = \frac{1}{4 \cdot timeBeforeEjected}$$
%
% - _Objective_ -
%
% We want to determine the percentage of the time a typical site is
% occupied with an acceptable molecule and the fraction of arriving
% acceptable molecules that become attached. In order to calculate these
% quantites, we will need to find steady states for the proportion of time
% spend in a particular state.
%
% *Step 2*
%
% We will use a continuous time Markov process to model the situation. We
% should note that our Markov process is ergodic, so this in turn ensures
% that the steady states do indeed exist for this system.
%
% *Step 3*
%
% Since the probabilities are not available to us, we must use the
% fluid-flow analogy to help us solve the problem. If we were to imagine a
% fluid flowing in and out of each state, then in order to remain in
% equilibrium, the fluid must satidfy the law of conservation of mass. Alas
% we will model each of our states with the following equation:
%
% Rate flowing into state $i$ = Rate flowing out of state $i$ for every
% $i$.
%
% This yields the following equations:
%
% $$50P_1 + \frac{25}{2}P_2 = 30P_0$$
%
% $$\frac{147}{5}P_0 = 50P_1$$
%
% $$\frac{3P_0}{5} = \frac{25P_2}{2}$$
%
% $$P_0 + P_1 + P_2 = 1$$
%
% We then solve the above four equations to find the long term proportion
% of time being in a particular state. Specifically, the pharmaceutical
% company wants to know what $p2$ is. Additionally, we can calculate the
% the fraction of arriving acceptable molecules that become attached by the
% following formula,
%
% $$isAttached = P_0 \cap acceptableArrive.$$
%
% Since these are assumed to be independent probabilities, we can calculate
% the following as such:
%
% $$isAttached = \frac{3P_0}{5}.$$
I = imread('3.jpg');
R = imresize(I, 0.6, 'nearest');
figure
imshow(R)
title('State Transition Diagram')
%%
% *Step 4*
clear; clc; close all;
syms p0 p1 p2;

% Set constants
rateMoleculesArrive = 30;
  percentAcceptable = .02;
  timeBeforeEjected = .02;

   acceptableArrive = rateMoleculesArrive*percentAcceptable;
 unAcceptableArrive = rateMoleculesArrive*(1 - percentAcceptable);
  acceptableEjected = 1/(4*timeBeforeEjected);
unAcceptableEjected = 1/timeBeforeEjected;

eq0 = unAcceptableEjected*p1 +   acceptableEjected*p2 == ...
       (acceptableArrive     + unAcceptableArrive)*p0;
eq1 =                      unAcceptableArrive*p0 == unAcceptableEjected*p1;
eq2 =                        acceptableArrive*p0 ==   acceptableEjected*p2;
eq3 =                               p0 + p1 + p2 == 1;

sol = solve([eq0, eq1, eq2, eq3], [p0 p1 p2]);

disp(eval(sol.p0));
disp(eval(sol.p1));
disp(eval(sol.p2));
%%
% The long term steady state proportions as follows :
%
% <html><table border=1>
% <tr><td> <b> P </b> </td><td> <b> Percentage </b> </td><td> <b> Fraction </b> </td></tr>
% <tr><td>     0      </td><td>       .6112         </td><td>     250/409       </td></tr>
% <tr><td>     1      </td><td>       .3594         </td><td>     147/409       </td></tr>
% <tr><td>     2      </td><td>       .0293         </td><td>      12/409       </td></tr>
% </table></html>

disp("The percentage of time a particular site is occupied by an acceptable molecule:");
disp(sol.p2);
disp(eval(sol.p2));

isAttached = sol.p0*acceptableArrive;
disp("The fraction of arriving acceptable molecules that become attached:");
disp(isAttached);
disp(eval(isAttached));
%%
% *Step 5*
%
% We can conclude that the percentage of time that a typical site is
% occupied by an acceptable molecule is $\frac{12}{409}$ or 2.934%. Also,
% the fraction of arriving acceptable molecules that become attached is
% $\frac{150}{409}$ or 36.67%. The strength of this antibiotic is the
% fraction of arriving acceptable molecules that end up attached to sites
% on the bacteria.
%% 2. (b)
% Compute the sensitivity of both your answers in (a) to the rate of 30
% arriving molecules per second. Comment on your results.
clear; clc; close all;
syms p0 p1 p2 rateMoleculesArrive;

% Set constants
percentAcceptable = .02;
timeBeforeEjected = .02;

   acceptableArrive = rateMoleculesArrive*percentAcceptable;
 unAcceptableArrive = rateMoleculesArrive*(1 - percentAcceptable);
  acceptableEjected = 1/(4*timeBeforeEjected);
unAcceptableEjected = 1/timeBeforeEjected;

eq0 = unAcceptableEjected*p1 +   acceptableEjected*p2 == ...
       (acceptableArrive     + unAcceptableArrive)*p0;
eq1 =                      unAcceptableArrive*p0 == unAcceptableEjected*p1;
eq2 =                        acceptableArrive*p0 ==   acceptableEjected*p2;
eq3 =                               p0 + p1 + p2 == 1;

sol = solve([eq0, eq1, eq2, eq3], [p0 p1 p2]);

% Sensitivity Analysis for time occupied by acceptable molecule
N = sol.p2;
derivative = diff(N, rateMoleculesArrive);
sensitivity_symbolic = (rateMoleculesArrive/N)*derivative;
sensitivity = eval(subs(sensitivity_symbolic, rateMoleculesArrive, 30));

% Sensitivity Analysis for fraction of acceptable molecules that attach
isAttached = sol.p0*acceptableArrive;
derivative2 = diff(isAttached, rateMoleculesArrive);
sensitivity_symbolic2 = (rateMoleculesArrive/isAttached)*derivative2;
sensitivity2 = eval(subs(sensitivity_symbolic2, rateMoleculesArrive, 30));
    
disp('Sensitivities');
disp(sensitivity);
disp(sensitivity2);
%%
% We observe that for every 1% increase in the rate molecules arrive at a
% typical site, that the percentage of time an acceptable molecule occupies
% that site increases by about .6112%. If the pharmaceutical company wanted
% to increase the effectiveness of the treatment, they could perhaps
% administer a high dosage, ultimately increasing the rate at which
% molecules arrive at the site. This will not change the proportion of time
% drastically. The conclusion is that the time spend for a site to be
% occupied by an acceptable is not very sensitive to this value. Finally,
% for every 1% increase in the rate molecules arrive at a typical site, the
% fraction of arriving acceptable molecules that become attached increases
% by .6112%. 