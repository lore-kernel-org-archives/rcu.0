Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14547CC71
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838511; cv=none; b=acQQVSVdXOOd1KLAjyTcmrZ2HIeoJF9L2DlvC3bWu8j4jNiRcWhBnyq3yEZIjRTyaq7oZuVdRGaLhctZ8uSgGxPAOHtOE3OoEbPKUBvpvJgurCIxjoZdcwN7Ee+H9eko0FrV8QEBa8F3IDQNM5GuRj/ieYi34mL5JU5uZoaWMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838511; c=relaxed/simple;
	bh=HEyh+xhAzG49tn2riClelZqb7JdjP+uvGlyXFlv5RtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TotRwOBchEjBq1b3RUafl+vnY5wzCoFxHfj60ME9Dj3ATfjvxjJzGkWdf/p6MRX7PmZpab+asjfUmCSnK1prY2TQjJCDxr41++CC7YzEqN+J8+yOK0UkUAEGsyfATiokp0wub8/W7vVQhaQhoDMIROOEnTFRB34jT5D/vUWGG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bYLGo0PG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bYLGo0PG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so1411828f8f.0
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838508; x=1792443308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4F888OOQShoEbLEfTPQFMYtPAYv48mf4TMQuqRsHmQ=;
        b=bYLGo0PGhg9wZL5l6tc4lZihAikDN6k3GJCXly9CIvV2XGGtu2C1PKSpwNiV3niHxS
         +1uzmO/7R00OXsQ5C0HydOM+bZ0DOV78eejprCDWIvI6tH3mxFzt0J7pnkKht/1Fwh6M
         SCOcvvX3u58PjJLgJ86twXCCbhjafUOt0YMRHtjxofr6d10ReFsdqlFWslpbD34YJBGs
         wUaq9CT82SL7oWAydBRoUhpCmuGrKZCMKL2obJxQP59G6eJXG3HsvQlJ1P7V1smRG3yL
         6yWSX4FlnLKOoDrbjv1wFfJclYm62IpyBlxid5OrKg8bR7LuGQrz5HjG6zXy4cSG22S4
         5IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838508; x=1792443308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4F888OOQShoEbLEfTPQFMYtPAYv48mf4TMQuqRsHmQ=;
        b=sGxBSYW6potsL6HtEQKj5wA2OB6tPaQSwu7ir0I/VfqF2U51TmhiYtDDr1s8dM1XjP
         rCXEfb40M3WiIZH4CZ+Gwb4mYUTj6eUYLao/qjAgawCbwljXurBB7nOVJfRmc7mUSkK5
         N+uJ5I/E0vkTEL/bUFVbMAlUtueOnGGfgHdHTkwDbDeOfEB/dOIGroIZ72slFWjU91by
         hfN4wWciNsOhs0pBlFHjmSyXpdk1MwCDDjzBWvZBpQoios1tVkvjBptxKbxTpmGmpIYt
         QrioSXyPgakaFTAb1EYuB6po5BqV2zHbLtbtG7Qkln5XjnyUcv2AxVXS4IGKZzAqal0R
         pdXg==
X-Forwarded-Encrypted: i=1; AKwUvBy5J/qat6SZ9g/jOY+kndRzJgKeCPZ2uy9Cuql6pycorecTcAd2fb18Xsp4Tc7+fnhuMis=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqTxVoxLPYHlPaRQkswZeMhS+FwwA9oZQ4ip5XJHGwbi+6Caf1
	TN2lKM6KGN+KcBuiYM6F83elQH4xkvtWA62/khl5SyvTYVmN2Tuaz4apZkWa+0lbNMM=
X-Gm-Gg: AYBFou39DhEl0/tNuog/A4joPQ6VTOSARzPzZG5c8toOLSL+bPksKaPOEP0ek/0UBB8
	Bk0RG5trwdKoVvlEJKM/IfB5HNG2XLxzhyd0ZxgnHrIRrWM3fPMf84IG1Q/1BmrPVC4Y3qnZ2Lu
	jgs9SxxUJhyD4Wrhu51P/+4u94HMGHynG7BLXn60SvHumhiSMOI6hNlmOkpOJ/OkjPfV07TN5KL
	OH2U0/xePpi2QvggN1oR2er9CsC6Kz0lm1+TvG5OMBeXK1LRwL9y96RfQcuFutMNwHl8NsAUTof
	TjfrI5N6Q0svUTurrZzH8WJ99YAZhMtDdVZcIQ6ii/rEnlrXcdqmENen9prQtvL3lqbtgSU5WUv
	DIUHpGAtcgMfwzPZq4QX99g/mOCYo9QJg8I3wNPEA3LvCKnz65TZiLwXVru2f1Q9Mm7qWF1A2lk
	DsgnnDLdCs6tufhwrSbrxspKBb912AAKA4wgZgmiAtdnA0dft639zPeJ5bOdM6md7RHKyay6Vb6
	35H30OXu8dj7pmS5dv5AU0HZg9NoYLwGXoufBKAPWw3Qq7GBJCZF3wlTWnZOFyRtk1MJCXX2+E=
X-Received: by 2002:a05:6000:29d3:b0:48b:3b4:1c8e with SMTP id ffacd0b85a97d-48dbaadebbdmr13615323f8f.20.1791838507920;
        Mon, 12 Oct 2026 13:55:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
Date: Mon, 12 Oct 2026 22:54:44 +0200
Message-ID: <20261012205447.2717801-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012205447.2717801-1-max.kellermann@ionos.com>
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for the following patch that adds tail caching.

For simplicity, hlist_nulls_del_init_rcu() is now always used, which
is also valid during rotation, because the entry is immediately
reinserted under `memcg_lru.lock`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..3d4bc12cf18e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4379,6 +4379,29 @@ enum {
 	MEMCG_LRU_YOUNG,
 };
 
+static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
+			      struct lru_gen_folio *lrugen,
+			      int gen, int bin, bool at_head)
+{
+	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
+
+	lockdep_assert_held(&memcg_lru->lock);
+
+	if (at_head)
+		hlist_nulls_add_head_rcu(&lrugen->list, head);
+	else
+		hlist_nulls_add_tail_rcu(&lrugen->list, head);
+}
+
+static void lru_gen_del_memcg(struct lru_gen_memcg *memcg_lru,
+			      struct lru_gen_folio *lrugen,
+			      int gen)
+{
+	lockdep_assert_held(&memcg_lru->lock);
+
+	hlist_nulls_del_init_rcu(&lrugen->list);
+}
+
 static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 {
 	int seg;
@@ -4409,12 +4432,9 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
-	hlist_nulls_del_rcu(&lruvec->lrugen.list);
-
-	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
-		hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-	else
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
+	lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
+	lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin,
+			  op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD);
 
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
@@ -4445,7 +4465,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		lruvec->lrugen.gen = gen;
 
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
+		lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen, bin, false);
 		pgdat->memcg_lru.nr_memcgs[gen]++;
 
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
@@ -4479,7 +4499,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
+		lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
-- 
2.47.3

