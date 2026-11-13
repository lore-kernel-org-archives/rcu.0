Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586799;
	b=pOKUlqAto57As6Qvd9tNmf2ffHDHvFyorpA/nFXe8szb1TOWOMUs+huweADq2Hyna8Tf
	 fJONX7rB0+41SAqokLRFRf2QpvNKKjcHuIyRT6Jcyk11O1yh1+vwvnKJKtsoQPDgKAjR0
	 E+NAmNAz7dNqGb5E5aKfNODMeMqX5tFOulBXZ8l91QAxwWqdn/tjscH7N3O1aQDrdL2rj
	 FIwgKgp/n5uIc4THuTKJth7cXLuODbOID+VbegOrUTyMwq4uBopjkZPhr3yHSOWX68PqN
	 jIJqIVqzL2CkbeE7tgtR6ciUz0Bzh/bGE96sdLjdqwOf/PZiUWzJ2xZEf+yM9VbuJhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586799;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SMgY5YNqGWPvm0q7pcA1ZGRkzwJOmnADRsWH2ZBgxGM=;
	b=v97yn/oYihV3QRpHA1/if/EtbgfPsTmJ0PjVkmRym5ld+sUwlb6me6hF2I8EGPeJ0XUZ
	 RzNcnfbwqmeKl33Co2Xi/g1Edw5jWZr4rr+9R35vHyTCziO1WKqlrjAzDIBGKeBETUCLR
	 ikevCYG8ZN1h8kAYA0vRQBbs8SbYfoXHdWQuCnzz5dFH65ItkFNFSsK8arkjpRBCB2nqW
	 0SN68ejiawpGvFfaE88mKHDP9+W3X6aZnFBeItgfMR3NvA0+vnd0zHgCaW9Aj8TuoNfum
	 eM2fvK5idb77seRVxKU3oyUwsgf8K7RCPQ3a8ej/BsvqTRkLvUJNAD5StQEgoCqrDRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rPf2dlCL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kWHqbXpb;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2169606A32E;
	Fri, 13 Nov 2026 16:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2169606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rPf2dlCL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kWHqbXpb
Date: Fri, 13 Nov 2026 17:19:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794586797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMgY5YNqGWPvm0q7pcA1ZGRkzwJOmnADRsWH2ZBgxGM=;
	b=rPf2dlCL4z6PgfHhhX2kl8GJegar+XrtxAZFvEKNwYUPtS+4WXetIfkMYtM9qP0xtxPqTe
	YZRlTP2hHiY05lCC+xnMz9Rq3N0GE7sjXfxGetT5RVWSN7RxJc0D62Cmg/eu7G1bdj4yfW
	8lmZFRLsSL1urFvHBM43x68W9xyMFhN4JbhmxBjfj3oEfEvrAUwVGnlpCP91xkZqUq4MU8
	mLAXOxwfXaVMJYyBMjZrK1yPjN3+X1lLDZDwKhB7/TRJmWvo5Q3YcBJ8zBb3CIxop2vlpm
	mdfLm7oKmxqvmfhWNLwH65ApuIdEuFJKXH8VjJ/ldU5C4NLwJ7bWx0EwddbHrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794586797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMgY5YNqGWPvm0q7pcA1ZGRkzwJOmnADRsWH2ZBgxGM=;
	b=kWHqbXpbZZ/6dIucNH+FI1QqnotX4CfnBVkjwhlJifMOJ5dfGi0Hb8qS461kdQTIMTt4Py
	2yMgOaXWr0XGibAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] rcutorture: Rewrite RCU priority-boost test
 around a CPU-hungry reader
Message-ID: <20261113161955.Ps45N002@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-2-joelagnelf@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261111213826.2035045-2-joelagnelf@nvidia.com>

On 2026-11-11 16:38:19 [-0500], Joel Fernandes wrote:
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -149,6 +149,7 @@ torture_param(int, test_boost, 1, "Test RCU prio boos=
t: 0=3Dno, 1=3Dmaybe, 2=3Dyes.");
>  torture_param(int, test_boost_duration, 4, "Duration of each boost test,=
 seconds.");
>  torture_param(int, test_boost_holdoff, 0, "Holdoff time from rcutorture =
start, seconds.");
>  torture_param(int, test_boost_interval, 7, "Interval between boost tests=
, seconds.");
> +torture_param(int, test_boost_reader_ms, 2000, "Boost-test reader CPU ti=
me, ms.");

That that I look again later where you add the Documentation for this:
You should check that this parameter is in range (not too small (<0) not
to too large maybe). rcu_torture_init() checks also other.

>  torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
>  torture_param(bool, test_no_idle_hz, true, "Test support for tickless id=
le CPUs");
>  torture_param(int, test_srcu_lockdep, 0, "Test specified SRCU deadlock s=
cenario.");
> @@ -1366,61 +1375,111 @@ static void rcu_torture_enable_rt_throttle(void)
=E2=80=A6
> +	smp_mb(); // Time check before reader check.
> +	if (!READ_ONCE(br.finished) && !stuttered && !torture_must_stop()) {
>  		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
>  		n_rcu_torture_boost_failure++;
> +		pr_info("Boost inversion: reader got only %llu of %d ms CPU in %lu jif=
fies, GP %s.\n",
> +			READ_ONCE(br.ran_ns) / NSEC_PER_MSEC, test_boost_reader_ms, jiffies -=
 start,

rcu_torture_boost_reader::ran_ns is u64 so this needs to be something
like div64_ul().

Sebastian
