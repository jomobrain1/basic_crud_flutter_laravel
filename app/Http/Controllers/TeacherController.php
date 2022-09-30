<?php

namespace App\Http\Controllers;

use App\Models\Teacher;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class TeacherController extends Controller
{




   public function index(){
    return Teacher::all();
   }

    public function store(Request $request)
    {
        //validate fields
        $attrs = $request->validate([
            'name' => 'required',
            
            'phone' => 'required',
            'image' => 'required',
        ]);

        $image = $this->saveImage($request->image, 'teachers');

       
        
        

        $teacher = Teacher::create([
            'name' => $attrs['name'],
            
            'phone' => $attrs['phone'],
            'image' => $image
        ]);

        // for now skip for teacher image

        return response([
            'message' => 'teacher created.',
            'teacher' => $teacher,
        ], 200);
    }

       
    public function update(Request $request, $id)
    {
        $teacher = Teacher::find($id);

        if(!$teacher)
        {
            return response([
                'message' => 'teacher not found.'
            ], 403);
        }
      
       
        $path = parse_url($teacher->image);
        if($path){
            File::delete(public_path($path['path']));
        }

       

     

        //validate fields
        $attrs = $request->validate([
            'name' => 'required',
            
            'phone' => 'required',
            // 'image' => 'required',
        ]);
        $image = $this->saveImage($request->image, 'teachers');

        $teacher->update([
            
            'name' => $attrs['name'],
            
            'phone' => $attrs['phone'],
            'image' => $image
        ]);

        // for now skip for teacher image

        return response([
            'message' => 'teacher updated.',
            'teacher' => $teacher
        ], 200);
    }


     //deleteacher
     public function destroy(Request $request,$id)
     {
         $teacher = Teacher::find($id);
         $oldImage=$teacher->image;
        //  if($oldImage){
        //      unlink($oldImage);
        //  }
         $path = parse_url($teacher->image);

         File::delete(public_path($path['path']));
         if(!$teacher)
         {
             return response([
                 'message' => 'teacher not found.'
             ], 403);
         }
 
        
 
       
         $teacher->delete();
 
         return response([
             'message' => 'teacher deleted.'
         ], 200);
     }
  
}
