Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBD2BF002;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459716; cv=none; b=e1hO6JXjXsE3HAZtH2kpetC4DZcXl9zZvJo0CsuBWFN7BeFV5rvfTPwMlebcRux0TDdOmaLkiF1E5W5ran41ihP44c6e24YttZD7Tl90DEWxnddxE7Z232xn5ylNdLj700Iw/Wx/TilwX+9uClcZrRcgx61hvON/LFOgMAQW/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459716; c=relaxed/simple;
	bh=mc9NEZIorPJjdaORA+vKGv+Y4mGP0Y2nM4Pw5HrxZAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doS5Zog+rkgqGkUeoOdirxi1S92ceolgcn51YkURJIU1wL4Qn/lnU00ZMH3TDOOmElDduOKwRntCK00byBFCJBzMd6zlMqJ3s+Kaa3dkEZu9ZBN0Mcr78jF9azy+fPzZtBdzUhY4JZmq2D3fL5NKCsBWhZnxXo23Yx6GvZeYEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maPutNAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maPutNAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6811F00A3F;
	Fri, 31 Jul 2026 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=eKklVX3VgDMz+JyKSn/kR/vQ4ctDUmrdEUdbFfrwoac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=maPutNAPI44k6qTzuksN/BgRf9kU5SqmWZHIJwba/IcC/Oy4t/abGdlmDbyjs8pru
	 3EUJBTKi15CPUE80PBtm4TXpxXP/LASpArf+nvGNXhRGZWuyw45If1P4DSmTs/rZ61
	 uvN+F8OQNNpYgoMMdLP9IrEGFCHenEh0jJMbHD4ITeWfwhU2Cl0/cLsFmzhigH/fcg
	 /W/MUfIioAyqV7s0VOmncgOBHQmlXpsJZrbw5ytEry9Y+ludqY7tPtQaf49ORUx3sO
	 GKKgzScrAgxcraRLGyhrasEbAuNSo8o4zvF/GzrqmuV5mCEz41DTnXwwzhUE1GMSGx
	 5+3XzmSJzXnDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AAE4BCE0F82; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Manuel Ebner <manuelebner@mailbox.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 04/16] doc: RCU: Fix brackets
Date: Thu, 30 Jul 2026 18:01:41 -0700
Message-Id: <20260731010153.3531313-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Ebner <manuelebner@mailbox.org>

Remove needless brackets and add missing brackets.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst  | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg         | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg         | 2 +-
 Documentation/RCU/Design/Requirements/Requirements.rst          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 414f8a2012d684..cf0f9cdca7e8cb 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -410,7 +410,7 @@ workqueues (see Documentation/core-api/workqueue.rst).
 
 The requesting task still does counter snapshotting and funnel-lock
 processing, but the task reaching the top of the funnel lock does a
-``schedule_work()`` (from ``_synchronize_rcu_expedited()`` so that a
+``schedule_work()`` (from ``_synchronize_rcu_expedited()``) so that a
 workqueue kthread does the actual grace-period processing. Because
 workqueue kthreads do not accept POSIX signals, grace-period-wait
 processing need not allow for POSIX signals. In addition, this approach
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index d05bc7b27edb7a..95a66de40ca5a2 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3933,7 +3933,7 @@
          font-style="normal"
          y="-3914.085"
          x="3745.7725"
-         xml:space="preserve">rcu__report_qs_rdp())</text>
+         xml:space="preserve">rcu__report_qs_rdp()</text>
     </g>
     <g
        id="g4504-3"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index 7d6c5f7e505c68..882132680308ef 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -815,7 +815,7 @@
          font-style="normal"
          y="-3914.085"
          x="3745.7725"
-         xml:space="preserve">rcu__report_qs_rdp())</text>
+         xml:space="preserve">rcu__report_qs_rdp()</text>
     </g>
     <g
        id="g4504-3"
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8a216e4a46a7df..8101fe6229d579 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2785,7 +2785,7 @@ both srcu_read_lock() and srcu_read_unlock().  This need is handled by
 a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
 which avoids the read-side memory barriers, at least for architectures
 that apply noinstr to kernel entry/exit code (or that build with
-``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
+``CONFIG_TASKS_TRACE_RCU_NO_MB=y``).
 
 Now that the implementation is based on SRCU-fast, a call
 to synchronize_rcu_tasks_trace() implies at least one call to
-- 
2.40.1

