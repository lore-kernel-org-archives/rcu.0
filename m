Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD11FF7D0;
	Wed,  5 Feb 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794048; cv=none; b=IMub5B2imEDx5JwBu7FmxvcIULDQoDcQSd7XebYtRAw+16zw3w4GWvqZZev1ZuvrhPB/xrSMxLQRf+j2FG0lOIXO4106xTYdoKccEXLa9v4lJ5KR0VA1AROa44RmqXKpeg+7hzUAOtwapygA/4yHf7RICPHbdwfS4e/n2gOeUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794048; c=relaxed/simple;
	bh=kq/UjGLGuu592iop9Db2Fbpd0JKQvY+WcIQOn/os+QE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYA27/whJHiNhqv974WKHZ/0DkLUrwNNOtMrKSB0Qsbls8PRqMwGfRyMTRdlhuLOWs7KrcB6l5Ieu2YRxuj+acmymoeSxcddXutnYxvu0noiODVXNXDqzoLqD/hiOq9Gi8TM6Fr6NUEehiUu2QcZFe8BiljbjYMJaYmUGDxtM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYdlDQ1O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuNvQj+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYdlDQ1O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuNvQj+J"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738794042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq/UjGLGuu592iop9Db2Fbpd0JKQvY+WcIQOn/os+QE=;
	b=gYdlDQ1Oo1hm9mgIcNYyuNLC+GhuRB34a9moCGuWyvOHmf2ppx5Z7v7WxNkWfoZezDSp/2
	3xUpJ5alU43QWve+Swv39e4HSISxWkZG19zqUHSiiKb9fNQ5QaRD2LQUQHepyKTzt06Mev
	XhsT1c71RGocjnK//TqEUrzigzCRNy28ASQqdM079SfJCTECjPPp2zcwOAC+gSSqEFIQDH
	+corAjfTzwN9D8RuAUNJDhvoBOMkZqn2IZAjkq8RlznWGtQVea+vPb7lqrn2ZvuywEY3ZP
	LSIog/AZWCAW530lRHf/V9zdZG5exkIs3uX+sMB+ImvFC/z7/RLctv+1qynfwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738794042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kq/UjGLGuu592iop9Db2Fbpd0JKQvY+WcIQOn/os+QE=;
	b=LuNvQj+JEzMY5TQ08nxT0ijU/HeqplSrpHOG8dxlhO11xiCR2Xer9RIIX9eEGvj1eY6QR0
	sH1HuE2FMq6+mABA==
To: paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
In-Reply-To: <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
References: <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
Date: Wed, 05 Feb 2025 23:26:41 +0106
Message-ID: <841pwc11ae.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> If there is no backlog, pr_flush() returns immediately.
>
> OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
> it, then?

For !CONFIG_PREEMPT_RT, if there are legacy consoles registered,
pr_flush() will additionally perform a blocking lock on the
console_lock. The kernel is in a clean shutdown path, so it should not
be a risk to block on the console_lock. But the console_lock is one of
the ugly global locks (semaphore, actually) we are working to remove
because sometimes it still causes problems.

@pmladek: What do you think? Should we have a CONFIG_PREEMPT_RT guard,
which would always be safe? Or do you feel comfortable performing a
console_lock() in the shutdown path for !CONFIG_PREEMPT_RT?

John
