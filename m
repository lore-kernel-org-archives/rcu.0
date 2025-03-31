Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8F21C179;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=Y/fsasU6NWpd1GxKFoUihagChCfVKOyb8IjskcaWhVKsDCTgmwr3ygDjzylL1YbMZZHVUxM461T7NFez24RLom2sy8f6bHfxdJXhrlqMMmwFFHk81j8Y125atolnhXDPdyiD+fSZqWV/mWD1+T4hvlQYoqDIDE83k7lLT+R/V38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=j8gNiTe021vKXl/HqR9kVLbh4GpEoFmmH1JdHrOrQgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwPjhbapWsztNldBiULTDwb+/LL0/y+dweENCJnk7tp9/xwSwcGAq7vyGzmAGx1BkIufSigoLceutYkAWGFdfDU1Ez8uB3wTixJEHqrbfPJDfeXU4pZRFq7ojef9TMMAAkM8ouLOE44ouyzq7GMTc2kWqy8CEMQyx8vP/UTPdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNop9wgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNop9wgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFC3C4CEFA;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454996;
	bh=j8gNiTe021vKXl/HqR9kVLbh4GpEoFmmH1JdHrOrQgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNop9wgd5JHvLkW3FO+PZk5MQmmoANAKsSUKzaRx4sgRBAdJSVXqYQTopwmpGuQz4
	 j6IFU46vHjmnc1lofPodiZNt30hnMXOEqEO4uSnwB5uxiZjqgbO62JJ8bUTrwYKvhL
	 s5hLYpvOO9eUvOLG48Douvgb+t4LnTDjBh5CdXdklT/sZwjrufFSQXwF56/kQUuXw3
	 o9EqrdG6EOThza+6PNpdBpc72yL3zxRdVLdFw6tfCtzj4/RLxkeBepo/um9oHe7x+8
	 iNZFYmEq9I2YmIpYXfOawZRUlJqGgOOKbwk3TnY7uvBkezMuWYvwX60cVCWPQns+S0
	 +g7dcD4O17hMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3DD8BCE13B4; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 11/12] torture: Add --do-{,no-}normal to torture.sh
Date: Mon, 31 Mar 2025 14:03:13 -0700
Message-Id: <20250331210314.590622-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, torture.sh runs normal runs unconditionally, which can be slow
and thus annoying when you only want to test --kcsan or --kasan runs.
This commit therefore adds a --do-normal argument so that "--kcsan
--do-no-kasan --do-no-normal" runs only KCSAN runs.  Note that specifying
"--do-no-kasan --do-no-kcsan --do-no-normal" gets normal runs, so you
should not try to use this as a synonym for --do-none.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 9cabe505585ea..751ce770e5462 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -51,6 +51,8 @@ do_scftorture=yes
 do_rcuscale=yes
 do_refscale=yes
 do_kvfree=yes
+do_normal=yes
+explicit_normal=no
 do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
@@ -128,6 +130,8 @@ do
 		do_refscale=yes
 		do_rt=yes
 		do_kvfree=yes
+		do_normal=yes
+		explicit_normal=no
 		do_kasan=yes
 		do_kcsan=yes
 		do_clocksourcewd=yes
@@ -161,11 +165,17 @@ do
 		do_refscale=no
 		do_rt=no
 		do_kvfree=no
+		do_normal=no
+		explicit_normal=no
 		do_kasan=no
 		do_kcsan=no
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
 		;;
+	--do-normal|--do-no-normal|--no-normal)
+		do_normal=`doyesno "$1" --do-normal`
+		explicit_normal=yes
+		;;
 	--do-rcuscale|--do-no-rcuscale|--no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
@@ -242,6 +252,17 @@ trap 'rm -rf $T' 0 2
 echo " --- " $scriptname $args | tee -a $T/log
 echo " --- Results directory: " $ds | tee -a $T/log
 
+if test "$do_normal" = "no" && test "$do_kasan" = "no" && test "$do_kcsan" = "no"
+then
+	# Match old scripts so that "--do-none --do-rcutorture" does
+	# normal rcutorture testing, but no KASAN or KCSAN testing.
+	if test $explicit_normal = yes
+	then
+		echo " --- Everything disabled, so explicit --do-normal overridden" | tee -a $T/log
+	fi
+	do_normal=yes
+fi
+
 # Calculate rcutorture defaults and apportion time
 if test -z "$configs_rcutorture"
 then
@@ -332,9 +353,12 @@ function torture_set {
 	local kcsan_kmake_tag=
 	local flavor=$1
 	shift
-	curflavor=$flavor
-	torture_one "$@"
-	mv $T/last-resdir $T/last-resdir-nodebug || :
+	if test "$do_normal" = "yes"
+	then
+		curflavor=$flavor
+		torture_one "$@"
+		mv $T/last-resdir $T/last-resdir-nodebug || :
+	fi
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
-- 
2.40.1

