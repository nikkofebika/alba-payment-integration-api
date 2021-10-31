<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');
            $table->string('bank', 10)->nullable();
            $table->string('va_number', 50)->nullable();
            $table->string('bill_key', 50)->nullable();
            $table->string('biller_code', 50)->nullable();

            $table->string('transaction_id')->unique();
            $table->string('order_id')->unique();
            $table->string('merchant_id');
            $table->integer('gross_amount');
            $table->string('currency', 4);
            $table->string('payment_type', 20);
            $table->dateTime('transaction_time');
            $table->string('transaction_status', 20);
            
            $table->string('fraud_status', 20)->nullable();
            $table->string('store', 20)->nullable();
            $table->string('payment_code')->nullable();
            $table->string('redirect_url')->nullable();
            $table->text('others_data')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transactions');
    }
}
