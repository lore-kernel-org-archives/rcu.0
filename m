Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D39316190;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778241; cv=none; b=OJpUcSqwjW8YAPBCOaLjC3fU2MVhg13/AJA6ehq/GI6fbMb6k8VeXtkFSmUGvM6lQLeAkMSQBqrMUGtRwQ5QnC0U4QZE73j3wqH8AVEkEjr4cA7B/czAfAp/bownvUdhGAKY6KgZ7ChMZ//uqf/oJ+qcQvto0T3po/xCcXJj6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778241; c=relaxed/simple;
	bh=Arz9E3aSQFsoY3+ttRcyI3U2xIGUyr03JzGHIesIHc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdATH3VrGqTfdShrFtVyCrG6yuZk/4yJ1ZJPeEoXUqBNHo5CaEMw0tVrf8pNpZ2mku8qyeCqYAgukXBDgtLRut59DxrPRdL6ca7NlyhwJjminiIjX/UbT1zJjYiXlhOaJxfqB/TQbCL3voaUcZZfqvMdRebByqJvTfxk+UiahCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpWxc6cO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpWxc6cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF281F00898;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778239;
	bh=7mqgeJCsBYJMP4GR85bBjLltzffKn3WDJgl+ZC3WYEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpWxc6cOGknnipZAmi3iW5ZlM0/lsDj6cA5tkKffXVheCnsyCCj4+ehygZzpGKrWR
	 zdLmnxWNqGTyF9W8D0rcWrOGg8sPOeauroKzJyRSa4MAD76CpJpuLyPdfzhnKFZEUa
	 u5RdN2C4Zz4OV1vggAb1dGvIodb0G/NTaB4f9GpGwzzuJmSxdDbMutrVcabZz0SBfm
	 RU/GYP8ODceQ0CaEAK+CZ1XQsNO6gZGJRk3bI0eb5WwUTuL3BF5syLbadI8NIjNAw6
	 yk/MVpx3QScY+jNZfqYQxJiJdUgLHojFnzt8D5RGsopUSuO/YyQrZbCBg+gGeJ81O3
	 pRN6O5wN1czGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F8EECE178A; Fri, 18 Sep 2026 17:37:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcutorture: Synchronously wait for all rcu_torture_irq() callbacks to complete
Date: Fri, 18 Sep 2026 17:37:16 -0700
Message-Id: <20260919003717.3134738-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
References: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The rcu_torture_reader() drives RCU readers from interrupt context via
smp_call_function_single(cpu, rcu_torture_irq, NULL, 0) with wait=0, to
runs rcu_torture_irq() on a remote CPU. this is async, nothing waits for
the remote handler to run.

On shutdown, torture_stop_kthread() only waits for each reader kthread to
return, and the reader's timer_delete_sync() only drains its timer. Neither
waits for a rcu_torture_irq() which still pending or executing on a remote
CPU, so it can run after all readers have exited and rcu_torture_cleanup()
has already advanced.

1. rcu_torture_irq() may issue cur_ops->call(rhp, rcu_torture_timer_cb)
   after cur_ops->cb_barrier() has been waiting for all outstanding
   callbacks complete. once the module is unloaded, fires into freed
   module text, a use-after-free happen.

2. rcu_torture_irq() may still be inside rcu_torture_one_read(), holding
   a read-side critical section, when cur_ops->cleanup() tears the flavor
   down (e.g. cleanup_srcu_struct()), triggering an active-reader warning
   or use-after-free of the torn-down structure.

This commit therefore issue a kick_all_cpus_sync() after all readers
kthread have returned and before cur_ops->cb_barrier(), synchronous IPI
round trip to every CPU guarantees that every rcu_torture_irq() which
previously issued by any reader has completed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 79807475b672..51ed35f5aab1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4491,6 +4491,8 @@ rcu_torture_cleanup(void)
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
+		if (irqreader && cur_ops->irq_capable)
+			kick_all_cpus_sync();
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
-- 
2.40.1

