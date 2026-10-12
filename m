Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F748440638
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838516; cv=none; b=ULlNPjhpsBmccqz0BhausrFWbllSHKostNYrWhKgdqpyUo/n2UWMDKaIUzxFfVceN4k288Mo96sm/PRvVz+OwF2Wlpw+etdCQdfmSmcmiRia60vhJRQJWov3wJUOB7DI0m14fxPbLEUoGFhJUBWafN2nkd+03wq5NWJ30yNKbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838516; c=relaxed/simple;
	bh=vk/ZLEuicmBlCrG96aV3h1S4Bcfxwl2bjRehHbc5fu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrLR5UeXgu2xNAtefLJNFfaS9LAuhRJ8Iqm0469rsDv75wsNQkZfTZjIEbtiEJsUR3kU1SSLRxbqQj7+lJrgYg260ZdBVOl/mIY6V7jOSKGgmTj8Ak68VeQB0N1RbkJ/qtiYq0LPhAZ+9XzA9jEjqpTopaO84uBIsGtGBxq3ujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=A12gOd34; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="A12gOd34"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1326169f8f.3
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838509; x=1792443309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cM4+BdXHxixpIoH9wpDKozsr43Lr0DrRbvDrH1ZEVGw=;
        b=A12gOd3485uFa/1lkxuIwNr7/hOnxNGDA74L0sDvNK+TANWK6Rqr1k9llJ1k+0l9ta
         l6gSb4/qwqdqmneHsU/8ifdZ55IUZc7BJiMn65nS4rB6qvvFmNHOE71phOgsGscogi89
         17RFocGEgNt7tWtNbF1QGM3c/hVb1jPtlv1uhTXalpQL0l3cdL0qwmeAVXUzQORWCGps
         vLpXkiEGkrFVoI+U30dcQDtmZxfo7ItHWSKOntPy6ilS+DW1KEyG+FDzKDFrFmC2xIjr
         oiiDDAuB/IBGA8h//uqhGupqWWJpzi2i9rRgsdwAojIlkNW0dUIBVRsRk1NhSFlUHj4K
         8FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838509; x=1792443309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cM4+BdXHxixpIoH9wpDKozsr43Lr0DrRbvDrH1ZEVGw=;
        b=Cih59dgKrNEk+OOOoNimnuaJw7g71uvGrF+lu4gokbIj6VjjewLpJHrP7i5/oqkZsz
         XC4g0pY8ehhxuxqmGQO681y53ZgaTtS5ebAJ2EXtsoJPWqY/MpMTtETbXTy2Jyv7qQ8e
         C54xS5LS8sxXGJahUNBWFOXJ7iiZW2LgyaWs2TAd2aeo9kbLQ3Is23/jhRNINYEag5uB
         kUYFQPrQ3TrFM2nH6Qi9PLs8iMOUd/4jypObV1GW1IGpJPo4f9zCpVzQyeLZmUNao7xg
         VQ0bf7+uDmQ4Q6iThDVJLs9IWE8uEWU4AxjriiVq1K4Y1vuO2MEvTzQXil0LOub2wTp+
         fjVw==
X-Forwarded-Encrypted: i=1; AKwUvBwxvEL1UAl11Nv3JbB8kiLQwNojFvAK8+bkRpEI39gBaQnoTkgIHFdl895ez9bisqTV/c8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNnzTqNwFEzvvBsptz+2C1kCRJLTVkJWCKShmf1a/DO3sAEVmm
	LNZ0Zye2+6P3IGXzFQc0Xy+kA4R2meWnDxfcjBR2GBjf7QIFwbR60nud5K7/byI5OoY=
X-Gm-Gg: AYBFou1xtMI3aah9u4gJLEHWNq/RaJShKexDtMTZ46cRSC6SQvEu7ah0W760ro2UKQb
	MxabOB1SSgnXih+CS2vIixjqphl7Zalsgj+8/yQwPskjDCVy6rPQvKE5ptrFkDwh+Zt8TRAZiur
	e9PmQ21oB0SzHeVKIhM69vWbLI0llM7bOD68SgQXdjywesyEjcK54KtmVe1Cxq5Tbi7h4vDH9Kl
	EKDxVpK//qxLVuEFfzMPHn48BPgNtaT7VBbWR5a7kwxtD6lo/R6+mcdMvYiajNnDrl7fy0XJ5S8
	Wj7ZY/jAJ8I+TIHQVFct0uw1grjgzKLYVCGS3FMJ2wAZEaon8y4R5S1H1BM7PmuboqqSSkhKMCN
	u2vSrg2soFJQyRqXLHpfkXf1D7yzvht8CEb5a03cSRvUUfncK/1KfPnx44l5Eg6lLqXVh54SaEw
	MgAXP/2rNUwNHe2pjF3zcm5/+hxQpvIRxrfsDYM/Fr3vamdBfII4vmHmDJhcTlpCOWa7NjntWHs
	BRauTi16iNrVgRdcVE9vPnwiIO3ET+z1WTImdryHQ+CAAr6J1PyRhhaV1SAAIaULUj0zi0RQBk=
X-Received: by 2002:a05:6000:2481:b0:48a:f318:ac02 with SMTP id ffacd0b85a97d-48dba9bdbaemr22343002f8f.19.1791838509192;
        Mon, 12 Oct 2026 13:55:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:08 -0700 (PDT)
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
Subject: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail insertion constant time
Date: Mon, 12 Oct 2026 22:54:45 +0200
Message-ID: <20261012205447.2717801-4-max.kellermann@ionos.com>
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

Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu()
which walks the destination bin to find its tail while holding
`memcg_lru.lock` with interrupts disabled.  With thousands of cgroups,
this takes a long time and causes severe lock contention.

Cache a pointer to each bin's last node, making tail insertion O(1).
This requires remembering the bin number (but the new struct field
occupies a hole, so it does not grow).

In a micro benchmark that creates 1500 cgroups and repeatedly writes
`1024M swappiness=0` to `memory.reclaim` in 8 threads, the request
rate increases by a factor of 9.5 and the average duration of each
write request is reduced by 89%.

All writes return EAGAIN in both runs; the benchmark measures the cost
of reclaim attempts that cannot meet their requested target, not
reclaimed throughput.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/vmscan.c            | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 94f9c3ff5416..9c1c1f153d1f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -586,6 +586,8 @@ struct lru_gen_folio {
 	u8 gen;
 	/* the list segment this lru_gen_folio belongs to */
 	u8 seg;
+	/* the memcg bin, protected by memcg_lru.lock */
+	u8 bin;
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_node list;
 };
@@ -683,6 +685,8 @@ struct lru_gen_memcg {
 	unsigned long nr_memcgs[MEMCG_NR_GENS];
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_head	fifo[MEMCG_NR_GENS][MEMCG_NR_BINS];
+	/* last entry in each bin, or NULL if empty */
+	struct hlist_nulls_node *tail[MEMCG_NR_GENS][MEMCG_NR_BINS];
 	/* protects the above */
 	spinlock_t lock;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3d4bc12cf18e..69976df5d537 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4384,21 +4384,37 @@ static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
 			      int gen, int bin, bool at_head)
 {
 	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
+	struct hlist_nulls_node *last = memcg_lru->tail[gen][bin];
 
 	lockdep_assert_held(&memcg_lru->lock);
 
-	if (at_head)
+	lrugen->bin = bin;
+
+	if (at_head || !last)
 		hlist_nulls_add_head_rcu(&lrugen->list, head);
 	else
-		hlist_nulls_add_tail_rcu(&lrugen->list, head);
+		hlist_nulls_add_behind_rcu(&lrugen->list, last);
+
+	if (!at_head || !last)
+		memcg_lru->tail[gen][bin] = &lrugen->list;
 }
 
 static void lru_gen_del_memcg(struct lru_gen_memcg *memcg_lru,
 			      struct lru_gen_folio *lrugen,
 			      int gen)
 {
+	const int bin = lrugen->bin;
+	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
+
 	lockdep_assert_held(&memcg_lru->lock);
 
+	/* pprev points to head->first for the only entry, otherwise prev->next. */
+	if (memcg_lru->tail[gen][bin] == &lrugen->list)
+		memcg_lru->tail[gen][bin] = lrugen->list.pprev == &head->first
+			? NULL
+			: container_of(lrugen->list.pprev, struct hlist_nulls_node, next);
+
+	/* Keep next intact for readers that still hold this entry. */
 	hlist_nulls_del_init_rcu(&lrugen->list);
 }
 
@@ -5883,8 +5899,10 @@ void lru_gen_init_pgdat(struct pglist_data *pgdat)
 	spin_lock_init(&pgdat->memcg_lru.lock);
 
 	for (i = 0; i < MEMCG_NR_GENS; i++) {
-		for (j = 0; j < MEMCG_NR_BINS; j++)
+		for (j = 0; j < MEMCG_NR_BINS; j++) {
 			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
+			pgdat->memcg_lru.tail[i][j] = NULL;
+		}
 	}
 }
 
-- 
2.47.3

