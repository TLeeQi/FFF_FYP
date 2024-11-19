<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Response;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    public function jsonResponse(
        $data = [],
        $error = '',
        $ext = [],
        $status = 200
    ) {
        return response([
            'success' => empty($error),
            'data'    => $data,
            'error'   => $error,
        ] + $ext, $status,);
    }

    public function success($data = [], $status = 200, $err = [])
    {
        return $this->jsonResponse($data, '', $err, $status);
    }

    public function fail(string $error, $status = 200, $err = [])
    {
        return $this->jsonResponse([], $error, $err, $status);
    }
}
