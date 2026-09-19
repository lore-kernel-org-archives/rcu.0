Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145073546D7;
	Sat, 19 Sep 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862364; cv=none; b=IEHZVYcGz/ElC48o0VPhTvBKzzooClWAdISsB+WFFdvB+wsx6TPoEKLxqaae5CadPskIFq+TQdrDCWNiGXwBohUcumJio08bv55X/2lEmp7zkIaBXkCWTXkAotIwrPj6vxcWM/YEWaM/6cbH/gb6ggNVzNCR473pySKniuYsKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862364; c=relaxed/simple;
	bh=rAhVNDiL11CVY48zH2oCKIRAYv0Q6pkIWHnxHVKp9Lg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OI8mGIasCmoBEG5wY0/Xi4agJgkd+L5MJAf6N5bOy6kxIDBoHweMIzTEx4OKn2OaQfkr25115t0yl30Bwg4jbvLPXCayB78P7zBfmxUJ/ccJn/lfdDlaN7wRZY7QDdzjscINsE2UImZdh9mlhjlP2mS2WyAWu8Z+mYrFCdvG9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=r8xwZZWf; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=9RyAbuNy; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="r8xwZZWf";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9RyAbuNy"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789862290; bh=pY6k578HAOH4JwKTJoaKCmp
	Jhb02KWQm0IuRCXWcjGI=; b=r8xwZZWfswZEzq1GcsmKlLofGD/op0oLwpha/c4V6+lKMYBgcz
	4q1m3icfYOa1yeeMOgHFBRnU0vmnkLdkOVVj5Lj31EV3yuvvSVoHFe6GtF2JGoG26Q1QPoNltXO
	Tqp7P0vWiUgx4GqCiFjhwt+KSplMLGHZdjJvb5O7K3F4XPVvjkLmW5bQjWxRYmvmwNIMalFfqVY
	8n7bPpmeN/pg9c/OtcLEF1GCBAR885Zdifk4TmrGW+QqbzQlkwx2hUxAjJR8gEWWsUjKz5qPgzr
	466Ss12BpkY18bFns6Ywbj738BJBx0+vEitSKezaiO66ZrNuha2/GRfTgAM5/XRf0BA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789862290; bh=pY6k578HAOH4JwKTJoaKCmp
	Jhb02KWQm0IuRCXWcjGI=; b=9RyAbuNyB3FsFzP95+hiYvrWbusSXlA8maMnSi3RU0Z10tbDlF
	L1TbfAjP1xllfOdKbkEdfYW+gxnhnK9AiRAg==;
Date: Sun, 20 Sep 2026 00:58:10 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>,
 Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-mm@kvack.org
Subject: Re: [PATCH 01/28] hazptr: Implement Hazard Pointers
In-Reply-To: <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop> <20260919000056.3132131-1-paulmck@kernel.org> <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com> <6B1FC39D-6EB0-433A-8E49-E5EFC9379AD7@mainlining.org> <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
Message-ID: <4C1A2E71-BC0E-4512-9991-7974BF17069D@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 September 2026 18:00:06 BST, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>On Sat, 19 Sept 2026 at 09:35, Bradley Morgan <brads@mainlining.org>
>wrote:
>>
>> I think hazard pointers are good, what test do YOU suggest we do here?
>

Whew! Talking to my idol, best day ever.

>I want to see a single real-world example of "look, this speeds this
>real load up by 10%, and the kernel code was actually cleaned up in
>the process because hazard pointers are great".

well they are, but the big maintainer blokes would want to test and stuff.

I'm just a measly reviewer.

>
>Not a microbenchmark that tests just the hazard pointers themselves,
>but a real kernel feature that has been converted to hazard pointers,
>and in the process actually shows improvement.
>
>The ONLY reason for hazard pointers to ever be merged is if they
>actually buy us something real.
>
>So I want to see that 'real" thing.
>
>I want to see how easy/hard it is to actually convert a real current
>user, and I want to see how it actually results in measurable
>improvements in performance.
>
>Something *core*. Something that everybody uses. Because I'm not in
>the least interested in a new subtle feature that interacts with the
>scheduler and is only used for some random driver or (to pick the only
>example I have ever seen) AppArmor.
>
>Now, obviously, the thing that would impress me is something like the
>dcache. If *that* can be converted, and it shows real improvements on
>some real benchmark, then I'm sold.
>
>Now, I don't really expect that kind of major test-case, but I do
>expect *something* meaningful. Not a driver. Not a test module. Real
>code.
>
>IOW: "Show me the money".
>
>Because the kernel is *not* some kind of acadmic project. Never has been.
>
>I simply don't want to merge something that is touted as an
>alterantive to RCU - which we obviously depend on very very heavily -
>without something *major* that actually uses it and shows the
>real-world advantages.
>
>The discussion about hazard pointers in the kernel has been around for
>a few years by now. If there isn't some real core feature that was
>converted to show that, then I think that's already a failure
>indication.
>
>I'm hoping that those patches and numbers already exist, and I just
>haven't seen them.

I hope this ends up being merged.

>
>                  Linus
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
