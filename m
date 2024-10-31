Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B74198E8C;
	Thu, 31 Oct 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368654; cv=none; b=rfy9WxsO0Mcb8QVikvR2PCKyS/APcxGZ0ADc09Xud2/vFjAjdchnPY25YSikYtYdGInhXSMY5739SqVAAf6YH63G2ZatNctBSL5f2dkthFJ+OUvw+7MhSIDTW+g95L1zq6uU5dqshVdYGGSxbHDCnFjhVdcRocjAtMu8IXFPAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368654; c=relaxed/simple;
	bh=Y/ZKdGs9HB+eMN46LQEMN2crILjud+xOTPZjCMfvnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdt98j/rZw4M/DKfOgplzJp+T7AKGrQq9cRXg1iBFFZ79H60Y+y/tqMdYuiw4CCIVYvsn0lZwc6daDio1PhcAa2bDYxBesvf9AFdGUiL0a/JK+Ut3drVYUkHp2p9K6G6kxVKx5YDL7pxYNUsy1Tu2KTq+WRRM/DhpnRDndXp9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G58e/nrB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G58e/nrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B5C4CED5;
	Thu, 31 Oct 2024 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730368653;
	bh=Y/ZKdGs9HB+eMN46LQEMN2crILjud+xOTPZjCMfvnbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G58e/nrB469sgVmF0ZG3dxQLcv+W1uDFu/FILhXfCLoJCoj/5k4VoyFTbNpZaA6uf
	 i+B4YT0rcIjWmzT/+f1HVjm+iwSZNelh/bgrflRm4IBECGl9hN2odDSmu792hsR7Z8
	 bY7jzfHc3H6ZhAlNdXLEimDrPw86vil0VEndvwRCPVvnygr7DN6Mq9+9KD8rSk+Zir
	 0c7TnXcYAX3tKBKOqlJJGuoAYYu9GC075Ki4VpLu4BRSGf4Ua0VjatKXc8ldILkPF1
	 5OSIdvCI9y6kbLKpZE6XIMron+uMCYRUWz0GkX5st4dnKSgs3SOWVeTndhpslO+/de
	 3Z8LVQ3W2uU1w==
Date: Thu, 31 Oct 2024 10:57:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	rcu <rcu@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: next-20241031: kernel/time/clockevents.c:455
 clockevents_register_device
Message-ID: <ZyNUi/DmVi8P21TA@lothringen>
References: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
 <87zfmkwqui.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfmkwqui.ffs@tglx>

On Thu, Oct 31, 2024 at 10:42:45AM +0100, Thomas Gleixner wrote:
> On Thu, Oct 31 2024 at 14:10, Naresh Kamboju wrote:
> > The QEMU-ARM64 boot has failed with the Linux next-20241031 tag.
> > The boot log shows warnings at clockevents_register_device and followed
> > by rcu_preempt detected stalls.
> >
> > However, the system did not proceed far enough to reach the login prompt.
> > The fvp-aemva, Qemu-arm64, Qemu-armv7 and Qemu-riscv64 boot failed.
> >
> > Please find the incomplete boot log links below for your reference.
> > The Qemu version is 9.0.2.
> > <4>[ 0.220657] WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455
> > clockevents_register_device (kernel/time/clockevents.c:455
> > <4>[ 0.225218] clockevents_register_device+0x170/0x188 P
> > <4>[ 0.225367] clockevents_config_and_register+0x34/0x50 L
> > <4>[ 0.225487] clockevents_config_and_register (kernel/time/clockevents.c:523)
> > <4>[ 0.225553] arch_timer_starting_cpu
> > (drivers/clocksource/arm_arch_timer.c:1034)
> > <4>[ 0.225602] cpuhp_invoke_callback (kernel/cpu.c:194)
> > <4>[ 0.225649] __cpuhp_invoke_callback_range (kernel/cpu.c:965)
> > <4>[ 0.225691] notify_cpu_starting (kernel/cpu.c:1604)
> 
> That's obvious what happens here. notify_cpu_starting() is invoked
> before the CPU is marked online, which triggers the new check in
> clockevents_register_device().
> 
> I removed the warning and force pushed the fixed up branch, so that
> should be gone by tomorrow.

Ah, phew!

Thanks.

> 
> Thanks,
> 
>         tglx
> 
