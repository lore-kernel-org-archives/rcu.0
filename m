Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C544D001;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=j3KrrKqmdqimCx+tMgJte2VglLm1MNFofe3v5LloiaM5S/tXN9foTu13as+G/NySbh/xI6pefeFlK8DglUxsQJdNq7FBah0V4lf32bQlAAveUiGSHAsXhoYA0bWlb0IO3q7Mo1i91fDRxyoKjOUjm72O0PiznhOCo6c/E8cGihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=wFT/i1ySNxXzoubSoSgzPm8HS2drPU39EeIV8Pogu1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5vNkogFzWcgD39gRvccaQnOnf8c1U/iw62wHaSxIvemSAXR4XjZQpfzozkzAfp0554vLdW1wTcPz4YxvcUoP6F2HWWgkaCZFpVXf/Qr9FKfiysrg1AU6srENYUqrhnzMqFf6UKGPiEOwxDe2UyQYWgNM3UItkODmofljI5KaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9FSs5KN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9FSs5KN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5A8C2BCF6;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=wFT/i1ySNxXzoubSoSgzPm8HS2drPU39EeIV8Pogu1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9FSs5KNlIFlmkSHDbZ/y6t+nvSUmau9KmfzuJ4DgecbmZ4k6bekSTHKugZaEhTfV
	 7SmdVgRT+5cnLcVB7Ts3s84tAU//GdscUOMwaLb2hnZSq5ueQS+TllyiDlJ/tIzZtN
	 OwWotK3QSXwC1TqPqXOHlFo0YYyGnVb8lQFJOu35OgxjoSGexjLCehhusI/1LDm8RP
	 dMJiCWaT63gs1npGfhe5RNFj9yop14KDBKpQlhYV9YGh39nPK2qWGdR+KJhQWjQmGn
	 v+HPgza5Kv5rzuRJzMJt1zF0jiid23MOvpIEH51z1eSkcCFlZQIP395MEj6ZvDn2rd
	 VAge4VamSgc0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5A67CE0F52; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: [PATCH 7/7] rcu: Document rcu_access_pointer() feeding into cmpxchg()
Date: Thu,  7 May 2026 10:09:50 -0700
Message-Id: <20260507170950.2040199-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the rcu_access_pointer() use case for fetching the
old value of an RCU-protected pointer within a lockless updater for use
by an atomic cmpxchg() operation.

Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de858..5e95acc33989b6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -592,11 +592,13 @@ context_unsafe(							      \
  * lockdep checks for being in an RCU read-side critical section.  This is
  * useful when the value of this pointer is accessed, but the pointer is
  * not dereferenced, for example, when testing an RCU-protected pointer
- * against NULL.  Although rcu_access_pointer() may also be used in cases
- * where update-side locks prevent the value of the pointer from changing,
- * you should instead use rcu_dereference_protected() for this use case.
- * Within an RCU read-side critical section, there is little reason to
- * use rcu_access_pointer().
+ * against NULL.  Within an RCU read-side critical section, there is little
+ * reason to use rcu_access_pointer().  Although rcu_access_pointer() may
+ * also be used in cases where update-side locks prevent the value of the
+ * pointer from changing, you should instead use rcu_dereference_protected()
+ * for this use case.  It is also permissible to use rcu_access_pointer()
+ * within lockless updaters to obtain the old value for an atomic operation,
+ * for example, for cmpxchg().
  *
  * It is usually best to test the rcu_access_pointer() return value
  * directly in order to avoid accidental dereferences being introduced
-- 
2.40.1

