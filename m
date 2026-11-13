Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571311;
	b=XiykCP2tyX56ObDe7woRqGEMx46BMWQSbSlL/QQVYzZyJ9qlw/0D5NRuaiIPexE6oWkv
	 1yjjQmNGqEBipPBdU6G0lD9MlFq4C2Uy7lFFC1dizLa73knZvddaJQjhtDNvaGNoYZism
	 ZXCRnu216wlQgcMTG3bJMGAAVC4O1b41WPqZtjbxF6q5XWLQm9S2DXlK5ZP5tWqLdLQdR
	 PaHbx1vgC7+5mfQaDlAWs41D5Y4G3o7J6/XS1uo0SbzxgW8qSg1NYIm8cc1mij65pIsKt
	 YDm+e3yMgAHeQiDj3GAoMvoW3fNLczDQjcu6gtTIGh2BivehJX4rSGdUM7RjcGIQbbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571311;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DqrOoHqxLKKJ53U6SJQjDkCjDTKQIVBfhMm5uKGdJlE=;
	b=30uerlLTIU8XCc7tdggJQlnSIvuQaAZN6N5jrs9qbYkmnd7fdZP8+NPDCAzF5euCdcvE
	 x/MdnV7dN+CIFN5wBPOYLColAQaUzCIJzNf8/A20iikiKo9CGdGFkCXqErBUEaXwnjiRw
	 B5An8fZEfOJyhnFA0m1TEjqiETrueTi0Wwkbla2yC9tw3+pvQgqRaKJGJE1CZP9E6K4+d
	 Z2EygPZMbNrykJ1l8QwghAz0D/MU1kWX5CZB3RfoAdF6bzxcstALDIUWipMiut95/vTPV
	 U4wbRqlxRh8iEzSn+jnda2YUUBSA2hqyUl67Y5ROWsTQWTxPvRvd56amSTQWJ7ELxGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="MlTn1+/M";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2zXk7jhv;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C3606DF63;
	Fri, 13 Nov 2026 12:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405C3606DF63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MlTn1+/M;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2zXk7jhv
Date: Fri, 13 Nov 2026 13:01:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794571307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqrOoHqxLKKJ53U6SJQjDkCjDTKQIVBfhMm5uKGdJlE=;
	b=MlTn1+/MmrBlx7Y7yqHKLjly6o7bY8Z6cyG+V5WdX6XRFZY5k5fzaLqEYLmhSC68v+Xn7B
	067GFshZaWA1MnixPBkhvMbZVIWgO6O0bbMGrMRX7UUsgy7xbuAwqLzEt2dNq5qU0dJLuz
	FN0ezYSVrkfq6KLJqZTVCgKOYldaWXJUiq/XgLJEaiFqEzvU02vwEUogcmFtH+4ZiW0IAP
	YDoAf3LS7Im8N9J8jqLGcDnWOXCQ6oOp1kRm9ba/GQd9WylkPvhF/jw2J3lqKdxB5R3UZY
	3c+ViOFDNboyHQm13TE+8hSaic3z0Mbtu6w5y7Mnnef6vTR+A1TDyL0suBzEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794571307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqrOoHqxLKKJ53U6SJQjDkCjDTKQIVBfhMm5uKGdJlE=;
	b=2zXk7jhv+ze7ZILsEQpq7uj3JNPVreGoYoz7Xw2wfBialNYyuq+e0SRKmJ6FTd02tjfvt9
	CfN5U2Id3xisCuBg==
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
Message-ID: <20261113120145.WctZny5P@linutronix.de>
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
In-Reply-To: <20261111213826.2035045-2-joelagnelf@nvidia.com>

On 2026-11-11 16:38:19 [-0500], Joel Fernandes wrote:
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> +	init_completion(&br.done);
> +	t = kthread_create(rcu_torture_boost_reader, &br, "rcu_torture_boost_rdr");
> +	if (IS_ERR(t)) {
> +		n_rcu_torture_boost_ktrerror++;
> +		return;
> +	}
> +	kthread_bind(t, raw_smp_processor_id());
> +	wake_up_process(t);

=> kthread_run_on_cpu()

Sebastian
