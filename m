Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6414B092;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=nzVjG/877BLyfo6Y6U7w3KVgGFR/Dl9OOwirqxEtZDjMJRfXxRCwmsqanLontfIYJFJm6PyV9YtQu2THlBFxfN8uhUnXB2UgC+O9tEpVhrCtWbFtRdGNeDZYRejq1WjGj4kTm+iUOjpj1aUUs2C57AonrV047EzI0Pz5/fHdZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=TioFm82Snd8j9pH8jLZE3PHQ5qk2yV0osr+xyGd7g+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=atJgD3z4OlRkCA1NYNDOGafuHOtIjFTj3QCKMF9aOwmFf5LhTk7H93IpIOkw21RvXYvnOd/ZKTSCO7qYv4GJMMA7jhwsV8pzejG8jYiv2alKejhaBayzNrK33xtctaciiogbQ6rrwGM4CwEWiD6j407pFd52ym+U0vMr+j3dCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGai/H0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGai/H0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631BC4AF08;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=TioFm82Snd8j9pH8jLZE3PHQ5qk2yV0osr+xyGd7g+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGai/H0ahb0euEOElAvwYeBDGe9Jz07a85uy4SPB+l6ilTdewzdtN5Ae4hLz4OI+j
	 I2GqRslKomd29+Tmkzt6rrykXqrevKlx5MJnvHL5bOROOoBT8k4kBeGGv8FCJgF3OG
	 YBFxN5on/nWq/stc5hGRnSuOhvyl1YQDKE/VcgYOIbxfqbWQIN+kYk51IYMcCYvkg3
	 Y8k4H6jedHeqI3RYTeXCltZM6pwzXrla3xfHIo8jHnCjgCrAsnHc+Kg5A1i6tNJ5jw
	 zNoGl1Gk27gYNYooerRsbrmx909YHi1YeiXdB994wWE8uY3VqchImLi18fEtViVyUG
	 TodZ+5mr+0Ixg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0EB8CE3F26; Tue,  4 Jun 2024 15:26:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot
Date: Tue,  4 Jun 2024 15:26:49 -0700
Message-Id: <20240604222652.2370998-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When the grace period kthread checks the extended quiescent state
counter of a CPU, full ordering is necessary to ensure that either:

* If the GP kthread observes the remote target in an extended quiescent
  state, then that target must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it exits that extended quiescent state.

or:

* If the GP kthread observes the remote target NOT in an extended
  quiescent state, then the target further entering in an extended
  quiescent state must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it enters that extended quiescent state.

This ordering is enforced through a full memory barrier placed right
before taking the first EQS snapshot. However this is superfluous
because the snapshot is taken while holding the target's rnp lock which
provides the necessary ordering through its chain of
smp_mb__after_unlock_lock().

Remove the needless explicit barrier before the snapshot and put a
comment about the implicit barrier newly relied upon here.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8a1d9c8bd9f74..bec24ea6777e8 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(cpu);
+			/*
+			 * Full ordering against accesses prior current GP and
+			 * also against current GP sequence number is enforced
+			 * by current rnp locking with chained
+			 * smp_mb__after_unlock_lock().
+			 */
+			snap = ct_dynticks_cpu_acquire(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-- 
2.40.1

