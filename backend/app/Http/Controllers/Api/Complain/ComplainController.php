<?php

namespace App\Http\Controllers\Api\Complain;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Division;
use App\Models\District;
use App\Models\Upazila;
use App\Models\PoliceStation;

class ComplainController extends Controller
{
    public function getDivision(){
        try{
            $division = Division::all();
            return response()->json([
                'success' => true,
                'data' => $division
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Division can not fetched.',
            ], 500);
        }
    }

    public function getDistrict($id){
        try{
            $district = District::where('division_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $district,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'District can not fetched.',
            ], 500);
        }
    }

    public function getUpazila($id){
        try{
            $upazila = Upazila::where('district_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $upazila,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Upazila can not fetched.',
            ], 500);
        }
    }

    public function getPoliceStations($id){
        try{
            $policeStation = PoliceStation::where('upazila_id', $id)->get();
            return response()->json([
                'success' => true,
                'data' => $policeStation,
            ], 200);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'PoliceStation can not fetched.',
            ], 500);
        }
    }
}
