Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585386;
	b=hU2b321DEeUAx4uApiKoelEEJs90CG2S48H83kJmUEmddLTU3irJCP1jxvCeVQSncqyu
	 RgkuV5VOl2T0zQ/W0PO5GyIa2JE/k3J+0GzUan4b0WcNIubq9ySwUni4u3BjxOGcnIRSy
	 9KU7RO7jtwQSQmzQBqbhgdiaVppZSkzIBpUTiJjCMbloFd9O9r/FuBdAMGVt6Wzh//jZQ
	 rub9JzGd0iN+gZhINw7RdhizGMS/Iv89L+Ss6garCSKjOldXqvitnTD+kpMVzXosXg8go
	 bQzmcXkXSjOCsk1uMnu5ClhLf4MIzvwueJX0IzI8dWS9L7vSb2MFI7YBV38Ez+IwyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585386;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UR5NKQoeFT6sICeEPgXoVm9crXtLsbkg/Ukyb4XiFJE=;
	b=38t7eUn9hMTLgb/4tN+oMfiAmhxV4++7P9vGLEbEbl3jGASvzYiBsZk0dRNNhxVGkBTY
	 UfSkRUMjKzaE9GWzAjWFEajS8RCkf42lupCLAmbMRjKQdHpgNaxeMt4tB0mhpUCmAZlKQ
	 A0eCrkoZCAvkVTsQNkb1CTihHwFteKrwhfvpi8hDqs0Jt9M6mn1CGMIJwgXHBwVUiMcmr
	 8w61pzwTVA5cpcSXGVtx430bUY+UKXVWaxX/DZjltgN7b+VwSY3E5bJNBwGZN1w6U/3wr
	 eUG9cYWEzqWafuxghhyDX2aoA6yTCLge5laJ3STrqj6y9VtoTzUS57OOrJdMgFITLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sS0AkHdY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="3DvRj/ML";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F13607020E;
	Fri, 13 Nov 2026 15:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F13607020E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sS0AkHdY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=3DvRj/ML
Date: Fri, 13 Nov 2026 16:56:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794585383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR5NKQoeFT6sICeEPgXoVm9crXtLsbkg/Ukyb4XiFJE=;
	b=sS0AkHdYZycdN5XkWVIlXXA2IjtytjJn/XeK0keQ1Rg97y3mAfyUkEjmJZsCXZD/OeXU42
	gebPYCSM5N/G9URBr22jotyalZPssf5WL2BBFyzlV91d/JsLn7EpsqtL+2Lf+P++9IwuEd
	XFNnx8Mzy3g5ACSptXCFIJZt+vHFL5c3fuyp8w3+ZIELrGel/v1sTVZ1u7YPw7F6NiUQWA
	VaYHeS/2MeY/qextmo6o+nWoD/amUFmD2HCMtdUc3CIb1+aimMXKJOklbsk4G+4GBYsO2R
	6ZMBsQUwGzC9T1duBELx0Ya1N1uPGfO2w7NzhF6j5QqjKzLew1IZalNGuWOoLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794585383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UR5NKQoeFT6sICeEPgXoVm9crXtLsbkg/Ukyb4XiFJE=;
	b=3DvRj/MLGzU7S1HBBgtv/fACjzXVxy4sWm6/3g5RzF3nip4ChipKN3sJ3iiwmWqaHgJF4U
	CSJLQ6ipEaIarcDw==
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
Subject: Re: [PATCH RFC 2/7] rcutorture: Stop disabling RT throttling for
 boost testing
Message-ID: <20261113155622.3SM4n6rp@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-3-joelagnelf@nvidia.com>
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
In-Reply-To: <20261111213826.2035045-3-joelagnelf@nvidia.com>

On 2026-11-11 16:38:20 [-0500], Joel Fernandes wrote:
> The CPU-hungry-reader boost test depends on RT throttling to bound the
> CPU time an unboosted reader can obtain, so there is no longer any
> reason to disable it.  Remove the code that does so, along with the
> now-unneeded sched/sysctl.h include.

Can I talk you into replacing this with
  20261113-sched_dl-v3-3-a76ffa1cdeee@linutronix.de ?

It removes an additional declaration in RCU's header file plus (the more
important part) it explains that it is not doing anything rather than
saying it is no longer needed due to the rework.

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Sebastian
