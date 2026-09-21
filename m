Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C646D0AF
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983207; cv=none; b=q86PrD2Sn2WVMw47pBHxy6AYBJKARqtRRVHKlQCaNqYTKBxPP8eguPk0BFIDVpi16DNHJZ0i5kf/eD4mgNyWT0/han++AhhyusC+4H0CA2YamD4GrCnsBc24+bfD9UmpTGv2O4hzfieEotMGIvx0WdVqqyfa1Z6ZL+k793qolSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983207; c=relaxed/simple;
	bh=ngtWac8X3lY5A5SaQnbYXeWkN/JG2JLNpAbPKFOiOjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaGYx0wYqnIT93+69inERDpBnL09PKpe4afu2rqDRnf51EmqCZQIDDiOK/kOYjVuY190KlbXQO3PNdktf577v5nHqFoEzHgVrVTtQRrck886t1RrgOeEsFBRHriQ1dmZ+pUe4qNMSCF67WK7Jdhdue1jltu5zG2TAw/eEfN+Dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9zsQ83j; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9zsQ83j"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ngtWac8X3lY5A5SaQnbYXeWkN/JG2JLNpAbPKFOiOjM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789983203; v=1; x=1790588003;
 b=f9zsQ83jctwgcHU/RmDsAzFpBmzcyeP8XJuu2OwoLEJIDVTZwJcC39vehYpLwR6qsxzsPI9Y
 1+31/aiNiv1DKkowHmxvokW9QTtZDPyV4BGyLdG4qzQ6MDM57NXkFeWBffJ0r7oaY0jB/d2Xufl
 QY//agRj3sw71upZe3+FidVc=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b8bc6083ed009dd;
	Mon, 21 Sep 2026 09:33:23 +0000
X-Mizu-Trace-ID: 0b8bc6083ed009dd
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	SJ Park <sj@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
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
Subject: [PATCH v4 14/15] lib: convert process iterator to for_each_process_rculock
Date: Mon, 21 Sep 2026 17:33:10 +0800
Message-Id: <20260921093311.104814-1-ye.liu@linux.dev>
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
with for_each_process() loop in lib/ with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: SJ Park <sj@kernel.org>
---
 lib/is_single_threaded.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
index 8c98b20bfc41..4e7fe85454ab 100644
--- a/lib/is_single_threaded.c
+++ b/lib/is_single_threaded.c
@@ -26,8 +26,7 @@ bool current_is_single_threaded(void)
 		return true;
 
 	ret = false;
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		if (unlikely(p == task->group_leader))
@@ -48,7 +47,5 @@ bool current_is_single_threaded(void)
 	}
 	ret = true;
 found:
-	rcu_read_unlock();
-
 	return ret;
 }
-- 
2.25.1

