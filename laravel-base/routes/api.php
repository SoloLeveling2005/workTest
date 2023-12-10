<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('user')->group(function () {
    Route::post('register', [\App\Http\Controllers\UserController::class, 'register'])->name('userRegister');
    Route::post('login', [\App\Http\Controllers\UserController::class, 'login'])->name('userLogin');
    Route::middleware(['auth:sanctum'])->get('info', [\App\Http\Controllers\UserController::class, 'info'])->name('userInfo');
    Route::middleware(['auth:sanctum'])->post('logout', function () {
        \Illuminate\Support\Facades\Auth::logout();
        return response()->json(201);
    });
});
Route::prefix('news')->group(function () {
    // НОВОСТИ
    //
    // Получение информации по всем новостям
    Route::get('list', [\App\Http\Controllers\NewsController::class, 'getList'])->name('getListNews');
    // Получение информации по новостям пользователя
    Route::middleware(['auth:sanctum'])->get('myList', [\App\Http\Controllers\NewsController::class, 'myList'])->name('getMyListNews');
    // Создание новости
    Route::middleware(['auth:sanctum'])->post('create', [\App\Http\Controllers\NewsController::class, 'create'])->name('createNews');

    Route::prefix('{news_id}/')->group(function () {
        // Удаление новости
        Route::middleware(['auth:sanctum'])->delete('delete', [\App\Http\Controllers\NewsController::class, 'delete'])->name('deleteNews');

        // Получение информации одной новости
        Route::get('', [\App\Http\Controllers\NewsController::class, 'get'])->name('getNews');

        // КОММЕНТАРИИ
        Route::prefix('comments')->group(function () {
            // Создание комментария
            Route::middleware(['auth:sanctum'])->post('create', [\App\Http\Controllers\CommentController::class, 'create'])->name('createNewsComment');
            // Удаление комментария
            Route::middleware(['auth:sanctum'])->delete('{comment_id}/delete', [\App\Http\Controllers\CommentController::class, 'delete'])->name('deleteNewsComment');
        });

        // ОЦЕНКИ
        Route::prefix('assessments')->group(function () {
            // Добавить/Удалить оценку
            Route::middleware(['auth:sanctum'])->patch('change', [\App\Http\Controllers\AssessmentsController::class, 'change'])->name('changeNewsAssessment');
            // Посмотреть оценку
            Route::middleware(['auth:sanctum'])->get('get', [\App\Http\Controllers\AssessmentsController::class, 'get'])->name('getNewsAssessment');
        });

        // ПРОСМОТРЫ - перенес функционал внутрь запроса новости
    });

});

