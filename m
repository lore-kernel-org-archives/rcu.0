Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBC27EC7C;
	Thu, 16 Jul 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161424; cv=none; b=IfXEWk51yoEj1JzvpxTc0fEnQ5lhVIvxTOpHynHnokaPmF2+4yN9lqKkTGWUZ134nAGLANMN/6J7ZHKoxKYKFZRPbcaG8oc0KtoReBfANO6RBUYx4SgpEWzKVyOXjGBglSF3dQaEQ9l3F3mv/XY9r2QRkyBwZ7REEr8Oj5pMA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161424; c=relaxed/simple;
	bh=mc9NEZIorPJjdaORA+vKGv+Y4mGP0Y2nM4Pw5HrxZAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cN4OBhYa8QbMxu2M1VjeWtHaKHSs0QSCxfvO3wdjB8futOdW7rXjEijoRQcONowUOwpbYO4g6jioXt5wTMw4bDCNQbMDOIZphUyT0uwsnyIXK6M+dR7gwimZgaGU8Fe391G+PQLj4wP3f04MKLawSjzqTi1B7XxIGcYIrkj2yKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMDe9A7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMDe9A7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E701F01559;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=eKklVX3VgDMz+JyKSn/kR/vQ4ctDUmrdEUdbFfrwoac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gMDe9A7junBBekONoYSm4po6AJVmGDAsQorEmMpmRVd3kE3BWRvEMmXiFwUA4WsBS
	 n1qgVCqb4FrE8rnsG+AtA/ktufbZxrhexurEh1rMrUITqRG2WAlZBSfhOZPhUf/TyJ
	 +ecdHvTiQZ30goBlq3z7/X/qINJHNDf50ex6UJm+XfIaoawxm0esTncQ02mVf4IyYR
	 EvZsFXjRnqrVlJG23/4QnoQR41zvUrGX7IoTuS4vUUVsmm5qZ8UqaFoP03+DKwxTOs
	 oRWp5qJlzsGgVOD/0wOBK6yqElsZyghGsYtqSQjNJ4sR75WPquk5b0OyGsOw0ypoi6
	 so1kTLTlh+7DQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02E00CE0E0B; Wed, 15 Jul 2026 17:23:41 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Manuel Ebner <manuelebner@mailbox.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 07/10] doc: RCU: Fix brackets
Date: Wed, 15 Jul 2026 17:23:36 -0700
Message-Id: <20260716002339.11717-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
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

