Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C521FF35;
	Tue,  2 Dec 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663904; cv=none; b=rRae1o6PRJ34cMP23e419OJ536mOEtL4zw/zRVtxW5g1SzUSAoyTWYakW7WB4yrJ2BpNV3KE0WkIuuQ1QUnL2J0lYIjQwhyCmYeIYAFsocv08eISn4r/S67wSCOa/MHrchuiht8Swtnk+bm45sXtnZSTcZhsKcI0lfKRC3Qdyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663904; c=relaxed/simple;
	bh=tzyqVz6yuCSn2/tRWNwXVMV4O/fa1CSwBvI+jzFXJw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEb/esTdfAHdxm9cAAyg+yBg5GtXlT6e33UO0xLUIC9Re2+40ZH2PTM3me2gdG/Nf0L5PiGhze4NeKiU35I9La/WHGM8kQkZBOlMHNmipXsnz626cAS0r4gAUXI/ZChuiyUzICOeEYpo6ySbOKETbme1un8bVlGAbKD73s/ZI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GpycixTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OzpGKc7A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GpycixTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OzpGKc7A"
Date: Tue, 2 Dec 2025 09:24:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764663900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGHMQc286HXJFdKeADnDSXWt2+24VfBua+gW3mW09ss=;
	b=GpycixTXoXv/wkPesly4xdNK1mPaELaS5KSSlCvHcEc38jyexgN0gY+qjKoIkgGFynZ1Cr
	3WxqoU1D1vYANr3fL/JplRDpJYrAf+U727upqR/y8I5MsU4DukPsDQ0JNv/QeyjwX5c+lV
	vtMY/Ds9QN25TnGxMScBINBuA6rVqho+qFT4o71U9q3SZCAE63B8mmCIxKGHyEXTQsxrfV
	LworygkC52+AQsSf+9O+pWoxaKKxvJaQcP9CE7bL+3jCQRA731jQmR6zO7cAPuqmN6XeTs
	WtnGtui+exfSFKEmq13Yu8VI5Dg+0tb66kw/Z1zqLn65hJ8c7SwpNbhPSFJyWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764663900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGHMQc286HXJFdKeADnDSXWt2+24VfBua+gW3mW09ss=;
	b=OzpGKc7AodT3EtVLcGMLlzxeuwex8o0ilID7wezcA+CJLvOw2GyoTdFkNs+1f4rABpPaAB
	T+ayAaNe2EZz3/Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	stable-rt <stable-rt@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
Message-ID: <20251202082458.m12SBi3G@linutronix.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>

On 2025-12-01 22:51:50 [+0100], Jan Kiszka wrote:
> How should we handle this? Consider 6.12 mainline with -rt and cgroups
> as potentially broken, asking people to user 6.12-rt? Or port this back?

If you have everything in v6.12 for an useable RT system and this is the
only missing piece I could ask the stable nicely to backport this.

> Jan
> 
Sebastian
