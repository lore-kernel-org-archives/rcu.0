Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BD2080F9;
	Mon,  3 Feb 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595138; cv=none; b=uLJLP/4POFy2gfy1dhFN1iStKFleIjtnUYNSlp6fj83SmLMTUNmjtjbF/4FDxMxaRzgfu4tjzhIG+3dL9P5/WQqEFIdb4jxP7GRlN++lvupJVdTL1qezbU+MkY4jX+80QZcVhx7Lar93mhfCu/3P379+8jkab+thTQApAp7PL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595138; c=relaxed/simple;
	bh=tKnh+kKottUjOUdTWNtI3LHAb+KtZ0BffGkQSU7pKrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr+eAx0ef618AYJtLwdkbWU8UHrESY+HBPfQoYD6pLtInnZDyJcYndSIK+cQkvRPY7p0oAs5xShktatZby6PZ0klBcusy5U/zYcfqYtQNFxkqf5+GA5sNOCU+brePoOYX8Br1ycBdpzoeVYRa4WRVXSMKcl3cuFDcmcbgTM/pao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZbbXXFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ggj5AKXh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZbbXXFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ggj5AKXh"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738595133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/fZu6xb+Szg+d8vtwSZnj4vBZAZohI+wxhZ6Q3N7B8=;
	b=0ZbbXXFrwenSMc6uxmEYuSRqnbNnDttcLnabAinX0KuKsGrcrgqG9zc11Kj1R5PI4CHn4E
	3ivBYxviO60jpMWVu70aXJPaWuWM+n3ZbNwCXCkLKeG6kggkKFhnz3T6OzypRH1f+oNarF
	2II3IFvw3EpmNP/ipqWHdNAlCGqB+PaJrzYkIxRWTTsZ0JU1Voa/UYc+TC3dm8iG7iaNbR
	mKKNVZ9vZzLa/GpHCNJEMd1Ufkma6pa2CPOq0jlWaTZJqqyUVCTmemPZiYPXV5mUAP4UEu
	DpZJYxMw2WLqmWSJrFzhrK1QIGZEd6d5XX80+o4PDAm/RQrX+Qsn0Gc15oTqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738595133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/fZu6xb+Szg+d8vtwSZnj4vBZAZohI+wxhZ6Q3N7B8=;
	b=Ggj5AKXhGFY/+u9Ea9vNMSv10xKbJagbXN+6zZwqrWuIOSfKtO7wlgnhTsmyz05IO2D8fR
	0VgvTUm99PKBHKBA==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	MengEn Sun <mengensun@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	YueHong Wu <yuehongwu@tencent.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] ucount: Use RCU for ucounts lookups.
Date: Mon,  3 Feb 2025 16:05:24 +0100
Message-ID: <20250203150525.456525-4-bigeasy@linutronix.de>
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ucounts element is looked up under ucounts_lock. This can be
optimized by using RCU for a lockless lookup and return and element if the
reference can be obtained.

Replace hlist_head with hlist_nulls_head which is RCU compatible. Let
find_ucounts() search for the required item within a RCU section and
return the item if a reference could be obtained.
This means alloc_ucounts() will always return an element (unless the
memory allocation failed). Let put_ucounts() RCU free the element if the
reference counter dropped to zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/user_namespace.h |  4 +-
 kernel/ucount.c                | 75 ++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 7183e5aca2829..ad4dbef92597b 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -5,6 +5,7 @@
 #include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
+#include <linux/rculist_nulls.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/rwsem.h>
@@ -115,9 +116,10 @@ struct user_namespace {
 } __randomize_layout;
=20
 struct ucounts {
-	struct hlist_node node;
+	struct hlist_nulls_node node;
 	struct user_namespace *ns;
 	kuid_t uid;
+	struct rcu_head rcu;
 	atomic_t count;
 	atomic_long_t ucount[UCOUNT_COUNTS];
 	atomic_long_t rlimit[UCOUNT_RLIMIT_COUNTS];
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa5011538257..b6abaf68cdccb 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -15,7 +15,10 @@ struct ucounts init_ucounts =3D {
 };
=20
 #define UCOUNTS_HASHTABLE_BITS 10
-static struct hlist_head ucounts_hashtable[(1 << UCOUNTS_HASHTABLE_BITS)];
+#define UCOUNTS_HASHTABLE_ENTRIES (1 << UCOUNTS_HASHTABLE_BITS)
+static struct hlist_nulls_head ucounts_hashtable[UCOUNTS_HASHTABLE_ENTRIES=
] =3D {
+	[0 ... UCOUNTS_HASHTABLE_ENTRIES - 1] =3D HLIST_NULLS_HEAD_INIT(0)
+};
 static DEFINE_SPINLOCK(ucounts_lock);
=20
 #define ucounts_hashfn(ns, uid)						\
@@ -24,7 +27,6 @@ static DEFINE_SPINLOCK(ucounts_lock);
 #define ucounts_hashentry(ns, uid)	\
 	(ucounts_hashtable + ucounts_hashfn(ns, uid))
=20
-
 #ifdef CONFIG_SYSCTL
 static struct ctl_table_set *
 set_lookup(struct ctl_table_root *root)
@@ -127,22 +129,28 @@ void retire_userns_sysctls(struct user_namespace *ns)
 #endif
 }
=20
-static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid,=
 struct hlist_head *hashent)
+static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid,
+				    struct hlist_nulls_head *hashent)
 {
 	struct ucounts *ucounts;
+	struct hlist_nulls_node *pos;
=20
-	hlist_for_each_entry(ucounts, hashent, node) {
-		if (uid_eq(ucounts->uid, uid) && (ucounts->ns =3D=3D ns))
-			return ucounts;
+	guard(rcu)();
+	hlist_nulls_for_each_entry_rcu(ucounts, pos, hashent, node) {
+		if (uid_eq(ucounts->uid, uid) && (ucounts->ns =3D=3D ns)) {
+			if (atomic_inc_not_zero(&ucounts->count))
+				return ucounts;
+		}
 	}
 	return NULL;
 }
=20
 static void hlist_add_ucounts(struct ucounts *ucounts)
 {
-	struct hlist_head *hashent =3D ucounts_hashentry(ucounts->ns, ucounts->ui=
d);
+	struct hlist_nulls_head *hashent =3D ucounts_hashentry(ucounts->ns, ucoun=
ts->uid);
+
 	spin_lock_irq(&ucounts_lock);
-	hlist_add_head(&ucounts->node, hashent);
+	hlist_nulls_add_head_rcu(&ucounts->node, hashent);
 	spin_unlock_irq(&ucounts_lock);
 }
=20
@@ -155,37 +163,33 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
=20
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
-	struct hlist_head *hashent =3D ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new =3D NULL;
+	struct hlist_nulls_head *hashent =3D ucounts_hashentry(ns, uid);
+	struct ucounts *ucounts, *new;
+
+	ucounts =3D find_ucounts(ns, uid, hashent);
+	if (ucounts)
+		return ucounts;
+
+	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->ns =3D ns;
+	new->uid =3D uid;
+	atomic_set(&new->count, 1);
=20
 	spin_lock_irq(&ucounts_lock);
 	ucounts =3D find_ucounts(ns, uid, hashent);
-	if (!ucounts) {
+	if (ucounts) {
 		spin_unlock_irq(&ucounts_lock);
-
-		new =3D kzalloc(sizeof(*new), GFP_KERNEL);
-		if (!new)
-			return NULL;
-
-		new->ns =3D ns;
-		new->uid =3D uid;
-		atomic_set(&new->count, 1);
-
-		spin_lock_irq(&ucounts_lock);
-		ucounts =3D find_ucounts(ns, uid, hashent);
-		if (!ucounts) {
-			hlist_add_head(&new->node, hashent);
-			get_user_ns(new->ns);
-			spin_unlock_irq(&ucounts_lock);
-			return new;
-		}
+		kfree(new);
+		return ucounts;
 	}
-	if (!atomic_inc_not_zero(&ucounts->count))
-		ucounts =3D NULL;
-	spin_unlock_irq(&ucounts_lock);
-	kfree(new);
=20
-	return ucounts;
+	hlist_nulls_add_head_rcu(&new->node, hashent);
+	get_user_ns(new->ns);
+	spin_unlock_irq(&ucounts_lock);
+	return new;
 }
=20
 void put_ucounts(struct ucounts *ucounts)
@@ -193,10 +197,11 @@ void put_ucounts(struct ucounts *ucounts)
 	unsigned long flags;
=20
 	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
-		hlist_del_init(&ucounts->node);
+		hlist_nulls_del_rcu(&ucounts->node);
 		spin_unlock_irqrestore(&ucounts_lock, flags);
+
 		put_user_ns(ucounts->ns);
-		kfree(ucounts);
+		kfree_rcu(ucounts, rcu);
 	}
 }
=20
--=20
2.47.2

