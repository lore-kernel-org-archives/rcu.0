Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411805;
	b=ROSFq50DQ1Z57nVQyvdEsYdMQeXYtvQdAqnNqDwIPDm0Y6kRZlM59DKN1k47PYKQRwpB
	 r9kQfqhsZuMfqdHYygYIeyS8uVjxsTBT63AeXQAUiGiQeHc8+njkOIdWSXcF5NaUKXDOm
	 gAwtNm5tGn0rFtcTu5bH75VpqSLXequtxFz1RYCSQspSWjqcqHcLYP2PJRWYZpxhOwOI3
	 EJZiTecH+30jxqB1N0PRhnbZCw86vRsqWdkOemF0sg7Cqjpbq66ZXdqh9AX1oOL9pSloX
	 +EIyRibO8OilxBfYoSqzvqzx6vh/7ICNCMzFRYddcaJBRoF3UfboqX9Yh17kV67vn3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411805;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+j+CUhgCY4xVSkjxHmOnbjeGHM1DsYRgRzd/ZrPTp+E=;
	b=dIirZ9UozCJxvlqx7MZ5ARQFGw5lpljiVHcqTnPOF4v2kIcafJWnaRZaUbTw36Us7Teg
	 MdBIXtTE7v4KE+OJ1r1UShW5I7I1CaKFRbIyCoN8BcitgzPzxjIwiJLAIlXQwot3ivQRB
	 YHKq2p7GpLHSi7wiItYipKud2BRQy3yPYlGrDtGzcJ6NtmyeLodGlJ52EhQsMpO8d9QbW
	 OE7HponJkMA3B+eMme0DOTQ4nZnz056KxVVgXyPG9Pd4BhUhvbVvhIyWljxlNrqIskgtz
	 2eeFWE9W8o9BJMDd3E32BT5+PZyk+oZIpmzXcPtR8LGzTWCuaK7Ut8zmhm32Rbc0pKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rhdaXThs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jxOp4G9I;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EB606A324
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 15:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15EB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rhdaXThs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jxOp4G9I
Date: Wed, 11 Nov 2026 16:43:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794411801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+j+CUhgCY4xVSkjxHmOnbjeGHM1DsYRgRzd/ZrPTp+E=;
	b=rhdaXThsY1z07Ytux32DNUIaZx3lRjGdsI8Ci1Zyf/r/g2jGVBgASBniRxm1S2vYo8+7VU
	IQqPmCQQEBafv6/mzIAHKPzRSd8Gg9R9+dKiZ1Aug6q1JCX7BCmP6va18QuCY6H0yJyyGB
	TR4yalWSD86Gg2Ct7ZczFsYhZfvDPPuA3aZicxZ24yKCTw1XgqjkBXkh1BN6p3XGwiHFBo
	uml3ABoBPg7vfDC3Y6FuQAGi3l7akswmG+Y1fRK3BVLU92ZnN5emPOZF6epbakm/cVJvmq
	pbhJ010IP4XCw0x2aclzYyqRZ3bTz9T8tOL6axYwUOz2ju4k8Gm/zgfMT1aVPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794411801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+j+CUhgCY4xVSkjxHmOnbjeGHM1DsYRgRzd/ZrPTp+E=;
	b=jxOp4G9IrHaQ9pJDscQDmwS61IKJaYEZbIEzPlEU8AQ+C+FMcHrfSHKvJ0ckBn71/vlkl5
	D8xa9rDm/0/ChsCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <20261111154319.2Iu5wbqr@linutronix.de>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
 <20261110080942.QxKXirzI@linutronix.de>
 <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>

On 2026-11-10 10:48:31 [-0800], Paul E. McKenney wrote:
> Unfortunately, my overnight run of TREE03, which does do RCU priority
> boosting and has for some years, fails with the splat shown at the end
> of this email.  Things go rapidly downhill from there.
> 
> For reference, I used this command on a 16-hardware-thread x86
> laptop:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 9h --configs TREE03 --bootargs "rcutorture.test_boost=2" --trust-make
> 
> The "rcutorture.test_boost=2" is redundant but I was lazy.

I identified the issue. The hotplug notifier runs too early. This is
only an issue if the CPU goes up because during "init" the notifier is
run while CPU is marked active.
I remember you have a test where the VM/system has X CPUs but you boot
with maxcpus=Y where Y < X. In that case the throttler is only disabled
on the Y CPUs. If the remaining CPUs are then enabled at runtime then
the fair_server remains enabled/ can't be disabled from the hotplug
notifier.

>> this makes things easier.
>
>Don't worry, it won't happen again.  ;-)

However. I could make sure that the fair_server is not enabled on init
if the rcu_throttler is built-in. This would make it easier again.

Sebastian
