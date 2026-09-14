Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AE3D6CCF;
	Mon, 14 Sep 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370847; cv=none; b=G5yVRR6KDxdHhiO5u4e/BopwmDME2vZCcYNptSY4gLknq9J8MGLeDVFH/wvGiZY4vLh/0ksF2tYtqTlV5yoPZEK17rY07LK7sxWC3EyJsqE5REGvHOHyR/N1bgoz6hH4uZg85WkdVANa+cuNliw1FU9keM5ZJzKLjAMHEbq/AG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370847; c=relaxed/simple;
	bh=22GFFGqdeelEcVqK7ReRhrNoxFAZgc3dDFDzvxqJ7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4DDdbZc2BLgt00Z031FVvz/rN9RVtrrW+3dmLHFILuov4w8AEY3pC4UXfcTM1ie8EdcE1wxjkk7K3JnYbDDfXyETFuPCGxV61x4wp+1eB2Fou85wORIUAJTvTeVmYBYyVFwV5xn1SnNKbOYzI2X8pr2wcR3kvTiSjP18d2iPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wReNpCCC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8xV12B3+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wReNpCCC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8xV12B3+"
Date: Mon, 14 Sep 2026 09:19:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789370363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvk+1CmaNH6YPN8PfGNCaM5zgpn1FSFdhQKnNF3jkDw=;
	b=wReNpCCCDn9GIQoHLGgRNiv6x1UEDPIT/2sx2/tviASP7IhmjM/Hv19ajmWB/bYs6Bde9T
	K/AyzTf6zZ9h1yVSqUz4INHP9/wGEqaBqZCNCkxo7DqvrSYVOmFGx//BQfwX2vWg7deWB0
	+2GKzsT3VBBj8/i97PcjYJg3IceYm4Lkc7HQJtVJsWmvQHBs8UpFH7KC8PMJ11rECgSD0w
	6ex+arWhorePCiM8pO4GhMmttIYBgFCQvIMQcDXSii2/j0YI5pP5maxxlEzJhjl5rnoAiS
	Qmd61RRyO+0X1SaLL0GrjS3WCcHl72zkMkNxfmYz0bevWPC1TyISDFfoaeUMFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789370363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvk+1CmaNH6YPN8PfGNCaM5zgpn1FSFdhQKnNF3jkDw=;
	b=8xV12B3+07dlVzkjVy0/uox73g+U8bs4ZXgRx1md91YNoCdAO/YUn1hg57ABQKKXMYXa8d
	qdZ77pw6d1rAdfAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuref: Fix the rcuread_is_dead reference in
 rcuref_read() kernel-doc
Message-ID: <20260914071921.8NKpjb_K@linutronix.de>
References: <20260911213643.3781-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911213643.3781-1-kmehltretter@gmail.com>

On 2026-09-11 23:36:43 [+0200], Karl Mehltretter wrote:
> The kernel-doc comment of rcuref_read() refers to rcuread_is_dead, which
> does not exist. The name is rcuref_is_dead. Say rcuref_is_dead.
> 
> Fixes: 3efa66ce6ee1 ("rcuref: Provide rcuref_is_dead()")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
