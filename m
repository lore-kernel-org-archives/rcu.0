Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5F30FF30;
	Sat, 19 Sep 2026 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777982; cv=none; b=oBYbg09dy+lk/eYP1h3gmodVkPFq72zdnqFo+pbuKWA17rIOcrwQPS4lxGc07zkMbLsO/WCZdr8Vlg1pYs+t0rx1C4He+eJr+wgKxlaxBW+BbBwrgjU/yhs7M/O3dbu0qhqddJ+dyPfpGxnI699iJpV5+3NdA8HMkXg4AdztF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777982; c=relaxed/simple;
	bh=n0wXEqeHdLP6Qo6Z3/eXapPH/ktUiP+z3Yy6S5TGSeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MybkYxoKznouZhFsYJdicZUcC+zkCr7kaUnv3Jb0N3T8Ea/efzU5HjbeGrpRKzOVl7/WF6z1cR9M6n+wsEMBVK9gT4+jmhlGny+SIMMWj4+YBkLueSK0x7WpvQaXUwRf7H73OZfNAjQ1+qOkWZuPTWdADlTsdoiV9+vaE+lcKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUKwQ73+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUKwQ73+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8B61F0089F;
	Sat, 19 Sep 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777980;
	bh=pSJdq6HplgsYvMXOfz6oCI9s5z06svO8jCcVkObHeLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUKwQ73+zNNqnGpB9VLKdFItYg+UI114O/mLY/xwhGAG38gnOGylAQ13cgAeS41fC
	 Ga/dYV3YJ/lox9iyIpQImLtfkrfb4q6wZxxy36MJvXc0otjeSTT8c16+Xp9dTXYQXU
	 o8uyo72tKLzTWu+1lBRKT15XSC0owM3p0YMof4gBGjAE4aOxDdXw69tfW/ImY4Aixg
	 rnJr9CmR96GvIeUGKR/1oWihG84sxGDZPyl8Ghr0dofq6qDkQIlEfe++Y2vLLQSCT4
	 pC7yV50yOzd4Wer9zqkDL/ow1XzlgKkCk6UNnoPGA+9YR/kgWFL8uCoRETq/sHhSyr
	 3mRDhSEvy0A5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C829CE1853; Fri, 18 Sep 2026 17:32:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/7] rcutorture:  Disable fragile readers during overload testing
Date: Fri, 18 Sep 2026 17:32:56 -0700
Message-Id: <20260919003258.3134343-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
References: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vanilla RCU readers, when either non-preemptible or preemptible with
priority-boosting enabled, can handle heavy overload conditions.
Other RCU implementations are more fragile.  This commit adds an
rcu_torture_ops structure field named ->rdrs_handle_load that is set
for non-fragile configurations of vanilla RCU, but cleared otherwise.
It also refrains from running fragile readers concurrently with overload
testing, thus avoiding false-positive overload-testing failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..7e08be857f01 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -440,6 +440,7 @@ struct rcu_torture_ops {
 	int debug_objects;
 	int start_poll_irqsoff;
 	int have_up_down;
+	int rdrs_handle_load;
 	const char *name;
 };
 
@@ -648,6 +649,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.extendables		= RCUTORTURE_MAX_EXTEND,
 	.debug_objects		= 1,
 	.start_poll_irqsoff	= 1,
+	.rdrs_handle_load	= !IS_ENABLED(CONFIG_PREEMPT_RCU) || IS_ENABLED(CONFIG_RCU_BOOST),
 	.name			= "rcu"
 };
 
@@ -2534,8 +2536,10 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
 	rtorsp->p = rcu_dereference_check(rcu_torture_current,
 					  !cur_ops->readlock_held || cur_ops->readlock_held() ||
 					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
-	if (rtorsp->p == NULL) {
-		/* Wait for rcu_torture_writer to get underway */
+	if ((!cur_ops->rdrs_handle_load && atomic_read(&rcu_fwd_cb_nodelay)) || rtorsp->p == NULL) {
+		// Wait for rcu_torture_writer to get underway and
+		// (if readers cannot handle heavy loads) for any
+		// forward-progress testing to complete.
 		rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
 		return false;
 	}
-- 
2.40.1

