Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0F1DFE3A;
	Wed,  6 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905467; cv=none; b=fXn205xA2hYuzcfNJlKfABwSYCzX2G/N38VcstO/7SEopAtHQShBUfTXqEbma55UaaR+EKk+UmC4ErivIf2mce2rMNiaVjmUEaaz16FgVaXJdYHMU2bsSHzRyfsy8EsayR+nywG4tzxxkBetZxShlqO/KDOHal0VrV0F+UILc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905467; c=relaxed/simple;
	bh=bxrUaP0iFuIQytJUIVYsQ435NmDo6IZumJ7hGL4qN1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofuct0mwbbKGsPg4ErOxe5KL9BGJcD74WcfGQKXKGH7og6sNZC0hCjjIE8q0dIIhiX1+XRqOIGbhfJVAYAcslntNnMuljwxSXDkLRFcpFlY2E9xTRIwKNQXjp9Y06b8Wi7U4y+7QhjXHE0AcM+X7MKOHhK0QF6M1BJOo2NQnS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjJ4DkCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnqwOWtn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjJ4DkCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnqwOWtn"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730905464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVN0DAOR7peTZ0SeKTNDZNJuwJl+BEEN1bDPz/38Gtk=;
	b=IjJ4DkCjMDxZ2jueN/FVDtbgOpkiY5g6Q9rX2wmZLZDGhG9MxTHw9Yo2CWLqPI6HZqgXf5
	AB+VgRKeAN2Wzmhf8TfI9tJ9znIiXr/oRJa4oeLt0iYZyV6f2NRJhIQwzLaZ4pG+foyO2X
	oCAwA5qJZ1cRxYAFWkcB0cKWaYfwSxOh2dEXj+TjCEaUx00rgwfgbVmm5HsgJD1IselDi8
	khedkK/FFlQnSadxPvfkQss9RyXFRbnNCBbzkwFB7XR5C6cLXNVNeIvaSEnZfz1v4xYvAi
	qV+GIwqgBlfuMNFYL67ssqIIqbNJvCbTTz8pd9jRO2r1zX369qWByvsSJQCGzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730905464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVN0DAOR7peTZ0SeKTNDZNJuwJl+BEEN1bDPz/38Gtk=;
	b=MnqwOWtnE+D9BgJuoeVaA/19yNzYnJR74crv6fFpqq7VL+o6zSenaV2B0l1sGOpd3OxTPS
	o9TeoF4BO8U6QGBA==
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
Subject: [PATCH v3 1/3] hrtimer: Use __raise_softirq_irqoff() to raise the softirq.
Date: Wed,  6 Nov 2024 15:51:37 +0100
Message-ID: <20241106150419.2593080-2-bigeasy@linutronix.de>
In-Reply-To: <20241106150419.2593080-1-bigeasy@linutronix.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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

