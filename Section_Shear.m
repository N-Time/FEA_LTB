%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% ys(mm)

function ys = Section_Shear(h,tw,bT,tT,bB,tB)
    hc = Section_Centroid(h,tw,bT,tT,bB,tB);
    Iy = Section_Iy(h,tw,bT,tT,bB,tB);
    hw = h -  tB - tT;
    IT = tT * bT^3 / 12;
    IB = tB * bB^3 / 12;
    IW = hw * tw^3 / 12;
    hT = h - hc - tT/2;
    hB = hc - tB/2;
    ys = (- IT * hT + IB * hB + IW * (hB - hT)/2 ) / Iy;
end