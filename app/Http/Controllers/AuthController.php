<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use App\Models\User;

class AuthController extends Controller
{
	public function register(Request $request){
		$validator = Validator::make($request->all(), [
			'first_name' => 'required',
			'last_name' => 'required',
			'phone' => 'required',
			'email' => 'required|email|unique:users',
			'password' => 'required'
		]);

		if ($validator->fails()) {
			return $this->sendError('Invalid input', $validator->errors());
		}

		$user = User::create([
			'first_name' => $request->input('first_name'),
			'last_name' => $request->input('last_name'),
			'phone' => $request->input('phone'),
			'email' => $request->input('email'),
			'password' => Hash::make($request->input('password')),
		]);

		if ($user) {
			return $this->sendResponse('User registered succesfully', $user, 201);
		}

		return $this->sendError('Failed to register');
	}

	public function login(Request $request){
		$validator = Validator::make($request->all(), [
			'email' => 'required|email',
			'password' => 'required'
		]);

		if ($validator->fails()) {
			return $this->sendError('Invalid input', $validator->errors());
		}

		$user = User::where("email", $request->input("email"))->first();

		if (Hash::check($request->input("password"), $user->password)) {
			$token = base64_encode(Str::random(40));
			$user->update([
				'api_token' => $token
			]);

			return $this->sendResponse('User authenticated succesfully', [
				'user' => $user,
				'token' => $token,
			]);
		}

		return $this->sendError("Credentials don't match");
	}
}
