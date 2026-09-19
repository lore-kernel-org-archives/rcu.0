Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0832F1FE4;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777743; cv=none; b=jg8JTGTPqwUAjDdZ6L+JNe4IxoIoX74LelObk69Bk09nLZygcAQBUydH9+t90Ju4EmH/t1lOR66LRJoGnL17cKUWPlv9kSRTriZuGMbAc+UuFuMyZO3OeizolsrODZ4bZbBIws/68JQj3wVP9Fw9hVptDSZF5vBtJ4T74lICujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777743; c=relaxed/simple;
	bh=fIMz9rwsSBn2cDCeHDfB4DbNMBaLEwTlKdhFp60MW54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9F2IjJ0fFRJXexQB5ZTvxDFp3M6l3dWi+xefE6uVQyq3+xLdSOWRrkN7JDZHkADxZ8OruMzchK1nlqe/CM6joJNuC2MLqdE8v6B7eQcuI3lkGD8o53h1nl8Ueog2mXB6Ik0Y4g7Wq31P8geEkwNJVWAczS44MyCqjapIn0UZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrrKcykC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrrKcykC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C381F000FF;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=nSYDzA5gZYusVHwyvBAM4SlvRFCBg7Iy3VA2QyG9glo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrrKcykCfRpwcA8WEdzlDUBUNpt7wnEk7gCNZDDU8I7PdHNO60t8t0bSpHYMgrmp2
	 To+b+K85kF3Of6AvnGEoUvLVDXZ1ly8tU2Bw/WmvdMjhNMeYtZpSyXPY+LicJsyf3L
	 dgdK/TDfB+NXnmWt10PSa852OaKd7F6BZQ2+r1RA1mdKAv7JSitcdF415kn8ihvt8B
	 rYgiHPKvGDkl4jG2y5aiclcue2kIQ7aD724VekYRPyi/TCel2+sCv/0jJrTLSi1cju
	 vnsfA9AydoL2C5s6hchoLVGX1MGAk5d9eLPun7MYhxPuBQwjrpGDkHhPSZ28Lfv3+x
	 ij/CITrQtQGsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4613BCE1775; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/9] doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU
Date: Fri, 18 Sep 2026 17:28:52 -0700
Message-Id: <20260919002900.3134117-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RCU Tasks Trace has been re-implemented in terms of SRCU,
update stallwarn.rst to remove obsolete verbiage about RCU Tasks Trace
stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index d7c8eff63317..a986358a5c27 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -122,10 +122,11 @@ warnings:
 	of RCU CPU stall warnings, eventually leading to the realization
 	that the CPU had failed.
 
-The RCU, RCU-sched, RCU-tasks, and RCU-tasks-trace implementations have
-CPU stall warning.  Note that SRCU does *not* have CPU stall warnings.
-Please note that RCU only detects CPU stalls when there is a grace period
-in progress.  No grace period, no CPU stall warnings.
+The RCU and RCU-tasks implementations have CPU stall warning.  Note that
+SRCU does *not* have CPU stall warnings, and now that RCU-tasks-trace
+is implemented in terms of SRCU, neither does it.  Please note that
+RCU only detects CPU stalls when there is a grace period in progress.
+No grace period, no CPU stall warnings.
 
 To diagnose the cause of the stall, inspect the stack traces.
 The offending function will usually be near the top of the stack.
@@ -213,21 +214,16 @@ RCU_STALL_RAT_DELAY
 rcupdate.rcu_task_stall_timeout
 -------------------------------
 
-	This boot/sysfs parameter controls the RCU-tasks and
-	RCU-tasks-trace stall warning intervals.  A value of zero or less
-	suppresses RCU-tasks stall warnings.  A positive value sets the
-	stall-warning interval in seconds.  An RCU-tasks stall warning
-	starts with the line:
+	This boot/sysfs parameter controls the RCU-tasks stall warning
+	interval.  A value of zero or less suppresses RCU-tasks stall
+	warnings.  A positive value sets the stall-warning interval
+	in seconds.  An RCU-tasks stall warning starts with the line:
 
 		INFO: rcu_tasks detected stalls on tasks:
 
 	And continues with the output of sched_show_task() for each
 	task stalling the current RCU-tasks grace period.
 
-	An RCU-tasks-trace stall warning starts (and continues) similarly:
-
-		INFO: rcu_tasks_trace detected stalls on tasks
-
 
 Interpreting RCU's CPU Stall-Detector "Splats"
 ==============================================
-- 
2.40.1

