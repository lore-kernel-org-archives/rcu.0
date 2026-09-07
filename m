Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC4443308
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768886; cv=none; b=hk71EbTuDKPN1r7sIW5grarYr+zmvrL2rzCh1sMscEWHOpN6IyHfZblFu9a7hs4mwXm7A1r/4SkOqNqdYGCFLZ5PdM1nhW1B7wFqv8aeeahPPhxeOLO25n6d+nmaj8qu52OOt5cufPjXXWVvGR2A54rDwyjUdegSssYLC00B/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768886; c=relaxed/simple;
	bh=DbvxqJsFC8I1jdIyCJVYNExbjeNMqAcKd+QJ2gOnSsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzWM47iW4UW6n5phS/7doR4+oTjqFN4l3JU1oGb6lTuSjbNnpl4YPwVxVHpQ0SZ+6eYQmorPG3PFsELaQEUVbB66Wfxy5I+pGlTn62+aMKoyJmRz3arIPRIopvduRdDsT8haILsmKNoUHSNYeGNM4305AdapTfOqv3S/tOVFM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QsEv9tJx; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QsEv9tJx"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DbvxqJsFC8I1jdIyCJVYNExbjeNMqAcKd+QJ2gOnSsI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768881; v=1; x=1789373681;
 b=QsEv9tJx+htfHkVlXBVh0jqEMfIZhKIiV4pwh/o31FxltAeubh5Va9WuiRzlYNnLS4RGXW4x
 3HwvGovI4EWm2dTeyV1ldFWXVea0E0hYEE3zKgj/wnYlr9LKJjErOiTjJr0WPsIeC7AFEexLstq
 DOoFXOu/yiKrsNroNAKn+bhU=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8a672054efb182f;
	Mon, 07 Sep 2026 08:14:40 +0000
X-Mizu-Trace-ID: a8a672054efb182f
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	ljs@kernel.org,
	sj@kernel.org,
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
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 4/8] mm/memory-failure: convert process iterator to for_each_process_rculock
Date: Mon,  7 Sep 2026 16:13:30 +0800
Message-Id: <20260907081334.1152889-5-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907081334.1152889-1-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
with for_each_process() loop in mm/memory-failure.c with
for_each_process_rculock(), which scopes the RCU read lock to the
loop body via scoped_guard(rcu).

In collect_procs_file(), the page_pgoff() call now falls outside the
RCU read-side critical section.  This is safe because page_pgoff()
only reads folio->index and does not traverse any RCU-protected
structures.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
Changes in v2:
  - Rename *_rcu to *_rculock
  - Clarify page_pgoff() safety outside RCU lock (SJ Park)
 mm/memory-failure.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba..7d93deb1f7b3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -555,8 +555,7 @@ static void collect_procs_anon(const struct folio *folio,
 		return;
 
 	pgoff = page_pgoff(folio, page);
-	rcu_read_lock();
-	for_each_process(tsk) {
+	for_each_process_rculock(tsk) {
 		struct vm_area_struct *vma;
 		struct anon_vma_chain *vmac;
 		struct task_struct *t = task_early_kill(tsk, force_early);
@@ -572,7 +571,6 @@ static void collect_procs_anon(const struct folio *folio,
 			add_to_kill_anon_file(t, page, vma, to_kill, addr);
 		}
 	}
-	rcu_read_unlock();
 	anon_vma_unlock_read(av);
 }
 
@@ -589,9 +587,8 @@ static void collect_procs_file(const struct folio *folio,
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
-	rcu_read_lock();
 	pgoff = page_pgoff(folio, page);
-	for_each_process(tsk) {
+	for_each_process_rculock(tsk) {
 		struct task_struct *t = task_early_kill(tsk, force_early);
 		unsigned long addr;
 
@@ -611,7 +608,6 @@ static void collect_procs_file(const struct folio *folio,
 			add_to_kill_anon_file(t, page, vma, to_kill, addr);
 		}
 	}
-	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 
@@ -635,8 +631,7 @@ static void collect_procs_fsdax(const struct page *page,
 	struct task_struct *tsk;
 
 	i_mmap_lock_read(mapping);
-	rcu_read_lock();
-	for_each_process(tsk) {
+	for_each_process_rculock(tsk) {
 		struct task_struct *t = tsk;
 
 		/*
@@ -653,7 +648,6 @@ static void collect_procs_fsdax(const struct page *page,
 				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
 		}
 	}
-	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 #endif /* CONFIG_FS_DAX */
@@ -2288,8 +2282,7 @@ static void collect_procs_pfn(struct pfn_address_space *pfn_space,
 	struct address_space *mapping = pfn_space->mapping;
 
 	i_mmap_lock_read(mapping);
-	rcu_read_lock();
-	for_each_process(tsk) {
+	for_each_process_rculock(tsk) {
 		struct task_struct *t = tsk;
 
 		t = task_early_kill(tsk, true);
@@ -2303,7 +2296,6 @@ static void collect_procs_pfn(struct pfn_address_space *pfn_space,
 				add_to_kill_pgoff(t, vma, to_kill, pgoff);
 		}
 	}
-	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 
-- 
2.25.1

