Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67804440A35
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768935; cv=none; b=lKVdg8wcMR2AtJFLC9XjytrnfSFSITRWuxEjJqvLpAbTZaHpVMDg1dM0s3GN6rgpAGLwy+NALqZrteKyUhWNeEDertT8DWjN6Ct5Bio2bvAw816fUwjvF9w9pfqpwlvg0Hw/7Kw5K+yvN9pr0JI7GexHx5O0P6J4R9svrFGkBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768935; c=relaxed/simple;
	bh=4aeyyo7NniAcYqllECrNMdgEOmExFee2/DggJvrhUqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGITqvMZaDqVqnbf01b3wEbL1enTBWewiXVRCYVxNfgxB0uzIX0/Mdk/x8UPdKFO/rNZQ//5U6GhDq8Ojs2EGahLjy0dwg/G6w7v5vashweYaNOm9y1VhRFCzCAMQwC/NlfBCoEPM8pZ7LnVh6MFcdnmzsk2ig4DAWwSR+/2PVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WpbZB8vM; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WpbZB8vM"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4aeyyo7NniAcYqllECrNMdgEOmExFee2/DggJvrhUqI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768930; v=1; x=1789373730;
 b=WpbZB8vMV1atTAj+eChqlE5a8sbZp8ATsL8FJlR45iT1eCqql9Z7vil52XF+a6WIzfcKn4gf
 R66TMNwf5wR7Ca9JpMJXHwOg5FmkuAqRSpAm1ZfBi61Xs31woef6EOwGW7XUH1M0pBBZKnneL8C
 654rUfJqyBaPq+fNHnFytbHg=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a35385b3d24bba3f;
	Mon, 07 Sep 2026 08:15:28 +0000
X-Mizu-Trace-ID: a35385b3d24bba3f
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
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
	linmiaohe@huawei.com,
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
Subject: [PATCH v2 7/8] lib: convert process iterator to for_each_process_rculock
Date: Mon,  7 Sep 2026 16:13:33 +0800
Message-Id: <20260907081334.1152889-8-ye.liu@linux.dev>
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

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process() loop in lib/ with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changes in v2:
  - Rename *_rcu to *_rculock
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

