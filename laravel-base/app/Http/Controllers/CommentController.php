<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CommentController extends Controller
{
    public function create(Request $request, $news_id) {
        $validator = Validator::make($request->all(), [
            'text'=>['required']
        ]);
        if ($validator->failed()) {
            return response()->json($validator->fails(), 400);
        }
        $valid_data = $validator->validate();
        $user = $request->user();

        $news = News::where(['id'=>$news_id])->get();
        if ($news->count() == 0) {
            return response()->json([],404);
        }

        $comment = Comment::create([
            'user_id'=>$user->id,
            'news_id'=>$news_id,
            'text'=>$valid_data['text'],
        ]);

        return response()->json([],201);
    }

    public function delete(Request $request, $news_id, $comment_id) {
        $user = $request->user();

        $news = News::where(['id'=>$news_id])->get();
        if ($news->count() == 0) {
            return response()->json([],404);
        }

        $comment = Comment::where([
            'user_id'=>$user->id,
            'news_id'=>$news_id,
        ])->get();
        if ($comment->count() == 0) {
            return response()->json([],403);
        }
        $comment->first()->delete();
        return response()->json([], 200);
    }
}
