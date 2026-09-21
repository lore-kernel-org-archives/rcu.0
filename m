Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA9463B8C
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982534; cv=none; b=U8wg0EQFHswflH3c9u739eVeDyO+s4BxqYPSuBA7yZYIgVEdcirDBikhaEZ8pcd3rpsACaJVT4sdL2jwlK3bwjrJwJqa2w2tHspTTwVUxdBMyjLqd7rw02DUYIyTtbOJn/2/vCqGbECFr1e69mIG60p2kEkbr5UMvk1oEDtmHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982534; c=relaxed/simple;
	bh=gg1y5J6wvSizwC3gFVsggog4FN4dVg6+drI/OX9nv8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3LY2M72tuGLm99Fi0zygpK9nxtTG4ma/Tywfx06v0BQ73Gf6AakO8UO1NCNL/yFBKSSCL9EAopHgEB9p7c7njbSEIIHMi154DiER4b0N3g2SEY/ZE2QW4Rwf4vES6tiQFxu7yOxNU6UHc8JDb2yCUCbJb31bBeTKfHkQPtVZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W7g7jKUi; arc=none smtp.client-ip=95.215.58.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W7g7jKUi"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gg1y5J6wvSizwC3gFVsggog4FN4dVg6+drI/OX9nv8o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789982530; v=1; x=1790587330;
 b=W7g7jKUizUZ9nspF8xvE7oYsI/6MDEC4F4BT8uIYNpkqMBgCYm1VKABuvLzzX5xk6GihvnW4
 Kba7Ddtk9hkKw4FFRsLyKYYAw67zyJSYsLaBSJh4VYgtSi44SsgivNbGm+njg1Hdob9GtvFRhHQ
 2zpF6qEh/rZTncHiI6WOhct8=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1e273a490565660;
	Mon, 21 Sep 2026 09:22:09 +0000
X-Mizu-Trace-ID: e1e273a490565660
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
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
Subject: [PATCH v4 03/15] mm/ksm: convert process iterator to for_each_process_rculock
Date: Mon, 21 Sep 2026 17:20:49 +0800
Message-Id: <20260921092101.89285-4-ye.liu@linux.dev>
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
with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/ksm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 49d48d1e0998..69d30e80a090 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3280,8 +3280,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct anon_vma *av = rmap_item->anon_vma;
 
 		anon_vma_lock_read(av);
-		rcu_read_lock();
-		for_each_process(tsk) {
+		for_each_process_rculock(tsk) {
 			struct anon_vma_chain *vmac;
 			const unsigned long addr = rmap_item->address & PAGE_MASK;
 			const unsigned long index = rmap_item->linear_page_index;
@@ -3298,7 +3297,6 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 				}
 			}
 		}
-		rcu_read_unlock();
 		anon_vma_unlock_read(av);
 	}
 }
-- 
2.25.1

