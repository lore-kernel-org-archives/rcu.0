Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED811F0E40;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=n1JRzxMWUnmZxEUWvJdr3YGj5SgHI8QbfCza2SYbKBxUn3VdeGzahCrcR885dO6ikkeIzsU5l3naOQFcpPUaqn97qoEecrtjpaTKVqt/ABuwbcg5HCBArJdgNghMGlXJSKR6569wF4SWO//Fae+CQ5vjVOqPIDchquXVZ9Dfb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=IlXF7fs/MSqgTj1R2PEuLIUUjiyRnagKzv1erhddzro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aj6cneMieS/31DDXA5Zb8u1YUIpDXj+6B6vkHAmCq3FswRGjBb391qdp18NpuBFxSIurx2MBVEWKa5L2jctKrPVBbGh5bJbS1vr3OayxV0b5s7wX2MYDwBQ/3wZA2E79ZYBA6b9C/tJkieaWESPmhUBa1uSSshfhLmgwdiSaoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJuu5mPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJuu5mPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC31FC4CED2;
	Thu, 30 Jan 2025 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263323;
	bh=IlXF7fs/MSqgTj1R2PEuLIUUjiyRnagKzv1erhddzro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJuu5mPNPJzV77mji9Xofr6M3WEFE//lHdhsPqqDjkzCxnIFFKNQjx6fjny23j4zp
	 Ihq/zuk2prXV9yPpWRGhNY2Q2BoX/8YjSZmMjV4prk/xOe0jRUExsBxPkoOK6rni1J
	 NVzbd9dFPcSdPJJewGRBqFPo+F7PIDc69PgMtqgqXHoXmuRgRQhJsAG3lst68jbNiO
	 5cqDL/pPsS0cuJgXVaGSMpv0wBTE410Wh2nqLv9l2+oR8txWZCM4drtgyuIREHDNeP
	 1IvPkLiljGdFoDPQkP6imRuEkV7B2mAMvZv4XpjZbzs7BeLKxT9L2VjwT3mr24vZZ3
	 n+XhnHPhUJwzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84DD6CE37D9; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH rcu v2] 1/9] rcu: fix header guard for rcu_all_qs()
Date: Thu, 30 Jan 2025 10:55:14 -0800
Message-Id: <20250130185522.1652093-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d912781..aad586f15ed0 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.40.1

