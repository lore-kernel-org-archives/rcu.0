Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204646AA9C
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982607; cv=none; b=J4CCqAeuAV6EWsITMIUShIfHVAprcAMeOcAIulSRjDBn3c33G38MFbp0ddGlvMeTLAgOKDZqMJenkOKAKcmNWk6Mytxv601bpVGWX7r7b0W8vc5gffyHXJFB6jMM45nZv/MwNtwjNTJnlpfRsYCeI5O0rcrcjhkw71hQ6aCu964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982607; c=relaxed/simple;
	bh=hvpqBrTuGQdelxQxV7LAEzeK1Pu58637uGt8AyWJtr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTQlJ9iuju7o3J6a8YvzVP20DkEnedZ/vNL1OxlMdO4cPGserCsIqpXpXHKWv3b+nyuS1oCR4uxJ8Kh32bw067QCeskTyALyjAbB8TniCX5G94KiDdqPIJfXTs3oGKh3k/HQDlBrHe8qfemLu9SAFfF9gkFG3NHLT/7eb/YT3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjCgDvee; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjCgDvee"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hvpqBrTuGQdelxQxV7LAEzeK1Pu58637uGt8AyWJtr4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982603; v=1; x=1790587403;
 b=UjCgDveeFLOD/PHHgF+rQI+KUm3sTeCxnsAh9q2sAKndYMz+0n0u945lFRj5bicxwpJegF17
 ySIWsumrwbLdNOhqTadT1MXLnuu4oumQdcM5K2T77wC1hukw2NYTrwsh/CcdMRbZ6CYl5UgdLXt
 34E0TJ7sFIi7QlcyBJF4kzSY=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c4a69cd911b0a5e9;
	Mon, 21 Sep 2026 09:23:23 +0000
X-Mizu-Trace-ID: c4a69cd911b0a5e9
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
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
Subject: [PATCH v4 08/15] locking/lockdep: convert process/thread iterators to for_each_*_rculock
Date: Mon, 21 Sep 2026 17:20:54 +0800
Message-Id: <20260921092101.89285-9-ye.liu@linux.dev>
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
with for_each_process_thread() loop in kernel/locking/lockdep.c with
for_each_process_thread_rculock(), which scopes the RCU read lock
to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/locking/lockdep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c56a7f91d72e..ea218dc75ad5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6834,15 +6834,13 @@ void debug_show_all_locks(void)
 	}
 	pr_warn("\nShowing all locks held in the system:\n");
 
-	rcu_read_lock();
-	for_each_process_thread(g, p) {
+	for_each_process_thread_rculock(g, p) {
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
-	rcu_read_unlock();
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
-- 
2.25.1

