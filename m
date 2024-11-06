Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006B1E0DA1;
	Wed,  6 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905468; cv=none; b=U0A1d+IJ9onNQ79Ge3GEVPUE0JyhUwxq/YZ1EwulW6S5yiqBSQBaqBnQviU243Wi6jcpy9gxlSWhXfVS4JxcebCGOQ7vw822yuUm5xyzFNBQYBqljG0OhIesM9goEO1u21muDE3Qk6z9hHoYrZr2VoRqtE15UmrNgiDiy/4Rm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905468; c=relaxed/simple;
	bh=FmzB8ZRj0dfS9Q8t32a1K8iEBd7tFBm57uOALkdDzxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0bCJ2hNavDRVfTGnRbgz1d9vZ9JVNMS/MHy7lTjOibGuPQr1AoTuSQXDiK9XdiLXcboLBLI7krB8SrFy3SIdVOH+OtVLfKN4SG8bWqqMkbByEAMcfPAmE52BJh2JpW4M5eqNnx4gG4rO7ehJkRIr+fRRSRMxrd+GvNdQ/DxZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yk5JyOVI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3InIA09w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yk5JyOVI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3InIA09w"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730905464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQdED8DAdnUkE8LHZdtmssZ0jx637Ik3t3wGyg9RV7g=;
	b=Yk5JyOVIhECLWkhFrvTIr3/+86uRpbE69YOxbNKR3xq5jzFV26U6SHqRUOhXNndGtVwrbx
	Tm3btdyDj2giJr6BWUK9ISQ7GvPbRpJK7fv0TLHGRhdNAG98ubqvK1p8zWWVSG+2Qo87+c
	8LV3nblCLoH6jqhr+YxwhrBiuQgJYvmlPLNC3ynCuJtWQ3gwPVzy6rA/QjmnSDMGI8Vtyv
	pAMtDGe2DTgB9Fl3xzYTUapysUr8Xc+NU2hU5nvdj1QGh8yDHYwXAhR8MW3BuPJmVebZXS
	MzMpS+9fCo+Bq6AAJ4dWcg6mMwg2N+v8upyMGpC5ZWJmRxix+BwSRvV0TPTh2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730905464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQdED8DAdnUkE8LHZdtmssZ0jx637Ik3t3wGyg9RV7g=;
	b=3InIA09wLEhY9FtqvNYl+W4CpEN5kpqpFD7MgGtYtJWqjXG5wkaD4Qxs/o6uQVlc8MhPcR
	/0TXDrrFJWt3EcCg==
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
Subject: [PATCH v3 2/3] timers: Use __raise_softirq_irqoff() to raise the softirq.
Date: Wed,  6 Nov 2024 15:51:38 +0100
Message-ID: <20241106150419.2593080-3-bigeasy@linutronix.de>
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
This is always called from an interrupt handler, interrupts are already
disabled so it can be reduced to just or set softirq flag and let
softirq be invoked on return from interrupt.

Use __raise_softirq_irqoff() to raise the softirq.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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

