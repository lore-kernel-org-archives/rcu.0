Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705845;
	b=uH21+t/zVdi2rvIYVF1t4x54IJxqi5vV8HhtU8A2AYQcVDfRZGapYpBR66crjJR6BJSG
	 fuzttdP5YXOyC27c5WEadYYFnfjqbJa3O/vgHPSVewdbMVh1JQCA5swkrgeC22EhTFTeg
	 uxHS5aOGwS9pttaooOrwXjmbvTMIlJYrB/xzOSUK6A2qGvAJAI1XxYLs4SL3W97rgQgms
	 UK2/0kIisA/Ajn3BO025z95j55g36OPLhVBBN4zQ99/xHjPuifeh1lr4EsjooGIdcJNQX
	 ZGakRWu2JInwGUSx1DxKVn5JcOykfnvr6LP2pBnapkOa2msHtCCIbWOStKe5W0r09Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZHfL2fUcvaXyzQYSxt8K4LaojAdVAqjS++SzJlHZY3U=;
	b=DT3dSXA62DsKbIek4m9O+Pj17DNqSnkdKFkfElXl6Wz3ndF1ofUlfAlTd9iDLGOlQt8F
	 YEKVgtkUuaAuz1TtTwcBCzjdmmGkT1KQIc/X9mIxzhmS0rIxDHr/9cmtU667P6i742DqY
	 rct8U3uup+4LzNmqeZPY5IH8Ocz2k8NsA+6g3CtVTSghOkFiLHu9ymN1F/7TCdmp+uvrn
	 AzYvcTIjzkU9mKIjHfuHwWoQnD7MlQGhtKB5WDufNxYUCqhHdUlQzjTblMPk3VKdseSUu
	 Uf/kkP15BrPHDd7IO8BAYJCcb7/EHBS06ouXVBpZbH+NpO7IruIdNthJdQHKV998LWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=XUa0czEG;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8E6082BC6
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 11:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C8E6082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=XUa0czEG
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d1da913so475654f8f.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 03:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793705844; x=1794310644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHfL2fUcvaXyzQYSxt8K4LaojAdVAqjS++SzJlHZY3U=;
        b=XUa0czEGmvB7bB/pIM9MPwojihqqZFMYLJSiHfM5PkFK25MyqPZXDfrjT1/905+xyp
         1/dH3MZiFuYXgBqF8B1ZtuSFl1GPT0ZBj3hubrNnvUHeIoEzlb9OW6TdzArShuBEf9j2
         NWIZSP/In/VhxTrNcZqmXEh/doKDCSLd4nd/FBbRUPy6nss9XQBLW7eAyb2kcT7OrHSR
         KdcbGV69pcQfE667+V7EtrQcKA0Jv2qPc/jmwm/ylgBlT4CDbyLAsO7BDboEHFgEUnEp
         h5SmKXrLFyWLok8jZ+n0SEYTEUxK+Bxmr1tvto34Pbf0CXLz3km39MVQt5si3KbY1b+K
         misA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705844; x=1794310644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZHfL2fUcvaXyzQYSxt8K4LaojAdVAqjS++SzJlHZY3U=;
        b=ZQilS5iFFtvVU4zpEIKeMhIKo2c5+6OEsL+S3DaiCRxnS0+uGwDkPkozN9XKUGVumC
         3Z09IBplUANHwMH05AmakfPZza4bE17pI0/2aCP685dwS6aCc8xE9GNASrSQ/gZFwklZ
         uAOW8j1HO3SYNjiF3Ykl2BNVoyv7l8fFIHFfVYjCkKc6SGRdMVoLt5Tndq9gXG11PedQ
         /vwr5rM/yQ5l4voTYcJhONIbHNAqm+4dbBmPd5QiOaGPadJEpXMnVeOM+iw9bNUtK4/H
         g0obd4seRQbkjWE/wQht1wV939QnUwZceDy6annEzad6WmrI1uaw4OnvU6p/DnQTb+Yk
         9VpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMEZpkWN0hCxqiEAiUWvhF0Hj3GETOKl8d+a5At/6DVHTU5DMvK0vz0UjOX/bFsvjR90Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oiezHSWCuqdotRw43eHr/DWua5Nw1W6t2gaLdd8n85vfQBjJc
	9OnB+rAgtCYBphqYIAOdfTbXwgOnWyrwVwzp42mNq+mhu/MTkaIGq3O09r0ScYaV7P8=
X-Gm-Gg: AYBFou0/dJKfe+JeUyCx14W2RKf+s2pDWisyeUw/Fx+s6nambCjTvl6fBtdtjrYLwAj
	sa6286pUPokiY7Vr7JmqY6wnsWOaIzEWoMr58Xgzwc0H27rl7v4xeg8HpTUNpQ8IZr/UqD44mNU
	f1Dzx+42UpSHzHBSKQhqV+BTPobzUUI5j8+3gdo3RA5+CydwLDhRU4Yv31WBXFi1txJFzBbdCcg
	j4gtaalH03U03TGvQBeRKzBKIi61KnQIIePbSV+BtROHy/pp//YinPs4ebBic4G6vE+VWXDFHcU
	OGCUqgZrlcgkvfhalLWaOLY/kER276XPW4s1tnUDsqb1ooGE109VDG8RrU/TVn0kFk3sdrUoxCd
	ciZAMeHxzJ10HZI/hlmLysqiVUG4NGTRPXbzMoktIq+Ke+QMa+NRPxRwljm1PEgQK1O9WOLAvZt
	E7ZRvY0G8/uBODVR1T82KGq2vaNqmDLdLjGRetShJ8xL+3c/jNhKHhmRE/8C3VUG2eaDoNGYCTp
	DhWzKKWeXCaYVz+a6O0NmkyZHJFh9GFU8ZV7lM9P9Yc0f7NAQy+Lm/gCe369px9/ObAjAlUkP1e
	/DP/1H6J6+Jhk+WldifqJMujl6fNJuxDUXE7S0x1Q1jY5kcOxU67aTKbjpeticboxA+BDWFjKTD
	0wE4dVWlU24a16UERYEliVswZT8BThg==
X-Received: by 2002:adf:e011:0:10b0:48e:6c3f:f7b2 with SMTP id ffacd0b85a97d-48e6c3ff7d7mr24868143f8f.23.1793705843573;
        Tue, 03 Nov 2026 03:37:23 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm23000997f8f.28.2026.11.03.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:37:23 -0800 (PST)
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
Subject: [PATCH v2 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
Date: Tue,  3 Nov 2026 12:37:07 +0100
Message-ID: <20261103113711.1832834-3-max.kellermann@ionos.com>
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

Preparation for the following patch that adds tail caching.

For simplicity, hlist_nulls_del_init_rcu() is now always used, which
is also valid during rotation, because the entry is immediately
reinserted under `memcg_lru.lock`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce8..aed56d452881 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4556,6 +4556,29 @@ enum {
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
@@ -4584,12 +4607,9 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
-	hlist_nulls_del_rcu(&lruvec->lrugen.list);
-
-	if (op == MEMCG_LRU_OLD)
-		hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-	else
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
+	lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, old);
+	lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, new, bin,
+			  op == MEMCG_LRU_OLD);
 
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
@@ -4620,7 +4640,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		lruvec->lrugen.gen = gen;
 
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
+		lru_gen_add_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen, bin, false);
 		pgdat->memcg_lru.nr_memcgs[gen]++;
 
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
@@ -4654,7 +4674,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
+		lru_gen_del_memcg(&pgdat->memcg_lru, &lruvec->lrugen, gen);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
-- 
2.53.0

