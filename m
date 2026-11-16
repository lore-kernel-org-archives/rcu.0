Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816860;
	b=5im+YHBkv+qjRMpuRDgxBqW0xVHUHDIiUG+q80bcyuc72O3Tc6xalYJJm6bf53WGl0ee
	 xRJ921gt5jnzVlS94dGNtEci3Pj/GHBXlhclPTmIDMwuC+TsRUKA2Je2U1sMtIY7+XhQg
	 lOr1ebn9uZ1j0CrI+xRZDuZI4aF2nSBwFrAkvj99T9/FuF6HfXuCrXOrOxl8KMEx3RYt8
	 5RezwnaUTmbcjrbeNzlzYxvTv0xAbFILOLTPoPjvou8ADFpMx1HNOY9C/B0gogt8Khmj4
	 aTqHJXobUVaVBapJtRcKHHg14Kk3Gc/NWUdEpgtYN93BeppWAUFiSk5XoTa6ZNOjiKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bGXfKLiq/xapUarMj/h8JL1wFySyJOjdq/BDGf5JeCg=;
	b=AxbAQ+TFCTen9sbx70pYx2QuG/VM9wJ1I8KOiZafetmfyfQcSPY/YZMBB5LfW/Z5aV01
	 qcFG3zGwm2BHg4h/YTLTIIBNHXh+ZA728p0HeaPEsRQffQeqLlmoqc1FNRv49F0oxwtx8
	 GIoUP+bsU1xh5U/A7MW5Gdr24QUadEqj31IGydderD9S4alp8gJ1k20tX4HLoGjZ/JQrW
	 ADeifY6WTSayQLCXpXuqdNqQpXmU6tWZM6zFP5R+99W4HbYFM1zuqR8VfgDis54LKXHOQ
	 A3aUZ1uQ9R5JQmzoTjQiveodR9LxADhnLDfMgWNwWY61h98SjzRZHoXH1aiqt6GBWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="Ad/wiBtP";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85B606A89D
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED85B606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Ad/wiBtP
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4919a880834so1475447f8f.0
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816857; x=1795421657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGXfKLiq/xapUarMj/h8JL1wFySyJOjdq/BDGf5JeCg=;
        b=Ad/wiBtPiRE2BxRwg4Vjr8gvGCtQhZWoctymyHiXg+2qiaQKB9Iebc5iKQGFGzjKZm
         +DWWoakhc7OS/zi+JMPO0s6XvUUo3W44w9ch3dFJJLQ6Qagyml/B4A+pFIT7qrKApRJf
         ToMk9g9bEegmF4mre3QEtpRolOSJfO1DopqayZfM0DuvCawQaLQ+jLOqF4V8q7giLChP
         v4jqd1cjJVMs1Vy5c6x0l3aIv55jqkDypOGnPIXpG3ZUTNPhpkVmTP/y+VPxKPtpW6fY
         FXDqyEBF+/tkOJzMxfPNc/ntlJXGx3avCaA9SCEVk2UFyu/5KuV1aND1EC6FnTGAJNjO
         x+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816857; x=1795421657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGXfKLiq/xapUarMj/h8JL1wFySyJOjdq/BDGf5JeCg=;
        b=QTm8ypQ/RIQN0zNKQimgxaWZESZod/u5L+jMRCeJiL9rIneVbIvxqtC8e9BNtoXxXt
         zljnpNR2xjEtjoAtt47CWWJ651HMyq19R6suqFRNLbq7UzfjxrsBIOY+iY5ylr6h1ZVg
         FQZl79yNeuLeZkWpnqf2Bq2zjq6nJOycEUzu2gZZqarZ0TlGM73p1KoSroreExVabahb
         /jEXBtnjbzWVPqfZrGJO4pUjCz4TZu6oTzHU+vqC2sOAhVkgAphobTxZbG4etC3yW0Zl
         4LD2LOpjixZENR9ayJk10UZ+xh6bceTywQJd+HkxcnIygOrbt71wm2YX02jdLKhTfcb1
         BLbw==
X-Forwarded-Encrypted: i=1; AL+hErHrJqzQlrOvFEOHHtFWJXv8Si6akcz9wbbBnYGLS7HqXpBeJcPdqyoqv8K9BmaTCxnd0f4=@vger.kernel.org
X-Gm-Message-State: APuU4Z95a07MOh8HbfeEBfULy6RIO1e+1bbqdaXS9YkojinQkXuKD4xG
	j7kscYqJE1sl0zTQH9knaccNi/+Tva+NODvnZsHf6DWRM00u9JdVdnJT4+ytc9o9ltw=
X-Gm-Gg: AZFdTZf5tUw8/E7Du8O6azH9NH9gpG1l1vsIRbyLesrMxcI33zRxJ1cjafzjuagCIIw
	Nnx9tpTQ7XcXdjZ+TYRuzhsN3kXkom/0h842q0FS9OSlhzL3xQk6NgPqUlF2ogN+tvhi8RMUFg/
	pO8Q8tSFJgoAGMH8wYzvphXM56eEz8PH3iafidmA3LpuvuDPUuILQxlt9UFTtimCvmdD057l5WP
	DCtvcd7gHfw6TCyaJC52EUui8aoN2EZ0kkbIvJdH5Fc+dNZn+lnP6cxZT+GXPuxnSTGybxH841S
	2dGmhLws50OxCY9AaCSD9MZa6DfgKGcxKtRn5HV+dqKj1btoX5TMhRLKD4U32TOqOUL1FneLL91
	6SXLBlLG6iTGmXsMA/l6k6+zA6bLvhWKk3IDuCDD9E/diwNNmEUFXsb4UEYwzBeifmyvVZNMZ32
	0yReTEouiiX+pKpRQUby+84/VsYk1hgDzXIwY2ufty5A5VXBgTMxxgWN1PQp3J+EFSINDqFROh0
	8qk3QLe6S/AM/7FCvhncIOElvTuJUs2Q+FDx4wkjBlvRau7raD53RpZuJkk+BxHCkrCyDw+ieyb
	2yCF8GNh54i1hiCiI+nMoF0rS1TmufCFsdHYdOQlzLiV9LgQgOog330FHr0ljridTZpAgzEGrQZ
	3W+KoX9lLqi4RRT7cUOzuoQRuXcvuf323uld1mMbD9rmOv9NCYto=
X-Received: by 2002:a5d:5f56:0:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-49c70ed9069mr24699139f8f.14.1794816857186;
        Mon, 16 Nov 2026 00:14:17 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:16 -0800 (PST)
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
Subject: [PATCH v3 3/5] mm/mglru: cache the last memcg node, make tail insertion constant time
Date: Mon, 16 Nov 2026 09:14:01 +0100
Message-ID: <20261116081403.216452-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116081403.216452-1-max.kellermann@ionos.com>
References: <20261116081403.216452-1-max.kellermann@ionos.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
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

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/vmscan.c            | 24 ++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c161d563ce8f..8382fc86cf0d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -570,6 +570,8 @@ struct lru_gen_folio {
 	u8 gen;
 	/* the list segment this lru_gen_folio belongs to */
 	u8 seg;
+	/* the memcg bin, protected by memcg_lru.lock */
+	u8 bin;
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_node list;
 };
@@ -661,6 +663,8 @@ struct lru_gen_memcg {
 	unsigned long nr_memcgs[MEMCG_NR_GENS];
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_head	fifo[MEMCG_NR_GENS][MEMCG_NR_BINS];
+	/* last entry in each bin, or NULL if empty */
+	struct hlist_nulls_node *tail[MEMCG_NR_GENS][MEMCG_NR_BINS];
 	/* protects the above */
 	spinlock_t lock;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 49ef29a86553..7cfaeca9a605 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4434,18 +4434,36 @@ static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
 			      int gen, int bin)
 {
 	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
+	struct hlist_nulls_node *last = memcg_lru->tail[gen][bin];
 
 	lockdep_assert_held(&memcg_lru->lock);
 
-	hlist_nulls_add_tail_rcu(&lrugen->list, head);
+	lrugen->bin = bin;
+
+	if (!last)
+		hlist_nulls_add_head_rcu(&lrugen->list, head);
+	else
+		hlist_nulls_add_behind_last_rcu(&lrugen->list, last);
+
+	memcg_lru->tail[gen][bin] = &lrugen->list;
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
 
@@ -6106,8 +6124,10 @@ void lru_gen_init_pgdat(struct pglist_data *pgdat)
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
2.53.0

