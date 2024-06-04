Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4014B09F;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540107; cv=none; b=B4I9spfXRraAUkBJIZvowqP2f6+kXlg/yU4N/5zNTcUSdFcL+AGWfRdWxP1Zpj2KbfUhFbruXBlfv8rUs+i15ZcyI0CdfPKzcq22Ld6CGJFxDcnfy26zBup1X7rqda6v0b9i7KrzzL3f1uYZ7HOhhS3sbUg0hGN8Xy2Nz6yY+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540107; c=relaxed/simple;
	bh=L+vh4i7DG4WUW2lk/fFRObt2YALvvoHN6lDNkPzL758=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkqeMX5KC3uiGdn5EJsT2fju4lo7wmK56HH3rB2ZO2aPQEWOP8SRAQkSjc//xslB27YzMpIhI5rGMbXQlwkwgUhKIqidZjor6KJnZ/bMoWcot9k+4M7Ty/mvEcqhrW7YPRWs9BeF5Z2j6vm0fS/jvQjt75//5ayD2DlFWDMpcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJYk/7+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJYk/7+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0D3C3277B;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540107;
	bh=L+vh4i7DG4WUW2lk/fFRObt2YALvvoHN6lDNkPzL758=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJYk/7+6d355+dU29WybwVSHg8f9bekAfAqsvjIYDVuC1jWpl4IAQbAI3psN6eoED
	 Cp2KJ3EPKAohcZJBPkzt7PBE6n1dO6YIhJCUoqiaW7sijQzPxy80KHYYlcyjEM1Fr4
	 ciEprKKOCYUizwz/t/pIB6ifyws64MmaWEHSdoLZRHfyn4G2scMN/NZQLn7x6Iuiqn
	 CLPF4soKeDzvWBsyRYDoTN97ojzT48rjEs4XRC3wL0UgAKOJmNfKsQ7GxqKJixeqNt
	 1f/EaNcS/4QAN4cvV+TEUFBuoRuOERcjSeEfqXpXVZ1muetQTw9XObGfAUer4jo4Z/
	 1wAh4oZ/5YngA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C01B5CE3ED6; Tue,  4 Jun 2024 15:28:26 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] rcu/nocb: Fix segcblist state machine comments about bypass
Date: Tue,  4 Jun 2024 15:28:22 -0700
Message-Id: <20240604222825.2371133-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
References: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The parts explaining the bypass lifecycle in (de-)offloading are out
of date and/or wrong. Bypass is simply enabled whenever SEGCBLIST_RCU_CORE
flag is off.

Fix the comments accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 659d13a7ddaaa..1e5b4ef167caa 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -141,7 +141,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
- *  |   handles callbacks concurrently. Bypass enqueue is enabled.             |
+ *  |   handles callbacks concurrently. Bypass enqueue is disabled.            |
  *  |   Invoke RCU core so we make sure not to preempt it in the middle with   |
  *  |   leaving some urgent work unattended within a jiffy.                    |
  *  ----------------------------------------------------------------------------
@@ -154,8 +154,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
- *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary. Disable    |
- *  |   bypass enqueue.                                                        |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
@@ -185,7 +184,7 @@ struct rcu_cblist {
  *  |                                                                          |
  *  | Callbacks processed by rcu_core() from softirqs or local                 |
  *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
- *  | Flush pending nocb_timer. Flush nocb bypass callbacks.                   |
+ *  | Flush pending nocb_timer.                                                |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
-- 
2.40.1

