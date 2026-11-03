Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705844;
	b=v+pnsAuHtMYv+Vq8h2UdodsoidxjUNOF7VxLFXCGlYP0a1rRM7JtnhOkTcUEC+GM9T2P
	 DlIGFxaqwzVaF1ZzFh3qTqjZWi6uX3SuMfK9KyFoYirqSNgv4ck0czqSZA6lbwOzZjKlj
	 57fStj4AUHPvPKfApi1kZFUUiNBMIbTUcFJ19iBioTLRCzK9o73zsmUdtekcOsz6jvjgf
	 4QHhOj+Lalug7VvMoNmmzWgqDroWTODlwqG/u0NOI5ActjMD70VSu5lrUfksU27ySnrJt
	 gEet5tSGZd3kU44KeN4eFHNgfLnuZt4Qze4h0lWsyoc4SmA8b0ZdEgUCnv3Ovmd1nfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0bwrQXRz1nV2S/H83UR+VWVa5zJUqJhABatAjcFjujw=;
	b=UOf1ktfQ68piDGOw9urkwpgkq6PKoMwLm3J6rH/plnr6+xZCh6jqiOjdXcCzLbvt2/gk
	 pst9Ru9kWWy/Z/MRqWO4JgTYP0VVgUo+NnjIRCgKsDNWzYEs6eh2R6SiWu0El8zSV0bwH
	 Oluh+KeQRs0imE+rhVS5BQGJ5NYQ2okCnmJxqoEWAVouKLYRIeharUlax82JFVk2ogiS0
	 Bz7ovyk2C5FEUwOOloOJJjUbWBgZkuaAs7LSnKHL/dChJVHm2X1Ivs6SbQ+jhskTTqkiY
	 Sdh3rnaDNUEo9phh1khsLZDTeAOdlOuLxfVaus9LU1YhkNR+cXKFUfvIs5ZE0T9MToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Op1fG3nb;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09396082BC6
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 11:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09396082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Op1fG3nb
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so30573925e9.0
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793705842; x=1794310642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bwrQXRz1nV2S/H83UR+VWVa5zJUqJhABatAjcFjujw=;
        b=Op1fG3nbG/RdYrz9q5mhMvv1lShzStkFtX9ySl30ncpCUWzvrwAc2vodSKoukMeDX0
         rBH0VPll5+OIEbLOkYAupsayDFJ0cNZRURefAPC3UdkqVsY4RaUqRhnfbz6S8WhyKqeO
         Q+YQM4SONCXqQruwrARZ094Dot/WVIe4bxgzFJI2OmRJSDbRg34N+512RnMYiwELgjpj
         Ki/t1yy0CSlMnHvF3mSXImL3SYXzxOLq4V76yG52EtEy15tHfGu6AUJIe84jB4NUQlgm
         8f6iTzSHXAhLzW7Z2F1sugQe2UJIfY/SX7bqqp/SLk6NSpuhWXiw0+Gln5IS++mWv0Uz
         ZPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705842; x=1794310642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bwrQXRz1nV2S/H83UR+VWVa5zJUqJhABatAjcFjujw=;
        b=nqjTtUP9Rb45QHyYaPtdm1x0t0Xsue4zYK8gRBWw4RHeCPFDUovWpwvs6Nxyt94Xjw
         9OfvaZLVNNn264ZPkctWHLUClcZz6TaODEhrzobDzSrH3S6kkF7XtryLyCMwletWIjKb
         SX/mHf85kuhsqow59EG6SeEUWHNxU+Qpw97Z3mvCoLGiKCXDmpiOhH4BLUEvZzdivnVN
         18CWpWd2/GVeR/BQUnwVLsLpDEV0rskU9ra/lu5dbVTnqcq3URdheR82bUu0YEo3+iBB
         nCGVVJSMXawkLcZzGH/se525LCdKk8PC6ICbV2tGys1KmdpIHsGOWHR+zAdsivYxFYBA
         d0xA==
X-Forwarded-Encrypted: i=1; AKwUvByzk6AR3ovDdNSvyA3ECIiG6wR0OwjPUKsQyFl3iiUN8raFkfjp7x5/2TZYak66ySw4em4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VduXFSlgaMSxptitJomKA++Wr/gyI/fDxJQWg+S1yzN0hiAMa
	bpVqDM2Pj8jkbYiORFTVgVURbxhCc/MLJ9QYBnaxRjv9jNtwPg/RoVkLtcvTzaAB3A4=
X-Gm-Gg: AYBFou3Nhfa6RGqzGmRXZzyPpTSsfhiqbRFUXWwfN2um6XN669bg6vJBHE0w1xzDhiN
	JHmJj3ELX4UuMTK8lGnRNQIKuaTKFA8R0RqZl+6aImjFepZsYlxFwsuKKoH7D41mImdARkBZdpC
	W0SqKuosc216MOAjTMB5Bei02VCrQNHBV57z8iOx40NMlELpscFjL1XCcZE+m0Ie8TRxsMKSL92
	cvmMpsJRl5InmziLtQLp/qct5+051KbMUT6JoQ4FvONYDD/99YbPHv4F91XXGa7c7StV2XM+8fM
	8L6rq8E3qcXBjXOf744QPcmMYLj1KF5wGHCbZd+kAaP7Pnt+FUGPAa8287LUIzz8p9FEXAgULNd
	2XQWA77QLt0dhDvAkwTNjbbbup7bz8G6pfktW0JVWsU8Lv2y791ejBEYQhe9Kc0L4aH9DKjmNS2
	XdKvhzNZJyCvVMcmMbe32vjCa/hYIpyxr6D8CvNNAjN8+4b3OinDH/nrAoqLn0CUhO+ejOfoRE0
	AJauxbXBwsXadr5Y//HCGbZIznMTBUyRX689ZfKZLBK+EHaIJnUzd4d3xb9L883VsJJHAGTWudi
	Pd22o4amwExVf446uw0anJTc2Ja3ud2ltpkF1ZMs+O1Y4U25OupgJo4r3BHkDqh86l/vm+9FxVM
	U+8W7S8YeaJ7ksrIaxqwFW5o+ba+dOQ==
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4ac185bc336mr278107635e9.18.1793705842252;
        Tue, 03 Nov 2026 03:37:22 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm23000997f8f.28.2026.11.03.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:37:21 -0800 (PST)
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
Subject: [PATCH v2 1/5] include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
Date: Tue,  3 Nov 2026 12:37:06 +0100
Message-ID: <20261103113711.1832834-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103113711.1832834-1-max.kellermann@ionos.com>
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
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

Move some code from hlist_nulls_add_tail_rcu() to the new function
hlist_nulls_add_behind_rcu() for callers that already know the last
node of an `hlist_nulls` list, to allow constant-time appends.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/rculist_nulls.h | 36 +++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index a97c3bcb1656..054e477dd093 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -115,6 +115,33 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 		WRITE_ONCE(first->pprev, &n->next);
 }
 
+/**
+ * hlist_nulls_add_behind_rcu - append after the last list entry
+ * @n: the new element to add to the hash list.
+ * @last: the last element in the list.
+ *
+ * Adds the specified element after @last while permitting racing RCU
+ * traversals.  @last must be the last list entry, with its next
+ * pointer holding the terminating nulls marker.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_nulls_add_head_rcu()
+ * or hlist_nulls_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.  Regardless of the type of CPU, the
+ * list-traversal primitive must be guarded by rcu_read_lock().
+ */
+static inline void hlist_nulls_add_behind_rcu(struct hlist_nulls_node *n,
+					      struct hlist_nulls_node *last)
+{
+	WRITE_ONCE(n->next, last->next);
+	WRITE_ONCE(n->pprev, &last->next);
+	rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
+}
+
 /**
  * hlist_nulls_add_tail_rcu
  * @n: the element to add to the hash list.
@@ -143,13 +170,10 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	for (i = h->first; !is_a_nulls(i); i = i->next)
 		last = i;
 
-	if (last) {
-		WRITE_ONCE(n->next, last->next);
-		WRITE_ONCE(n->pprev, &last->next);
-		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
-	} else {
+	if (last)
+		hlist_nulls_add_behind_rcu(n, last);
+	else
 		hlist_nulls_add_head_rcu(n, h);
-	}
 }
 
 /* after that hlist_nulls_del will work */
-- 
2.53.0

