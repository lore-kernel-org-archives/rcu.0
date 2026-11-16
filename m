Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816860;
	b=kTwBHh0xOwjhQ6QcaCHeGbZ2fvd8Bd3pyFVYRwYIToOD9LsQdCDqIcOeDNvAclqlKncZ
	 e8c7jKnhwfN80uYpv+F0yk3yWvI5Y0wcIKDu5edvaI/P+V6vnsqVdjFx3gY7Z9avOmX1J
	 KjASd/bNWwS8ouOxdVD6SJlD0tOZiZl6abZgNZifT4bduWy97wcMUVuotcaxL25zaC09L
	 emHzcwsN6Z9cvmohbGNoyPhczeq9nNo4wHYdPXGQ2Mqrk3exUjqWkys46GZjLiHC6KBh+
	 L7ZIgWJEPt+e7mrhlcsLSG6IO5LVwX1e+VDCEmFA2Uzm81Ncf4NzRjgxyh/v+UM3pyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rgVoS+4faU3bxp5jftE1mXkf/VtghCyzl7UmbElyWsY=;
	b=bzOuLB7ymS1TE1wYtMRn+yywj9SM7mkpUIwXHysL1V9bEuQNcykY5WVCaT/GpVSQKtzK
	 qs+X3HrJ/0DzE2PwY1/VKAJs+ZpoDvgElV1jeDUHUESNlklMEJJYNc1QBhPvPph6t5bdk
	 zw0MJ1bT8ew/vCpZQ6wisjssaM9bUZZ8be6XByyBxzepvb9/qvoS9h5DIfS6AvDnkPRb5
	 1i6aa7tFdo29wpq0byi6ief/IZl/yWZsJhdEA6uh7Gn1z73AoCZ6o19x/6fKtldntfX0j
	 Z2hUEln1FDY4rMgafVcROg41cF7tt4Br4FFm6P8CB6fa4vGZaG9AatpVhds/Zjb1V1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=CTJTJ2ek;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F4606A889
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 332F4606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=CTJTJ2ek
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1416475f8f.2
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816858; x=1795421658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgVoS+4faU3bxp5jftE1mXkf/VtghCyzl7UmbElyWsY=;
        b=CTJTJ2ekl0YEb/6Z4dumwuhmbJOftlbsiG3oEW99VXkrBtp+wVph2NYJyy0ECmUE81
         dW2dTaR4FVJLIvDeXRBADvGy1KrMpFSuEh36KfzMnJ2vErpDGDAdfCJuvLc0AOZgq1Ra
         Z1t+akA+v3yKDfWiIVIAovQZXHHk7nMLrceDigUpfKm/hvfPuCqADshoPnvLnLf7R1wP
         EWZ8FqlOvA5eg72Npm2+acl70Y5w+8diZ46x3QqfA4tIZMa0XiWJSs8sSK1wIg0cYPfz
         u+SIu3/Gcpw9F7O5pjbogXdkn0KIK2Jo8o2Wis7DRyNzop+LKWdgtb8Iy3cwBvSGhock
         rMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816858; x=1795421658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgVoS+4faU3bxp5jftE1mXkf/VtghCyzl7UmbElyWsY=;
        b=IDvqqihKBuv3cG3PQ0QKRaafPHZ9xzNCuByM36qFI9Egx4Ro8ET10LPpDDQPSybFwx
         S6UEi/p9zA/912xfmkAvGnR3v7xvRWDm3o22loIjDk+mM70kxPNTbACC+pD+QY2GLolK
         p8C8BtTp1laVInKDcp7lCtBDrTpCf92O9WXAfhfjNwRpWAXjgZ785YMfMjbNE+YeEy7w
         qoHPprORNqyIk8Pk+ex6P6yUUDBTBeI3SdBUye6eNf76KU9yG2xvRAq1ujh92hCaLXNl
         AnZPxPz69u7BCgfK+xOvPDX+BgCbPFuRvujybUIx5/LV29UIUyL+pxinbPfvAj12qnPg
         mFCw==
X-Forwarded-Encrypted: i=1; AL+hErE5+JQmKIVKal4Ef02hehkjStAcxB5jw6nH9iip2RBSwh8GbKGwMniSIyV3EOb3P86JRWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CEmGRmLBEi12sxSObtr3vzrOGykRuaU3FrcZzvjwFj19na8bl
	S86lKZkWJn58DpCdc6YaxOU0eOXMLpcN+AiQLONseuSjXSabZ9J21bCA86KBJ2R8+WE=
X-Gm-Gg: AYBFou26/YQDGTqjQ0T7sbMCno1WPTkm9xJ+FuZ4XTwPjPPtS8B8nD9nDDr/1uyVxZz
	MpEm5w2zoUNjUWqDJ356gRU+SA+C8aJLq8IIJyr1S7+xyDIjtZ3LJY6EGVBZAVAW9FOlYGpTe0F
	N2ddWDczOdtFZDkls5E5DkaNn98upiegHhmJcy8etf0TWRFJxXNr0jEjE46CWvYtNB669q1K12i
	g7gMo8ZBNfWeLi8ndJaclodXJl2PeVgYXWQpVGFwfYuNheVeKggX4bIeaVXi+wKdrt2fNeFgDmb
	BlLlnjmnnfnxl5S6s7FjJclRZYqoBjF7F5SWBlRskz2pizCPKmrHlJ47GmZ8uEF8xPEhI/WFS4m
	WTQxXZszTEFDR/F7da01yIAN/9xvaxNdZuESazaoOEKqvTXcy/rYVGTnCLXAH3PMGrLuLIdQVdD
	FAXZOBMACm2QkSdCf3rCnl3Xh5vjXdB0fC3dqEhNtLX6kMXR8wRVgAOR5mjwp8UKgCkjKZPKQOb
	E7HYHPSs2q4z+G/pNOzrqKgE4+oB8Smr8v8RajkxoatXKfTDcqdzV/0XdnHzHXBGyMC5ZLIv0Og
	8Da8aewNrSkKy3vB0Frk6loO5EWczPAYz8P88YbkCCUfIS9HlEsS9JZ8kfuAJGWbj6xbYyTPbv8
	eIhsuD6exKrJWinu12mA1aAF+4GWk
X-Received: by 2002:a5d:64e4:0:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-49c7381b46cmr23102640f8f.25.1794816858364;
        Mon, 16 Nov 2026 00:14:18 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:18 -0800 (PST)
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
Subject: [PATCH v3 4/5] mm/mglru: avoid redundant rotations of young memcgs
Date: Mon, 16 Nov 2026 09:14:02 +0100
Message-ID: <20261116081403.216452-5-max.kellermann@ionos.com>
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

Concurrent reclaimers can request promotion after another reclaimer
has already moved a memcg into the young generation.  Requeueing it
into a random bin again adds list mutations without advancing the
old-generation scan.

Therefore, skip `MEMCG_LRU_YOUNG` when the memcg is already in the
default segment of the current young generation.

In my micro benchmark, this increases the request rate by 36% and
reduces the average duration of each write request by 27%.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7cfaeca9a605..6b7c9f118e18 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4472,7 +4472,6 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	int seg;
 	int old, new;
 	unsigned long flags;
-	int bin = get_random_u32_below(MEMCG_NR_BINS);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
 	spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);
@@ -4490,11 +4489,19 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	else
 		VM_WARN_ON_ONCE(true);
 
+	if (op == MEMCG_LRU_YOUNG && old == new && lruvec->lrugen.seg == seg)
+		/*
+		 * This memcg is already in the young generation and
+		 * reshuffling it again cannot help the scan of the
+		 * old generation.
+		 */
+		goto unlock;
+
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
 	lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
-	lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin);
+	lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, get_random_u32_below(MEMCG_NR_BINS));
 
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
@@ -4502,6 +4509,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
+unlock:
 	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
-- 
2.53.0

