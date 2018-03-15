function varargout = guimain(varargin)
% GUIMAIN MATLAB code for guimain.fig
%      GUIMAIN, by itself, creates a new GUIMAIN or raises the existing
%      singleton*.
%
%      H = GUIMAIN returns the handle to a new GUIMAIN or the handle to
%      the existing singleton*.
%
%      GUIMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMAIN.M with the given input arguments.
%
%      GUIMAIN('Property','Value',...) creates a new GUIMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimain

% Last Modified by GUIDE v2.5 09-Dec-2016 09:14:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimain_OpeningFcn, ...
                   'gui_OutputFcn',  @guimain_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before guimain is made visible.
function guimain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimain (see VARARGIN)

% Choose default command line output for guimain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimain wait for user response (see UIRESUME)
% uiwait(handles.figureMain);


% --- Outputs from this function are returned to the command line.
function varargout = guimain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ckPartialResult.
function ckPartialResult_Callback(hObject, eventdata, handles)
% hObject    handle to ckPartialResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(hObject.Value == 1)
    handles.pnlTimeSteps.Visible = 'on';
else
    handles.pnlTimeSteps.Visible = 'off';
end





% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

behaviorTooblePanelsDefault(handles, 1);

callbackMeans(handles);

behaviorTooblePanelsDefault(handles, 0);

% Atualizar as informações da tela.
guidata(hObject, handles);




function countClusters_Callback(hObject, eventdata, handles)
% hObject    handle to countClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of countClusters as text
%        str2double(get(hObject,'String')) returns contents of countClusters as a double


% --- Executes during object creation, after setting all properties.
function countClusters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to countClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pumDistance.
function pumDistance_Callback(hObject, eventdata, handles)
% hObject    handle to pumDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pumDistance contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumDistance


% --- Executes during object creation, after setting all properties.
function pumDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pumAlgoritm.
function pumAlgoritm_Callback(hObject, eventdata, handles)
% hObject    handle to pumAlgoritm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 1 = K-means - Clássico
% 2 = K-means Fuzzy
if(hObject.Value == 1)
    handles.pnlFactorFazzy.Visible = 'off';
else
    handles.pnlFactorFazzy.Visible = 'on';
end



% --- Executes during object creation, after setting all properties.
function pumAlgoritm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumAlgoritm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function callbackMeans(handles)
    % Pegar quantidade e Clusters
    k = str2num(handles.countClusters.String);

    % Pegar o valor da distância selecionada
    d = handles.pumDistance.Value;

    % epsilon não coloquei como parâmetro mas, é possível! 
    epsilon = 1e-6;

    % Ocorreu erro ao tentar carregar valores de arquivos externos! 
    % dunn;

    % Pegar se vai fazer passo a passo ou vai rodar direto
    runInStep = handles.ckPartialResult.Value;
   
    % Pega o tempo entre cada informação
    timeSteps = str2num(handles.txtTimeSteps.String); 
    
    % Verificar qual algoritmo foi escolhido para ser rodado
    algCluster = handles.pumAlgoritm.Value; 
    % 1 = K-means - Clássico
    % 2 = K-means Fuzzy
    if algCluster == 1
        % Chamando função K-means Clássico                
        Cmeans(k, d, epsilon, runInStep, timeSteps, handles);
    else 
        % Chamando função K-means Fuzzy
        f = str2num(handles.txtFactorFazzy.String);
        FCM(k, d, f, epsilon, runInStep, timeSteps, handles);
    end
  
    
function behaviorTooblePanelsDefault(handles, hiddenPanelMain)
if(hiddenPanelMain == 1 && handles.ckPartialResult.Value == 1)
    handles.uipnlParameters.Visible = 'off';
    handles.pnlSteps.Visible = 'on';
else
    handles.uipnlParameters.Visible = 'on';
    handles.pnlSteps.Visible = 'off';
end
    

function txtFactorFazzy_Callback(hObject, eventdata, handles)
% hObject    handle to txtFactorFazzy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function txtFactorFazzy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFactorFazzy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtTimeSteps_Callback(hObject, eventdata, handles)
% hObject    handle to txtTimeSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function txtTimeSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTimeSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
