Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0D17B436;
	Thu, 31 Oct 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367770; cv=none; b=uiqSdiFeTEsPVPJBzjzTKxMqF4EAH8/OfXwgZXTYQIBFbyHELx0zQN+qPCPKqRXKnRjyLXZc8WppIdynjQmjmEnMTYFDk0XzwPQR4sb0JyljHKA0y7mSy/Ih99Wy9UrgtuWeEshADwPpNZ/avcLrMjUNscV/7XlgDuHtdvVu8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367770; c=relaxed/simple;
	bh=gvIolUj3GPlr1v9Qqq8NCLwsd+Y00rCxC2cPy5H86zE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlAZ2BCvV1qdaCXloVrIh4GqCMa0Dt6keIlAU9XVZLTpsUICEc9Y5WvdSjRYkIcp0mYanRfX1ZixkVt81TWx8ZyiyRAA9JAU6kIE9XyVV7Zefwb8yplFouv328HU1dUhMprjgMzfoP39VI9AMrXKfeH2AkzLcuFDIkL3HkLkAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s83G6sty; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oyyTImzd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s83G6sty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyyTImzd"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730367766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnGraNEP/rz5O8q33kitqbhHCgnpJ/YmvKLNCF0vYpQ=;
	b=s83G6styN8bgmTOKXbhnhzTwe1neMnP/IpGepXQT7lX+qFFWLfa1JAALy/5s/UDFw+e9Is
	bWN4An2XBNJf//s8S3rU7M4QZ9tW/s8n+d7qe0IPa0PFV8uXRDQ8jpz4smkRquwI9563H0
	BWZUZC50qQ/7deg/5m9O7B7x+bsRXd2dJT6dhYvot1HbXtcdOglrUjODmchKNiWY88aERW
	B7S8QXHIXqKfzHg5PRrTnoSWpxONFzCX2ZxU7STM06NHPwu2lFHbE1Rp031323f8dF81Dz
	n3nE+LRcrLXQI8Yx/DHg0s/otWtPbd4IJbK4+YnBKMtk4IFTCSpO3tFOm+TjeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730367766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnGraNEP/rz5O8q33kitqbhHCgnpJ/YmvKLNCF0vYpQ=;
	b=oyyTImzdRYppbqXbvspmSJ48xaqRz2JgQX5pq2j23MXY1W3SVMnYhCx5MHCGxCTDOE6EGH
	cn8sejRYV+V+e6CA==
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Mark Brown <broonie@kernel.org>, Alex =?utf-8?Q?Be?=
 =?utf-8?Q?nn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: next-20241031: kernel/time/clockevents.c:455
 clockevents_register_device
In-Reply-To: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
References: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
Date: Thu, 31 Oct 2024 10:42:45 +0100
Message-ID: <87zfmkwqui.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 14:10, Naresh Kamboju wrote:
> The QEMU-ARM64 boot has failed with the Linux next-20241031 tag.
> The boot log shows warnings at clockevents_register_device and followed
> by rcu_preempt detected stalls.
>
> However, the system did not proceed far enough to reach the login prompt.
> The fvp-aemva, Qemu-arm64, Qemu-armv7 and Qemu-riscv64 boot failed.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> <4>[ 0.220657] WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455
> clockevents_register_device (kernel/time/clockevents.c:455
> <4>[ 0.225218] clockevents_register_device+0x170/0x188 P
> <4>[ 0.225367] clockevents_config_and_register+0x34/0x50 L
> <4>[ 0.225487] clockevents_config_and_register (kernel/time/clockevents.c:523)
> <4>[ 0.225553] arch_timer_starting_cpu
> (drivers/clocksource/arm_arch_timer.c:1034)
> <4>[ 0.225602] cpuhp_invoke_callback (kernel/cpu.c:194)
> <4>[ 0.225649] __cpuhp_invoke_callback_range (kernel/cpu.c:965)
> <4>[ 0.225691] notify_cpu_starting (kernel/cpu.c:1604)

That's obvious what happens here. notify_cpu_starting() is invoked
before the CPU is marked online, which triggers the new check in
clockevents_register_device().

I removed the warning and force pushed the fixed up branch, so that
should be gone by tomorrow.

Thanks,

        tglx
