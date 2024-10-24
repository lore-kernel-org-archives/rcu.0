Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2A1E2614;
	Thu, 24 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782269; cv=none; b=XvkWYhtGxrEbTZr5bxE2EPUzMzO7tPp2BI/xsh3aqUuVrVj4Ev2ci1Kdxs2pjlcwzQXjXmLNQsHRYqd8dCF8AH1vURM0TPOjx7uI7QyIqRwY3NRLQZvNsOxp6W5q3sxvVHCQh/ef2uTLbu81d3oHgQGBu1rP8zHvNxxIK0D5Bhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782269; c=relaxed/simple;
	bh=/7ZRVvFwZ+7VQnjOzyeKR08bCh1EnmmIHVHoSnjt+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWESrfqpbpKfGFOyQrKXi07RzwcK14/CGjWvIkn8+MaeLePiQotblHAeKKHBRVZ75dzy81yAeuXdiOOy+WQsRfZXCFgKfmsVXuL+pF3g3TAGEAUr4lOKKiM8W8N/HLr4vrV2mVkv5Oi1r++ghwcUyF9oGu3eZXV4pmOkrqZt1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPV6ARtp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KxvyAXc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPV6ARtp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KxvyAXc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729782260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnZElyqVxUkhY65aKgaxFCt3b1HrfEQgNljIzazjk7c=;
	b=zPV6ARtpY3ZsdtxuWmZkox2fm8QWFRR7BGRAvOsMh5QgA6HX8X2UCQuUKNw8XmGrtfiiNr
	jDUrYp+aHh+XGLrC/OnWzHJxqbQddWQg3QsBlJ9MJAk4Hnr5a5DokqMwWx7FCDdu2MwKQo
	XjiDLK7P540SEtm/pztQjhcCxIWmvKBTOpOz6gz/e+7rFSy2+melBxE2XFoOeXpQrVMsBm
	MrDkRthxnxLZ04qDOZ7Z0upEhdVj7zkVMUpXL/u/BiwacPRwQbItihPdJ+f9IAiqD2HiJI
	2jxax3Jz48Bxtiz3zuxpNjolfGGfiYple2XezfJ8n4zJLdGUXWtsBM+6zj25zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729782260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnZElyqVxUkhY65aKgaxFCt3b1HrfEQgNljIzazjk7c=;
	b=5KxvyAXcr3/r/erHSX5No2gYMnsPSKcb+YWtn6pkqzBzE08M8Cek8xGyRGtqfddVz0CG7L
	2+IpHZ5pz4dlIODQ==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/3] timers: Use __raise_softirq_irqoff() to raise the softirq.
Date: Thu, 24 Oct 2024 16:55:50 +0200
Message-ID: <20241024150413.518862-3-bigeasy@linutronix.de>
In-Reply-To: <20241024150413.518862-1-bigeasy@linutronix.de>
References: <20241024150413.518862-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As an optimisation use __raise_softirq_irqoff() to raise the softirq.
This is always called from an interrupt handler, interrupts are already
disabled so it can be reduced to just or set softirq flag and let
softirq be invoked on return from interrupt.

Use __raise_softirq_irqoff() to raise the softirq.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0fc9d066a7be4..1759de934284c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
-			raise_softirq(TIMER_SOFTIRQ);
+			__raise_softirq_irqoff(TIMER_SOFTIRQ);
 			return;
 		}
 	}
--=20
2.45.2

