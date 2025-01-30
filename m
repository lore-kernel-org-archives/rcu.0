Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF31F131F;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263885; cv=none; b=NuKNxNGpdwF/gM5tUnCcP4heb80BIUp4wnupHC7i2nqpPEESwawpZ31aMBxcPmx29quFvqAyQhLDMb3gjrHISuGdxAbiNOGM5hdIRXi29woQ9zcgGIyhDj8jn186X6t2MSkRiQn7BXw7j7LTuSY/VmEEPfsn5yP3Am3cfMW7Bm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263885; c=relaxed/simple;
	bh=skpQ2y/71eDNwBWi3t9jBbeEnDPFWYsUiO3M8+45cao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3/TVzY5vNwMVCUAccMm9oxCr81CWx1JjzL1LwiLr9JnEeZW5kHxwRCkL4BZqveuji0BlnQd15ACtq1rrheuoJ5PasEK4XiYjz61P17D8P3t9hFTcbXzGwZ7Ms6doaNVxGrDaAViJU6+3lDL2dgm+iuP2ClEHOf1ovywqOAZP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/mSmcuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/mSmcuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63CFC4CED2;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263885;
	bh=skpQ2y/71eDNwBWi3t9jBbeEnDPFWYsUiO3M8+45cao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/mSmcuU1/UuqIbbMMfXYhH7HSGIvrmV0oQ0Wr8sPEcVgNCDUtoOkSh5KG1LJ2WGN
	 D6xUzWitf90oRNzJT7EOly83J49esDd0KcBP7Gk8OdaKpp4CHs3a77pqW9djpVV8h+
	 BywpTB1gHcTi2CQt9WOJBgy9Ot9cwapa495ZxXXX9PVlduLHxVzrFvOpct28QLMmm0
	 2q6/M3EiejmG0omszMAWAfHPq5fkkLSTVhRPrOcu3GTLa7CMe5tDn6fPhMSme0PrWc
	 AIExyBU7Grmw4mTHcYmZjg1sEEsWt1DRpV0S9HMnpr/s9xIntWGPS7zljbalrrp8ON
	 xwduPBSS58dLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76579CE37D9; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 01/11] torture: Add get_torture_init_jiffies() for test-start time
Date: Thu, 30 Jan 2025 11:04:34 -0800
Message-Id: <20250130190444.1652700-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a get_torture_init_jiffies() function that returns the
value of the jiffies counter at the start of the test, that is, at the
point where torture_init_begin() was invoked.

This will be used to enable torture-test holdoffs for tests implemented
using per-CPU kthreads, which are created and deleted by CPU-hotplug
operations, and thus (unlike normal kthreads) don't automatically know
when the test started.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 0134e7221cae..1b59056c3b18 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -104,6 +104,7 @@ int torture_stutter_init(int s, int sgap);
 /* Initialization and cleanup. */
 bool torture_init_begin(char *ttype, int v);
 void torture_init_end(void);
+unsigned long get_torture_init_jiffies(void);
 bool torture_cleanup_begin(void);
 void torture_cleanup_end(void);
 bool torture_must_stop(void);
diff --git a/kernel/torture.c b/kernel/torture.c
index dede150aef01..3a0a8cc60401 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -792,6 +792,8 @@ static void torture_stutter_cleanup(void)
 	stutter_task = NULL;
 }
 
+static unsigned long torture_init_jiffies;
+
 static void
 torture_print_module_parms(void)
 {
@@ -821,6 +823,7 @@ bool torture_init_begin(char *ttype, int v)
 	torture_type = ttype;
 	verbose = v;
 	fullstop = FULLSTOP_DONTSTOP;
+	WRITE_ONCE(torture_init_jiffies, jiffies); // Lockless reads.
 	torture_print_module_parms();
 	return true;
 }
@@ -836,6 +839,15 @@ void torture_init_end(void)
 }
 EXPORT_SYMBOL_GPL(torture_init_end);
 
+/*
+ * Get the torture_init_begin()-time value of the jiffies counter.
+ */
+unsigned long get_torture_init_jiffies(void)
+{
+	return READ_ONCE(torture_init_jiffies);
+}
+EXPORT_SYMBOL_GPL(get_torture_init_jiffies);
+
 /*
  * Clean up torture module.  Please note that this is -not- invoked via
  * the usual module_exit() mechanism, but rather by an explicit call from
-- 
2.40.1

