Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542F46985D
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982652; cv=none; b=Z9MnkkJ4kGkDAwN9j4uOrNdYnvhx6SWvGJtraG4rZkBTuj8vGOSpj0K0WJpj91H+4s+lLsVQd3W0e8neswPXKTQ9Xs+rrBEFW48ixBx4s02ows88Wrb4ZjqS5PMTWxV9aPElftsMZ416ysqfTB+oIto29nEJMWGcy/SbadvYwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982652; c=relaxed/simple;
	bh=VqnVaCdhVlGtZkszWTI2vWRw1i1BnDWykkewz9dTKKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkcIj4Ts076Iad5F7ApnR8F6iocmau2Eqn81ei/56Pn6Ma7of1klLLPCj+K0jjr2+qenwvzTBJe8Xl9xPZv0aYDTfqXDAnTTO0WtpTCZ57YnWBS7DTUygBZfMo8PyNL/rRBIymkF/ETnNaRON+cGKb/mwcGDQUPUfJ9NOSS8Okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CsrOzaLb; arc=none smtp.client-ip=91.218.175.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CsrOzaLb"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VqnVaCdhVlGtZkszWTI2vWRw1i1BnDWykkewz9dTKKk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982648; v=1; x=1790587448;
 b=CsrOzaLbncf1jifun0BnzCbuZmSUkImkyOH6UEG7P6A+Vt+UHtkBjSpvOZsQen6Gs1BBhnKf
 JJXOgk+/vI3k3CHqWgDGCdFFhAEbadIg2OFSrD2Kh+26utEq24v1OUZK1+aPv3rnawiazblk0N+
 iblvXkKpkWKJQgTM3UnRfQM0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d6ffecb1f71c0195;
	Mon, 21 Sep 2026 09:24:08 +0000
X-Mizu-Trace-ID: d6ffecb1f71c0195
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
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
Subject: [PATCH v4 11/15] tracing/fgraph: convert process/thread iterator to for_each_process_thread_rculock
Date: Mon, 21 Sep 2026 17:20:57 +0800
Message-Id: <20260921092101.89285-12-ye.liu@linux.dev>
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
with for_each_process_thread() loop in kernel/trace/fgraph.c with
for_each_process_thread_rculock(), which scopes the RCU read lock
to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 40d373d65f9b..f797ce119223 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1057,11 +1057,10 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		}
 	}
 
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		if (start == end) {
 			ret = -EAGAIN;
-			goto unlock;
+			goto free;
 		}
 
 		if (t->ret_stack == NULL) {
@@ -1074,9 +1073,6 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 			t->ret_stack = ret_stack_list[start++];
 		}
 	}
-
-unlock:
-	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
-- 
2.25.1

