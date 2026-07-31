Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F942DF6E9;
	Fri, 31 Jul 2026 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460044; cv=none; b=GcSYM2SIGQDnNe9S5CR2cv4lbLteAjTXhfxr7yKGBsAWWIhBxp5THtT0mqhU7tmZ6Kj/M6+LnQ9q8Rl8PXIrGXa3JJmYgt6TLchc12ZBdNJXah1TQT9L1XfBJcWKZySycv3/XL1O47kuwBsKLBwzEg8ojJeG1pebmVu7ChOmFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460044; c=relaxed/simple;
	bh=k8eiUhSCS99nfeMIAB5X17c4syzziXQSHl14L8cgmIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBdG4Zv8FZRpIUsvvvm44R/LG2KHonKeShv2dKAiXNKeH+aip677ppblZJQp4AMSLj55F3a32AtJsTLk6UxqDWjMcjLTK7xmlHiZHt/rzl4BHdhveiHjXfet8ipYC5InA/ium9tmOHH8DBXFe7I2kZ/uLKAXaaqqFTPiRPJ+Fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCLMGZpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCLMGZpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61CF1F00ADE;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460040;
	bh=6Be4ToWGsWbF4xVC3u3KRZYOBb8phj0i+n1mZ9tSayU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCLMGZpiqBffB/hCJMYXe9zCWfUK6TtC9z6+UHSKyZ/+fIRWV8jVBTUqR3Tp4tqNG
	 OonHIIDoMmb7xQLrAVi5v5jp0N2nzdJvKdE5z9eXnJBEMpTP18U6sWKrXQLO3TzufY
	 MvON8C5wjU+kVnoYHBJCwqc2ajIoX02aZ2UNiGSpbgp/RkpoMrdJ6hwKgOKJsJE21Y
	 3u85CZb4XlxBTJHcb0G8GQryRRiJVTvhusLZyNO8XVRIzzkvtl61qr9O+pKQqymUnX
	 NGeJfymkV0k7TzhGpJZ8kmGbEybpsctOg/rwAzmETpiZDIEBFzKmQmEh6CGU2T9o8c
	 UKJs/gVEojDHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FD22CE1018; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2 06/13] rcutorture: Add nwriters module parameter
Date: Thu, 30 Jul 2026 18:07:12 -0700
Message-Id: <20260731010719.3531912-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Believe it or not, there are people who would like to run rcutorture
without actually torturing RCU.  For example, some people would like to
induce various types of stall warnings without placing any unnecessary
additional overhead on their systems running in production.  And
rcutorture provides the stall_cpu, stall_cpu_holdoff, stall_no_softlockup,
stall_cpu_irqsoff, stall_cpu_block, and stall_cpu_repeat module parameters
in order to allow the user to force numerous types of stalls.  In addition,
rcutorture provides a great number of other module parameters to allow the
user to reduce other overhead.

But unfortunately, there is no way to turn of the rcu_torture_writer()
portion of this torture test, which on my x86 laptop consumes somewhere
between 40% and 45% of a CPU.  Although this is quite lightweight for a
torture test, it is not welcome on systems running production workloads.
This commit therefore adds an nwriters module parameter that defaults
to 1 but can be set to 0 in order to disable the rcu_torture_writer()
portion of the torture test, but that cannot be set to any other value
(that is what the fakewriters module parameter is for!).  This reduces
the overhead to well under 1% of a CPU, which is much more likely to be
compatible with production workloads.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Puranjay Mohan <puranjay@kernel.org>
Reported-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/rcutorture.c                         | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f2281..b942149720c9bf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6117,6 +6117,11 @@ Kernel parameters
 			the number of CPUs.  For example, -2 selects N
 			(the number of CPUs), -3 selects N+1, and so on.
 
+	rcutorture.nwriters= [KNL]
+			Set number of RCU writers, which must be either
+			zero or one.  For additional writers, use instead
+			the rcutorture.nfakewriters parameter.
+
 	rcutorture.object_debug= [KNL]
 			Enable debug-object double-call_rcu() testing.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c9fb375701f893..acda5c5fca5f28 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -116,6 +116,7 @@ torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testin
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
+torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
@@ -3163,7 +3164,7 @@ static void
 rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s: nreaders=%d nfakewriters=%d "
+		 "--- %s: nreaders=%d nwriters=%d nfakewriters=%d "
 		 "stat_interval=%d verbose=%d test_no_idle_hz=%d "
 		 "shuffle_interval=%d stutter=%d irqreader=%d "
 		 "fqs_duration=%d fqs_holdoff=%d fqs_stutter=%d "
@@ -3178,7 +3179,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
-		 torture_type, tag, nrealreaders, nrealfakewriters,
+		 torture_type, tag, nrealreaders, nwriters, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -4754,10 +4755,11 @@ rcu_torture_init(void)
 			goto unwind;
 	}
 
-	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
-					  writer_task);
-	if (torture_init_error(firsterr))
-		goto unwind;
+	if (nwriters) {
+		firsterr = torture_create_kthread(rcu_torture_writer, NULL, writer_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	firsterr = rcu_torture_updown_init();
 	if (torture_init_error(firsterr))
-- 
2.40.1

