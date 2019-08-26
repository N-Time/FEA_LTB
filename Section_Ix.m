%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
% Ix(m^4)

function Ix = Section_Ix(h,tw,bT,tT,bB,tB)
    yc = Section_Centroid(h,tw,bT,tT,bB,tB);
    hw = h - tT - tB;
    AfT = bT * tT;
    AfB = bB * tB;
    Afw = hw * tw;
    IxT = 1/12 * bT * tT^3;
    IxB = 1/12 * bB * tB^3;
    Ixw = 1/12 * tw * hw^3;
    Ix = (IxB + AfB * (yc - tB/2)^2 + IxT + AfT * (h - yc - tT/2)^2 + Ixw + Afw * (hw/2 + tB - yc)^2);
end