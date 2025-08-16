Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FFDBA4A;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=FAATJZDxp2jzyjey3gmQA5NTvfugUoAXu+olD5ABHgzpfZmaoPUWBKwSwyTBSot2cRHUwT1emQz4gUSmFz0MZv9UB1GC+vqJ2r+snm6RPkEQwmWPLvHfAxoV1vR9E9ZxOtyw1FvEczDPggsmvNxrOtg3zFcAS7ynXM2ulEDv7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=Mp9NGrJWUWVhDqtHZIZvK7J6EzBqIIE/DcFZ0dsLmlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCwDY4pGC2q3QU+UDDlsUa+pQr+r7jBGItuNmdT6B7C4rNfdoIj4sXTX8ZPXmAdRz1ZCj0DgND22YgGqxzlBGaSjbu+QNsZovUEorbXDvCnlAjtxBrJoeUFo4K7p+9NC9pf5KQIrwr8cVqXfntDUlQOE4JNNKI9j7i48STdEzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq9/un6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq9/un6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD96C4CEEB;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302919;
	bh=Mp9NGrJWUWVhDqtHZIZvK7J6EzBqIIE/DcFZ0dsLmlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lq9/un6si0KLvYYMrjst4wRt1pwPAp4waTuw87tw94afsTlJQyIfi8XTm+khcLVzx
	 K633FvvXvYIpq9RR5/RXChgmvhS/1UuxE9urhaUgN4h5+BkKwzaShIPLl1pPI4MZe1
	 mzAYKDKht5CPYnnoE+A68yY5jor+7pAARp3lHvSg6XLIKMAmxvTAWbpn1+aNfHadS4
	 t5Js4z325mfJaWl9GPQlq/x2isUh2zPBJfm3iRNK+Om6YPFWbMC5MSGs12nE2KHQF1
	 siar6rycDGoRtFei/m4ZdWttUeCtaTUfhtcKimBmqyB5avPCH9rTyaQ1OYgoV/fdqS
	 f3rhUZdziNl/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11835CE0B2D; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/7] rcutorture: Fix jitter.sh spin time
Date: Fri, 15 Aug 2025 17:08:31 -0700
Message-Id: <20250816000837.2622858-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
References: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An embarrassing syntax error in jitter.sh makes for fixed spin time.
This commit therefore makes it be variable, as intended, albeit with
very coarse-grained adjustment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/jitter.sh        | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index fd1ffaa5a1358e..3c1e5d3f88058c 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -39,6 +39,22 @@ do
 	fi
 done
 
+# Uses global variables startsecs, startns, endsecs, endns, and limit.
+# Exit code is success for time not yet elapsed and failure otherwise.
+function timecheck {
+	local done=`awk -v limit=$limit \
+			-v startsecs=$startsecs \
+			-v startns=$startns \
+			-v endsecs=$endsecs \
+			-v endns=$endns < /dev/null '
+		BEGIN {
+			delta = (endsecs - startsecs) * 1000 * 1000;
+			delta += int((endns - startns) / 1000);
+			print delta >= limit;
+		}'`
+	return $done
+}
+
 while :
 do
 	# Check for done.
@@ -85,15 +101,20 @@ do
 	n=$(($n+1))
 	sleep .$sleeptime
 
-	# Spin a random duration
+	# Spin a random duration, but with rather coarse granularity.
 	limit=`awk -v me=$me -v n=$n -v spinmax=$spinmax 'BEGIN {
 		srand(n + me + systime());
 		printf("%06d", int(rand() * spinmax));
 	}' < /dev/null`
 	n=$(($n+1))
-	for i in {1..$limit}
+	startsecs=`date +%s`
+	startns=`date +%N`
+	endsecs=$startns
+	endns=$endns
+	while timecheck
 	do
-		echo > /dev/null
+		endsecs=`date +%s`
+		endns=`date +%N`
 	done
 done
 
-- 
2.40.1

