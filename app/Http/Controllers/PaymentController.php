<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Transaction;
use App\Models\TransactionDetail;

class PaymentController extends Controller
{
	public $bankList = ['bca','bni','bri','mandiri','permata'];
	public $electronicMoneyList = ['bca_klikpay','gopay','cimb_clicks','danamon_online','cstore','akulaku'];
	public $requiredValidator = [
		'item_details.*.name' => 'required',
		'item_details.*.price' => 'required|numeric',
		'item_details.*.quantity' => 'required|numeric',
	];

	public function bank(Request $request) {
		$bank = $request->input('bank_name');
		if (isset($bank) && !in_array($bank, $this->bankList)) {
			return $this->sendError('Bank tidak terdaftar. Daftar bank ('.implode(', ', $this->bankList).')');
		}

		$validation = $this->bankValidation($request, $bank);
		if (!$validation['success']) {
			return $this->sendError('Invalid input', $validation['validator']);
		}

		$transaction_data = $this->setTransactionData([
			'item_details' => $request->input('item_details'),
			'email' => $request->user()->email,
			'first_name' => $request->user()->first_name,
			'last_name' => $request->user()->last_name,
			'phone' => $request->user()->phone,
		]);

		if ($bank == 'mandiri') {
			$transaction_data['payment_type'] = 'echannel';
			$transaction_data['echannel'] = [
				"bill_info1" => $request->input('bill_info1'),
				"bill_info2" => $request->input('bill_info2'),
			];
		} else {
			$transaction_data['payment_type'] = 'bank_transfer';
			$transaction_data['bank_transfer'] = [
				"bank" => $bank,
				"va_number" => $request->input('va_number'),
			];
		}

		$response = \Midtrans\CoreApi::charge($transaction_data);
		if ($response->status_code == '201') {
			if ($this->saveTransaction([
				'user_id' => $request->user()->id,
				'bank' => $bank,
				'response' => $response,
				'transaction_data' => $transaction_data,
			])){
				return $this->sendResponse('Transaction created successfully', $response, $response->status_code);
			}
		}
		return $this->sendError('Failed to create transaction', $response, $response->status_code);
	}

	public function charge(Request $request, $payment_type) {
		if (isset($payment_type) && !in_array($payment_type, $this->electronicMoneyList)) {
			return $this->sendError('Provider tidak terdaftar. Daftar provider ('.implode(', ', $this->electronicMoneyList).')');
		}

		$validation = $this->electronicMoneyValidation($request, $payment_type);
		if (!$validation['success']) {
			return $this->sendError('Invalid input', $validation['validator']);
		}

		$transaction_data = $this->setTransactionData([
			'item_details' => $request->input('item_details'),
			'email' => $request->user()->email,
			'first_name' => $request->user()->first_name,
			'last_name' => $request->user()->last_name,
			'phone' => $request->user()->phone,
		]);

		$transaction_data['payment_type'] = $payment_type;

		if ($payment_type == 'bca_klikpay') {
			$transaction_data['bca_klikpay'] = [
				"type" => 1,
				"description" => $request->input('payment_description'),
			];
		} elseif ($payment_type == 'gopay') {
			if($request->input('enable_callback') == true){
				$transaction_data['gopay'] = [
					"enable_callback" => boolval($request->input('enable_callback')),
					"callback_url" => $request->input('callback_url'),
				];
			}
		} elseif ($payment_type == 'cimb_clicks') {
			$transaction_data['cimb_clicks'] = [
				"description" => $request->input('payment_description'),
			];
		} elseif ($payment_type == 'cstore') {
			if($request->input('store') == 'Indomaret' || $request->input('store') == 'indomaret'){
				$transaction_data['cstore'] = [
					"store" => 'Indomaret',
					"message" => $request->input('payment_message'),
				];
			} else {
				$transaction_data['cstore'] = [
					"store" => 'alfamart',
					"message" => $request->input('payment_message'),
				];
			}
		}

		$response = \Midtrans\CoreApi::charge($transaction_data);
		if ($response->status_code == '201') {
			if ($this->saveTransaction([
				'user_id' => $request->user()->id,
				'payment_type' => $payment_type,
				'response' => $response,
				'transaction_data' => $transaction_data,
			])){
				return $this->sendResponse('Transaction created successfully', $response, $response->status_code);
			}
		}
		return $this->sendError('Failed to create transaction', $response, $response->status_code);
	}

	public function bankValidation($request, $bank) {
		$arrValidator = $this->requiredValidator;
		$arrValidator['bank_name'] = 'required';

		if ($bank == 'mandiri') {
			$arrValidator['bill_info2'] = 'required';
			$arrValidator['bill_info2'] = 'required';
		} else {
			$arrValidator['va_number'] = 'required';
		}

		return $this->validation($request, $arrValidator);
	}

	public function electronicMoneyValidation($request, $payment_type) {
		$arrValidator = $this->requiredValidator;
		if ($payment_type == 'bca_klikpay') {
			$arrValidator['payment_description'] = 'required';
		} elseif ($payment_type == 'gopay') {
			$arrValidator['callback_url'] = 'url';
		} elseif ($payment_type == 'cimb_clicks') {
			$arrValidator['payment_description'] = 'required';
		} elseif ($payment_type == 'cstore') {
			$arrValidator['store'] = 'required';
		}

		return $this->validation($request, $arrValidator);
	}

	public function validation($request, $arrValidator) {
		$validator = Validator::make($request->all(), $arrValidator);

		if ($validator->fails()) {
			return ['success' => false, 'validator' => $validator->errors()];
		}
		return ['success' => true];
	}

	public function setTransactionData($data){
		$itemId = 1;
		$gross_amount = 0;
		$item_details = $data['item_details'];
		for ($i=0; $i < count($item_details); $i++) { 
			$item_details[$i]['id'] = 'item'.$itemId++;
			$item_details[$i]['name'] = $item_details[$i]['name'];
			$item_details[$i]['price'] = intval($item_details[$i]['price']);
			$item_details[$i]['quantity'] = intval($item_details[$i]['quantity']);
			$gross_amount += intval($item_details[$i]['price'])*intval($item_details[$i]['quantity']);
		}

		$transaction_data = [
			"transaction_details" => [
				"gross_amount" => $gross_amount,
				"order_id" => "order-".date('ymdHis'),
			],
			"customer_details" => [
				"email" => $data['email'],
				"first_name" => $data['first_name'],
				"last_name" => $data['last_name'],
				"phone" => $data['phone'],
			],
			"item_details" => $item_details,
		];

		return $transaction_data;
	}

	public function saveTransaction($data) {
		$transaction = new Transaction;
		$transaction->user_id = $data['user_id'];

		$transaction->transaction_id = $data['response']->transaction_id;
		$transaction->order_id = $data['response']->order_id;
		$transaction->merchant_id = $data['response']->merchant_id;
		$transaction->gross_amount = intval($data['response']->gross_amount);
		$transaction->currency = $data['response']->currency;
		$transaction->payment_type = $data['response']->payment_type;
		$transaction->transaction_time = $data['response']->transaction_time;
		$transaction->transaction_status = $data['response']->transaction_status;

		$transaction->fraud_status = isset($data['response']->fraud_status) && $data['response']->fraud_status != '' ? $data['response']->fraud_status : null;
		$transaction->redirect_url = isset($data['response']->redirect_url) && $data['response']->redirect_url != '' ? $data['response']->redirect_url : null;

		if (isset($data['bank']) && $data['bank'] != '') {
			if ($data['bank'] == 'permata') {
				$transaction->va_number = $data['response']->permata_va_number;
				$transaction->bank = 'permata';
			} elseif ($data['bank'] == 'mandiri') {
				$transaction->bank = 'mandiri';
				$transaction->bill_key = $data['response']->bill_key;
				$transaction->biller_code = $data['response']->biller_code;
			} else {
				$transaction->bank = $data['response']->va_numbers[0]->bank;
				$transaction->va_number = $data['response']->va_numbers[0]->va_number;
			}
		} else {
			if ($data['payment_type'] == 'bca_klikpay') {
				$transaction->others_data = isset($data['response']->redirect_data) ? json_encode($data['response']->redirect_data) : null;
			} elseif ($data['payment_type'] == 'gopay') {
				$transaction->others_data = isset($data['response']->actions) ? json_encode($data['response']->actions) : null;
			} elseif ($data['payment_type'] == 'cstore') {
				$transaction->store = $data['response']->store;
				$transaction->payment_code = $data['response']->payment_code;
			}
		}

		if ($transaction->save()) {
			foreach ($data['transaction_data']['item_details'] as $d) {
				TransactionDetail::create([
					'transaction_id' => $transaction->transaction_id,
					'item_id' => $d['id'],
					'item_name' => $d['name'],
					'item_price' => $d['price'],
					'item_qty' => $d['quantity'],
				]);
			}
			return true;
		};
		return false;
	}
}
