Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD519D89B;
	Tue, 31 Dec 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664856; cv=none; b=fQzxj0UprZFXfTfso0SiT2L+PI78RhMbLjDsEVkW6iUUflrJFdZ1RUvverdyLepQQDgvWGVb4nlFMqFkT6pi8XedTl57W3/UPc2Z/qqSNh39CVqNKZvjTkS8P82woX2QQ/ULqO3TWxempSmQHMkEfL9EH2K4K+fTMfOUBWz8T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664856; c=relaxed/simple;
	bh=7953vUn/djj86ZY3UMEo4hYVRUJH/ByIBebIXXt/TBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYjXXAtty3Epui0aTWiPD1KLq/t9YJwiI/gzxxGkpIDpIAd6SmbanL1n279TLBXwP8bzAu0RcvOelb4FF/Gd6jN2DZtFtvzzD5dCiYiMW0dT4l3O7F62Rm+kJ3Hb9Z5k/PKkyujlTGR75tkDTnlKK232dc/oUhxPGaxz5PeZxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIQkPONz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIQkPONz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B2C4CEDD;
	Tue, 31 Dec 2024 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735664855;
	bh=7953vUn/djj86ZY3UMEo4hYVRUJH/ByIBebIXXt/TBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIQkPONzjyFOhFQUggOTWiyIfFC77TFo2SyzRF6HKyB/P4lkfgfoeozSARFL0lVWj
	 75h25G+TkubfOpvsdHGf/zK62sZgHP6frXblds10kZp3GIF+XFDWkXOU86uKxhScNm
	 iFlPf74JbvK2jSt17HxpJt7LVUaMWZ5iNl0oyMbvBdcU+5/k49V9i9NowV7hAd8n89
	 CN2tF+uWQP9joFxJAzvTINODOuHFR3R63VdD7auGF0gtwzl1W4OOX0oGTORzsJhKXt
	 FOyW4snHWlV27MDiN/qnCM05VlsqC58P/QR9bDi8QylEyxxOqTSy6bn4mMI52bDol9
	 HxIXbNf3C8SdQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 3/3 v3] Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
Date: Tue, 31 Dec 2024 18:07:12 +0100
Message-ID: <20241231170712.149394-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241231170712.149394-1-frederic@kernel.org>
References: <20241231170712.149394-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f7345ccc62a4b880cf76458db5f320725f28e400.

swake_up_one_online() has been removed because hrtimers can now assign
a proper online target to hrtimers queued from offline CPUs. Therefore
remove the related hackery.

Reviewed-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a43141a1b3a5..a03fc19abde7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -554,19 +554,13 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
-		} else if (!irqs_disabled_flags(flags) && cpu_online(rdp->cpu)) {
+		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			/*
-			 * Don't do the wake-up upfront on fragile paths.
-			 * Also offline CPUs can't call swake_up_one_online() from
-			 * (soft-)IRQs. Rely on the final deferred wake-up from
-			 * rcutree_report_cpu_dead()
-			 */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-- 
2.46.0

