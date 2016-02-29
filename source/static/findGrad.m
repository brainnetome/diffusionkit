
function findGrad(dcmfile)
% This script is special to locate the individual grad directions
% for each DICOM file, if the dicom2nii tool failed to extract them.

% by NMZUO, Sept. 12, 2014

%prestr = 'DiffusionGradientOrientation';
prestr = 'DiffusionGradient';

myhdr = dicominfo(dcmfile);
myfind = fieldnamesr(myhdr, prestr);
iLen = length(myfind);

iCount = 0;

for i=1:iLen
   mystr = myfind{i};
   
   if strfind(mystr, prestr)
       iCount = iCount + 1;
       disp(['Field containing ' prestr ': ' num2str(iCount) ]);
       disp(mystr);
       
       % to extract the grad directions
       eval(strcat('myhdr.', mystr))
       
   end
    
end

end