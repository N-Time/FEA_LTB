%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% yc(mm)

function hc = Section_Centroid(h,tw,bT,tT,bB,tB)
    hw = h - tT - tB;
    AfT = bT * tT;
    AfB = bB * tB;
    Afw = hw * tw;
    As = AfT + AfB +Afw;
    hc = (AfB * tB/2 + AfT * (h - tT/2) + Afw * (tB + hw/2))/As;
end