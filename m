Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44534CFD4;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374004; cv=none; b=JknIzZqTWdMEnKbDV1zYVr9X+oV2sovToE9g34iXeHPGfTLhnxw8K1i1zXlucPayu74lafwte6IQ5h0QhrIZJMbtFjPt4OsMG1GMW33UnbZN2nMA+xYdbLnMUl3FEo0S7jAxlU5HbJPYDAQJgeKGMdQRnl6D/q0KaP3aFfS2DQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374004; c=relaxed/simple;
	bh=4KUUrYSVLSgf7AtIDUdA8yD1hmE5D2On1prenhy0yxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DO1Bnq3UyQfDP4jJvv/MmlUEU0+lZkZZj26sihlEFXOdRcLa/F7jk81NNp2SUbpWWAExQmaZphZYWCLYPTQ8FZDOkO4ENRm7/sAc/nnWuUrxHXWLeoJ0hBtWgkTOT4enoRqmCzlaqwHbL2E29+Nh5s3jP1C+FPAccfOVT47BYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M65M4Swq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M65M4Swq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F17C116C6;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374003;
	bh=4KUUrYSVLSgf7AtIDUdA8yD1hmE5D2On1prenhy0yxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M65M4Swq8ZtLapk8i60TThkhyGsAAgXBjsSTw7fCwbBms7pGTOybte3tEvbXOq+5T
	 H1CImQ2jpJelQWOspeMkYz+eBeILI81Wz8XTD0CNDBlE06Kp1rDpd5lUOG4UeShbUc
	 ssBExd/HhSjmOjBfjEclFem6+kidJ46qGCm/hx4JWWxZRpW57gX8EkTOl1TFObRmp9
	 rNYpZqSHnTK3RAIasVHqs2ZPHsJsQZhZDcEQlMpxUSbFojt8aUsHKi38CNKpKl5TFR
	 Wz5IQOh1i3Bnea5thHQdHc+MXQG3UcbtkmHHzWTpLt7lvFeXK2KzZRA0CrUppg5Y5z
	 CCiTN66T7h7aA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99CD6CE0BA5; Wed,  5 Nov 2025 12:20:02 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/5] rcu: use WRITE_ONCE() for ->next and ->pprev of hlist_nulls
Date: Wed,  5 Nov 2025 12:19:57 -0800
Message-Id: <20251105202000.2700370-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
References: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
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

