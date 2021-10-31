<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

class Controller extends BaseController
{
    public function __construct(){
        // Set your Merchant Server Key
        \Midtrans\Config::$serverKey = env('MIDTRANS_SERVER_KEY');
        // Set to Development/Sandbox Environment (default). Set to true for Production Environment (accept real transaction).
        \Midtrans\Config::$isProduction = false;
        // Set sanitization on (default)
        \Midtrans\Config::$isSanitized = true;
        // Set 3DS transaction for credit card to true
        \Midtrans\Config::$is3ds = true;
    }

    public function sendResponse($msg, $result = null, $code = 200) {
    	$res = [
            'success' => true,
            'message' => $msg,
        ];
        if($result != null){
            $res['data'] = $result;
        }
        return response()->json($res, $code);
    }

    public function sendError($msg, $result = null, $code = 400) {
    	$res = [
            'success' => false,
            'message' => $msg,
        ];
        if($result != null){
            $res['data'] = $result;
        }
        return response()->json($res, $code);
    }
}
