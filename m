Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4F42070;
	Tue, 18 Mar 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306192; cv=none; b=mVdD1CaKeePz5SV5RadFihKYOzPuk+ER57jsGfpJh3w74KPeMS4gbJ21MkojtvZB7sWHCcW3v7IjDpKHldOyQ0RssayXd/WnddZFATQzBqCHymybZ6gs9yT21MEH4vaMDL6Ap8X+tES8htG8k5TPXJpICAqkU0KzKulevRJJB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306192; c=relaxed/simple;
	bh=W3LGO0ftBFKLCw3W6a6ZJzVnMrnFnIssiyirgrpTGtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUp7bhFf/yC+gYLEFioZGMDAAmoDZR9xpLhIxbOPpyenMUbIfd0qRGJtR7YhpPn5fy+e6iy/Xae7P+EqjCTpZAnLepWoWScyf9y7en+0Q+LpNH2J0ZjOQtF7bcN9HcUeTbaO0TCiwECEITW/JVaYC1F5J6DNdVMU5cI1430t0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/9jei3W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/9jei3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBCEC4CEEA;
	Tue, 18 Mar 2025 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306191;
	bh=W3LGO0ftBFKLCw3W6a6ZJzVnMrnFnIssiyirgrpTGtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/9jei3WezmtaUvY4tb1qTGPPI5jOEYLCvHH3s61FgvO3fzz0kqfWuAV1pp5cXuU0
	 hvXlgYLLrHeIhO1suLHgZXi4vllKTgz2smJ+glzojzOVyJd/Pb0yr3B84mp+NdnA0N
	 jwi88waI4PVrbvdZOVzj0Ci18QnSQnF3JSQjnnemW12hKbKL1xFhtbS+C1mO38zR9i
	 5g5PlFZ87VNYkfD9vvYAJDFLvRdcvXfiEHdb1oskHw7P6tbFwcczzZiVNOU1q6j2db
	 qMx/+YYmV8oO1gE5p73Qoy0qBRvcXeu4gfeW0OZYiCcUiN/GEsuJlyq7Aw/tMIHqy+
	 jvToq4A8cWHfw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 1/2] rcu: Comment on the extraneous delta test on rcu_seq_done_exact()
Date: Tue, 18 Mar 2025 14:56:18 +0100
Message-ID: <20250318135619.4300-2-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318135619.4300-1-frederic@kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The numbers used in rcu_seq_done_exact() lack some explanation behind
their magic. Especially after the commit:

    85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")

which reported a subtle issue where a new GP sequence snapshot was taken
on the root node state while a grace period had already been started and
reflected on the global state sequence but not yet on the root node
sequence, making a polling user waiting on a wrong already started grace
period that would ignore freshly online CPUs.

The fix involved taking the snaphot on the global state sequence and
waiting on the root node sequence. And since a grace period is first
started on the global state and only afterward reflected on the root
node, a snapshot taken on the global state sequence might be two full
grace periods ahead of the root node as in the following example:

rnp->gp_seq = rcu_state.gp_seq = 0

    CPU 0                                           CPU 1
    -----                                           -----
    // rcu_state.gp_seq = 1
    rcu_seq_start(&rcu_state.gp_seq)
                                                    // snap = 8
                                                    snap = rcu_seq_snap(&rcu_state.gp_seq)
                                                    // Two full GP differences
                                                    rcu_seq_done_exact(&rnp->gp_seq, snap)
    // rnp->gp_seq = 1
    WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);

Add a comment about those expectations and to clarify the magic within
the relevant function.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..7acf1f36dd6c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -157,6 +157,13 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
  * Given a snapshot from rcu_seq_snap(), determine whether or not a
  * full update-side operation has occurred, but do not allow the
  * (ULONG_MAX / 2) safety-factor/guard-band.
+ *
+ * The token returned by get_state_synchronize_rcu_full() is based on
+ * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
+ * against the root rnp->gp_seq. Since rcu_seq_start() is first called
+ * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
+ * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
+ * periods ahead of the root rnp->gp_seq.
  */
 static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
-- 
2.48.1

