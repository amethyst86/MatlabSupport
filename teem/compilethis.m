% Script to compile nrrd IO functions on unix (inc Linux/Mac)
% Assumes that teem library has been built and installed in /usr/local
% with the same binary architecture as matlab (ie 64 bit for 64 bit matlab)

% If teem is in a non-standard location, then you must edit this file to specify
% the correct include and lib paths 

if isunix
	[result,hostname]=system('hostname');
	if strncmp(hostname,'hex.lmb',7) && strcmp('x86_64-unknown-linux-gnu',computer)
		disp('Building teem library from /public/octave/teem/');
		% special paths for LMB hex 
		mex nrrdLoad.c -I/public/octave/teem/include -L/public/octave/teem/lib/ -lteem -lz -lm
		mex nrrdLoadOrientation.c -I/public/octave/teem/include -L/public/octave/teem/lib/ -lteem -lz -lm
		mex nrrdSave.c -I/public/octave/teem/include -L/public/octave/teem/lib/ -lteem -lz -lm
	else
		% default linux/mac paths
		if length(dir('/usr/local/libx/libteem*'))==0
			error(['Unable to locate teem library.' ...
			' See MatlabSupport/teem/compilethis.m'])
		end
		disp('Building teem library from /usr/local');
		mex nrrdLoad.c -I/usr/local/include -L/usr/local/lib -lteem -lz -lm
		mex nrrdLoadOrientation.c -I/usr/local/include -L/usr/local/lib -lteem -lz -lm
		mex nrrdSave.c -I/usr/local/include -L/usr/local/lib -lteem -lz -lm
	end
	else
	disp(['don''t know how to compile on windows, but shouldn''t be too hard!' ...
	' See MatlabSupport/teem/compilethis.m'])
	% Details of how to build teem (the superpackage containing the nrrd library)
	% (including on windows) are at:
	% 	http://teem.sourceforge.net/build.html 
	% It would also be worth contacting the teem users mailing list
	% teem-users@lists.sourceforge.net
end
