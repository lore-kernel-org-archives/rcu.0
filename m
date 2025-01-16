Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337F2442E4;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=KHLHP4ishJ1K9huyEDMv1DIVGf+7KwNpg7PxsNzSeSE4/S6Ni2s/ORF32LASsrZrdru+K2kA/XmvQJgXRPLJaSz5s0aDIa42mpC/SEA4QjpiyKibwMPgyiyCfrXgbwPGfBnLWh4f5aKHifAd6GM6ZhbPsPxS3U+moilm2UbTU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=sNsrlG0xwaUm9vOI/jxEuBiUxmOvuWV5gFJh0f+cF64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dg8fsUZkCbYZI4NQnYKFKUgjj6Ktddy0/xcjS7hcuhmBgLaeoZZ7DLAMfLuGGG6nrnXtTEuZ6nAy67oWr/1r20bj9ITK5qDY7yYYrkmuBIHKzJW8jWF117OnC3eLcwT9SXM10wpSue4lEf9mGVGX2TyDpnpcNp4BJ/9Y1r728mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIdX5y9S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIdX5y9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FBAC4CED6;
	Thu, 16 Jan 2025 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059075;
	bh=sNsrlG0xwaUm9vOI/jxEuBiUxmOvuWV5gFJh0f+cF64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIdX5y9Sjb3ozn3k395jgeSOFcYZ1sOqUoIC60yrVXwmQskLoROov4ZZrlStW6VVn
	 MKhwm+Zw/7DorKMO77CDVrXG8+ymlegI4+crF4BwW/19QCCYEqFcCgHjGk+LjM83Mt
	 lztnirgrLiL3bCccX4ADwzRKsZJWpn/EX/z8hXGrqu00OimY8ilTDRABLqKrNXtlU3
	 SGzweZ9U870fG/7y1Vr0WndAabyWEJq7MALNjlWeLfR7j5JAs5gx9J1KT4GydS3GnL
	 nA/Sj8kXHTlKpZt43/R//+4brgyaBqiHQZhyJ2csJK/5NJGoZn1TiljzUUrlZxRNWw
	 wkoCKa9nJT0pA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1383CE13C4; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/11] torture: Add get_torture_init_jiffies() for test-start time
Date: Thu, 16 Jan 2025 12:24:24 -0800
Message-Id: <20250116202434.3783613-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
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
index 0134e7221cae6..1b59056c3b182 100644
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
index dede150aef011..3a0a8cc604010 100644
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

