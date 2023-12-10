<?php

namespace App\Http\Controllers;

use App\Models\Assessment;
use App\Models\News;
use App\Models\Wake;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class NewsController extends Controller
{
    public function myList(Request $request) {
        // Количество элементов на странице
        $perPage = 3;

        // Получаем страницу из запроса
        $currentPage = $request->input('page', 1);

        // Получаем коллекцию элементов с пагинацией
        $items = News::with(['comments','assessments','wakes','author'])->where([
            'user_id'=>$request->user()->id
        ])->paginate($perPage, ['*'], 'page', $currentPage);

        // Получаем общее количество страниц
        $totalPages = $items->lastPage();

        // Возвращаем данные, например, в JSON
        return response()->json($items, 200);
    }
    public function get(Request $request, $news_id) {
        $news = News::with(['comments','assessments','wakes','author'])->where(['id'=>$news_id])->get();

        if ($news->count() == 0) {
            return response()->json([
                'message'=>'Новости не существует'
            ], 400);
        }

        $wake = Wake::create([
            'news_id'=>$news_id,
        ]);

        $news = News::with(['comments','assessments','wakes','author'])->where(['id'=>$news_id])->first();

        return response()->json([
            'news'=>$news,
        ], 200);
    }

    public function getList(Request $request) {
        // Количество элементов на странице
        $perPage = 3;

        // Получаем страницу из запроса
        $currentPage = $request->input('page', 1);

        // Получаем коллекцию элементов с пагинацией
        $items = News::with(['comments','assessments','wakes','author'])->paginate($perPage, ['*'], 'page', $currentPage);

        // Получаем общее количество страниц
        $totalPages = $items->lastPage();

        // Возвращаем данные, например, в JSON
        return response()->json($items, 200);
    }

    public function create(Request $request) {
        $validator = Validator::make($request->all(),[
            'title'=>'required',
            'text'=>'required',
            'img'=>'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);
        if ($validator->failed()) {
            return response()->json($validator->fails(), 400);
        }
        $valid_data = $validator->validate();

        // Получите файл из запроса
        $file = $request->file('img');

        $destinationPath = public_path('images');
        $fileName = uniqid() . '.' . $file->getClientOriginalExtension();
        $file->move($destinationPath, $fileName);
        $imagePath = 'images/' . $fileName;

        $news = News::create([
            'title'=>$valid_data['title'],
            'text'=>$valid_data['text'],
            'img_url'=>$imagePath,
            'user_id'=>$request->user()->id
        ]);

        return response()->json(['news_id'=>$news->id], 200);
    }

    public function delete(Request $request, $news_id) {
        $news = News::with(['comments','assessments','wakes','author'])->where(['id'=>$news_id])->first();

        if (!$news) {
            return response()->json([
                'message'=>'Новости не существует'
            ], 400);
        }

        if ($news->author->id != $request->user()->id) {
            return response()->json([],403);
        }
        $news->delete();
        return response()->json([],200);
    }
}
