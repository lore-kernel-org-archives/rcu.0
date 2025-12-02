Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58029E11A;
	Tue,  2 Dec 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681739; cv=none; b=eM4J8ziF2Pwr+b5cUe7lhhpYC1AxPqcUWY1ts2SOE1PTgfjxSHuOF9GKJJ70LcVJnrD1U/KvfEzRykyIeyPytk6edU40fB5Pc1trvhsVjngbK3zyNHb6INhKFIVGpU5NLD1hJ2pCFI66dtRcTk1KBiGMpTiFIWG8t0tRET82dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681739; c=relaxed/simple;
	bh=nP5h3fUP5ASmbQtYyOUIZbhxDeMOICbxoe3e+MQtti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCqB1L950qAQ02PHcGRX4AK8ruHj1F7ae69MrhvEtBSxDQxZvV/uy6efXOwPuKWL42p3S69Pr3AOjlM0rhB/MqSq6IYCN7uM0pFSfK3b9oDVWn7uEZ0gybVX+hB+2anQoWY9jx+ODhvrpdFia161MaLDKnYqMSN8H4PnWd8lQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBp1Xxap; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7McnW/Xr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBp1Xxap";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7McnW/Xr"
Date: Tue, 2 Dec 2025 14:22:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764681733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKje59zp3vJuGgIeA31kKTCrz140Cc6KYl+XY/FtTQI=;
	b=jBp1XxapCbvWO5jfX705FSwlrno4E4a7ZJR3N2Xv8al9PZZJ87vG3RwimgF+XA5G4aW1uy
	zZggnFtAf/TIjiTMQ8u+C6fofDKOkF8H5/EGwpqgGDfrwXHcmit/TQO4Joe5ElFmZgTlXz
	/TNALH3SZBQjFiHtYsKEqeq6TMs+4NIw1ahNgJLoKUwfpe0g0fijtwkyMwnZ6WUP+2UXcZ
	FEvozUJH9vDDnaIVLB2jpJfVKBFo1sYeG1Y26l3Aug6haxfh/CBkLMMAoTAU4sNFQDBiXS
	3961X1GqFCOU8i4DQGvDfAOuJSxxwX4MPCxvdVds/ncnT8b9HsRQ2W/OWYsyUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764681733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKje59zp3vJuGgIeA31kKTCrz140Cc6KYl+XY/FtTQI=;
	b=7McnW/Xr5nHhYpkdXt6slRpSYy3XjY5r2G/8CwVHsNpDiV7Hz26nY7UkHW6wRkRGTvyzzQ
	VCt5YAaRlnzB6eBQ==
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
Message-ID: <20251202132212.uxWTkFJd@linutronix.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
 <20251202082458.m12SBi3G@linutronix.de>
 <afbd1a03-0458-4c06-a96a-2d5f34e2632e@siemens.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afbd1a03-0458-4c06-a96a-2d5f34e2632e@siemens.com>

On 2025-12-02 13:39:56 [+0100], Jan Kiszka wrote:
> On 02.12.25 09:24, Sebastian Andrzej Siewior wrote:
> > On 2025-12-01 22:51:50 [+0100], Jan Kiszka wrote:
> >> How should we handle this? Consider 6.12 mainline with -rt and cgroups
> >> as potentially broken, asking people to user 6.12-rt? Or port this back?
> > 
> > If you have everything in v6.12 for an useable RT system and this is the
> > only missing piece I could ask the stable nicely to backport this.
> > 
> 
> Given that this is a fix for potential lock-up... Does it have
> dependencies? The other two patches in this series are optimizations
> only, or should they better join the backport?

Just an optimisation if I am not mistaken but it will conflict if not
backported.

> Jan

Sebastian
