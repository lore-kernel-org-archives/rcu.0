Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCC222D7D;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=a7IB86TQLkMTjDhY6c2Xkp/utickpmYimV1FA8cZ+u0g//Fh1YHvXmvFWmXUjnvsYWDtNww+qmFNNw47+5zS5J90waydoy9agaRZ6NPZLRRSe85UIc1P0w7hXsN6cUZdNNozzS79bzUqJ1hDTmDhw4xtCDgnzxlJOijInlvoh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=TgGDrUo443tEAwTGGMId9ohWtXzXSJj5mgIOxRAsba4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWA1xcG8pbCgNTxZ8IdfjPguGPoXO62t3zw1KQA3oFaOnoOHAJLMK4iiG3/hPPMWDkNv0w7zjcd4SphhxBP/FZMcSaCG/VWzLHtyGaZhyGbNW0P3C2OE7S3jjDh0igBvUsU8CVWEe3n2MYq/EGzWf9AlSgMWfE0qRVpVsy8k3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV9oNo9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV9oNo9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FCC4CEDF;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=TgGDrUo443tEAwTGGMId9ohWtXzXSJj5mgIOxRAsba4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV9oNo9gLzbVi3LoTTl+RQC3pqaV4iVooK5YPjTZQtIDrWY94sBELYWg+MISQLrwr
	 f7EWBoe7iJ9rI1OfgQxEsnRYIkSVJBNj0PLvqnPmSSuUsNgzkH2P1blAt3N/H6+IaM
	 2aE11dOVGqCm4oxzqVKwor+qMU9xd/nK+7wUkqorDVnpJampPktQF7kFfYAzaPNUzj
	 VFYXmZzhYDGl9g7oy3gxYn6xcQFjoRseza0h17oNesnsGoGLL5fezeOPHtJu+r58YT
	 p5AFQXMUBO3V5JWBUJnD9VO1rVr3LcxsABPhs2iTL1EuhlpyPW1+UvjODGEvf7gGUJ
	 9+Y0amZ/0lseg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 461A7CE0FA8; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 5/8] rcu: Make preemptible rcu_exp_handler() check idempotency
Date: Thu, 12 Dec 2024 10:39:33 -0800
Message-Id: <20241212183936.1936196-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the non-preemptible implementation of rcu_exp_handler()
contains checks to enforce idempotency, the preemptible version does not.
The reason for this omission is that in preemptible kernels, there is
no reporting of quiescent states from CPU hotplug notifiers, and thus
no need for idempotency.

In theory, anyway.

In practice, accidents happen.  This commit therefore adds checks under
WARN_ON_ONCE() to catch any such accidents.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f3884393b9477..6985c998fe6b1 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -746,7 +746,19 @@ static void rcu_exp_handler(void *unused)
 	struct task_struct *t = current;
 
 	/*
-	 * First, the common case of not being in an RCU read-side
+	 * First, is there no need for a quiescent state from this CPU,
+	 * or is this CPU already looking for a quiescent state for the
+	 * current grace period?  If either is the case, just leave.
+	 * However, this should not happen due to the preemptible
+	 * sync_sched_exp_online_cleanup() implementation being a no-op,
+	 * so warn if this does happen.
+	 */
+	if (WARN_ON_ONCE(!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
+			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
+		return;
+
+	/*
+	 * Second, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
@@ -760,7 +772,7 @@ static void rcu_exp_handler(void *unused)
 	}
 
 	/*
-	 * Second, the less-common case of being in an RCU read-side
+	 * Third, the less-common case of being in an RCU read-side
 	 * critical section.  In this case we can count on a future
 	 * rcu_read_unlock().  However, this rcu_read_unlock() might
 	 * execute on some other CPU, but in that case there will be
@@ -781,7 +793,7 @@ static void rcu_exp_handler(void *unused)
 		return;
 	}
 
-	// Finally, negative nesting depth should not happen.
+	// Fourth and finally, negative nesting depth should not happen.
 	WARN_ON_ONCE(1);
 }
 
-- 
2.40.1

