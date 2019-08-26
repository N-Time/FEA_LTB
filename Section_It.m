%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% It(mm^6)

function It = Section_It(h,tw,bT,tT,bB,tB)
    hw = h -  tB - tT;
    IxT = tT^3 * bT;
    IxB = tB^3 * bB;
    IyW = hw * tw^3;
    It = (IxT + IxB +IyW) / 3;
end