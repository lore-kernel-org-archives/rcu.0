Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE2DA76A;
	Fri, 31 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459847; cv=none; b=hIm4JUsms0aYAYGUsAhs/CsN95l19Tzqip0BGLwf7ThK20DIIMfoJpuMdH6OtmzIt1nat0MMJrPJS1KACHHtQtQD+z0Mr7dVTHWzAzG5ZK2WIFPEAEuqr8FnrFBRT7DbggJugq+Xk9nI6gG4KtyMbqRRGaVoAp4oCYDZ9paRF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459847; c=relaxed/simple;
	bh=Yb5qKEYD7gqWoJ8H0XhEOcVMDaNEDLXxCd6UHdiYAPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYeXEHK9YzZAEvNVV628YD5Ohxe0np6R+3FHqj99socDxlsANrBPjYMWq7+dzrwQZQXZwoty1jY5Sg4kE3V2AxdqR6napRDEGINlWU5Mug6fphWlegvDwPhU45bVBH6MdODW6njzolkWtIfRDq5ysjvepSxqrGXNF4OOcy5BCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqBuzx2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqBuzx2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A4D1F00ADB;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459844;
	bh=fKNGySMMG/lARfFIiQH61dXgzdia8Ddv1o1T8fH8wcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqBuzx2Cevhsig7tS4nxwLAZX6VqgfTaE/TXpWQqCBKSmDAUxQnmFAfFU78o7RLIQ
	 PScB6wKi0JFU+8EAAwDzxHot6mD9IisYzYV/B7mLnYbyw/a9tjnkRjOXKcpVA2lNbY
	 Vz8KH6DLay0Xau2FfcNGMUv0jU7/2dhzq9cpDlMuHnzeBhCNHqQDjbq5xGC6XyF8Yk
	 98zrhgynlSu4D9i2RFLsg0UJUOZlBUuG3X+g2/PRszSgLQ5G39gS1GMkNbdJ/G/8vV
	 Bn6/pD1uLy36gMOqOoHA/oZxh9fkD93fjaTweXS2ZE4JMRhuumyBqXQ94058nwWIUL
	 fty/ApNnsRUUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C595CE1497; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 08/10] rcu-tasks: Fix IRQ read lock/unlock data race
Date: Thu, 30 Jul 2026 18:03:59 -0700
Message-Id: <20260731010401.3531631-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noted by Marco Elver:

rcu_read_lock_trace()
   ....
t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
	<interrupt>
					rcu_read_unlock_trace()
					< ... var decls only ... >
					scp = t->trc_reader_scp;

This constitutes a data race between these two accesses to
t->trc_reader_scp.  If rcu_read_lock_trace() were to tear its store,
this value would be corrupted.

This commit therefore defers the rcu_read_lock_untrace() function's
load from t->trc_reader_scp until after it has verified that this is
the outermost rcu_read_unlock_trace().  With this change, the interrupt
handler increments and decrements t->trc_reader_nesting and does not
access t->trc_reader_scp, thus avoiding the data race.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index fd3ddeb6aa3bd2..70decf877348a6 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -126,11 +126,13 @@ static inline void rcu_read_unlock_trace(void)
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
-	scp = t->trc_reader_scp;
-	barrier();  // scp before nesting to protect against interrupt handler.
 	n = READ_ONCE(t->trc_reader_nesting) - 1;
-	WRITE_ONCE(t->trc_reader_nesting, n);
-	if (!n) {
+	if (n) {
+		WRITE_ONCE(t->trc_reader_nesting, n);
+	} else {
+		scp = t->trc_reader_scp; // Compiler cannot hoist load due to data raciness.
+		barrier();  // scp before nesting to protect against interrupt handler.
+		WRITE_ONCE(t->trc_reader_nesting, n);
 		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
 			smp_mb(); // Placeholder for more selective ordering
 		__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
-- 
2.40.1

