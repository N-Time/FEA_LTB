%%%%% Multi-Loads %%%%%
% Loads(kN m)[Amplitude(kN m) Distribution(m) ay(mm){up<0, down>0}]: qy Py Mx0

function [Lqy,LPy,LM0] = MultiLoads(Filename,Sheet,RWend,RWstart,Cn,Rqy,RPy,RM0)

    %%%% qy = [Amp  ay] %%%%
    Lqy = cell(Cn,1);
    if isempty(Rqy)
        for i = 1 : Cn
            Lqy{i} = zeros(1,2);
        end
    else
        Nqy = size(Rqy,1);%Num of loads of each cases
        LqyAmp = zeros(Nqy,Cn);
        Laqy = zeros(Nqy,Cn);
        for i = 1 : Nqy %Num of loads of each groups
            LqyAmp(i,:) = xlsread(Filename,Sheet,[Rqy(i,1:2),RWstart,':',Rqy(i,1:2),RWend]);
            Laqy(i,:) = xlsread(Filename,Sheet,[Rqy(i,3:4),RWstart,':',Rqy(i,3:4),RWend]);
        end
        for i = 1 : Cn % each loads groups
            Lqy{i}(:,1) = LqyAmp(:,i);
            Lqy{i}(:,2) = Laqy(:,i)*1000;
        end
    end

    %%%% Py = [Amp  z  ay] %%%%
    LPy = cell(Cn,1);
    if isempty(RPy)
        for i = 1 : Cn
            LPy{i} = zeros(1,3);
        end
    else
        NPy = size(RPy,1);%Num of loads of each cases
        LpyAmp = zeros(NPy,Cn);
        Lzpy = zeros(NPy,Cn);
        Lapy = zeros(NPy,Cn);
        for i = 1 : NPy %Num of loads of each groups
            LpyAmp(i,:) = xlsread(Filename,Sheet,[RPy(i,1:2),RWstart,':',RPy(i,1:2),RWend]);
            Lzpy(i,:) = xlsread(Filename,Sheet,[RPy(i,3:4),RWstart,':',RPy(i,3:4),RWend]);
            Lapy(i,:) = xlsread(Filename,Sheet,[RPy(i,5:6),RWstart,':',RPy(i,5:6),RWend]);
        end
        for i = 1 : Cn % each loads groups
            LPy{i}(:,1) = LpyAmp(:,i);
            LPy{i}(:,2) = Lzpy(:,i);
            LPy{i}(:,3) = Lapy(:,i)*1000;
        end
    end

    %%%% M0 = [Amp  z] %%%%
    LM0 = cell(Cn,1);
    if isempty(RM0)
        for i = 1 : Cn
            LM0{i} = zeros(1,2);
        end
    else
        NM0 = size(RM0,1);%Num of loads of each cases
        LM0Amp = zeros(NM0,Cn);
        LzM0 = zeros(NM0,Cn);
        for i = 1 : NM0 %Num of loads of each groups
            LM0Amp(i,:) = xlsread(Filename,Sheet,[RM0(i,1:2),RWstart,':',RM0(i,1:2),RWend]);
            LzM0(i,:) = xlsread(Filename,Sheet,[RM0(i,3:4),RWstart,':',RM0(i,3:4),RWend]);
        end
        for i = 1 : Cn % each loads groups
            LM0{i}(:,1) = LM0Amp(:,i);
            LM0{i}(:,2) = LzM0(:,i);
        end
    end
end