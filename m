Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C269209669;
	Mon,  3 Feb 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595137; cv=none; b=cLSieN1PS1LudNqVG8Y8BjR5r+0cWdZD7gNdfoI+Gcl4uZOx/5NgGe1XaphEp9KK1GQLMwkZ5ZWTT7eFEAyiVW9dXp9VKFULCXYq4myuwa27wBn/ZKkBsBkNndQrMaEi3FYbiPDaEqwfyinZrFDSKdw/aLue/QgPUOztczjAqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595137; c=relaxed/simple;
	bh=OK+jjP1BbZyIi0ssNy/G6Co6NiIxx8Mftl1ZXIchREU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG1QBjap4n97FTtmvyaObxcdAXZ4YyyP7jIoLIIIpywv2frop93zIr7y8z2FvOAtbQnOlRELT3FQjlub4+H0NQnoNOPJSBiBs5bJwcy+4/wPYUlz58W/nySq72N5Pcb2dl9MT8EQJYTggoe1vZsfQwNqKRAtLlPjxtQr70Q4zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xl3Y7N2g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCsnnDqD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xl3Y7N2g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCsnnDqD"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738595133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/YC+WrCwCy8jU9IgZ0UBmsm9LE5suKhW48TMzGwyHg=;
	b=Xl3Y7N2gm9AWBuNZWaFwtrshtQeqFuVHdAaTnEzmyCudnVivxTw/C9kNuyfwDIH2Cn/Qts
	pskpB74IsS1dR4N17fYXX1CH5dUyB1pQ8BkjwDTQipNmPHje498nNipUZo0I04P63m9WFa
	21wZZlktX9yOgW3+WyTeERN41fdLs8BhHxWY7OvFoV6F2DRZB409O5MAqo6hTQL8fnqBLE
	E9VILjj9H2eIAfv6kePJMyOAqn8WPtwjFPGmD9e1qeeZ5VdNEswaHb4LdPtZS4Bj1UiqSq
	1oZkq+lBh4XuKBdztjdCfHthpcKqFKfrMcHCOMRP0a+NRH8gozVvdrIrIcACeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738595133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/YC+WrCwCy8jU9IgZ0UBmsm9LE5suKhW48TMzGwyHg=;
	b=FCsnnDqDI7I4cPhfYeSHNQz7gD7v8pFMIbnCHIhJHQLZ1yyLHX+3GZz1BVf8v8v2b7YKJf
	Lt4GI8bcx8anhZBg==
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
Subject: [PATCH 4/4] ucount: Use rcuref_t for reference counting.
Date: Mon,  3 Feb 2025 16:05:25 +0100
Message-ID: <20250203150525.456525-5-bigeasy@linutronix.de>
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use rcuref_t for reference counting. This eliminates the cmpxchg loop in
the get and put path. This also eliminates the need to acquire the lock
in the put path because once the final user returns the reference, it
can no longer be obtained anymore.

Use rcuref_t for reference counting.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/user_namespace.h | 11 +++++++++--
 kernel/ucount.c                | 16 +++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index ad4dbef92597b..a0bb6d0121378 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
+#include <linux/rcuref.h>
 #include <linux/rwsem.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
@@ -120,7 +121,7 @@ struct ucounts {
 	struct user_namespace *ns;
 	kuid_t uid;
 	struct rcu_head rcu;
-	atomic_t count;
+	rcuref_t count;
 	atomic_long_t ucount[UCOUNT_COUNTS];
 	atomic_long_t rlimit[UCOUNT_RLIMIT_COUNTS];
 };
@@ -133,9 +134,15 @@ void retire_userns_sysctls(struct user_namespace *ns);
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid, enum uco=
unt_type type);
 void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
-struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
 void put_ucounts(struct ucounts *ucounts);
=20
+static inline struct ucounts * __must_check get_ucounts(struct ucounts *uc=
ounts)
+{
+	if (rcuref_get(&ucounts->count))
+		return ucounts;
+	return NULL;
+}
+
 static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_t=
ype type)
 {
 	return atomic_long_read(&ucounts->rlimit[type]);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index b6abaf68cdccb..8686e329b8f2c 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -11,7 +11,7 @@
 struct ucounts init_ucounts =3D {
 	.ns    =3D &init_user_ns,
 	.uid   =3D GLOBAL_ROOT_UID,
-	.count =3D ATOMIC_INIT(1),
+	.count =3D RCUREF_INIT(1),
 };
=20
 #define UCOUNTS_HASHTABLE_BITS 10
@@ -138,7 +138,7 @@ static struct ucounts *find_ucounts(struct user_namespa=
ce *ns, kuid_t uid,
 	guard(rcu)();
 	hlist_nulls_for_each_entry_rcu(ucounts, pos, hashent, node) {
 		if (uid_eq(ucounts->uid, uid) && (ucounts->ns =3D=3D ns)) {
-			if (atomic_inc_not_zero(&ucounts->count))
+			if (rcuref_get(&ucounts->count))
 				return ucounts;
 		}
 	}
@@ -154,13 +154,6 @@ static void hlist_add_ucounts(struct ucounts *ucounts)
 	spin_unlock_irq(&ucounts_lock);
 }
=20
-struct ucounts *get_ucounts(struct ucounts *ucounts)
-{
-	if (atomic_inc_not_zero(&ucounts->count))
-		return ucounts;
-	return NULL;
-}
-
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_nulls_head *hashent =3D ucounts_hashentry(ns, uid);
@@ -176,7 +169,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns=
, kuid_t uid)
=20
 	new->ns =3D ns;
 	new->uid =3D uid;
-	atomic_set(&new->count, 1);
+	rcuref_init(&new->count, 1);
=20
 	spin_lock_irq(&ucounts_lock);
 	ucounts =3D find_ucounts(ns, uid, hashent);
@@ -196,7 +189,8 @@ void put_ucounts(struct ucounts *ucounts)
 {
 	unsigned long flags;
=20
-	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
+	if (rcuref_put(&ucounts->count)) {
+		spin_lock_irqsave(&ucounts_lock, flags);
 		hlist_nulls_del_rcu(&ucounts->node);
 		spin_unlock_irqrestore(&ucounts_lock, flags);
=20
--=20
2.47.2

