<?php

namespace App\Http\Controllers;

use App\Models\Assessment;
use App\Models\News;
use App\Models\Wake;
use Illuminate\Http\Request;

class AssessmentsController extends Controller
{
    public function get(Request $request, $news_id) {
        $user = $request->user();
        $news = News::where(['id'=>$news_id])->get();
        if ($news->count() == 0) {
            return response()->json([],404);
        }
        $news = $news->first();
        $assessment = Assessment::where([
            'user_id'=>$user->id,
            'news_id'=>$news->id,
        ])->first();

        return response()->json(['status'=>$assessment->exists()],200);
    }
    public function change(Request $request, $news_id) {
        $user = $request->user();
        $news = News::where(['id'=>$news_id])->get();
        if ($news->count() == 0) {
            return response()->json([],404);
        }
        $news = $news->first();

        $assessment = Assessment::where([
            'user_id'=>$user->id,
            'news_id'=>$news->id,
        ])->first();
        if ($assessment) {
            $assessment->delete();
            $status = false;
        } else {
            $assessment = Assessment::create([
                'user_id'=>$user->id,
                'news_id'=>$news->id,
            ]);
            $status = true;
        }

        $assessments = Assessment::where([
            'news_id'=>$news->id
        ])->get();

        return response()->json(['count'=>$assessments->count(), 'status'=>$status], 201);
    }
}
