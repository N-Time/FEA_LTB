%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% Iw(mm)

function Iw = Section_Iw(h,tw,bT,tT,bB,tB)
    ys = Section_Shear(h,tw,bT,tT,bB,tB);
    hc = Section_Centroid(h,tw,bT,tT,bB,tB);
    hw = h -  tB - tT;
    IyT = tT * bT^3 / 12;
    IyB = tB * bB^3 / 12;
    IyW = hw * tw^3 / 12;
    hT = h - hc - tT/2;
    hB = hc - tB/2;
    hW = hc - (hw/2 + tB);
    Iw = IyT*(-hT-ys)^2 + IyW*(hW-ys)^2 + IyB*(hB-ys)^2;
end