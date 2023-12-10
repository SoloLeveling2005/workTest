<?php

namespace App\Http\Controllers;

use App\Models\User;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'login'=>'required|unique:users,login',
            'password'=>'required'
        ]);
        if ($validator->failed()) {
            return response()->json($validator->fails(), 400);
        }
        $valid_data = $validator->validate();

        $user = User::create([
            'login'=>$valid_data['login'],
            'password'=>Hash::make($valid_data['password'])
        ]);

        return response()->json([], 201);
    }

    public function login(Request $request) {
        $validator = Validator::make($request->all(), [
            'login'=>'required',
            'password'=>'required'
        ]);
        if ($validator->failed()) {
            return response()->json($validator->fails(), 400);
        }
        $valid_data = $validator->validate();

        if (Auth::guard('web')->attempt($valid_data)) {
            $token = $request->user()->createToken($valid_data['login'])->plainTextToken;
            return response()->json([
                'token'=>$token
            ], 200);
        }
        return response()->json(['message'=>'Логин или пароль введен неверно'], 404);
    }

    public function info(Request $request) {
        $user = $request->user();
        return response()->json($user, 200);
    }
}
