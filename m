Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309718CC13;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117551; cv=none; b=r4h0rkE05hLpLU9nJxIY/AALA72HheuubmqWOfzU4zyL962gxwWVosF1xkRpTXCW2tC7BG2NqSF5Ar2mdPT5omr7pSKL+RCoQtTBSqu2MLh+rHwSuZs7vBgIlqfqlg8r2MhSjry5sCJHSSUBGDK85/34bk6q0vi7yX65gBoaD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117551; c=relaxed/simple;
	bh=4KUUrYSVLSgf7AtIDUdA8yD1hmE5D2On1prenhy0yxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puuKzLHhtoKZl0SIzwdNkOaIMh5GPsI4GKzSpfMTKEHxNJggPfCyrNIVFF3s8hwudxuvc/TpCjsM1EGJD7JSl81aBlRbI697XOiEvQvbDOLOQ7XhDW07QbxyU6h4ac5hYYy0312lQiGqzCZNxPv0cAf8kHI6TalJk878hyr5f68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJWJ6IlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJWJ6IlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D30AC113D0;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762117551;
	bh=4KUUrYSVLSgf7AtIDUdA8yD1hmE5D2On1prenhy0yxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJWJ6IlBiI0ol/o2uOH/A1eSEfRCMM+oV6C/50NzpBRqhJA761koPotXwi8+IhBbm
	 1OEzM3+xTsF6+jy+LzYRm9iIFknvOWBO6+PNvBAwpetWnjv38m4jeno+2wp2e2aUhF
	 1Smr2Hs8MS5VjqioOCBV29moh8BTjlbHn7ZLJYyZY5h05bNE+An3F8sznSWbjb/t1o
	 IhtNs4klYScYAgcadXOIbTESIirfyxbWlM4BBg+pTXYVxMe9MQmbU0M6fbLcH65A3H
	 L2o9wFVhdo+qNjCEgBFkQQGCLiw7oI3lwLg2/o3vyX7bv1R9eM7hkpssj0cguqmfkj
	 lwtizZao6d+2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A489CE0F65; Sun,  2 Nov 2025 13:05:50 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcu: use WRITE_ONCE() for ->next and ->pprev of hlist_nulls
Date: Sun,  2 Nov 2025 13:05:46 -0800
Message-Id: <20251102210547.3898972-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
References: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.40.1

