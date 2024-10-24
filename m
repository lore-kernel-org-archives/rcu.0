Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBC1E25FC;
	Thu, 24 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782268; cv=none; b=o/XyC/5mTh0Vte/KF9nh1u8PGL8ZQaYo7hsnsguNsDRaeAZsPlA/wk7mHce7mvZrIyHOLxAjg/OskXSUncHskSDbENa7+OtJBIGfJiJ9CvSKuS4p40paMRvVkP6TAHJH3y1hHOdyN+cdFZ9A2Xd2XbUD9ob7Lfl9X7tOTZf7CbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782268; c=relaxed/simple;
	bh=HfyR1ZRYXkjKZkd7RtAB0OlErMa6eGDmJY5BJT+005Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJVyU7kS824hZR/2GUNeeJIBOAuXTkXwNemFrBtgm83HC461q2X+lzbSSIQ2u+5J+4zyxpDR3AI8AU94yR+ZYswQXlOA4UqNjVXJRSzxpbI7WiAd2gMhvk0u1XVg9aXmfRFTIHDhi9ITkVkelE+VFTeUc3ffmvK1nmnPaXnLP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tLooQmms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xtl84M/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tLooQmms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xtl84M/d"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729782259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RBUgezimWTlIVj/xJQsYpKXFWuoCJnPRQ023lCFpxc=;
	b=tLooQmms20Ua0zXdO9iXeUIMbV7lqwOT3v8CnHfoOZzCEmzRgFJiB8N7gewtRQCipT55Hb
	mZPVyqsOBYU7aS3wgFmQh/tuhG9EjUgk7WVlScq5mI+uzgxEAo36sHMIAgvQlEotjfBg1N
	F4cCs1Pw+Of7k846sepSFDUl/8OjaOid2i9o60SZQRtTvO2A8mCcChLBWN1mJaDet5AJPN
	Y7bHJE6tiDCurxgM81TvtKWA6xL3d5RaLIpWkcQEBuTahExbbf4+O2JE0YtpbOSnIlUD2f
	o+I9Z/41icIdVUXiBKGzjmtaR75I36zMoB0YcS+TgUIcg0DD00l7NMSM+MN6RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729782259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RBUgezimWTlIVj/xJQsYpKXFWuoCJnPRQ023lCFpxc=;
	b=Xtl84M/de/F+xuJqjvUBmsxBchv5CDrGRv3Pz84UsRez/up2PCawXOQEGIOp8wRkmhea49
	++W/RG7OJItg8hAQ==
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
Subject: [PATCH v2 1/3] hrtimer: Use __raise_softirq_irqoff() to raise the softirq.
Date: Thu, 24 Oct 2024 16:55:49 +0200
Message-ID: <20241024150413.518862-2-bigeasy@linutronix.de>
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
This is always called from an interrupt handler so it can be reduced to
just or set softirq flag and let softirq be invoked on return from
interrupt.

Use __raise_softirq_irqoff() to raise the softirq.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08ea827f..5402e0f242178 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		__raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
--=20
2.45.2

