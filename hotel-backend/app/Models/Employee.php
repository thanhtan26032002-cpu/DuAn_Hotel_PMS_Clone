<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    protected $table = 'employees';
    protected $primaryKey = 'employee_code';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'employee_code',
        'fullname',
        'position',
        'department',
        'date_of_birth',
        'phone',
        'email',
        'address',
    ];
}
