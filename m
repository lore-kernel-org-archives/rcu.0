Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23342AFA2
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113717; cv=none; b=SWxaYSJ3Gh0pV5nwgVP6hgAaLakHYJSVJOrMLT3Y85V721c/K7Jpl1HJQ4hqD4+Fn+aFN4QdFIOW9ERrPtpAdI2x5Mu9Qvk0myVnbqsmvsgBYMqSGB070Yb63gYohovFejG23UmHWg7mS1E/40J7b/PfE3CxT7INI9d2UuI4nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113717; c=relaxed/simple;
	bh=Re/ZsMyjr8Kl1M8Xab8XaAEgyJ6r9rT2dZ2X4TDsND8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfTzs0+RuXX0vYEPfUIWRFPKdAxxIn4yNuxsvqp+ug1KUUFNTBpXQxAuvBp0i2VRwz8Tv9Ue0ZZiUXNccWxzfoIa2elRBEMBzH809zrUR+l6XOUbqigJYEqvGN+o6n9fbiCsxQW4iJ/cXJj2weEv2Ieb2dQiNzPquxSZYNgdzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjcPcQDO; arc=none smtp.client-ip=91.218.175.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjcPcQDO"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Re/ZsMyjr8Kl1M8Xab8XaAEgyJ6r9rT2dZ2X4TDsND8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113714; v=1; x=1789718514;
 b=UjcPcQDOh7J6vkpFrcteNi1zUz7dIM0nAAKZgQgvTarbMJTiE3coDjU8Pj2EWY5fivxKe2dd
 LEC4NFSI9WGVGdZkhi4ERY6K2Yb8H0qpVALmaZf51lH8v27JXszGAfsroYwza3D5hPPzD0KUVFO
 U10C4ohj7jdtjyqcH6sxNZ9Q=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 67efd391483b1f6c;
	Fri, 11 Sep 2026 08:01:53 +0000
X-Mizu-Trace-ID: 67efd391483b1f6c
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	mic@digikod.net,
	tglx@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
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
Subject: [PATCH v3 12/15] unwind: convert process/thread iterator to for_each_process_thread_rculock
Date: Fri, 11 Sep 2026 15:57:57 +0800
Message-Id: <20260911075800.491472-13-ye.liu@linux.dev>
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

Replace guard(rcu)() combined with for_each_process_thread() loop in
kernel/unwind/deferred.c with for_each_process_thread_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

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
 kernel/unwind/deferred.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5bea47314254..ecfe1336095e 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -319,9 +319,8 @@ void unwind_deferred_cancel(struct unwind_work *work)
 
 	synchronize_srcu(&unwind_srcu);
 
-	guard(rcu)();
 	/* Clear this bit from all threads */
-	for_each_process_thread(g, t) {
+	for_each_process_thread_rculock(g, t) {
 		atomic_long_andnot(BIT(bit),
 				   &t->unwind_info.unwind_mask);
 		if (t->unwind_info.cache)
-- 
2.25.1

