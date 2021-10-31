<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
	return $router->app->version();
});

$router->post('register', 'AuthController@register');
$router->post('login', 'AuthController@login');

$router->group(['middleware' => 'auth'], function () use ($router) {
	$router->get('users[/{id}]', 'UserController@index');

	$router->group(['prefix' => 'transaction'], function () use ($router) {
		$router->get('cek/{order_id}', 'TransactionController@cekTransaction');
		$router->get('{my}', 'TransactionController@getTransactions');
		$router->get('/', 'TransactionController@getTransactions');
	});

	$router->group(['prefix' => 'payment'], function () use ($router) {
		$router->post('bank', 'PaymentController@bank');
		$router->post('charge/{payment_type}', 'PaymentController@charge');
	});
});