Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902D13FEE;
	Tue,  4 Aug 2026 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801834; cv=none; b=BJuW0dovANqA+Uiq6yJs+vcw/yK5tKgVp0hvV+Vu7bLJDksfqXXcOv9nTUuTRl004ddUZBNJb5f5JKSyxm5INqMnPU109fwwp2Qp957i37tqaoq715LwHPUy86n20MHjJAJt6y2WyxTAxABNPZsrudtNIWTQ6kmUbHvhqQ3K4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801834; c=relaxed/simple;
	bh=CCimtxGCRC0NSJ1taDhAkxzVIhsW9r6GeTO1XCUhZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xb0MWl1rrmzaDyazKn0h3hB1+H8Z8qeB+mP9GOSKcRcz4xAikCZRApPf2yPL2qO+lFsYEVHhF7z3Kl8EcgdrmkeFaPVwNjDlGSyVRyASAK6EAZD4DT+LseiLO9EM9qkOg1a+BSW06xleVN8yD2kKHiJdE5NflwN3lZ9I4yR05IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=pYhWpOUw; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="pYhWpOUw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785801821;
	bh=kXnXKKtoRN+fL226V5e+aXyE+V0mtd9pYLDdPMt+mac=;
	h=From:To:Cc:Subject:Date:From;
	b=pYhWpOUwMIcI1E7d502A1vaDNlUr7+rZZZWY2Ipc/8/gOTBpfig0m1K/nBJT4gZ0i
	 DHJMXHkAulkk6iYBsKDIKMAXofGhOCAnPdG2S97nJXi0yMjpK6dZgw37r608AX9KxS
	 XsQms/Di9ZoIUJivbeKYVfOhOG9cve6vJSz5F0AI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with UTF8SMTP id 4hDYfj0h69z11cv;
	Tue, 04 Aug 2026 00:03:41 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hDYfh4fXzz11ct;
	Tue, 04 Aug 2026 00:03:40 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hazptrtorture: Fix inverted sleep condition in do_pending kthread
Date: Tue,  4 Aug 2026 00:03:39 +0000
Message-ID: <20260804000340.4812-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The do_pending kthread never sleeps. Its supposed to.
kthread_do_pending_ms sets the gap between cleanups, and the docs
say so too. But the sleep sits behind torture_must_stop(), and thats
false while the test runs. So the kthread never sleeps. It just loops.
It drains the pending lists over and over, no pause, and burns a full
CPU for the whole test.

Flip the check. With !torture_must_stop() it sleeps for
kthread_do_pending_ms between passes. When the test stops it does one
last cleanup and exits. Nothing left to do, so no sleep needed then.

Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred hazard pointers")
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/rcu/hazptrtorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 72aeb50668e9..7c8b5899fb01 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
 			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
 			hazptr_torture_do_one_pending(cpu, &rand);
 		}
-		if (torture_must_stop())
+		if (!torture_must_stop())
 			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
 		// Omit stutter_wait() because this function needs to do cleanup.
 	} while (!torture_must_stop());
-- 
2.47.3

