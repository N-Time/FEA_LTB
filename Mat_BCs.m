%%%%%%%%%%%%% Matrix with BCs %%%%%%%%%%%%%%
%%%% Input %%%%
% DOFs of all BCs Nodes: BCsNdDOF
% Matrix: Mat

function SMB = Mat_BCs(Mat,BCsNdDOF)
    if size(Mat,1) == size(Mat,2)
        Mat(BCsNdDOF,:) = [];
        Mat(:,BCsNdDOF) = [];
    elseif size(Mat,2) == 1 
        Mat(BCsNdDOF) = [];
    else
        return
    end
    SMB = Mat;
end