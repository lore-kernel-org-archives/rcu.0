Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A73F106B;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405914; cv=none; b=N3/tnBhNC30xTpAW6VrACkmgtdi8bsYLds9dmodbe7gHjXlcz1nFjAknJdpzM4qpuK7LaDgNRtcp2CZoJrUPio0IKcbYZLrwKZjZ4QBPqlKG/52ElsRuonJoCVThE7iVhD6bO+nSRYcSt+ngK2KAb1EfzYSGHzWl5LHSjo+Se4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405914; c=relaxed/simple;
	bh=wGZ4qan7/j/8qTLzj3/b9p7Ohjp1uGrM2QuuZUYZwt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoYDPhpjcUBjXE91zY+oYrv6RNIWN7SCa1PmDKzQyfD18fx58U/akx5aOgIJjrSFh0Ih8ByMLlqlrgh78QB2waWOSlzo+DIjZLweolNpVabDuuKAm2PC7TmVVx67eJwTZw37s67tdcir3QBcBgktdqpUfjGhgWM4xsffI/2Tn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+x04BSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+x04BSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A69A1F000FF;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=aAlK4qyzR12Nz1UmiH1dkwwVv6ZGAmCATRLIWlWGkcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+x04BSar6rEA09mRsN49rP9ir6UkRZ0zX+n3cvD+RV92VsFJltqM80miV1LozO4t
	 YluLvC2muACxZ4SiUm21lABQ2Xrefod5bPTywFS3M75XuO+Fn/NzN+NBg3pPJzf8Bt
	 00KaSwMBkXjFO+tzyRcTBxthIruSy11xuxo2UaVIdE8UPxVukKa0ZMrbwmoC35MCoR
	 MKyxeopIzhBcEsRpK73QDVnvGTYI5T5f5ezl5llaYw6qNX7y/TITTISz+v51TrfvsD
	 cO+GER+XppyBz/V6SBBmOFGWVv4DrhH1wLs0B1kJvTJJsVSYwdrxR/dSqtSJkVgCHr
	 yCpUhbFScbsYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 23B6BCE0D79; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 01/10] doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU
Date: Wed,  7 Oct 2026 13:45:02 -0700
Message-Id: <20261007204511.1982646-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
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
index d7c8eff633174..a986358a5c279 100644
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

