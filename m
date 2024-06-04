Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2CA5F;
	Tue,  4 Jun 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539718; cv=none; b=EfxdU/kXG0HxzbRIBzCXqfhsZfopZrHpQeKAIKpI1IYKbDIBem1Vu2mfFZOAQzDgPtEPmp9czwIsWpc4gAynh6wm6+2ParP80ZkyqEdvjHSWeFDEEmVzBU/sCECVv1bio2PmF8zPCnm/CeZq8SuhPseLoNPKHLZbt2vzV3SNnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539718; c=relaxed/simple;
	bh=miADrXP78rcihw0Pzcipac84PpQR6U3LGdRSUZbgACA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNxDHvBowab0wj3iTezlTZ52ldEeLqdNNnesXhmASmK5uG2/H7XK+D2Lj7BYVrCphVZzSDaAZMHg7AHXx+/ziywiIjLv5wigQb4C9qhVEZ5Cq4B+VFmGqLo3PWYUkL7iCFLpsj70/Ewgn6FuZNTktcpLFWfCtAT219uk19K8Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JktfB5Ic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JktfB5Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1AAC2BBFC;
	Tue,  4 Jun 2024 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539717;
	bh=miADrXP78rcihw0Pzcipac84PpQR6U3LGdRSUZbgACA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JktfB5IcwYSjsYBWlP0OV9QVc/5t8jTmiXmrccSFHYZcUUxI9AdXxAXJbng1BQf2S
	 I5ilTb+UmXdiVXoWQp5ipqHdOVcH4nLd5Gpxmone5KPlPgolvuem33eHhXedrtoZbB
	 Nu0W5oqh9e+3qjBk4OjdpWBv4n97BlxpgdmbWkJKO1opm3jsZ6dG6z3326bdLfkEHS
	 H6vEQyhLjtdxK6wRI14UtACBrN65sIO4vD4yWoOaKL5jde+a3Xvri7vFDkvIk6s62c
	 WHp97KDxlsQfbMhpq7r5LTG2uD1OfSWx1vAtaoEPMDrkrb8ZPRl5+XyxPZKNLgmwSQ
	 kD5nzw6m+RFow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80251CE3ED6; Tue,  4 Jun 2024 15:21:57 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH rcu 1/2] doc: Update Tasks RCU and Tasks Rude RCU description in Requirements.rst
Date: Tue,  4 Jun 2024 15:21:54 -0700
Message-Id: <20240604222155.2370541-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds more detail to the Tasks RCU and Tasks Rude RCU
descriptions in Requirements.rst.  While in the area, add Tasks Trace
RCU to the Tasks-RCU table of contents.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index cccafdaa1f849..f511476b45506 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2357,6 +2357,7 @@ section.
 #. `Sched Flavor (Historical)`_
 #. `Sleepable RCU`_
 #. `Tasks RCU`_
+#. `Tasks Trace RCU`_
 
 Bottom-Half Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2610,6 +2611,16 @@ critical sections that are delimited by voluntary context switches, that
 is, calls to schedule(), cond_resched(), and
 synchronize_rcu_tasks(). In addition, transitions to and from
 userspace execution also delimit tasks-RCU read-side critical sections.
+Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
+interact with them.
+
+Note well that involuntary context switches are *not* Tasks-RCU quiescent
+states.  After all, in preemptible kernels, a task executing code in a
+trampoline might be preempted.  In this case, the Tasks-RCU grace period
+clearly cannot end until that task resumes and its execution leaves that
+trampoline.  This means, among other things, that cond_resched() does
+not provide a Tasks RCU quiescent state.  (Instead, use rcu_softirq_qs()
+from softirq or rcu_tasks_classic_qs() otherwise.)
 
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
@@ -2632,6 +2643,11 @@ moniker.  And this operation is considered to be quite rude by real-time
 workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
 by battery-powered systems that don't want their idle CPUs to be awakened.
 
+Once kernel entry/exit and deep-idle functions have been properly tagged
+``noinstr``, Tasks RCU can start paying attention to idle tasks (except
+those that are idle from RCU's perspective) and then Tasks Rude RCU can
+be removed from the kernel.
+
 The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
 consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
 and rcu_barrier_tasks_rude().
-- 
2.40.1

