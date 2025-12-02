Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E6303A2C;
	Tue,  2 Dec 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663737; cv=none; b=cqnU17UReefgBMNPB2cm8IQ0yPikmjbgGe0f8VZkdRO08VIOzOAB5R2ol6DQnax+Vx5ft71E2ftA+LV3Kr5zeQKR7SmWFgYZQh2+aVu7b2y+v08+6xMlCEEgyBpE6Zto9lE5jXECNBfdACFiatEKFSazrHhJF4sGu88EdRyohHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663737; c=relaxed/simple;
	bh=IaGacwC6i68oxxyydKflVFPRjYbQzqksdhw7QJNF44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubOVWgYqXeb8Gl3ABGM7oceboL9QIwS8su6xtRhXgcHooJuw03/OB3BapayAGDID//+mzCHtoHwuaKORq8t6rBnVqAPSULoAGhW7hol90OippMHpTfwojmR3buJWeKrOSQes1wwp9VQkCBtibTHD+pQSaEoTqRqnA50QfDPENik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQpjQ/SN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4/R2gQNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQpjQ/SN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4/R2gQNL"
Date: Tue, 2 Dec 2025 09:22:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764663728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6420xYUY3XeZnCjRYtdux3uYF91ZsBHaiFiGXMfJg=;
	b=ZQpjQ/SNhYQ8fqhJPmn5zDs+qLQaEJHI1gQ98l+1boqie09DcODoeIhEHGnRI0RHLJgUIr
	ZcdaEgzlh8LFsG9ZASGIHqZmioTgiHhGmuzTkfyLPl1QGB4M91Q0EQXYGKbUQafenqcwc3
	M7D9oVnSQaJAU3JkphsyRnhITcgi5Ubp2sWyEiD6ZawlMCTwgDrV3m5PvS9a7SNvXRB/k9
	ZWCW7BYTv4cPrkMtqQtDv69IyMSUnoXniAbeJcNSvvDVqwkUW2QR+7Vi7qFKYb1sNtRB3C
	E2sqOSgoSSMKxS00Na3a/nsCbO8jE06JyInaaeU870cDgVdEqrebA0ZU0BmWDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764663728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6420xYUY3XeZnCjRYtdux3uYF91ZsBHaiFiGXMfJg=;
	b=4/R2gQNLxyoTGcDVwJV+QjvpytmuzfQmEMdh0GjxiNG60YrmvsamZfI/bMhOgKLceYLG1l
	iQjlq7G72+GzBCBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
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
Message-ID: <20251202082206.EnnTU37J@linutronix.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
 <aS4pgDjn1b8coe0r@redhat.com>
 <00552531-d00a-4e29-898c-86f4474b12a7@siemens.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00552531-d00a-4e29-898c-86f4474b12a7@siemens.com>

On 2025-12-02 07:57:04 [+0100], Jan Kiszka wrote:
> So, we have this right now in the 6.12-rt and 6.1-rt trees. The patch
> (b12e35832805) that enabled the lockup above was added to 4.18. In
> 4.19-rt (still under maintenance via 4.19-cip-rt), we had ktimersoftd -
> was that addressing the issue as well? Or could timers have expired back
> then also outside of that thread, thus potentially without SCHED_FIFO prio?

Looking at v4.19.25-rt16, there is ktimersoftd/ via "softirq: split
timer softirqs out of ksoftirqd". This became later ktimers/.
So yes, the timer should be expired with a SCHED_FIFO priority.

You are most likely aware of "Defer throttle when task exits to user"
	https://lore.kernel.org/all/20250829081120.806-1-ziqianlu@bytedance.com/

> Thanks,
> Jan

Sebastian
