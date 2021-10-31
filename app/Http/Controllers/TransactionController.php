<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Transaction;
use App\Models\TransactionDetail;

class TransactionController extends Controller
{
	public function getTransactions(Request $request, $my = null) {
		$data = [];
		if ($my != null) {
			$transactions = Transaction::where('user_id', $request->user()->id)->get();
		} else {
			$transactions = Transaction::all();
		}

		if (count($transactions) > 0) {
			foreach ($transactions as $transaction) {
				$data[$transaction->id] = $transaction->toArray();
				if ($transaction->others_data != null) {
					$data[$transaction->id]['others_data'] = json_decode($transaction->others_data, true);
				}

				$data[$transaction->id]['owner'] = [
					'first_name' => $request->user()->first_name,
					'last_name' => $request->user()->last_name,
					'phone' => $request->user()->phone,
					'email' => $request->user()->email,
				];

				if(count($transaction->details) > 0){
					foreach ($transaction->details as $d) {
						$data[$transaction->id]['detail_transaction'][$d['id']]['item_id'] = $d['item_id'];
						$data[$transaction->id]['detail_transaction'][$d['id']]['item_name'] = $d['item_name'];
						$data[$transaction->id]['detail_transaction'][$d['id']]['item_price'] = $d['item_price'];
						$data[$transaction->id]['detail_transaction'][$d['id']]['item_qty'] = $d['item_qty'];
					}
				}
			}
		}

		if (count($data) > 0) {
			return $this->sendResponse('Transactions found successfully', $data);
		}
		return $this->sendError('Transactions not found');
	}

	public function cekTransaction(Request $request, $order_id) {
		$headers = array(
			'Accept: application/json',
			'Content-Type: application/json',
			'Authorization: Basic '. base64_encode(env('MIDTRANS_SERVER_KEY').':')
		);

		$ch = curl_init('https://api.sandbox.midtrans.com/v2/'.trim($order_id).'/status');
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_USERPWD, env('MIDTRANS_SERVER_KEY') . ":");
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($ch);
		curl_close($ch);
		$response = json_decode($response, true);

		if (isset($response['order_id']) && $response['order_id'] != '') {
			return $this->sendResponse('Transaction is found', $response, $response['status_code']);
		}
		return $this->sendError('Transaction not found', $response, $response['status_code']);
	}
}
