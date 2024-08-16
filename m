Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09074076;
	Fri, 16 Aug 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792315; cv=none; b=uA7TjIHiw1GcDkagZSgUXugCJh5DesZfsW5CwmmSDvTVhIWVY9bN2zQNd63RDfpcTdzXOj1ek3peYU0kR9WJUnMJ7JvjhMUu75MTo6rw89q6pj1mr99tY/SDMxw+O+TBKJnJ2Cfg43gmckf9BvtRBxhInS8F+rHvCYKSLbvumkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792315; c=relaxed/simple;
	bh=QfEsd8CNM/qDln+by7LXPRLcSy7qOHCULrCU0g6vcGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAsmfseIhcMgPX6d4KLSHbneHCoWZT3T7woO3WbsPiHhFjJmhk/uniUpmzSdRu4ZFKH+nj6ton+QDz2kjC26OgzcCV+hPd+Emj4frNJ/qa1dNRWy+rg+EjE0ocHUILKg3y219D6bdkQUf9/3omkFzQkljyFpjFku4J5jZKfK+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVsDCrFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVsDCrFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D87FC32782;
	Fri, 16 Aug 2024 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723792315;
	bh=QfEsd8CNM/qDln+by7LXPRLcSy7qOHCULrCU0g6vcGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVsDCrFrkBaiSSyX7fwLmzxPT7DD9oqmoNhHg70N0whKSLHrqsJ4NnCfGdXHGH3WD
	 ali9g8AKHBc7BB4LosDf26JPn5KVCszDak19XWbHjQZS87B9mZ+uFpNGewiOuCrU09
	 xySqv9B0RenbvEeq5JDbAJDik85ozKrCFakos9pXEVPtBSAf0bUrHKkyRsyl14ngSs
	 Pgx+noeU4TGOrSlDixb6zn4MCvtafmRnWCuJTA1dX2WqFTUNevj9YJbmSVZyBsZG66
	 PEaQ0Pf3/CWE7SQQmDV7kzOcJ7DhPrhJskTQvARAbazmmxUqgCj2WEIrLkTWPLFvSo
	 oIsCqsXGLekFA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Waiman Long <longman@redhat.com>,
	Vratislav Bendel <vbendel@redhat.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH rcu] rcu: Use system_unbound_wq to avoid disturbing isolated CPUs
Date: Fri, 16 Aug 2024 12:41:09 +0530
Message-Id: <20240816071109.63059-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816071026.GA62718@neeraj.linux>
References: <20240816071026.GA62718@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

It was discovered that isolated CPUs could sometimes be disturbed by
kworkers processing kfree_rcu() works causing higher than expected
latency. It is because the RCU core uses "system_wq" which doesn't have
the WQ_UNBOUND flag to handle all its work items. Fix this violation of
latency limits by using "system_unbound_wq" in the RCU core instead.
This will ensure that those work items will not be run on CPUs marked
as isolated.

Beside the WQ_UNBOUND flag, the other major difference between system_wq
and system_unbound_wq is their max_active count. The system_unbound_wq
has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.

Reported-by: Vratislav Bendel <vbendel@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-50220
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Tested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..494aa9513d0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3539,10 +3539,10 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
-			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
+			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
 		return;
 	}
-	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
+	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
 }
 
 static void
@@ -3634,7 +3634,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3704,7 +3704,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_wq,
+			queue_delayed_work(system_unbound_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
-- 
2.40.1

