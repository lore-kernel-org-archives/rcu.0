Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE3F4DCA
	for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838517; cv=none; b=TUI70w8c/d9eJ75UEFYvnnmK2hthnThPkTZq6/sZND52niabEmOpJwgLyHbN7m1ylDPNDNze25ZPODA0PzMe04NKGT+CXgvElIzHX0591dxfQk5M9X4tYmPAv8DmpXy9RLz4sec+NaBeE89xyKmul4zPHQ8WOZslh77beKAor20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838517; c=relaxed/simple;
	bh=FqN2Oq8OSwYSRwvXe8D/xIiMKP0E983eVJRjmt3gZoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kaq1XH4NBYJQp2KKLDkREjLkkxy6M8v/nnJ29ZUMTGHH9BQFqMxMW6i4dtUh4QQfc9B8LovuABNimv9kRA04bI0dwpeuCl1XJmvLPSANQMz1Jf2u7P3YAEtpEwCt/c7JNmH67tsCg8Xt0im0aCnsZpR29Rpq/je4DgKuAmfXVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Y6vdWMxy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Y6vdWMxy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso20158615e9.1
        for <rcu@vger.kernel.org>; Mon, 12 Oct 2026 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791838512; x=1792443312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+9SFNU2toYET7V9kae+GOxpqVvlHel3XOqT/2H6Lgo=;
        b=Y6vdWMxyzMa91z635rX9qqkyo6p5RIbEdqTtnwCpAcyviCUns/6dVoeZX75vsHTA4H
         olA6AvNVdUTpfGZA5+NYeQHzM0HWKaAGxNWKQj+rAOgQwS2/yPpBnG6yETGmviL9VWB8
         T4Q6apipkn82riAjHxJw7omCkqEidorQWcQ/9EfFlp5qrkid39dPhluDJrzMzFft6BEg
         dzgY8rDIMGQR8s/AL47xSk8gMoNsmymQrkMZ2t64ywgNsS/6sz5LbF27b85cDinFtWW3
         EqyeCaEt7wvEP6SdjZZvfKETFnmgmCRuJhKDYIwH+6PArxMjZfNMZYP1vBiThrNEbJEN
         bqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838512; x=1792443312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+9SFNU2toYET7V9kae+GOxpqVvlHel3XOqT/2H6Lgo=;
        b=zd4SAtM3IFg+wdhceJou873rq89SI5/y/T4IUBlXx52YgPR34kJNkSDifb+Nng8mvq
         KHes3DFzdNIegmwUc2AKn3/fos0t7gvqYEPVmW1XQcPRa7jVamjOx3mFAn5SdzBgdFDj
         Q/H/JHNf0eQ9Ouq6SSH/5DtPOrJOKoUT6HCSfKe0AWdrwvfg3mj2DSNoJW2klxKAQiiU
         NALnBOJ2zmQY+yBLnOn6rOfKeafaH5z4v+M0NsR82xc3T86ERHTaaYkmSI5MHvMTV9Pb
         E3IevMYXGNenP36YhZdx72lap59m7NMX/lvXVHm7sWcd0+gQr3iMPtONhMTugmugapYk
         /EhA==
X-Forwarded-Encrypted: i=1; AKwUvBwwiL0HHH6y3cQ0QMjNbmVcVKm+WV9UIwEPZm0QixvXAPjiZS2LE1eRDfpDqgzu0qy/y50=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvdRxbte5o5hpbeE6WLZdz0yboHseIcueanglAFbFkqAhSKYDW
	nDqyk67WqUT7YLRB7HMja4hrS2jW2nWBQBzgIpKZkLoWIJVq5VfZPTEDRzTRrvXd7WA=
X-Gm-Gg: AYBFou1pYzqHMQGNGqslNufxFipPXZqY/IqtNAG3/KFpm1OfwUCRYW9Yi5jDSlB6KG3
	vthZW3T5p50G67tECod/dEOQmeHEi9thE5OIhBk1qSbku1FersLymvw2eAQTBWU5bPZNxSUPogE
	m0VQG1He0A87TxsvlaCwUYBXCkQgh7JmDNS1ANrvNLWlJn0GJKmbZWUhSEARjN/Y44Q001Nsd1B
	+LOaMSBjq8FVXPf9JPVjkecBVEveH+pd/B6exD8gn6xB8YLpoavEamHCABG/IkGwPdS0xuz/RBn
	vOfIO4TTzU26y9wygb/ZPW3UXR0or9SgZGXrMhETpQNaHFgr5jzF9EIUpJn8b9xWtlHelTIroFA
	koQ4TEj0yY+Hs7V6SJ0P0xHZ1MaWIZlT8qgZ8xSSynaX05UAoO5LWN/lQduw11tI0tu7rte9hzO
	BpGn2aI8gP61OZX1ezC0l0eeN7RlYPoO3U9yMuAesoH+C5mNz+4wsz8AKJ32Bf+QQF+EituRgDl
	bNHixkfhpa6p32JK9OKZx+PsDAi7XsVn/vJA+182ePkv6ot4Okya9Cg1fr0l3at3oyv/qvb4xE=
X-Received: by 2002:a05:600c:3488:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a18e4b8028mr210808095e9.17.1791838512348;
        Mon, 12 Oct 2026 13:55:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm1895744f8f.0.2026.10.12.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:55:11 -0700 (PDT)
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
Subject: [PATCH 5/5] mm/mglru: reschedule between memcg reclaim attempts
Date: Mon, 12 Oct 2026 22:54:47 +0200
Message-ID: <20261012205447.2717801-6-max.kellermann@ionos.com>
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
index 922c59eb9629..c9d53546dc10 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5194,6 +5194,9 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
+	/* Yield between bins/retries that contain only skipped entries. */
+	cond_resched_tasks_rcu_qs();
+
 	op = 0;
 	memcg = NULL;
 
@@ -5224,6 +5227,14 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
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
2.47.3

