Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858289;
	b=PBA559Efa6cUXGO9DBz3QREGlcZiLfvf2JRA3fMOivf/axc+rfnnIYiDKzkcRLgtkKMn
	 Grph95ThwLcJKFB5YaZKg6kaqK8D0+w/8RJr7UG4BVU1K+bCIteCSh1NiwBqPwZ9ax3lG
	 FNRG3J2tJV2n0qqPPy8/lrhfsXZzXpcVdLH/vPruhNxhZjBKKCRExt8Ou88ku4ZEwvg4s
	 ZhOxK41rrL5qW3br8U2fGCRnt1W2OE4mMcgTui8uTteQ5kfnwzbuRZ//5aQswrSjaZMgu
	 DIcojnQOZc5PylsYhKtQuntdIa3IKHWNUwjCoQ80+6ZHYtg3eDvectLeA7R0jhRaa2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=if3bGY34uDkeP8TVVarSMCihpY+jRPRYB/uyEJlD4X4=;
	b=Kwa7LTqrr+8QQ5klT/6FcdppuvZB2m+wsCDoMigoef3EcZJz9gs7+djrsybBZysjcHO8
	 gGCLchdlxev/5m2Ts8ZGWEWAtZbNL/e5bWBNYpiT9p6/VeENqNEK7QLRcz2EbZq7cviLn
	 Fpp7o84eNknujsbTFYnC9fm7nV5fIWd8+bDj7ZIRr2I1Pnyj2JZXk1fnjr6s8f7/eS81A
	 vr+SqDXuOulqaveyvGF8JkrWDNjSgqbDhY8zs8ZR4aGWx55/1a5S25yS/gC57LKR+sDjM
	 hg2dtxmXWEsfTILhLrkYxdUQjQGoS74DKMOEYE9gBZrtX79Wnqlp1IIIxs+eXTUwR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0RS2MVk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5937606A88D;
	Mon, 16 Nov 2026 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0RS2MVk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7A3EE1F000C7;
	Mon, 16 Nov 2026 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858288;
	bh=if3bGY34uDkeP8TVVarSMCihpY+jRPRYB/uyEJlD4X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0RS2MVk4Al9HoUOTdvSZ3+iSPKzwwPGQiv4CVdHhlc+f9MMlGVTvlF+RxD0kZ/Rc
	 25O+ScrELRKecKFThrY6J0T1f+GuTymqbvzcCsziAqUXfUsZurdut9dbFV7O+XIaIK
	 mbwSO98hICFa/e4+LdypNbRLDBje5zLsua5YJ9iw4waG/9XjRTTDwYoYJ6xozG7bVQ
	 8nRBMqH13rivGSR5ucCn18i0wESWPPfCXwCLQTxAPjvzM1hRU03gvl0cg/UjetCXmx
	 MC+vd324dytSJWqEaOCLwtxPuglwOI38gDuiru38V5MLS5czqE/M5/X/WOAsvEvzvZ
	 FDCN/kbgMy1kA==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/7] rcu: Add rcutree.boost_disable to disable priority boosting at runtime
Date: Mon, 16 Nov 2026 14:44:36 -0500
Message-ID: <20261116194438.306618-6-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_RCU_BOOST is now enabled automatically for preemptible RCU and
cannot be turned off, so rcutorture's BUSTED-BOOST scenario, which is
meant to show that rcutorture detects broken priority boosting, can no
longer break it.  Add a boot parameter that makes rcu_initiate_boost()
do nothing, giving that scenario a way to break boosting.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..04a58dd003f4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1270,6 +1270,9 @@ static int rcu_boost_kthread(void *arg)
 	return 0;
 }
 
+static bool boost_disable;
+module_param(boost_disable, bool, 0444);
+
 /*
  * Check to see if it is time to start boosting RCU readers that are
  * blocking the current grace period, and, if so, tell the per-rcu_node
@@ -1284,7 +1287,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rnp->boost_kthread_task ||
+	if (boost_disable || !rnp->boost_kthread_task ||
 	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
-- 
2.54.0

