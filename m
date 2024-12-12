Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80074188938;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=MYd0SbE5EI7HKtDrGrHNqioDeCkSZLUTMYQjnc0RL4zDsSSByiADNOLfWID36wko/iPiODbPbRIlpJdyQrGk6dracGB4PrXDN69MpB7vrqnjH9DzfXNvyXwffy8LGs4JEMAvByzwWQT7sSg2dlN0vC1DTu/w4MH+XEVyAgwHig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=CB7qitqTyFGRiWs84wTv8ARO3blatEc+ifaORbcqGDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ls9X+ZDje9PujtG5XgIwGtV+WTleexiGA5fwIaSGTuHfxa63/FB0ekFnAJQbg2IXvYZCE8uizn0o25EYDr8eNoNUqljYrsHfFWy7RBbtE4WPRHsB7GfpN3s3YfRcoUm3NddpKYxd3Q5eQKnMWi4Ss1dOP9bYOiyb+up4/r9Fjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWtRYXTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWtRYXTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB42C4AF0B;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=CB7qitqTyFGRiWs84wTv8ARO3blatEc+ifaORbcqGDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWtRYXTpw2hPbyOa6TzyPtbLOsN00+AWNmqWB5mCRyxaSiuVEIh55KAQQaKVISVdv
	 huWj9SuH1jVbCuRzx2/QeO/mJYwdI/4dMz3FVzu4tkxXQ9LM887rxWDMJYzHPVv4c6
	 IZmjiIw2kI+OQl4JiGGIc88n2bgoJkwrKVG5M8L25M1Rsc4z980ESXFmDPwWICMISM
	 6t+LN98FnUoVkUfZEt77jJ3NcE/9BXl5BiK5zDi8/vdrQ+YwsMyPqxFsz+R7FRXnZA
	 pqNEuu57jDusdMWvr0JVFlB8Nw3sd38xUl61f2ZgGV2BF1bSAhOcjWEFNnCyJrVy1C
	 6XixvJpP1Marw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC7D7CE0FA5; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/18] rcutorture: Decorate failing reader segments with CPU ID
Date: Thu, 12 Dec 2024 10:49:43 -0800
Message-Id: <20241212184957.2127441-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds CPU number to the "Failure/close-call rcutorture reader
segments" list printed at the end of an rcutorture run that had too-short
grace periods.  This information can help debugging interactions with
migration and CPU hotplug.

However, experience indicates that sampling the CPU number in rcutorture's
read-side code can reduce the probability of too-short bugs by a small
integer factor.  And small integer factors are crucial to RCU bug hunting,
so this commit also introduces a default-off RCU_TORTURE_TEST_LOG_CPU
Kconfig option to enable this CPU-number-logging functionality at
build time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 15 +++++++++++++++
 kernel/rcu/rcutorture.c  |  9 +++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 9b0b52e1836fa..b3ac000004bfe 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -53,6 +53,21 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config RCU_TORTURE_TEST_LOG_CPU
+	tristate "Log CPU for rcutorture failures"
+	depends on RCU_TORTURE_TEST
+	default n
+	help
+	  This option causes rcutorture to decorate each entry of its
+	  log of failure/close-call rcutorture reader segments with the
+	  number of the CPU that the reader was running on at the time.
+	  This information can be useful, but it does incur additional
+	  overhead, overhead that can make both failures and close calls
+	  less probable.
+
+	  Say Y here if you want CPU IDs logged.
+	  Say N if you are unsure.
+
 config RCU_REF_SCALE_TEST
 	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99780a74da44c..0bc6fc5822153 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -262,6 +262,7 @@ struct rt_read_seg {
 	unsigned long rt_delay_ms;
 	unsigned long rt_delay_us;
 	bool rt_preempted;
+	int rt_cpu;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
@@ -1862,6 +1863,8 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	WARN_ON_ONCE(idxold2 < 0);
 	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
 	rtrsp->rt_readstate = newstate;
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
+		rtrsp->rt_cpu = raw_smp_processor_id();
 
 	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
@@ -3559,8 +3562,10 @@ rcu_torture_cleanup(void)
 					err_segs[i].rt_delay_us);
 				firsttime = 0;
 			}
-			pr_cont("%s\n",
-				err_segs[i].rt_preempted ? "preempted" : "");
+			pr_cont("%s", err_segs[i].rt_preempted ? "preempted" : "");
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
+				pr_cont(" CPU %d", err_segs[i].rt_cpu);
+			pr_cont("\n");
 
 		}
 	}
-- 
2.40.1

