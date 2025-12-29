Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C83C17;
	Mon, 29 Dec 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035779; cv=none; b=HUKDO6U4Bxs4L78zloO2Q7wKsqe6Ts8Acv4LU42OMJ43WY4xENumdLUSM9cmGA6itlwhRSQmomfrMCZCkND6C0pKTfbqlEXljf4gsvkVOFwl4o35xioiCRYORlx+684nURPVuhGXrGt0B8w4lxsRl8SylK5aNdPIWqLQ1x2gfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035779; c=relaxed/simple;
	bh=BEbQHDltytOiejUkg/yJFBnuuD7L8xxFe8uLhAJ2Wf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RG41cqI3gPd2OHMzeCVuSFr3Zyov2lOsGwslkrdDUtbfSh7YJzdgz51jP/zDnXdvaTlprYCUW3Le9ca/6WBa3b9CWen5EjKXNJ2s5P3NSjOICi1r5EsZuxMs853bWGwthb2q0yDOlQQFbL7Pc79VMaNYv7IvrLbR9XuG2XtAlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du5bgvl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du5bgvl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2500C4CEF7;
	Mon, 29 Dec 2025 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035778;
	bh=BEbQHDltytOiejUkg/yJFBnuuD7L8xxFe8uLhAJ2Wf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=du5bgvl0JuGxEXabnct3P0QGc/Emp5woQG4sB5bxBud7nHwP5A5MQwhJmHjtYGnrT
	 3NGT4MVPUhKuAB0Acynmza0xaRo2f6vKUHo7EvHl1qLKREro7kV/WEwMSqliaA4HdW
	 hshhpvkVDkH7FSQOMoJs37hYKP+qDGWCgpmlRfeiBGz4CR9pPBVndl0Ki5jz0wCkjX
	 bEsj/56Ia3VHx30Rkb45h0AWvg+1z5Ib7xritIXyaUw6oURLPLx+h01I+tqAZr4NMn
	 iJXGKfIOnjBTqdpYQ6KHwuhUv+1Rw8iZg1RO7mDkvb/f21GrGrRP+z+X/4KjQ+G9MD
	 9HQvnhtTXe/Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 761EBCE0C97; Mon, 29 Dec 2025 11:16:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v4 1/2] rcu: Make expedited RCU CPU stall warnings detect stall-end races
Date: Mon, 29 Dec 2025 11:16:15 -0800
Message-Id: <20251229191616.693898-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
References: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an expedited RCU CPU stall ends just at the stall-warning timeout,
the current code will print an expedited stall-warning message, but one
that doesn't identify any CPUs or tasks causing the stall.  This is most
likely to happen for short-timeout stalls, for example, the 20-millisecond
timeouts that are sometimes used for small embedded devices.  Needless to
say, these semi-empty stall-warning messages can be rather confusing.

One option would be to suppress the stall-warning message entirely in
this case, but the near-miss information can be quite valuable.

This commit therefore detects this race condition and emits a "INFO:
Expedited stall ended before state dump start" message to clarify matters.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 96c49c56fc14a..82cada459e5d0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -589,7 +589,12 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 	pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 		j - jiffies_start, rcu_state.expedited_sequence, data_race(rnp_root->expmask),
 		".T"[!!data_race(rnp_root->exp_tasks)]);
-	if (ndetected) {
+	if (!ndetected) {
+		// This is invoked from the grace-period worker, so
+		// a new grace period cannot have started.  And if this
+		// worker were stalled, we would not get here.  ;-)
+		pr_err("INFO: Expedited stall ended before state dump start\n");
+	} else {
 		pr_err("blocking rcu_node structures (internal RCU debug):");
 		rcu_for_each_node_breadth_first(rnp) {
 			if (rnp == rnp_root)
-- 
2.40.1

