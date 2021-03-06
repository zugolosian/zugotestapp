%%%-------------------------------------------------------------------
%% @doc zugotestapp public API
%% @end
%%%-------------------------------------------------------------------

-module('zugotestapp_app').

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    'zugotestapp_sup':start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
