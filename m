Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85C45FFA4
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982592; cv=none; b=lM5aHj0Re536PlHTYTF5tf39JmTU3MKQlLkMINE8cS/lVj38kaikgzkE+NXuJOeWG/gguxJcMT/WOnLnm02nWoAVFq9OmkEH7GYg3ZRJGgOORHs7NjO5GTSvSweterbySPGE8twQ82v58m/X2uyfWD8bq0qUaTNPWUso5Qtms8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982592; c=relaxed/simple;
	bh=66wflbyis4BetWzKnN/o4fNs3siEXCRm0GuSiVvDJXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8IudBdNf2dYAJSk5jvzem6U+77dULS1COjHx+9P/09Kqr2/g3NxVN9n71Q7hOOiS6I+pHva9uNQg7//de1/eMAwGuembH8NoJhFVfIVJRp1n6QIGiX+Vv5f5IxeCpxlobqMFrEqR8VHM5D4Higz+Obb8OUBjNIZeMNYP84YNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D9oKassi; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D9oKassi"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=66wflbyis4BetWzKnN/o4fNs3siEXCRm0GuSiVvDJXk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982588; v=1; x=1790587388;
 b=D9oKassi8FGfFTqHza0cIFeIN+4H+uuY20i2nfNdFOhWsqPLrfrXKez6NoTGByO3MB3Es2Dj
 QmMw+w10l3It6/ORf8KaIKeRqbAeqzz0Oa7gJzrNQe/iWWwO3QPIUDpM7VEBgiaKfrpvG7uouqF
 DCfUE+CZSkS6GWrAyHEvjhk0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 515370f5e6daff6a;
	Mon, 21 Sep 2026 09:23:08 +0000
X-Mizu-Trace-ID: 515370f5e6daff6a
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com
Subject: [PATCH v4 07/15] hung_task: convert process/thread iterators to for_each_*_rculock
Date: Mon, 21 Sep 2026 17:20:53 +0800
Message-Id: <20260921092101.89285-8-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921092101.89285-1-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process_thread() loop in kernel/hung_task.c with
for_each_process_thread_rculock(), which scopes the RCU read lock
to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/hung_task.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9..73a5ad3be9a8 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		return;
 
 	this_round_count = 0;
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (!max_count--)
-			goto unlock;
+			goto out;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
 			if (!rcu_lock_break(g, t))
-				goto unlock;
+				goto out;
 			last_break = jiffies;
 		}
 
@@ -337,9 +336,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			hung_task_info(t, timeout, this_round_count);
 		}
 	}
- unlock:
-	rcu_read_unlock();
-
+out:
 	if (!this_round_count)
 		return;
 
-- 
2.25.1

