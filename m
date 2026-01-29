Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77037C0F7
	for <rcu@vger.kernel.org>; Thu, 29 Jan 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686006; cv=pass; b=rC3/zJMgy0SnM2qJEbDPq5OA8su61tnz7EDnIYkzBDAXiMBWuCo6ORsxv63wY8tBEKdQkLswDDStwZKnFhJllJEyfn1D4dyXg1xdB1+96xfa+GV1MWapl0c5Fpv2IjIhs6/kNQiyx0E6mtwiUL0q5WJw7DXAZREEWMtKR0IQnyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686006; c=relaxed/simple;
	bh=rTBwobW7blgjKHgIg8gbEPiJ438NMcLNfvtouebEM2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISMYKbHK+iMfPm78iUBmm8W6wdXM0UT3ciDlyj+6b9jqE5HdG83Zw2OpwYWDk5FQhivFUPtmQ3urqA/OxiV8YxZhnEgDagMhspEYkNw+HeT1FA4QjGFDa5V+LYz8mH+UFNWhfC7mZKcSfUdeYow2n3TXHyw0JzleDstD7XBxn7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Obs72H; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Obs72H"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124a7216c9cso80178c88.0
        for <rcu@vger.kernel.org>; Thu, 29 Jan 2026 03:26:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769686004; cv=none;
        d=google.com; s=arc-20240605;
        b=kYayQuOJHR7doFxVseg711SZGMNEFzFUxIecYsR9d/xelehSO22hiaUw1NuNSGPSL/
         kuiMIQGOMz5dnnK8VlU8ht+/STBjQ6kjj2ti/ubgHwnRc0rUYPoQF45KIJdcVlvTciO6
         0s8pg7iujAobXH0/4fDIZ+b+nuU3owzI5Rum1KHkzde19ILgPyTDKFt1YGlS+3v20PQu
         g3HlipYV0JG3VKfCkGPZsY2TDfsxr6ycL/FGQc50jmaCo7YlYwONmyhSFHRbZfuGGheR
         hEdB8BQ0/4wB6JdvIBLr1qfo6IOkxLHxrTIleOOnGvg+jcXEvOb+B+sNMfY3ajo7NFc+
         Jv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rTBwobW7blgjKHgIg8gbEPiJ438NMcLNfvtouebEM2Y=;
        fh=XRwNbsvZyNSov0tMKt9gkbcwMiMhiQF9fJBgUBjO5FM=;
        b=QenfT/MUs5Gj2m0aMKIGUH4Si8rnrZFpOz7eyvjcszsyTlm23MUYlTl6iFoy8mypsW
         flQSSGE03Lwp5XmFx2OOT7LrJRjw6RENJqQE5kpOs09YrFKp950O8MQMTcfZ64A6HyJ/
         U9te6Zhqnsy+ag/0cj39RHcYjCombDKcm1G6GrMJmddrqMjMUrq4LDU/dt0Ko6U4PKiu
         PP9TEmpxOBF5seV6Nf7omGcg9MPPh5VJgBOjLad0/mgSGB7tctAvSi/mkqmMvvf16CDK
         vNLSjiDx/vnaKSe5z1m9xfVW1mQwghnmt0u+NFJ3LieiJ823oA2bsRUK7Eg/ayaIgg3O
         3PXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769686004; x=1770290804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTBwobW7blgjKHgIg8gbEPiJ438NMcLNfvtouebEM2Y=;
        b=h2Obs72HAaigq9JycZG2ZT3H2dsshQ+XnW2//01/iRP8tnF8Ss9U9Ga4gi3FFGnr3c
         8kmxDVE5NW3DzpwIZMOiJ4iCx1RjiqOSUp9rQrIwe/FmJiMdyXODaI/OaxKcICf4Raxv
         SVKj/7mGDjqbNM0otsolLu/uK8t20RJfTwV+0kcvCDooMZQCNvm+RUjtRCiAVHL5iBl+
         kkIlumkLpWsW1s7Ip0e6wbbX9QEAj78bRK3NOb8bLPXgvMy7ZE32k1H+RCQh2biR3oIn
         BJsXmwVq3WbzIk1QcQnppKhcI71iIRKpzap/7Pg+Gpb62N15GxnZs8uLJTxEX3IkI/zb
         Y1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769686004; x=1770290804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rTBwobW7blgjKHgIg8gbEPiJ438NMcLNfvtouebEM2Y=;
        b=Lx47+FtYbvezfgSOQfuznLoX8ePwsrxMyoag4r+OXp0SVPAB6LGkzURWK/b3u0whND
         tZVrn1S/Gg9R58+snImFTkJd81MbCQagankmgfdv+ymfZ/8nkimDdqrwlWzk2Kjk2G+c
         KsAndML285iWDN5xRkvqG2QWSZNyeO0JzVs7LHF1BO5+kY0ppidtduHz2T9+bSwvgUxn
         ig1A1lqp1e3iRccdeYFAfR2aTVJk12lRjb0JFvJ0RO2g9cYJ0bIr9OaRRWLAlYuTFT0B
         b6LUnpD93Kn2yhTVtEI1ABgQdVZz0bmugzzHiKH0YV8E2+bsUkLk6Eohis67ff3GKFcd
         cuow==
X-Forwarded-Encrypted: i=1; AJvYcCXV+0IUTrMtTv3Tdf2NrNt+qcPCXToGVuZACfL/WNhAgNTAG0DRHq3XSFWSB/OiHaDf8ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsdxi54oqHN5yxifms6DrmVzup/dJSSiT/6vTgqDGnRtOZhUFk
	a7emc55lkhbqaEu3bU31GMwJdAFHJ7KC+ygwoh5HcC4Vv8YsbWYjHIyD8TXpIwnZw7CYvkjhJH+
	hAM9n0pgaEfwuv7njdQ/lvzXQB2FEVSo=
X-Gm-Gg: AZuq6aK7jrAb19qaWZM9pYnHSrHRJ7XQXeFGkGZJQSE3DCmJRveiCJx8LyyDqQJ9Pde
	ZX0sn729Nq55jrCu+DHox2MhJAPHMSygiAyyGpo4OqZ8MJNXfZ8vaFplm9jgfQNpDmWjmhe8bX2
	i34q0pwSxF6RiaVFwQqUPURRtzsPELOctWhcjHKfM6KFcmR9JFo+ctec+TIBz53JCVRFc9ObFeO
	5UJExdwFJTeNCFFmdsniGlTpD+FJi578hWuAExnoWPtw4a+U7BSB62MSEtftCgv+OjSSKeP9azJ
	swd2GNz6t2rt9Yg62hnYmfdVBXdo9pNzrIIEkyA/ZKvOwzEOC7DSI5o3NYOwihBI0PJxfVda6ck
	+kRVX+YcJ15dgeGDx8iD0ujQ=
X-Received: by 2002:a05:7301:4b03:b0:2af:7427:30b with SMTP id
 5a478bee46e88-2b7aeee373fmr959224eec.1.1769686004277; Thu, 29 Jan 2026
 03:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129004520.62697-1-boqun@kernel.org>
In-Reply-To: <20260129004520.62697-1-boqun@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Jan 2026 12:26:32 +0100
X-Gm-Features: AZwV_QjEigWgVtwlfTZvvep8-dxvVBHL09lG7swXUdQJFwhVozQ7aNFZLFhFcLE
Message-ID: <CANiq72=p9ZY2GWgnu=wYbNUQE3mxRsa3KMfkEnJV++X=mhTcXw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	rcu@vger.kernel.org, lkmm@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:45=E2=80=AFAM Boqun Feng <boqun@kernel.org> wrote=
:
>
> I had issues using my gmail account multiple times this week, hence
> switch to @kernel.org.

I will apply the patch unless you or someone else wants to route it differe=
ntly.

Gmail is definitely giving pain to a few people this January...

Cheers,
Miguel
