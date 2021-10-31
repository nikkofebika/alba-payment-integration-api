<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
	public function user() {
		return $this->belongsTo(User::class);
	}

	public function details() {
		return $this->hasMany(TransactionDetail::class, 'transaction_id', 'transaction_id');
	}
}
