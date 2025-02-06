Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393D15B10D;
	Thu,  6 Feb 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832580; cv=none; b=ewXo4jTgaFMRGKDLh9zgF+inFFHVbgXCtE9PIWm0aSRfMFy7BgwYLb5HEztFzv9fq39opigQxsoreeZoYpJi3AaTNxLOAoHNQlzXLBxApi7z9wWHMowSA1JM2ctSMSIR+U1uCKz3GMhd2CwEYbwIREzT8iuk16YTEWmgFOHIlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832580; c=relaxed/simple;
	bh=zoXpb2uZ4G1ayIkY8zVg0/bZvomtLPM1cQ+FBzzwPFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMufGeAiLz+uGgrijaBZf1ZqHWewcZ9vCqBikRAocesaKP+m+fT2k/oSG9z/XnyjHs7KPZJwmw6fzSigVUH0+vR9zBS8xwrsGeuCiog1NSW1rANnGZbBlrcAcCxC1LgdWKCjJqrW13Rr61ANHmS9c/fs9E8Bse/9L13p5qBK+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbjNQ/bb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZO5SoL8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbjNQ/bb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZO5SoL8"
Date: Thu, 6 Feb 2025 10:02:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738832571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/F+ln2+g3W9PoeiddkYbJpnqkzufji2LFVIii8xR+0w=;
	b=QbjNQ/bbpW9PKim6rH1qomez84mXknzGV/Mj839BFhnBdMNjMnGYoCyXh1qzzJ0yGRre1U
	GPXNSxdKggUpWdq+PN9+Bt8BF+4kA6ZS58KNg74d9gP5R0q8OhT+IuLXTBKHELwk9iGs+y
	WH03xA14tx2N2OhR2eJAjADvYDcFDj6TUmvKZOmceVULTBjl869rU/O2TDAB5yZsX6q24T
	Tgjl95E3lvTg9as8g8l9/HREdRNjIp6MKr4MRFN6bcx0nGT0urnFJ9LpDcCPZ7EzByaFXs
	bXcuFmfnqc9jPpjk2S3k8rRMYpcwFjt213E5d8xEkXTwCDAOUb2AHu3VHYeFuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738832571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/F+ln2+g3W9PoeiddkYbJpnqkzufji2LFVIii8xR+0w=;
	b=GZO5SoL8+Eykg0UuJ1dk9Gjtq+Xte48aipmOm8EuOuvCzX9PYyW7ZjO6hhwWHsCCcdNZDy
	vXbne7qD3bm7cUBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <20250206090249.G7TXOt0y@linutronix.de>
References: <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>

On 2025-02-05 15:50:14 [-0800], Paul E. McKenney wrote:
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..d658d7e81bef 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
>  extern bool nbcon_device_try_acquire(struct console *con);
>  extern void nbcon_device_release(struct console *con);
>  void nbcon_atomic_flush_unsafe(void);
> +bool pr_flush(int timeout_ms, bool reset_on_progress);
=E2=80=A6
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a701000bab34..a84828d0757b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -704,6 +704,7 @@ void kernel_power_off(void)
>  	migrate_to_reboot_cpu();
>  	syscore_shutdown();
>  	pr_emerg("Power down\n");
> +	pr_flush(1000, 1);

this could be true instead 1 given that the type is bool

>  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_power_off();
>  }

Sebastian
