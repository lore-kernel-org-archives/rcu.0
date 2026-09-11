Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F298459AC4
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113590; cv=none; b=d0BoCZLyuTll654atjVYkhbv/BZjusfmFLuJWNgnBsQZI8Utd5qtz0a4SfePyW++U47V9EGP9U5XjwahkRddEq7zFu97mtOUTZtJtbBggS6GBVi8/X7T2Fy40O/anTLrpmicEe8CvpVxZD0WoYvAYa4IL+584ux/KFFnlymSTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113590; c=relaxed/simple;
	bh=TDuvYwzdbuaBULIJ2jxj18W/NBHRAQZRTlKBQBMgQMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFnYiHz0UAAFB+6O/KNPu0MmVGGpkCUCOaKooPc8WQB8lFlzkyBUyWTcyAhCdWFlAjx4RGcB2v5FZTyss6xojlgmjxnvzl/D2fnj1RtneurvxxesHMhxp4QvMM82qef7xwqrL9Z6q37axIV5n5j7FDl80NCXJvV/z6tL9be51fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8UHpIuH; arc=none smtp.client-ip=91.218.175.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8UHpIuH"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TDuvYwzdbuaBULIJ2jxj18W/NBHRAQZRTlKBQBMgQMs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113586; v=1; x=1789718386;
 b=g8UHpIuH1iiMFg9exMCp0oGDRdZkKwS0rKp01RPJ2FqZf1pbHq60jt/hle7Q83ez+zGV5PPW
 VXcKnnCODgMP8LJqBecns78Yasza6y60EBziaaCU7K6zZPjiRXJAcnEHFjc5oEhBw2Jmx/Av+F5
 IZidRLrA5pukiKpMJDN8STQ4=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f84c3708b464234d;
	Fri, 11 Sep 2026 07:59:46 +0000
X-Mizu-Trace-ID: f84c3708b464234d
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	gnoack3000@gmail.com,
	gourry@gourry.net,
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
Subject: [PATCH v3 06/15] freezer: convert thread iterator to for_each_thread_rculock
Date: Fri, 11 Sep 2026 15:57:51 +0800
Message-Id: <20260911075800.491472-7-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_thread() loop in kernel/freezer.c with
for_each_thread_rculock(), which scopes the RCU read lock to the
loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
Changes in v3:
  - Split from kernel/ patch in v2 (Peter Zijlstra, Steven Rostedt)

Changes in v2:
  - Rename *_rcu to *_rculock
 kernel/freezer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index a76bf957fb32..7a870f71dcf6 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -217,11 +217,9 @@ void thaw_process(struct task_struct *p)
 {
 	struct task_struct *t;
 
-	rcu_read_lock();
-	for_each_thread(p, t) {
+	for_each_thread_rculock(p, t) {
 		__thaw_task(t);
 	}
-	rcu_read_unlock();
 }
 
 /**
-- 
2.25.1

