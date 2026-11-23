Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441928;
	b=R3zGAH/9M6rPS2PeKei7tVv3aLu+f13RjsUvvxFwKlOML6DnadIGq4+v7B4gOsdqOja5
	 UJL+4DVEX/inMdiQbp6TSd0niHIrwecupSH9TqNeUsDDflcyqbo07X9urkOBntWmzDbkK
	 zvTt98utSVG+OiUBIquhJUflX2c8FpPNVy4ZwAiW6o4UqQAT/qxfBUhRuRYpsa5h3Jp+6
	 uv6b9F6ue4jiKQw9TOVQ9MlxmWCYY2Hh/NoTr/Ihq6oZCPPLfaS4Kn6aY6sUGYk5FOtiB
	 /Qnr4xvTZT2JEexnu2WKmX8SkWGTddtxdpd6FZafKtg+L/5e3lSZ2YtfSCKrtQoSUfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hN4yemycesflqKXqm8D59iST16TmA2LaImFy+AHGkgk=;
	b=5fQ1p2QYlsOqZPEKldnxXSlrp0giebqjm7tV1pi+iuA9WN0FgDB1K7NBkxcNw+28CQFU
	 mOqOgaB22zSVvcvAgvpiDFNxu1DLB9P6Wd0ExotnoTc7pO66D2OraSBjZnbAlNgZ57NYV
	 8lOukKqdcs8wTAIGT75H/min2oAQvMHCyAAgd5DuHmKFP5aUhwZdJfIHY+0cFBww48sUX
	 OUOY0Vr3e5sxgm+RRKKf4fJ2p0d+88AiOvrHQGMDOKe2UEHRV4D7M/+BrE2MtjaG5kICf
	 FWxrQ0ls7tNGe9ddWaPEfJhdeVaEoiDzq6y7mEuePgsErDNevdOAw/tz+R2pOuq/5fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MsJZrLgr;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA96606A33A
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA96606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MsJZrLgr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso23691395e9.1
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441926; x=1796046726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hN4yemycesflqKXqm8D59iST16TmA2LaImFy+AHGkgk=;
        b=MsJZrLgriwHBvCUgyx/HgJGaeMlf7GUlavPKqYfxDvpMwi5T4KdqIzXwTIkjN8luX4
         nPhNKfG7dGMCWtVwGpncivYKnt/64emIqSqMyIGpPxpGHGp5KqyC8uO32Vwyfk4+BAHO
         UXKN9yEeCggTFxDf7593gsu9s35kDeLm6g6JkaTyFEKKYRxkHGp88q5M/DdVy/R3mkil
         AiEmeUZOEss/TnEe3CtdobJF9Nm875lsGObmhuQj/Q5aMFHDtWbAd2+EoUCTpHlFYCie
         IVj/860Askd9FFi0wcg8DkBmnd4xLIvPqPwk45SV/Owyo0uzRepFR4TdGTtqD+2dgeVi
         gCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441926; x=1796046726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hN4yemycesflqKXqm8D59iST16TmA2LaImFy+AHGkgk=;
        b=m+WN9mUc2XR330pC/1AHAdtT5D6jkSaC7pI9ywJ/5+rBu94fhExScKyTxizo56WqZV
         uxuVNWNCna3+IBF+RdhvNLDOflGOVVniYMx/lJeMqBAbpOo4m+hxn+qsdHE9XzboC6e+
         JhEuF2C26gaqS5MKgIxepepF2rTZ4DvzQ3v7fo7DArdT6KsdhurkBOTzsjlp/sxMiekP
         qeOfGvwiKjUtr+yNC4ZiXRVLXJyO0h+Eu0pEBznGvzkHMdQ9rKZreEiLU1kvcQiUptVZ
         xhGOicQjWwNL8z/ugVMy0kjLN1HWcN1o0NdgSHYBIkledJBJkTN6YiSSMrpGkAABeQaq
         Q9nw==
X-Forwarded-Encrypted: i=1; AL+hErEGtHm4WtVFs5+YcH0klpnGbxC19Ja2QT3SgN3Q3bLziufp9rSbliQHVb2DxVtc6eC48Nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+SXVjc0Oj0BLsFpPVhpZWHcPIqP6xqt17M9rlwUv8wUpgcnXZ
	ID7Qo2iOjFEe0gc4yKVb2iZuSZ2zqNt1Lr+FcKlHxF3I4PYzpu5VTuJpLxJ71JvdiA8=
X-Gm-Gg: AZFdTZf9SY/Zrz+vb2ZP0iqs0csASRyop/AottaAVQVQuQhPrzuQgrFfwN/60gzaBa8
	MQWoGy8WnONfYk2LdcMo30QGH8T9zSR/tOakHYA3i6nZkuBLxTL/DVCvhavk9+USaZsKYVzBSjT
	1DvUiKgy68WdjYvsl3p5zZzMIX5750DYx/zI46GzC7LWLB4zQv8otsPkI1R0u/q045bD93rFMRW
	cxD+/XAxrENghQxnYMtQnPbrFbU3Ze78dyOaqq1RZgrt4JM8VDL9ccpaNpp0EwXcv5sP9EQ/Bhz
	duJE+5LEpDg/+geVql2PEK6BZvZKktuzzle+CFN4+A4LzBrtFbMMPyAqjONHhMDFmTViDI8VRr3
	tmjh+2QwJAIjevSBLFtIewU5Cf82mPneq+o9JPS6Y4QHgs2GPpXwi1q8mzgslfXC+2xYkHvDp1b
	4jpWFdtx24brYSf/JKJ2dztQHK0gGFXQoR78Fw03rd2W4CKWSDAWOyKzg2JMwlcCEDE8KYWUg6i
	F7/cVhWCCsnWY9+TC4kZkOsPVglCX3WPp2szck0uOh/zJc6gLd0q0EXWUw7rxCz/KYj6TmJXvQn
	S3QNsJTbagx306RfjoiG7+nTBr8gbM6yfvzPywMN3noUN8j1kZPBGSOgC2B3I+fEq+H1fcPjaQC
	Yi2G/tSTy7toPcj3ktoE1/D1Ma9VBXbQ=
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr277263185e9.29.1795441926279;
        Mon, 23 Nov 2026 05:52:06 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f1b7800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:7800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm169279215e9.5.2026.11.23.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:06 -0800 (PST)
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
Subject: [PATCH v4 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
Date: Mon, 23 Nov 2026 14:51:57 +0100
Message-ID: <20261123135200.4086519-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123135200.4086519-1-max.kellermann@ionos.com>
References: <20261123135200.4086519-1-max.kellermann@ionos.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bc7579d47f9b..1d63647e3710 100644
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

