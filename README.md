# dmp_calc

A deck cost calculator tool for duel master's plays.


flutter build web --release --web-renderer canvaskit

aws --region ap-northeast-1 s3 sync ./build/web s3://dmp-game-charge-calculator-staging/ --profile=PROFILE_NAME




CloudFront invalidate
aws cloudfront create-invalidation --distribution-id EMT0EG9PPWIMU --paths "/*"






aws --region ap-northeast-1 s3 sync ./build/web s3://dmp-game-charge-calculator/ --profile=PROFILE_NAME
