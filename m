Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D2209677;
	Mon,  3 Feb 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595136; cv=none; b=oHjgyI6imx4tOcNzG2TlG6U0Uhaq7fFNeW+Iae+FZxMrFaCt4xUOdhbi8l2q31DF8+gvFADQH77Vhh2Av9FUpRkKtXrk9j2mlHdFDEp7rEqPrxi4hrf4bUmSyS8e1HlwHO0/J2BPNUiaFdEkEPhHvXxYSLglUi+9jFRmckQVHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595136; c=relaxed/simple;
	bh=NtVEvi5o+2Y5THcCCOoGtQ1CfQwhYnEubu5wZVXHpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX0X0VPjVegnXEanhB0md5QoKONBEMNWehG2egOpn1xhXa4Sc9UzzWZUc5ldvL4YHCFq1tmOQQsZIQ2ZlTPy9VsXBHiJzQcsRA3kGrzCSLbi+EThP25G/xtur2b0G99hJUDyjDm9z4u6R9eMYajG/CAUu4y/L5UVTuNx1kYGA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=upFoTsQ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffdWqGo8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="upFoTsQ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffdWqGo8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738595132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgDvhm/mNA7fkgOGrealCnDdq680fG6HjgiYD8iSCJw=;
	b=upFoTsQ5Z0RB/yHDpPEDCeLaIxtvP4eXCtigHDmPRJBNkG4LpCTG8out6dq2A6rWYI5wXq
	Her978ZQIkhVX4YcH07EtCpRXSpqtY8LsPQli/Avpmbu69YVqm0Y2JHD4MSwghTjde1xy3
	dxH72Pqn/z0o5NBLcrhY4VdEYE4F7Wc5rKRDyKtQw34Kw9odl/h7wO6ZIV5eWRG9RjvjH/
	AM8woHboRsX9og8nF1c8t+PlSEhm8kY9FdK353DsBu+bqjleM34vdy8qhmLz9nFCNRlSHn
	isDKrLeOrNRBbmDhW5eStX7v/OAp9Tr63bsNJh6HdA1XSt48bEMICanLN5n+fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738595132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgDvhm/mNA7fkgOGrealCnDdq680fG6HjgiYD8iSCJw=;
	b=ffdWqGo8I4UCQin0vD+hOTdKMIHMmKbB0iVsYHTerwXm8KVNMBMvYSSBn1sNS/13zAP/ON
	ls/hEhruu8yMz8DA==
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
Subject: [PATCH 2/4] ucount: Replace get_ucounts_or_wrap() with atomic_inc_not_zero().
Date: Mon,  3 Feb 2025 16:05:23 +0100
Message-ID: <20250203150525.456525-3-bigeasy@linutronix.de>
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

get_ucounts_or_wrap() increments the counter and if the counter is
negative then it decrements it again in order to reset the previous increme=
nt.
This statement can be replaced with atomic_inc_not_zero() to only
increment the counter if it is not yet 0.
This simplifies the get function because the put (if the get failed) can
be removed. atomic_inc_not_zero() is implement as a cmpxchg() loop which
can be repeated several times if another get/put is performed in parallel. =
This
will be optimized later.

Increment the reference counter only if not yet dropped to zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/ucount.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 86c5f1c0bad90..4aa5011538257 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -146,25 +146,16 @@ static void hlist_add_ucounts(struct ucounts *ucounts)
 	spin_unlock_irq(&ucounts_lock);
 }
=20
-static inline bool get_ucounts_or_wrap(struct ucounts *ucounts)
-{
-	/* Returns true on a successful get, false if the count wraps. */
-	return !atomic_add_negative(1, &ucounts->count);
-}
-
 struct ucounts *get_ucounts(struct ucounts *ucounts)
 {
-	if (!get_ucounts_or_wrap(ucounts)) {
-		put_ucounts(ucounts);
-		ucounts =3D NULL;
-	}
-	return ucounts;
+	if (atomic_inc_not_zero(&ucounts->count))
+		return ucounts;
+	return NULL;
 }
=20
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent =3D ucounts_hashentry(ns, uid);
-	bool wrapped;
 	struct ucounts *ucounts, *new =3D NULL;
=20
 	spin_lock_irq(&ucounts_lock);
@@ -189,14 +180,11 @@ struct ucounts *alloc_ucounts(struct user_namespace *=
ns, kuid_t uid)
 			return new;
 		}
 	}
-
-	wrapped =3D !get_ucounts_or_wrap(ucounts);
+	if (!atomic_inc_not_zero(&ucounts->count))
+		ucounts =3D NULL;
 	spin_unlock_irq(&ucounts_lock);
 	kfree(new);
-	if (wrapped) {
-		put_ucounts(ucounts);
-		return NULL;
-	}
+
 	return ucounts;
 }
=20
--=20
2.47.2

