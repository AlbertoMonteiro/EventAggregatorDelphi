unit Unit2;

interface

uses
  System.Classes, Generics.Collections;

type

  TEvent<T> = procedure(data: T) of object;

  TSubscription<T> = class
  private
    FHandler: TEvent<T>;
    FIsDisposed: boolean;
    FOwner: TComponent;
  public
    procedure Dispose;
    procedure Call(data: T);
    property IsDisposed: boolean read FIsDisposed;
    constructor Create(handler: TEvent<T>; owner: TComponent);
    destructor Destroy; overload;
  end;

  TEventAggregator<T> = class
  private
    class var FSubscriptions: TList<TSubscription<T>>;
  public
    class function Subscribe(method: TEvent<T>; owner: TComponent)
      : TSubscription<T>;
    class procedure Publish(data: T);
    class constructor Create;
  end;

implementation

{ TEventAggregator<T> }

class constructor TEventAggregator<T>.Create;
begin
  FSubscriptions := TList < TSubscription < T >>.Create();
end;

class procedure TEventAggregator<T>.Publish(data: T);
var
  subs: TSubscription<T>;
begin
  for subs in Self.FSubscriptions do
  begin
    if not subs.IsDisposed then
      subs.Call(data);
  end;
end;

class function TEventAggregator<T>.Subscribe(method: TEvent<T>;
  owner: TComponent): TSubscription<T>;
begin
  Result := TSubscription<T>.Create(method, owner);
  Self.FSubscriptions.Add(Result);
end;

{ TSubscription<T> }

procedure TSubscription<T>.Call(data: T);
begin
  if not Self.FIsDisposed then
    FHandler(data);
end;

constructor TSubscription<T>.Create(handler: TEvent<T>; owner: TComponent);
begin
  FHandler := handler;
  FOwner := owner;
end;

destructor TSubscription<T>.Destroy;
begin
  Dispose;
end;

procedure TSubscription<T>.Dispose;
begin
  Self.FIsDisposed := true;
end;

end.
