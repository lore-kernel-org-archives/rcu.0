Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F32262FF3
	for <rcu@vger.kernel.org>; Fri, 10 Oct 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079049; cv=none; b=Vuj0dvaaoBK3en4uzZqm91p2Vj+6UYROC3nD6LiP7akIglEj1lRZWPDPTuDdNzHJnpA64kHZbuyvZADKh2jLvj8sG8wl2ZoW2VKjP94QTHoIAJlDYyMmWXN7JZTrA2QoAO8BGRvz1kPw7WVOSkExtiKhI1Fphx/P4qkaUkI7/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079049; c=relaxed/simple;
	bh=IW99f50/LMtmQIKTFyZWDFUg8qpk62xemqeeesU707Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT+nTdITqjl2Gekh7LCNP0KzuPeK/unErCMIYm2gclyAsufZ/K8sx6bMXjw9Uo1ZlrySJ/5Nwy67SZC2gdn5ob6tU+1p1VwqHIiWjXRNGvfohmLIPBwS2h9n+iPUBuR74B93EMctBfBB3in2oxiOBoD0ldXs2jsggJktfH6NLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gKFjMWU2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gKFjMWU2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760079044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sc5MDeXEWaIz3lsKlW82yYHnmHgjYpsf+czrnB0INjU=;
	b=gKFjMWU2rnOvbArNyQi9whOTtxtktUmZl07TSGsgDW4hDK+7plac51AQ+QwoEN6nUsqBqj
	bSjBjUw2MGsgAV+V6XUe7pSGj3jW5W4JMzg9Ff108TA9Qy3uz404NVcBjbLlttOWjA5A88
	T8JQrMKTiqDuPvI7M4p0jfcf6jCmoU8=
From: xuanqiang.luo@linux.dev
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com
Cc: rcu@vger.kernel.org,
	edumazet@google.com,
	mmpgouride@gmail.com,
	fw@strlen.de,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH v1] rcu: use WRITE_ONCE() for ->next and ->pprev of hlist_nulls
Date: Fri, 10 Oct 2025 14:49:10 +0800
Message-Id: <20251010064910.605653-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

In rculist_nulls.h we can still see ordinary assignments to ->pprev and
->next of hlist_nulls.

As noted in the two patches below:
commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
rculist_nulls")
commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
hlist_nulls")

We should use WRITE_ONCE().

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/linux/rculist_nulls.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..d5a656cc4c6a 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 
 	if (last) {
 		WRITE_ONCE(n->next, last->next);
-		n->pprev = &last->next;
+		WRITE_ONCE(n->pprev, &last->next);
 		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
 		hlist_nulls_add_head_rcu(n, h);
@@ -148,8 +148,8 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 /* after that hlist_nulls_del will work */
 static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 {
-	n->pprev = &n->next;
-	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
+	WRITE_ONCE(n->pprev, &n->next);
+	WRITE_ONCE(n->next, (struct hlist_nulls_node *)NULLS_MARKER(NULL));
 }
 
 /**
-- 
2.25.1

