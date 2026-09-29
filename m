Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023273D45FE
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693244; cv=none; b=UkmOExXOT7C5T3hA9MCeU/0nI2CeB4KeSca4mZkCfYt2X0hxyDax5tofyXIfXyLHlvJPV1hvGSrU9vDmQXnxDaWps8kvIKNGgkP0lR/IqUp67z6VaJhDKn6Px+rBedz/6P8eE4Pb4k54uh6fYXZ8XtgyKLz4X5qaLnDn2+YIeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693244; c=relaxed/simple;
	bh=SLmPCj6Drkarz6MGesiMP1GtPbh4rsUc3J8b1Kcoqwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSSHz0OjA7oTcgS62IVk2l95U3UBKHyidtH0re67rQLnyNbU4JsHJ4JKAoimQOS0vB1sGb0Z8b3ZHA/1afiZzWUNOuWn10PE1hfqSrnPjMXU2H9m3T9VVR4xFXe+ojb9NYAMyvCLXz/P9D3T3jVSdDYz2VMslc/ZYW8q2j0VnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fca3M88A; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fca3M88A"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbdcb4f59so445528166b.0
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790693240; x=1791298040; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IP+IFTLJhHPOzVgLZORkj6YpvpTLDjx8asIrhC/8Liw=;
        b=Fca3M88AwTm/Qnvt0P2TOGxBjE1RNIr3Mr2YYA17rg3M++6WFj2XZ+VTVP88v8H1Uj
         q8+dcqgB44bv+/BgyVNttO1qNJwdUAz7AZV9q1agplXqYPW8J+byLyTwFySSJ5qjzU63
         LBoxXYGALap/brtuogIq1UEuiFnFw9TUU+HmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693240; x=1791298040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IP+IFTLJhHPOzVgLZORkj6YpvpTLDjx8asIrhC/8Liw=;
        b=ZcEzIuftenuoZPzqQMGzC/aBiT2nYhwLChe4VXcJZo/xQw9Rnwf2SNCQ8XitF7CD9f
         5ORCV+bsavYb6ybRqFwl7TeDnxFd4opPjl6CU1TR6UtO/eUy8DMT1CnbJ+E8FzPjHnxW
         oXEHKp+YBj8DBaUYu36s+s+4a/Abp84GGsQD8PuLt3o/xkBl8KJCSGh7D/2BjarHD3lJ
         wdyEKFHaT9N9NYurtlIAl1rjSxk0G5h6vc86iCcfvus9lZl/CnJuImDSVq8gB4C2PX2Q
         t43ouX+B8Un9Tbuk1vnDgL+3TqRzcRkokxj529kYzYpIWyEwoJtF9VWgpzm1H7PWJwpu
         1rtg==
X-Forwarded-Encrypted: i=1; AKwUvBwXpoYNNaIYuXOPVsUrC4GlrBF9hiZJ/J+UnfXzE0Bb4Zq2BmIJ+4hd3sOeachoUZrgnZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mGyUddoL+7/yVkCz2ZhLqgzDKQK9DSSe9OTGHhklAx+Rp0ZC9m
	kDmMRD0Hs85TRaWxLzo9zt5Mwh5fA6AC45PDdZvH8bQ2eE01aS1anlrn6VxSnv6tbnf/NysCh+q
	CDSrekEs=
X-Gm-Gg: AYBFou1XlNl1YbBmfA2nlxh4NVd3Dxxe6plEsNmFCoxLYsVwQj9v1F04Gw6YetSSHyK
	flM01AHLRyHGnvqYusDXbrRljm9fNXJv6M9v0UwtxLx1I77jR6KRN6LqK43OHL63xQsIXZGCndO
	wfItILtD50iWxKZ1/A9VRL9x7g6X1uLD3OicnPWSbSz9Q02pu4IhMnn+NZtaabvmLLcIErrS8F5
	foa/E4GR3deZeM2s6tVnsYQJYRj48MirbEDvkHpbnFEzCQltwnYe4ajeaevJ3V4gJIgiAOSlQIx
	di1+9KBMZEt83JICX8mZFApLNc/lJml+ksBlDo+SrpZ1P9GsuiDFqh5ZtHZFttnGm31wOfKNEvf
	pKhxmLKZ64MrMBCq2t0fy7gT7zo2dC/4OScvUaUeJGGK7Ff6piZW25vFLkiZAwpN58EZZ1PDc6E
	cUvgfc2WIwmUhz/0eV12qcFt0JQbHhAlqB0N9Dw4sQToeiFu/hrqsKbWbBxlQ6IoqIBdQSqvPvX
	DRTeFJZtjtu+zOgIUd2IWPOWC9lySKlifuGtHn67MbQ4LdIUvc=
X-Received: by 2002:a17:907:3ea7:b0:c25:5a7:87f with SMTP id a640c23a62f3a-c2ac2163c4cmr1389959866b.0.1790693240097;
        Tue, 29 Sep 2026 07:47:20 -0700 (PDT)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com. [74.125.228.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3a0424sm452922566b.70.2026.09.29.07.47.17
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 07:47:17 -0700 (PDT)
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af43c5b0cso553575066b.1
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 07:47:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzyRkFH8qn9mf6NAKQGppwr9r/tY189Vd0IkgDDOJUP/Ku9fw8OTCllspisXC7z/8Uoais=@vger.kernel.org
X-Received: by 2002:a17:907:c491:b0:c26:1648:a06f with SMTP id
 a640c23a62f3a-c2ac253fd57mr1427153166b.42.1790693237251; Tue, 29 Sep 2026
 07:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com> <20260927155134.4740-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20260927155134.4740-3-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Sep 2026 07:47:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQyCdrWH3ZuSajOxZqiups6jYbPtqY8JR8OeS7yi49Mg@mail.gmail.com>
X-Gm-Features: AclHuK-hIyKMMCYq0m6RbVGEdDaE41y87jUOezwgP_JOLXBYBmnHdH3WXkY-n-A
Message-ID: <CAHk-=wgQyCdrWH3ZuSajOxZqiups6jYbPtqY8JR8OeS7yi49Mg@mail.gmail.com>
Subject: Re: [PATCH hazptr 2/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Sept 2026 at 08:51, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> +static __always_inline
> +int ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +       OPTIMIZER_HIDE_VAR(a);
> +       OPTIMIZER_HIDE_VAR(b);
> +       return a == b;
> +}

I had to think about why I hate this so much.

It's probably entirely senseless, but this just rubs me the wrong way.
Those OPTIMIZER_HIDE_VAR() statements are hiding the wrong thing. They
are telling the compiler to treat valid information (the pointers) as
if they had changed, so then the compiler will have to just reload
those pointers when they are used later (and "used later" is part of
the whole *point* of this, after all).

But it was never the pointer values that needed hiding from the
compiler. It's always just the comparison. And while the "optimal"
thing would be to just do something like

  static __always_inline bool ptr_eq(const volatile void *a, const
volatile void *b)
  {
        bool ret;
        asm("cmpq %0,%1":"=@ccz" (ret):"r" (a),"r"(b))
        return ret;
  }

that is an architecture-specific thing - and then have that
OPTIMIZER_HIDE_VAR() available as a fallback.

I don't know if it's really worth it, but I really do despise that
"hide the wrong values" thing that generates two new values just to
compare them and throw them away, and adds register pressure for no
good reason.

               Linus
