Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30E16D9AD
	for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702858; cv=none; b=lM4iEiT1iWM6aQPX4MDgumvaLSgHrbENpKiFhLFy72AuSbCbkP1MimVtMWux43jgJDAr5TdRHMudZ7LTYXY5sbompV2Ih2jokLtpqiNAxt5aXCHCxDisxeoKTd3FoESEfmJKYUnnnIYVzeCOGuuKItc16XZt+EctIavCP7nEQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702858; c=relaxed/simple;
	bh=03eOuIbpk2CL8gHcNkcMr6D2tKWHDvUL5fMCqSTDmZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN5yNVVTfSUFpewKsk/tkF46m3biF8O6Ckc/2HYs/4AjE7Otu4Z7Riuu3df6Q04mtC6XaWkK1VM8O2ZmpD4p9pUYZZlm/kXZNvrpy4ge7ChEsVyBXN/okXqCeBrMtXgjYqlU3HA0woQCE9hXOkqXIeC8rGTBRbHj586Rk7OrzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu/7SO3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu/7SO3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgv6m6VmpgYAIYyr1Uojk4UY9y2hZWycgx24o6Dhrv4=;
	b=fu/7SO3YUiqklrnbNmWeKVbC56Wdguoty48y9rOJ+y5jQKzprHRfwwM0eNdLRTQg7UxzjS
	lkVlc9XjWnlZFk+RhJBFR9RPBfbtx1mHEvXcjrlOtJrYMjA0EtBeM9869CeOEN+GTh6kYe
	sPj94jYT7YKdw39swgI/yBVaUqkq+gk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-I0jpcKX5O0eRlw_1D8M9ZQ-1; Thu,
 11 Jul 2024 09:00:49 -0400
X-MC-Unique: I0jpcKX5O0eRlw_1D8M9ZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15AAD19772C9;
	Thu, 11 Jul 2024 13:00:45 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DD7319560AA;
	Thu, 11 Jul 2024 13:00:36 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 01/10] rcuwait: Split type definition to its own header
Date: Thu, 11 Jul 2024 14:59:55 +0200
Message-ID: <20240711130004.2157737-2-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A later commit will add a struct irq_work member to struct task_struct, which
would require <linux/sched.h> to include the definition of struct
irq_work.

Thanks to header dependency hell, incudling <linux/irq_work.h> in <linux/sched.h>
results in defining inline helpers using not-yet-defined fields (mm_struct,
task_struct, various task states...).

Break off the definition of struct rcuwait into its own header file.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/rcuwait.h       |  9 ++-------
 include/linux/rcuwait_types.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/rcuwait_types.h

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 27343424225cf..1f1ca7d38cdf8 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -5,17 +5,12 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 
+#include <linux/rcuwait_types.h>
+
 /*
  * rcuwait provides a way of blocking and waking up a single
  * task in an rcu-safe manner.
- *
- * The only time @task is non-nil is when a user is blocked (or
- * checking if it needs to) on a condition, and reset as soon as we
- * know that the condition has succeeded and are awoken.
  */
-struct rcuwait {
-	struct task_struct __rcu *task;
-};
 
 #define __RCUWAIT_INITIALIZER(name)		\
 	{ .task = NULL, }
diff --git a/include/linux/rcuwait_types.h b/include/linux/rcuwait_types.h
new file mode 100644
index 0000000000000..60a4385a2c368
--- /dev/null
+++ b/include/linux/rcuwait_types.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RCUWAIT_TYPES_H_
+#define _LINUX_RCUWAIT_TYPES_H_
+
+#include <linux/sched.h>
+
+/*
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
+ */
+struct rcuwait {
+	struct task_struct __rcu *task;
+};
+
+#endif
-- 
2.43.0

