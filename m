Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16B43DA3C;
	Thu, 30 Jul 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421977; cv=none; b=ltMqQEU5vtM7KYqDYtP4BIARizgxjDuic0nffTJ6pM3/5awYS0h6jI1zYJp/aUdelLuwCPfvwI931CSDIuTVEGRZ9MMs6AQu7oDaZOCjuPCc4oEF2Yw2Vd9lB3UJaWtw1KrTgYjzveCI8TF/pLWa9I7i8hwCLfikAejxKD0Pzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421977; c=relaxed/simple;
	bh=VYDIP9dmnyQpgO86jo/2Akdzrf+4hXrG6O+d9z2ZtOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ucZwED4p6Tmr/InTHJfDQQbtk81ZIyDWx4AYg2+nAqC8ZHFGdffQ0AzpAoRxPqi2Yj5uLCQst2Lj+VR8cJkx/M9fqRFW2CeLusF45ZHHR1dOSKWuhxFW8vfq9BCCAtLIPQP8L/LpJVftn6fuUURs+W0I+ItqfKsHEKXuWDqKAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQuIWHR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQuIWHR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DE01F00A3A;
	Thu, 30 Jul 2026 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421976;
	bh=/rPOa6qb2Hl55Jp7oWeuPKM83u1LEmbFcYHQoUGj5W4=;
	h=From:Date:Subject:To:Cc;
	b=hQuIWHR+h9t8EgXjRvXqbFdLLIHthBMA2GC+giXqn7dz67m89ccTw7W6miHiPXDK6
	 yBFuh+5r6HwpJ/u0MWXD9mwh/yaD2k6upDJzslw7FkHB6Oni5bzSMez2686W/MpG+n
	 jtUAoieXaDsrk44GKFJh+nsT0n0K2n9VIC1ckPjJWikim9H3BqwWQ3LKyl20nZFZGR
	 VrySXmlnwJaA9I+NP5lbf7nOqO+iSSiyThiaqM+gvQvSzdcbu8UVKDgNC8U0zVsMC6
	 gWI0ZQOTV3nY56shMkvY4/lWxycP1//RP+I+ztN7NUHB3sha+LQL6gIQSs44jPpVox
	 yHTVoDJ4iaZfQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Thu, 30 Jul 2026 16:32:46 +0200
Subject: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI1ga2oC/yXMQQ5AMBBA0avIrDUpFVJXEQtlyliUzCAScXfF8
 i3+v0CQCQXq5ALGg4SWEJGlCfRTF0ZUNERDrvNSV0arPeC5Lrwp13EsWVRhrDO+tL6yGcRuZfR
 0fs+m/S27m7Hf3hHc9wMGbLXsdQAAAA==
X-Change-ID: 20260730-unexport-barriers-439b3f69f791
To: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2

No module code calls these functions directly. Seems it was always the
case. Remove the exports.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Based on slab/for-7.3/kfree_rcu_nolock
---
 mm/slab_common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6750dfa27367..cd155ffc2762 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1329,14 +1329,12 @@ void kvfree_rcu_barrier(void)
 	deferred_work_barrier();
 	rcu_barrier();
 }
-EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
 void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 {
 	deferred_work_barrier();
 	rcu_barrier();
 }
-EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
 
 void __init kvfree_rcu_init(void)
 {
@@ -2163,7 +2161,6 @@ void kvfree_rcu_barrier(void)
 	flush_all_rcu_sheaves();
 	__kvfree_rcu_barrier();
 }
-EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
 /**
  * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
@@ -2186,7 +2183,6 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 	rcu_barrier();
 	__kvfree_rcu_barrier();
 }
-EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
 
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)

---
base-commit: b01f6ed9ff0c4581fc669044fa5b82a93b4ef144
change-id: 20260730-unexport-barriers-439b3f69f791

