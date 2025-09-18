Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8472EB5BF;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191394; cv=none; b=k/OhEoQlMlT+WLfpm2WCMJEk+MK5MMSofWGPhoIL/fq+s8nUbsjUiJ9J7plU+Kw8szu64dpq8J5SZmfLWr+c8FmFza+z1tsPqk6ClwcrQxpG1Kc7LsNmo0GJcAMAoA3S917syJWaIygOS2lBghnxr6JArLpJYGyuTh68nJ6/HMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191394; c=relaxed/simple;
	bh=Mp9NGrJWUWVhDqtHZIZvK7J6EzBqIIE/DcFZ0dsLmlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWK6SO19Y8czUnhDdRW7390zRI5l0uMmHVnEVqXbXyYpZ6qR62JvZ9AIg1tl3/w051X0D2nmXONNPz/gX7akwI65nheV2asdJPajvQQb4CSVx9B/AE3vDcweHO++vJuKl65Uu9G0dtZHqJSjW+cQ655O0CSXgMR/D9Gp4qETPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyvYsFVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyvYsFVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840CAC4CEFB;
	Thu, 18 Sep 2025 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191394;
	bh=Mp9NGrJWUWVhDqtHZIZvK7J6EzBqIIE/DcFZ0dsLmlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyvYsFVF++doDfDmql4rI45Ly/L4C6sSTlPhwMehw3YmWvFJxJ/BhN+uKI+7b51Ao
	 ouhcbmsQQvbjDsAmP1FUTyIoANwHI4wrUG0qPSfG9ZOHnzHgcZAkap3SQi4pOqg4fC
	 yS47Di4SMEkXElmAB0GPq9VNafK2lKv8MV9Ju+fgArO0h62zYyFwuCa/9owN+sEWxU
	 /2ORzpAE3i1bm728Bf4H2m4IYlN1c4WGcI0cDSo5Yp5GTqrrevwQVexvhlNMzAqcmc
	 kJADyuO7ZH3hP/KuIScc2oh2bVV/ppdndc4EuH3v/ZIc74k5fEoTVs+xoSXsUrN3wt
	 72bTFrO6VS48A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD70CCE0B32; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 01/11] rcutorture: Fix jitter.sh spin time
Date: Thu, 18 Sep 2025 03:29:42 -0700
Message-Id: <20250918102952.2593045-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
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

