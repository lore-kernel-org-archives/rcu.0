Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816858;
	b=DJ8JU422B+7jdZ+3XDKgwppn1cLI5gJiVjV2wzC+y4U0EO0n4QBcXO8lXxmsgPJvC0vU
	 YiiXZBcnD97cVRGCQsZOQsL9Y0VISQaEEAMyaWfpXvnJy3s7Jw1YYKCIECSumONooOw1I
	 ViAKyomvfT0qmWBNZCA5IOnIYMvrvjm9kkNBQASB8EXdrMvFkb05sPgjA8NcnUEI1kKTC
	 y4uK57vEujVckq3thyny4sauIoRrkqZxIdsBOqP8q7rqjqMHToFTzrJj3VsY6AZfFmljr
	 eP6giIcj0FdXxfSXVJL/iWQ0U07gkc2FOahCUfrZ1jr70IGxnIYDnkLJHZ0K28BkXkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z66nA7na/nCTcTXEktzwqJyV65V9uawjJcIXBSwcrSg=;
	b=1edikFouv0ltpgNeH+3zyuVFlh+bv1tFMZ8tHsl6lCbT/6IE58Eq4efqUIuYU6jV1nPS
	 GRWSwGnbRzbGEc406OO9jlruF3YPy9pfVbG1BEjizt2rwrIbQIePTh7jBhy9DsaeAkwNS
	 hYMKMvYW3jymsVQkOlsfwXptgIaok1wFUtwRlASDDFN8l+FCf8W/SfYG4fxmGcGeihiL6
	 346cPQXGTrFdQbd8N66+M0kfZSwuY96kkAXN1ZXd2EbH5yFTSaIkbFwll9043Pr+gp+uS
	 WfSDyr+KjEQqJYJ441Fz1Uy4j5z0cz3dVc6I+pumkcZBN51iV2BpQxNtwgmt/9W5JCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=CYSYAxQ8;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE2606A31C
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=CYSYAxQ8
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490f38e9688so2156637f8f.0
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816856; x=1795421656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z66nA7na/nCTcTXEktzwqJyV65V9uawjJcIXBSwcrSg=;
        b=CYSYAxQ8QNlj2VlXXSB6rwSNPfBjZQu8cKrmWHvHbpJ4f/i7/0P3tyMmUsFs0u/gb/
         BYqN613nzQf5V4xItSG+Kn9QCXBqRl4E+epCqR6lEHuAvb6d7jhSbPdTs0OPx7ZPNErI
         6P6LxXFlfp70soNuEiN62P3i0yjo6dEnIGtbWFBcPyzJWslGvOl04pX+0mtySszbIsiz
         hsw39t0ENBTQqnCL3YYW5XXS6QyKfoDxfO1yk3JaFX2KsIhHcLa89ekYaAgc45gKfYK4
         H3n4ckZZGwwz2o2CrgSbkOFyQIf8obDzCCAC9AabCrh3C3UTximAAmN68k6Laq7dBOGw
         hYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816856; x=1795421656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z66nA7na/nCTcTXEktzwqJyV65V9uawjJcIXBSwcrSg=;
        b=rO4jqZcJ6C3iJ8BzWTBnkDAFtQbj7JiD60VQCL6WCDNcvWwNerTXQdTAFFDrdIky9f
         0tMbZSQvJ8EkwDBMByswMQyrLm/+Qu+9orrvD7I7KH2T6ZUYDVEfZCW9YuFw21XhxxVZ
         tTf0iFBeVaoOp4iJwzdpKkbH+cHhLs6S3eCOHroPY1PT0+7TrZJW/fBV17gfT25qM+Cx
         r79josczjIvU4GNTNh+9wFbDV2cOQEmOOORZoKfMXmHNoXW+5UcnyixZ33d8vD7Vr9cs
         iWh5tqq+riP90Q2HC3UMSbRQdWnu/6osGohuaSLuHd80p6tvZbHEUn8z9/MtikpY9QzT
         mJvQ==
X-Forwarded-Encrypted: i=1; AL+hErFZ//Gr4SjTaH/e8Xcg5rMHWBpo0D7AhGZI/dUrqZvy78hZq/bL08XjH/VNmyxJSvE04WQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4BTjDGcS4m4E4xPPaZq5qwpjBwvSUZ0RdQ61GbZJRZak6BGJj
	4nsCUaSA5/bvof2Rz5sD+ZgkEWG97wgcYK3q9hBU62mm8gGEo+ZjEzxgNFLOXLyW5So=
X-Gm-Gg: AYBFou0PiN8hkVl8QSaMmr6uIbl5pCosfuJH1hiyJlo2fuYz20ChmO6YfCv/K1oYl1+
	niriz4cxiCrweE2j/DFfZwmIhn0puRmIw948n+wPZcbSFl6D68l2gMuWwPCYD4q164QJUYanW+W
	MIctm/FdoPnHvXqKWemOIPCv5n2AKNip3kXZ1em84mNG0u7QWeo6A6yUlbjMpEqtts48SztQucw
	B694kXBHxC2+6IR5fpb+QL25t4qZ19VS7uBP6CY8bRodkEmd34XNZc9gImI5JpAa+dAogifAh3s
	eJGXFgcZTemiW4yzn+QUbzbZVytOphLNOUxm2VVCgyg6R4W2don0HZImPw2IFshpFGoQfgNt2ej
	pLUttX3lBOHmVzHb880VX1ITmUT5RH7juw1eaud8oFoxC3dIO0in5ZhDpscPzvDpSWDQuRI1wIJ
	atphQ5+1NBcpEZP27WT8BovItCUlxd4yeAmc+3FKdLkER14SQ9trQXL4UOJ+jhhDdhIZDwQ+Gr/
	Qu9lV81owTirCXHQIDcf6w8Mbm77Zrd5/+Mj7biqZUc9xFTnhKGvZ8pF+Zp+ks40naPuopM7k+F
	FjOBstVpqyXYH8YlKQmdIJwLRLLR7/vowhzwwtryrEirbq5U9toK15cHj9r74+j1Tjs4C5Rel9R
	6br31ekI0BmSXZibxJ4+8NZwaCN1whg==
X-Received: by 2002:a05:6000:2402:b0:498:6171:c074 with SMTP id ffacd0b85a97d-49afe168694mr29470489f8f.3.1794816855867;
        Mon, 16 Nov 2026 00:14:15 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:15 -0800 (PST)
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
Subject: [PATCH v3 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
Date: Mon, 16 Nov 2026 09:14:00 +0100
Message-ID: <20261116081403.216452-3-max.kellermann@ionos.com>
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

Preparation for the following patch that adds tail caching.

For simplicity, hlist_nulls_del_init_rcu() is now always used, which
is also valid during rotation, because the entry is immediately
reinserted under `memcg_lru.lock`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e772eacff3f8..49ef29a86553 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4429,6 +4429,26 @@ enum {
 	MEMCG_LRU_YOUNG,
 };
 
+static void lru_gen_add_memcg(struct lru_gen_memcg *memcg_lru,
+			      struct lru_gen_folio *lrugen,
+			      int gen, int bin)
+{
+	struct hlist_nulls_head *head = &memcg_lru->fifo[gen][bin];
+
+	lockdep_assert_held(&memcg_lru->lock);
+
+	hlist_nulls_add_tail_rcu(&lrugen->list, head);
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
@@ -4455,8 +4475,8 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
-	hlist_nulls_del_rcu(&lruvec->lrugen.list);
-	hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
+	lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
+	lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin);
 
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
@@ -4487,7 +4507,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		lruvec->lrugen.gen = gen;
 
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
+		lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen, bin);
 		pgdat->memcg_lru.nr_memcgs[gen]++;
 
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
@@ -4510,7 +4530,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
+		lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
-- 
2.53.0

