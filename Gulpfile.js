var coffee = require('gulp-coffee');
var gulp = require('gulp');
var gutil = require('gutil');
var nodeunit = require('gulp-nodeunit');

gulp.task('default', function(){
    gulp.src("./src/**/*.coffee")
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./tasks'))
});

gulp.task('test', ['default'], function(){
    gulp.src('./test').pipe(nodeunit({reporter: "tap"}));
});

gulp.task('watch', function(){
    gulp.watch('./src/**/*.*', ['default']);
});