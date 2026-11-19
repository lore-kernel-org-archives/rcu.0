Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079691;
	b=pYgJrGur/TrG0PbQBPtGpMaqDX+2DNhh+CaprsL2JlIIygBlx+tVTc8Yy14bWFdqGy4S
	 6pU+zXxUnurOHmLlDiqu3WhxyhPdE5igqWWpI0KoW5MMb5Be9d8D/T+TdbQGeEGqk/+nf
	 KkfpNew5X3/I3XZaXbZEtgabjNguxgUkiC7R9KiNT0LSSPQUz7Ek3em4RN6Ix75dhzGJI
	 1jXWgM/pXC7bzXTDZilY4CPkI9s9NFm0lg9pDBFwGvhdHJIjwhzYhNjV11JXDnNy9O8NR
	 86Tje2oZc/Zoo9+par1yP1YyBYDvCvhFp8BOG69NR/BrgwBv3ue3ktDH2ocp1sXvw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079691;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RCYCyxErggUfcOuYAaIWQu6Q2HbBr+qz7D8g/6lWPn0=;
	b=il3lxirwI49VG1NQ7lWYwAK/q/XSdCVMsR4w10fg3UK8otnACtMZBFtXBlNqwMKJQxzg
	 L4tNV18aajLPVx7g8yFqL5diwUfTsQv81wrkLdcw/3T6aDOdQbTfaKiwUt793rQj41PuQ
	 es18KzlIUE8A2VN204Bfq5mo84o6CJT8hu3dP7nSUmwLOJ/nakEatb21bFeZwSnD+WRED
	 ZhI5Mn+wGEoDbFrslEcz4XKS//lMKEXs69kcErc4JQIbFhquQUrr/R+42n1+Cz3OoaQku
	 cRcnXx4ZvieECERDKMFIYsrPNsTom4DmvqHP8Js1bn7XuxQHjvVIdHXg2GqfN49zmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H7Df6owR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lKDHs6nO;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE6606A320;
	Thu, 19 Nov 2026 09:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAEE6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H7Df6owR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lKDHs6nO
Date: Thu, 19 Nov 2026 10:14:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795079688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCYCyxErggUfcOuYAaIWQu6Q2HbBr+qz7D8g/6lWPn0=;
	b=H7Df6owRQ7tQfgAlprNzYgMcQDHXW0qr8LdxenIrqSPk+96QXbnY9oVz6IRif3T49103jD
	CdwjNWWTB2FYqY16B0QNzeFLR0FWkXgj7NoO7AYhikSckbDo0Qi3D1UaHq9vv2n19TCYH9
	Z7s/ejCVDjjHekAEeyO6AKz82qKlgq1vnKiS4AgKDVXqNDa5KEprBjIBaeC0HmdBA7SAi/
	nTRCVSxnb/G7rK84M6KTFr22qV0UZe7B/yV5t2ggeEPYYXvH95Nf8hBYjya8vMzk28dRMZ
	+B7oAe31TZmhE32Z9McnoCu8J77mMrZa0sJq7T/6QnwTBTlPcs6+6zyWcPkybg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795079688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCYCyxErggUfcOuYAaIWQu6Q2HbBr+qz7D8g/6lWPn0=;
	b=lKDHs6nOLG8iGJrZHH5pJiQZhx6BW6wjowbbW5BZIFEy/jXSl8Herr/Bo4m5XZFYVOSn74
	WCEkgNTRtyT8kDAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <jfern@kernel.org>
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
Subject: Re: [PATCH v2 1/7] rcutorture: Rewrite RCU priority-boost test
 around a CPU-hungry reader
Message-ID: <20261119091446.PPYLd9B1@linutronix.de>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-2-jfern@kernel.org>
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
In-Reply-To: <20261116194438.306618-2-jfern@kernel.org>

On 2026-11-16 14:44:32 [-0500], Joel Fernandes wrote:
> The old boost test relies on RT throttling being disabled and on grace
> periods taking too long, which is fragile.  Instead, each interval one
> CPU runs a normal-priority reader that spins inside an RCU read-side
> critical section until it has consumed test_boost_reader_ms of CPU time
> (measured via sum_exec_runtime, so time spent preempted does not count),
> while a SCHED_FIFO hog on the same CPU tries to starve it.  With RT
> throttling enabled, an unboosted reader gets only about 5% of the CPU,
> far less than it needs within test_boost_duration.  If the reader
> finishes, boosting worked, otherwise it failed.
=E2=80=A6
> Signed-off-by: Joel Fernandes <jfern@kernel.org>

This is doing what I though it is doing in the first place :)
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I didn't run all the tests for it but did test it initially in my setup.

Sebastian
