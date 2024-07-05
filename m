Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00C2B9B9
	for <rcu@vger.kernel.org>; Fri,  5 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195964; cv=none; b=qbxfv8rILeIlShxqKcuqopAXyiGNLXraI7mqxlV9JXwPznrY6XiAF2NWGc+ksAJWTQCqFENoZLUlFLGtu3sg34yR16jtAIpWWhjkPmS1RxLihoRVqBbHuL+VcSjqmh1YOYlLeRVX9LM4RBIg6wHJ1lTQBbl2BLEb5DWkXL3jaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195964; c=relaxed/simple;
	bh=FWWA5vWPWEnwEMej04dnaHYkX7pc5lbg596pR/SZems=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jp9Q2QJRVpH2UwHx2pRUVasukwyaY6nCDiUkh4OLwzMcXFpmKrua5pvvdqyOB7/eIl+9CuUqMBZhGXMSWzqITvnZ6XPnmFzcQdDQnopYxTmSVH38AgoMMG2Cb4jG6aazQWuleMCG9P7QycsbYeaj8jxpDMd5NyzM9ml1v/zzsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Yshwr+D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFY12wX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Yshwr+D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFY12wX4"
Date: Fri, 5 Jul 2024 18:12:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720195961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P4mPrHKOv0gyj1s+Guj02SaDEFIs272Atvl/z5dKV+k=;
	b=2Yshwr+DcwdFxQ9uLJRA86xH3/xTK1nwLxJXRVfM4viN8bW9pUck4jQS3NY+EZ/XjqVEzH
	Dw1OtWeV49aykyLT1SToiA6wx8HDQnFr8YLE1eC85gPMjyqN2tBF9b71I/r2eMAtjWWSUH
	SfLnQlYW6kLjWYxvtmgIG2xrSdtS9a9FvIYEs5NpkJVJS9Vf1FqmeNY0EY4VSurKvjOBoR
	3qUV3e1QSeQK3e9P5cjRUBHQAiA8nvUy4yii7zI0QNeWlZtLUMWF+p2od4LtkvHYywgZyy
	nxIegsHyEnIsce6rGOqUeWcCRxyhdfFqXDXN6x+mDOaRYyG49EytimFG7MyQNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720195961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P4mPrHKOv0gyj1s+Guj02SaDEFIs272Atvl/z5dKV+k=;
	b=qFY12wX4qW5CrYWRRHDblpsPcwYER3TobBDPNO888m/DNJLR4DT2jNuNNF+uW+eVa0AyTS
	9+b43jpjxjXe2QAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <20240705161240.HiOFN5hH@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I noticed this on an older kernel and reproduced it on -rc6: I boot the
(RT) kernel with
	isolcpus=4-15 nohz=on nohz_full=4-15 rcu_nocbs=4-15 rcu_nocb_poll

and compiled a NOHZ_FULL kernel. If I pin a shell onto the isolated CPU
and do nothing then everything seems fine. If I issue commands, this
happens:
   tick_nohz_handler() -> update_process_times() -> rcu_sched_clock_irq()

rcu_sched_clock_irq() invokes rcu_pending() which returns true due to
|         /* Have RCU grace period completed or started?  */
|         if (rcu_seq_current(&rnp->gp_seq) != rdp->gp_seq ||
|             unlikely(READ_ONCE(rdp->gpwrap))) /* outside lock */
|                 return 1;

And it is the first check of the two. Later I see 
|         /* Is the RCU core waiting for a quiescent state from this CPU? */
|         gp_in_progress = rcu_gp_in_progress();
|         if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
|                 return 1;

which triggers it but then "later" it fallbacks to the first case again.
In both cases it wakes the rcuc/ thread on the isolated CPU.

Is this something that needs to happen on the isolated CPU or can this
be excluded for rcu_rdp_is_offloaded() CPUs?

Sebastian
