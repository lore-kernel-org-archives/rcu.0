Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7819A292;
	Thu, 31 Oct 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371353; cv=none; b=WHpe7rZ+amhWlMTKJ7Kq4x8sMSaOfmjOsjcxboVkUCQX980eR9Pdya+xOAm0aXcQyb1mEKsH4Q/dzyffrNfLjdbWdlFRVAmUkGywgdMpgrnOGov/CbW4LxkBVoAGzU6euhFmNTwmxjhxvlcIC2osNm27iFyK2b15vAFvAYd/aP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371353; c=relaxed/simple;
	bh=w8SM03Soo92p7J/ulrQ18OgXCFF12QqL6256J+h7OY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+2GKZ/UpUQC3h6T4JQAYqrdsYVf7U2kL5A7ALAW1o6b/PrZgSmpUTRoocBEn8k+F/92iTg7BUKOcnV092WWQuQ58g57HF/lnlB5LQH0T848Yy2zJyAjAv88umBvvUxJt1RXY8IoWp/eKTeh5Hf+PRlZE5okXD857quJEr+aoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFRIpANt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PrbjYQaH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFRIpANt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PrbjYQaH"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730371350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ2852SIBLZ55jYpM8pe/ulD60t0c9GE/dvFw1Spiq0=;
	b=cFRIpANtDdtqy4wVeyUftYfX+3K6iAeHLYHbrhbjQDewDLfFxiTRAWBpLABLpSV/D1nKoX
	Wk+NfWIT0Th1PtumMMsKOGceAYI86AU0/eVQLUo/JdueUDK6mTO8gndDcQDwWpAlcdvlKx
	3zlURNVKNzYwkTYSrZRVKvVgFFut9pePG7Yi5sFUHmPtz3zgeow/cfVwkC8cRC0tvK2N9z
	ZsOM8KSjcuq8lrbqaUoAOLSAuiq9ZYBNBlgIDzTTV0RHjTq4n0OgJF3AWotNwFtUwQt0x/
	TtHrpm1PFM2JE0s/CeuRo8/9ib3uTQh9uz5XOUAcz8j8fO7LVAj3x7+k91hMLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730371350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ2852SIBLZ55jYpM8pe/ulD60t0c9GE/dvFw1Spiq0=;
	b=PrbjYQaHayM1BR2KDeqfwmwwH+YaLRQVslv5TNNxy548ptz/ne1W/M0I8ZbloOONg2kQs5
	KJsCwHYidFFwoQCw==
To: Frederic Weisbecker <frederic@kernel.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Mark Brown <broonie@kernel.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: next-20241031: kernel/time/clockevents.c:455
 clockevents_register_device
In-Reply-To: <ZyNUR4oi8TXeEpYi@lothringen>
References: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
 <ZyNUR4oi8TXeEpYi@lothringen>
Date: Thu, 31 Oct 2024 11:42:30 +0100
Message-ID: <87r07wwo2x.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 10:56, Frederic Weisbecker wrote:
> On Thu, Oct 31, 2024 at 02:10:14PM +0530, Naresh Kamboju wrote:
>> <4>[ 0.220657] WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455
>> clockevents_register_device (kernel/time/clockevents.c:455
>
> It's possible that I messed up something with clockevents.

Yes. You added the warning :)

> Can you try to reproduce with:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> 	timers/core

I force pushed the branch with the warning removed.

> I wish I could reproduce on my own but I don't have easy
> access to such hardware.

apt-get install qemu-system

gives you access to all supported architectures :)



