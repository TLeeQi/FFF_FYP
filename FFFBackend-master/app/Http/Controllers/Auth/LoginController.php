<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function login(Request $request)
    {
        $this->validateLogin($request);

        // Check for 'type' equal to 'admin'
        if (Auth::attempt([
            'email' => $request->email, 'password' => $request->password,
            'type' => 'admin' 
        ])) {
            return $this->sendLoginResponse($request);
        }

        // Check for 'type' equal to 'sadmin'
        if (Auth::attempt([
            'email' => $request->email, 'password' => $request->password,
            'type' => 'sadmin'
        ])) {
            return $this->sendLoginResponse($request);
        }

        // Check for 'type' equal to 'vendor'
        if (Auth::attempt([
            'email' => $request->email, 'password' => $request->password,
            'type' => 'vendor'
        ])) {
            return $this->sendLoginResponse($request);
        }


        return $this->sendFailedLoginResponse($request);
    }
}
