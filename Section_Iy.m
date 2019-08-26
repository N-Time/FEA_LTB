%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% Iy(m^4)

function Iy = Section_Iy(h,tw,bT,tT,bB,tB)
    hw = h -  tB - tT;
    IT = tT * bT^3 / 12;
    IB = tB * bB^3 / 12;
    Iw = hw * tw^3 / 12;
    Iy = IT + IB + Iw;
end