Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816862;
	b=mpzR3UxlICz8fkz8JWlXLI84X1H1hYu+QD9OXeDiMZUBXH3MOUFzxkslsDyaSBgHJycS
	 sdRpCDVCjDrBkemeluepLGsmPdHsmz7L+vsjiiMrK7lKjhWoSJRg6KSvKCObO9LBmeioL
	 PNSzd50G+sV8t4YtquHbqaYSwafFl9uPBaDM28VGR0oQXW7j3DG033MaMk19kQF7Act6S
	 qiE9z59ck6VUF7jdARMU7QH4LbgdJDbh9rQXCA5pmGdrWgxdvs5bRkvZJJdCkbEqbYCpX
	 Yn/z1RLEKDjkUsGPhVWEQEvMwHF9VNUpHqmRYW4oG+AnfR0qpnoDnaEe4pqdmTuD40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bKgCjEB/L7NjUFFwv+JmT6TUn26DjOLxcRu48u5oJDs=;
	b=BDxE/ljWb5/cy3RL1z/jOA5Cu+c6Z37ARoU9SLYy1XGIv8ooU73bP5OYlNsOOb72nzRP
	 UB+Ok8bJ0ghfyEB812ejT8kzXkGhc1Elr3LxxwMZ8YkKqTLi+54i3EYTBGQGjA+s1+9w5
	 dg5jN2Lh35EnlwU405VOEdghzzrJlLUBps3nR/ffPQHiwsH2BD0QD0xrCs006zlmwoWSG
	 aiOmLlu/pUj0Vg6mN0SOB/PeQQ9x8J+AgSxq7Deyx1W9oj2q06QtbW4xfJ1Y3PmHvNrp7
	 hza2GnE5b9SKYEiqvl5KpQcPgmL+yM+zKaqWgSBQJ1wl+5n6AD9paKZh19iMfYsKuIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=N30RaGbt;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F460606A8A2
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F460606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=N30RaGbt
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1244940f8f.2
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816860; x=1795421660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKgCjEB/L7NjUFFwv+JmT6TUn26DjOLxcRu48u5oJDs=;
        b=N30RaGbtBhTAcpWoQQYzskE7xXD6X0Yf9EzOSIZ57NGyRnFGSYnM8rPtwlYxX5qp3j
         xJkjeOEAQr4ViRwNh9twbq9bV9cG+Jv/8mbdarjEn3H3gaRtMvLwGkTJx8Q72uBFmaLz
         i6b7v0DDwS+Y04VmRRbigcYiq/LSYhTs5j+pFwl/J/7wVAusAQFlAcMGzF6ym+176pSs
         Oh3fuQo4weS6M3O/jEkc5f+DmLqGcH2wRmNiixGGvI3pH2+E7Tox3fr626LPul+ABLqG
         5+Wu+RNqvzp5b6fOK/3Z+KHE+nS5f4HqhGqstOmsmPLAm4mhxDbyD6t8I5/6wfOc9Hee
         S8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816860; x=1795421660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKgCjEB/L7NjUFFwv+JmT6TUn26DjOLxcRu48u5oJDs=;
        b=DIo5R2Sat+xnVsGNEw2iX3+rNYPT66FeCollSUESUgAYb+weZ941aatMLHnDmv2DeN
         va9vBdVNy5JpFWC+pUUZa+468pj5qkscwubR02u64ZmKBM4Ddxv18QkS8bsnqgYgX5m7
         TqsZKaVuKlWcz6wZJlzsBuktGuW5Mv/72GQHhExRnPe+YRJJckPLX5nN3sTBoEHWEO7V
         tVU7PCGJ+3L4z7aM3qM5tk4E4NHvUV5fs7/fRBCyNT/gqQt71PCuh6ALkTVV1NAnGR1W
         sq0XXBMqqjYsi+GZk8kxKqL/DLxdL7Fgso80WlwHkkrr1MRIUL6oKEaZuxvE84q3zVvk
         kAKg==
X-Forwarded-Encrypted: i=1; AL+hErHru2g5CIDAsoZ/Qjc4cydg6fY291XV5cKJSaJ6Xzstx23pfDkoBsu4djp+gX2gI7igkN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p+c0syt3mciptYTdSA2fcX4alzss0myXPEeXwxWlDMb7GvF6A
	DGADtOxi5gwovgIRA09Ea7pb99DK3GIBO3QJ/nw4mjWaAdRKWVmLBLnoPWGInEGMrsg=
X-Gm-Gg: AZFdTZdvk3EB6cV/3iFvU90Yn2AuzR+c+R9t7yqfWVValw+uO1vdU9u8KavXF4IB7F+
	4IMAvbBRCXPyxHQ8U4MNhX8SNOnKRLf6RNq8eeMBZfTaJQ0q+G/ErnlfSTPB9+Q68y6ZXM8GhVC
	uVNE0hK5TUIfprQddfwTLVDPBsZIb4CmUWU5kZR2FJJ4Rw8J4Te3vx9TFor91fHsKUJvUsq0dIV
	NuosAxgUjME8EtrR35v3DNqWtRNtYrBVPoo24c+oShzEZjZoUohuIOSu2ae2bME9vlVxLzEyUQc
	FrQEuA1HjQMPtwVitFByl65pxANTBkqUQ2Prhi3XvQ7CqnJ/bMGl6as4U73id/U3klHi4OGr0JJ
	cSlqePkDOw/NlLcBnEnBE4x20KgAixBgjA+9RI82kZOBpZjLoSz7mzFBk9/tmrAs1tZykpCq02b
	Bi24VcMnZg56EYnBUF6d6f7hPhQcI8XmxyQZZKEQzRxGh+15D0UxLy5JgO92xzbxsizuXYoTheE
	a9/tkQoAqq8CjgdR8EkXIiIFHA0MD/LCxFVXMGCE5S/hZLm5YO8nsS2XPfFqpamost4GTZf8Zz7
	P7sY/4DtabyaGYOmZNdhuRMyl3JKbe8GFyUyakmxYvJTcWqtGblICK3qYf+rrwCziFd7KpiWG6a
	v0mcJp/lBG9Un2a6M3pVh49vlh+Wa
X-Received: by 2002:a05:6000:22c1:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-49c6fc9e5bemr21910324f8f.4.1794816859538;
        Mon, 16 Nov 2026 00:14:19 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm22902289f8f.11.2026.11.16.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:14:19 -0800 (PST)
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
Subject: [PATCH v3 5/5] mm/mglru: reschedule between memcg reclaim attempts
Date: Mon, 16 Nov 2026 09:14:03 +0100
Message-ID: <20261116081403.216452-6-max.kellermann@ionos.com>
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

shrink_one() can return immediately for empty or protected memcgs, and
try_to_shrink_lruvec() can break out before reaching its
cond_resched().  A scan through many memcgs can repeatedly rotate
entries without giving other runnable tasks a scheduling opportunity.

Call cond_resched_tasks_rcu_qs() (as the existing shrink_lruvec() loop
does) after shrink_one(), while the memcg reference still pins the
cursor and before reacquiring the RCU read lock.  Also call it between
bins and nulls-marker retries, covering scans that skip every entry.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6b7c9f118e18..a0d76e5a10c0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5400,6 +5400,9 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
+	/* Yield between bins/retries that contain only skipped entries. */
+	cond_resched_tasks_rcu_qs();
+
 	op = 0;
 	memcg = NULL;
 
@@ -5430,6 +5433,14 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		op = shrink_one(lruvec, sc);
 
+		/*
+		 * Empty or protected memcgs can bypass the
+		 * rescheduling points in page reclaim.  The memcg
+		 * reference pins our cursor while we yield outside
+		 * the RCU read-side critical section.
+		 */
+		cond_resched_tasks_rcu_qs();
+
 		rcu_read_lock();
 
 		if (should_abort_scan(lruvec, sc))
-- 
2.53.0

