( function _VectorAdapter_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

  require( '../l3_vector/Include.s' );

}

//

var _ = _global_.wTools.withDefaultLong.Fx;
var Space = _.Matrix;
var vad = _.vectorAdapter;
var vec = _.vectorAdapter.fromLong;
var avector = _.avector;
var sqrt = _.math.sqrt;

var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// iterator
// --

function map( test )
{

  /* */

  test.case = 'dst = src';

  function onElement1( src )
  {
    return - 5 < src && src < 0 ; /* numbers in range */
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.map( src, onElement1 );

  var exp = _.vectorAdapter.from( [ true, true, true ] );
  test.identical( got, exp );
  test.is( got === src );

  /* */

  test.case = 'dst = null';

  function onElement1( src )
  {
    return - 5 < src && src < 0 ; /* numbers in range */
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.map( null, src, onElement1 );

  var exp = _.vectorAdapter.make( [ 1, 1, 1 ] );
  test.identical( got, exp ); debugger;

  var exp = _.vectorAdapter.from( [ -1, -1.5, -2 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'Check if a number is > 0 - empty';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - true';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ 0, 1, 0, 2, 1000, 307 ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ true, true, true, true, true, true ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - false some';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ 0, - 1, 0, 2, 1000, '307' ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ true, false, true, true, true, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a number is > 0 - false none';

  function positiveNumber( src )
  {
    return _.numberIs( src ) && src >= 0 ; /* positive numbers */
  }
  var src = _.vectorAdapter.from( [ - 1, - 2, - 1000, '307', [ 3 ] ] );
  var got = _.vectorAdapter.map( src, positiveNumber );

  var exp = _.vectorAdapter.from( [ false, false, false, false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check if a string starts with h - true';

  function stringLengthThree( src )
  {
    return _.strIs( src ) && src.charAt( 0 ) === 'h' ; /* str starts with H */
  }
  var src = _.vectorAdapter.from( [ 'hi!', 'how', 'has', 'he', 'handled', 'his', 'huge', 'hair' ] );
  var got = _.vectorAdapter.map( src, stringLengthThree );

  var expectedStr = _.vectorAdapter.from( [ true, true, true, true, true, true, true, true ] );
  test.identical( got, expectedStr );

  /* */

  test.case = 'Check if a string starts with h - false';

  function stringLengthThree( src )
  {
    return _.strIs( src ) && src.charAt( 0 ) === 'h' ; /* str starts with H */
  }
  var src = _.vectorAdapter.from( [ 'Hello, ', 'how', 'are', 'you', '?' ] );
  var got = _.vectorAdapter.map( src, stringLengthThree );

  var exp = _.vectorAdapter.from( [ false, true, false, false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'Check an array´s length - true';

  function arrayLength( src )
  {
    return _.arrayIs( src ) && src.length === 4 ; /* arrays of length 4 */
  }
  var src = _.vectorAdapter.from( [ ['hi!', 'how', 'are', 'you' ], [ 0, 1, 2, 3 ] ] );
  var got = _.vectorAdapter.map( src, arrayLength );

  var expectedArr = _.vectorAdapter.from( [ true, true ] );
  test.identical( got, expectedArr );

  /* */

  test.case = 'Check an array´s length - false';

  function arrayLength( src )
  {
    return _.arrayIs( src ) && src.length === 4 ; /* arrays of length 4 */
  }
  var src = _.vectorAdapter.from( [ [ 'Hello, ', 'how', 'are', 'you', '?' ], [ 0, 1, 2 ] ] );
  var got = _.vectorAdapter.map( src, arrayLength );

  var exp =  _.vectorAdapter.from( [ false, false ] );
  test.identical( got, exp );

  /* */

  test.case = 'single argument';

  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst );
  test.is( got === dst );

  /* */

  test.case = 'dst and undefined';

  var dst = _.vectorAdapter.from( [ 2, 3, 4 ] );
  var got = _.vectorAdapter.map( dst, undefined );
  test.is( got === dst );

  /* */

  if( !Config.debug )
  return;

  /* */

  test.case = 'Only one argument';

  test.shouldThrowErrorSync( () => _.vectorAdapter.map( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 2 ));

  /* */

  test.case = 'Wrong second argument';

  // test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  /* */

  test.case = 'Wrong first argument';

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.map( Int8Array.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function filter( test )
{

  /* */

  test.case = 'dst = null';

  function onElement1( src )
  {
    return src + 10;
  }
  var src = _.vectorAdapter.from( [ -1, -1.5, -2 ] );
  var got = _.vectorAdapter.filter( null, src, onElement1 );
  var exp = _.vectorAdapter.make( [ 9, 8.5, 8 ] );
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ -1, -1.5, -2 ] )
  test.equivalent( src, exp );

  /* */

}

//

function _while( test )
{

  /* */

  test.case = 'dst = null';
  function onElement1( src )
  {
    return src < 2 ? src : undefined;
  }
  var src = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  var got = _.vectorAdapter.while( null, src, onElement1 );
  var exp = _.vectorAdapter.make( [ 0, 1 ] );
  test.identical( got, exp );
  var exp = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  test.equivalent( src, exp );

  /* */

  test.case = 'dst, src';
  function onElement2( src )
  {
    return src + 10;
  }
  var dst = _.vectorAdapter.from([ 0, 1, 2, 3 ]);
  var got = _.vectorAdapter.while( dst, onElement2 );
  var exp = _.vectorAdapter.from([ 10, 11, 12, 13 ]);
  test.identical( got, exp );
  var exp = _.vectorAdapter.from([ 10, 11, 12, 13 ]);
  test.equivalent( dst, exp );

  /* */

}

//

function all( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.all( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 130;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.all( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.all( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.all( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function any( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 0;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.any( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.any( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.any( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.any( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

//

function none( test )
{

  /* */

  test.case = 'basic false';

  function onElement1( src )
  {
    return src < 13;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.none( src, onElement1 );
  var exp = false;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  test.case = 'basic true';

  function onElement2( src )
  {
    return src < 0;
  }
  var src = _.vectorAdapter.from( [ 5, 10, 15 ] );
  var got = _.vectorAdapter.none( src, onElement2 );
  var exp = true;
  test.identical( got, exp );
  var exp = _.vectorAdapter.from( [ 5, 10, 15 ] )
  test.equivalent( src, exp );

  /* */

  if( !Config.debug )
  return;

  test.case = 'Only one argument'; //

  test.shouldThrowErrorSync( () => _.vectorAdapter.none( ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( null ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( NaN ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( undefined ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 2 ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ) )); /* qqq : add such test case */

  test.case = 'Wrong second argument'; //

  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), null )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), NaN ));
  // test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), undefined )); /* qqq : add such test case */
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), 'string' ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), 2 ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( _.vectorAdapter.from( [ 2, 3, 4 ] ), _.vectorAdapter.from( [ 2, 3, 4 ] ) ));

  test.case = 'Wrong first argument'; //

  function onEvaluate( src )
  {
    return src > 2 ;
  }
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( null, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( undefined, onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( 'string', onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( [ 0, 1, 2, 3 ], onEvaluate ));
  test.shouldThrowErrorSync( () => _.vectorAdapter.none( I8x.from( [ 0, 1, 2, 3 ] ), onEvaluate ));

}

// --
// etc
// --

function distributionRangeSummaryValue( test )
{

  test.case = 'basic';
  var a = vad.from( new I32x([ 1, 2, 3 ]) );
  var b = vad.from( new I32x([ 3, 4, 5 ]) );
  var exp = [ 1, 5 ];
  var got = vad.distributionRangeSummaryValue( a, b );
  test.identical( got, exp );

}

//

function shrinkView( test )
{

  /* */

  test.case = 'fromNumber';

  var exp = vad.from( vad.long.longMake([ 1, 1, 1, 1 ]) );
  var vad1 = vad.fromNumber( 1, 4 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 1, 1 ]) );
  var vad1 = vad.fromNumber( 1, 4 );
  var got = vad.shrinkView( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer !== got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromNumber( 1, 4 );
    var got = vad.shrinkView( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromNumber( 1, 4 );
    var got = vad.shrinkView( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLong';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var got = vad.shrinkView( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
    var got = vad.shrinkView( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLong( vad.long.longMake([ 1, 2, 3, 4 ]) );
    var got = vad.shrinkView( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongLrange';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
  var got = vad.shrinkView( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
    var got = vad.shrinkView( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrange( vad.long.longMake([ 0, 1, 2, 3, 4, 5 ]), 1, 4 );
    var got = vad.shrinkView( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongLrangeAndStride';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
  var got = vad.shrinkView( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
    var got = vad.shrinkView( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongLrangeAndStride( vad.long.longMake([ 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0 ]), 1, 4, 2 );
    var got = vad.shrinkView( vad1, [ 2, 8 ], 6 );
  });

  /* */

  test.case = 'fromLongWithStride';

  var exp = vad.from( vad.long.longMake([ 1, 2, 3, 4 ]) );
  var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
  test.identical( vad1, exp );

  var exp = vad.from( vad.long.longMake([ 2, 3 ]) );
  var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
  var got = vad.shrinkView( vad1, [ 1, 2 ] );
  test.identical( got, exp );
  test.is( vad1._vectorBuffer === got._vectorBuffer );

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
    var got = vad.shrinkView( vad1, [ 2, 8 ] );
  });

  test.shouldThrowErrorSync( () =>
  {
    var vad1 = vad.fromLongWithStride( vad.long.longMake([ 1, 0, 2, 0, 3, 0, 4 ]), 2 );
    var got = vad.shrinkView( vad1, [ 2, 8 ], 6 );
  });

  /* */

}

// --
// proto
// --

/*

- check subarray

*/

var Self =
{

  name : 'Tools.Math.Vector.Adapter',
  silencing : 1,

  context :
  {
  },

  tests :
  {

    // iterator

    map,
    filter,
    while : _while,
    all,
    any,
    none,

    // etc

    distributionRangeSummaryValue,

    shrinkView,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
