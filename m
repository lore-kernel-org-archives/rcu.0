Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB6155742;
	Fri,  4 Oct 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038329; cv=none; b=hO2w/GTlkHOTwGd0XeI5Ot0Ie57L8gmGc3w7SqQ5TKx3dlYsH69lZruM8au/FJ/w4DkvUtuo0DpHAFGoCA2xMZRp0pd4FqNHAywl3SNJqTEEwJiS36pzcrQycBnYMrw1Rl+mWcK0Gxw72UZkr5ucSRD46lH4g9pMv74feoqf12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038329; c=relaxed/simple;
	bh=7mubocY6kh3/gtRFZ62Bo56SeQ9GZ5pPxVAe7t8I3uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALzaZb/h+dNM0CLi9vkJhLiDBgKhoj1TvwO1CXIVighOJHEqhJGJCK0tFbpDICsflRSNdT4KtBo82VGxAW8JXDHyCcb3Ou8IffAwudZxcGoj5WYu/6JXMDxLuOVSKQvdYwvVGVuZja1NEHFzD05O3g/gQetntjGVh6hGhrNldwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LC+6I5xC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tLNGrjDB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LC+6I5xC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tLNGrjDB"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728038326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S92vnLrom7/3j1daVQozNqEwDMB0Bu21+iMpxwsPiH4=;
	b=LC+6I5xCV3ZWTwGH2p7xTpf/BO5bdarUrXTcctB2MkkI7nF+YbRWkjNChBLw7hhqMvWjuI
	tUPAGp9US5MxG69N2tWungRnwQZbWtjAxgQhigmf4c8E9S5upKGcUyDJij6ZGcALmucNcY
	GBGNC+tQegSdoZscp5bmkJUa/B6LEqVyDKFh/6OFAqRlPl7MDdWsF4vv20DNiiTqQAkdRW
	cgMUBRYCimt1g57+vFEdihMfCFPXW3jwtk9FZTn3qpyvYbw5OBCg/F4Wi3tS4aCD5YY1MA
	MYYoErKi8D5T3imbNGDAVTae1sdV2I0OQBva56W4+FfO745IaOiiahzlKhWabg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728038326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S92vnLrom7/3j1daVQozNqEwDMB0Bu21+iMpxwsPiH4=;
	b=tLNGrjDBFSJ6VKB1UrCM3FK9Sxcl7JO5NvEmXtxJOV4bGRcu/SQW64viKRp5zLXZxfrpGZ
	Twfp765G/LDe7PBg==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/1] softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.
Date: Fri,  4 Oct 2024 12:17:03 +0200
Message-ID: <20241004103842.131014-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

the following was in the PREEMPT_RT queue since last softirq rework. The
result is that timer wake ups (hrtimer, timer_list) happens in hardirq
processing them requires to wake ksoftirqd leading two:
- ksoftirqd will consume all further softirqs. That means all
  soft interrupts that would be processed in the threaded interrupt will
  no be delayed to ksoftirqd. The threaded interrupt runs at higher
  priority than ksoftirqd.

- ksoftirqd runs at SCHED_OTHER so it will compete for resources with
  all other tasks in the system, potentially delayed the processing
  further.

The idea was to let the timers be processed by a dedicated thread
running at low SCHED_FIFO priority.
While looking at it again, it might make sense to have the
pending_softirq flag per-thread to avoid threads with higher priority
picking up softirqs from low-priority threads. This isn't yet a problem
because adding softirqs for processing happens only from threaded
interrupts. So the low-priority thread will wait until the high-priority
thread is done. And the high-priority thread will PI-boost the
low-priority thread until it is done. It would only make sense to make
the flags per-thread once the BH lock is gone.

The patch is limited to PREEMPT_RT. The ksoftirqd bullets from above
apply also to !PREEMPT_RT +threadirqs. Would it make sense to restrict
it to force_irqthreads() instead?

Sebastian

