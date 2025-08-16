Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871E2D3EFA;
	Sat, 16 Aug 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302410; cv=none; b=dJ4WUZ9zsF6sHrcIwRcm4BeDVqk32aDPfELSwWo8NjXbOWfYXoT5HROXoEtODL9bNVJgYlDO5KC/7mxnFwWyCZtqXp21BA4jFR04jzXEzyuSba6JpK4xEgdfUPEFkj9fYPRNSiPH2ijlmN/BJ21xGP93TGvTlxt6HzZdnHZTtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302410; c=relaxed/simple;
	bh=sx/aMTOwkIm8Zaz1kuQ2mUJmqtZSUqCr6SzbEBFIuVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=On/LMyo8d7FLzIlriu5Ok4qnEBcL8+OpjZT8hm2tTo0auceTdInzSajWSHhsUBs8AW5LuhEQ0L72L/p5nE2J9vQURb2I7+8wVkR+DG5FGfkIu5lcvoZ+v2DTf2+KMHh1izxl1RxRppDgxVUsZzttCCfNdTEgOHZuzycjWMPZbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7okZ8df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7okZ8df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F229C4CEF6;
	Sat, 16 Aug 2025 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302410;
	bh=sx/aMTOwkIm8Zaz1kuQ2mUJmqtZSUqCr6SzbEBFIuVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7okZ8dfkpIGXL0mUvHjL/UCgqPFaEpSR3ueo0m+HjYujCmdEQAicFeC6TG3MrrZw
	 ej4rrTiMCQ7pX+eMFNqiX6N79ntcQcnti5Ui3YfhXqADSOexWfRCoekksan7pJBnje
	 D3QbcgN86gqpgkaj7zxCBS2gM1RDk94gIkkj9Ad6UXxdeKyzOCtyLwPQsWdBiE+UlU
	 zBEg9uGuajiEiUZ3Drh2wZAHePRH+mYO4s6K7IRr9CTlsG9M58AyfI+p68u8fNcwWD
	 lKczhEg2tuKrHQu9DDIQm/FguxKpzyC0zdI4Vy80LSZMXAgTVa1pAHTOvf1GjZZYGv
	 bgyZ3aLp7fy1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83B1CCE0B30; Fri, 15 Aug 2025 17:00:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] doc: Add RCU guards to checklist.rst
Date: Fri, 15 Aug 2025 17:00:06 -0700
Message-Id: <20250816000007.2622326-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also note that RCU guards can be easier to use.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 7de3e308f330f6..c9bfb2b218e525 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -69,7 +69,13 @@ over a rather long period of time, but improvements are always welcome!
 	Explicit disabling of preemption (preempt_disable(), for example)
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.  Acquiring a
-	spinlock also enters an RCU read-side critical section.
+	raw spinlock also enters an RCU read-side critical section.
+
+	The guard(rcu)() and scoped_guard(rcu) primitives designate
+	the remainder of the current scope or the next statement,
+	respectively, as the RCU read-side critical section.  Use of
+	these guards can be less error-prone than rcu_read_lock(),
+	rcu_read_unlock(), and friends.
 
 	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
@@ -405,9 +411,11 @@ over a rather long period of time, but improvements are always welcome!
 13.	Unlike most flavors of RCU, it *is* permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
-	Please note that if you don't need to sleep in read-side critical
-	sections, you should be using RCU rather than SRCU, because RCU
-	is almost always faster and easier to use than is SRCU.
+	As with RCU, guard(srcu)() and scoped_guard(srcu) forms are
+	available, and often provide greater ease of use.  Please note
+	that if you don't need to sleep in read-side critical sections,
+	you should be using RCU rather than SRCU, because RCU is almost
+	always faster and easier to use than is SRCU.
 
 	Also unlike other forms of RCU, explicit initialization and
 	cleanup is required either at build time via DEFINE_SRCU()
@@ -443,10 +451,13 @@ over a rather long period of time, but improvements are always welcome!
 	real-time workloads than is synchronize_rcu_expedited().
 
 	It is also permissible to sleep in RCU Tasks Trace read-side
-	critical section, which are delimited by rcu_read_lock_trace() and
-	rcu_read_unlock_trace().  However, this is a specialized flavor
-	of RCU, and you should not use it without first checking with
-	its current users.  In most cases, you should instead use SRCU.
+	critical section, which are delimited by rcu_read_lock_trace()
+	and rcu_read_unlock_trace().  However, this is a specialized
+	flavor of RCU, and you should not use it without first checking
+	with its current users.  In most cases, you should instead
+	use SRCU.  As with RCU and SRCU, guard(rcu_tasks_trace)() and
+	scoped_guard(rcu_tasks_trace) are available, and often provide
+	greater ease of use.
 
 	Note that rcu_assign_pointer() relates to SRCU just as it does to
 	other forms of RCU, but instead of rcu_dereference() you should
-- 
2.40.1

