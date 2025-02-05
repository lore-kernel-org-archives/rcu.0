Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A2192D83;
	Wed,  5 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794689; cv=none; b=Iy8cpj49sljmeBXoa52xq2dNZfa5sSvLo9MWRkwenYqFj+BsQ2SuDv+Bs6pDzJ5dP/iAdoDh/QZUInTRVd95beHwK2b5LYQLt8PL+moJw5HHv2E3bXTnPat4kFKEKwITXlF4QanS4gXyNYoj0ySUL4iiVoNdaMNUpl9zr5QNxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794689; c=relaxed/simple;
	bh=Vr5fU+QGCImK+vWVGfPtqObS6yfloyhPGeEb4Dfyzgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDGzLpIsAlWf83FL1xbjLr8QAmXh92pivIXTq+ylVMw7gbIS6RbfO35/HM6ckMLf8N0SAVim30pHtQ+VWUIu8SDb9JgteL8AdyqU/8y+kI69zzujVzkXaGiv0Foj2rinJ7LWeiKbAcpyKbLXzDq84cAQGcRibyUFvNaIdjKNRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcwKXQST; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUdlV0Sl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcwKXQST";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUdlV0Sl"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738794685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr5fU+QGCImK+vWVGfPtqObS6yfloyhPGeEb4Dfyzgo=;
	b=zcwKXQSTwk6ZxwH7pJEiZaoV8bOXjB3Fju/dViMWRLbXyXAEhIwABcbv9hZZVEkPbZ7Tx5
	NTTuIg/I6uH7acxoypiLQWpEa2pCugpzlDoPl7fU6OGg3t/j/RxA8iXvZ47P1i3AbUlwx/
	NEJjll21TvoiVEi7PFCh6L3k2Q8tRv9Osk2J83BtIsejEJ/naxpzVJZlFGXBrz6h2Kn3Dq
	OA1SPFDyBzB1b96q7YcSGHIrLqe2sOH4YdYTLPa8b9OVp9b0aCm1cFg02+MjWrBKro5XUz
	gyuWsIyTt+sZHpiuS5fwPKvscqkaBCTpxQtHsJp2M4JrpmOk8xSTH+HggwtmMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738794685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr5fU+QGCImK+vWVGfPtqObS6yfloyhPGeEb4Dfyzgo=;
	b=UUdlV0SlLMlKrCo/hZ/bp50ohZ6M4v8PVu4mKiVWogHdTmwRWAurZ141BjQ2RibtB1ldDZ
	T34MIDLavsqW5bBA==
To: paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
In-Reply-To: <841pwc11ae.fsf@jogness.linutronix.de>
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
 <841pwc11ae.fsf@jogness.linutronix.de>
Date: Wed, 05 Feb 2025 23:37:25 +0106
Message-ID: <84y0ykyqf6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-05, John Ogness <john.ogness@linutronix.de> wrote:
>> OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
>> it, then?
>
> For !CONFIG_PREEMPT_RT, if there are legacy consoles registered,
> pr_flush() will additionally perform a blocking lock on the
> console_lock.

Sorry, I was just thinking about the flushing component of
pr_flush(). Later in the function it takes the console_lock even for
CONFIG_PREEMPT_RT. So please do _not_ have a guard.

pr_flush() should never hang on the console_lock during shutdown, but if
does, that is something that will need to be debugged and fixed.

@pmladek: Looking forward to reading your input on this.

John
