%%%%%%%%%%%%% Section Properties %%%%%%%%%%%%%%
%%%% Input %%%%
% I-Section(mm): h tw bT tT bB tB
%%%% Output %%%%
% By(mm)

function By = Section_By(h,tw,bT,tT,bB,tB)
    hc = Section_Centroid(h,tw,bT,tT,bB,tB);
    Ix = Section_Ix(h,tw,bT,tT,bB,tB);
    ys = Section_Shear(h,tw,bT,tT,bB,tB);
    hw = h -  tB - tT;
    AT = tT * bT;
    IxT = tT^3 * bT / 12;
    IyT = tT * bT^3 / 12;
    AB = tB * bB;
    IxB = tB^3 * bB / 12;
    IyB = tB * bB^3 / 12;
    AW = tw * hw;
    IxW = hw^3 * tw / 12;
    IyW = hw * tw^3 / 12;
    hT = h - hc - tT/2;
    hB = hc - tB/2;
    By = 1/(2*Ix) * (-hT*(IyT+3*IxT+AT*hT^2) + hB*(IyB+3*IxB+AB*hB^2) + 0.5*(hB-tB/2-hT+tT/2)*(IyW + 3*IxW + AW/4*(hB-tB/2-hT+tT/2)^2)) - ys;
end