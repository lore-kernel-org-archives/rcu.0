Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EB347BC4
	for <rcu@vger.kernel.org>; Mon, 22 Jun 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155036; cv=none; b=ESDDOX1Vc7SXIlYypSWO0VpTiO2iWVYefsEhW3czottA5df/jzUMFylGnyrbl4qXOAk2MwEEtJaqclDFiTTBmawvtOFcPDYe4YSiYGyVwOBDm7WGvTI5SwCuSOEFieYz4D7Z600Yel5nD95UGHtvGdu9gLs1V4Da3y/FWJi1iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155036; c=relaxed/simple;
	bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdhP0mbb7Bt6kl/eOrcP/054iSE/N1T3otV7WefP3qpblwzbs6r0eoInL4pWnQ4N0l2/RsU2Rl9Xde+HiW5/cscOLm7KkDVyOu/dw7mJuQSiG7JHKg5mBdaGyis4utNUTe3jo+JEPCEPkekS1edQpO0XxTrhaTCRSx1QWV37lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFiZE21b; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFiZE21b"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c0a352e33so197602eec.0
        for <rcu@vger.kernel.org>; Mon, 22 Jun 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155033; x=1782759833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=LFiZE21bJOd27mvhUeQY65zQorGfroSNylZhnl5pr3qjxqG/eN1p6cReYMi7Y8XHb0
         7P2yUKScTc7SL9KBMwdl8WT1nEKnGZf9ur45NKJJuEmRNsVr4TarSwghnJCBC39U5FT/
         hbLMbAuZB7Uhid7P768tqQ5oB5rNa0UgEghjqL8I6E/OiecFdkW7XXJUCVzAvM2Bcvqj
         aAAg70ofC8G+A3+uW7Vx2nk3e0tc12ATFJvEbWA6+4EjPe4CrUqJXP2Emg2HT57KZ67b
         LsX6aiKqdjYFThFXLMKvM5eHENHiOf+kS4D8rdkQabgcObx3aWN/R9FVWrU0LGgqTlRe
         mYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155033; x=1782759833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=g6h5wjIiCK6Z52IUYGHg2SYT/LhJsKLu4+HkR1trsW2kWTshfMa1dsnma4+KMj0GcJ
         tWHx724KzrD1JWBrHxCAcLlf38uJcei5QFyvLuXGr0WsxBJzWKFe4ixd8hA1Ez1K5jdf
         hT7D3LSxj44IESXvEWWDYWn1Fek4imjWLes0acaf766ZCsDN3eqnLJtq/MZgnM5ddDrL
         9FiMlPYui772hmKIe+G7/Psc1cCyxM9xs1zqqXWIGqLGr5OYG+I/sMyO39J3wOgLLTyc
         c4uxpLD2DuA5QxIzVnL32bAH0gX1Azxo0aJFoLLJoZknd9h87WcQ68mX4at2dxIoimMQ
         Vgdw==
X-Forwarded-Encrypted: i=1; AHgh+Rpkkh981aGVG68InZgFZZdXZdJGrO/sIVYX4jrvSOBkd5iMmyTOhihjv1HRoastu4zpx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJdpwZ3psuhjlcxbCxE3OSZW1SoFSRiMwzcZ9ZW1Z9O4fFUUq
	UtDhOBuc4PQYoeHSbRBlExHw7rDmRehGqfI3kqdTe+tbe7TrpNC2iWLr
X-Gm-Gg: AfdE7ckEA4DzJKIeXYA3NUDbaKxzEJROMtlzVp+w/umKOXXzHw+a7are84wp3cq4RpQ
	vmcmDo8H1kC5k0DI3E4zS41bc7bd8995Sgw3V5aqrrKHI9+Tt3jQ/AJDO+JkBRFlYpX2Ahrl0d2
	aJqzxsGuOAuYYIPH8zBGUb1IeJRdVsZ5muBZUU5ERLJDFdI7lOalVEAVmqG7/e47ZvBQw3F7vwc
	/udvnCo8LCiAONUisb1aKGX5QIYhJui8BWh8hUJkP3k7PalJ3v4J9jWeLudMw2DkR/j1/tvh7oW
	5iEktoU3XWKKMRSQgHHHSAXpGwxN3hm6qSxBhqO4WPAOrXYcSDU/xU9G1+usgK8o/HvwcX5VL+a
	l4thKQLPHRrPbkYpJY/CTwsZqIkkkBfCfAn35XgKW6Y+TBzYpvC3fuXJvMHp2+IOOQ1m8lS6/Y5
	DocweuK9j0NzS0bsL4582rCuDp7FX/5TBGIIQlqeef7HhAdCO5El934Be+Kfkr/DIl2Ho=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id 5a478bee46e88-30c5553b105mr382073eec.7.1782155033135;
        Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm10549199eec.26.2026.06.22.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:03:52 -0700 (PDT)
Message-ID: <1979fc81ae7bdaabda8616cd9698a40ef8bbfaee.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Paul Moore <paul@paul-moore.com>,
  Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Maarten Lankhorst	 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock	 <natalie.vock@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov	 <oleg@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport	 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Josh Poimboeuf	 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes	 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Will
 Deacon <will@kernel.org>,  Boqun Feng <boqun@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,  Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, John Stultz	
 <jstultz@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Nathan Chancellor <nathan@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, David Vernet	 <void@manifault.com>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	netdev@vger.kernel.org, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	kexec@lists.infradead.org,
 live-patching@vger.kernel.org, 	linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, 	llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Date: Mon, 22 Jun 2026 12:03:46 -0700
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	 <20260622042811.31684-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 12:28 +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> The safe list iteration helpers require callers to provide a temporary
> cursor even when the cursor is only used internally by the loop. This
> leaves many functions with otherwise unused variables whose only purpose
> is to satisfy the old iterator interface.
>=20
> Use the mutable list iteration helpers for those cases. The mutable
> helpers keep the same removal-safe traversal semantics, while allowing
> the temporary cursor to be internal to the macro when the caller does
> not need to observe it.
>=20
> Convert list, hlist and llist users under kernel/ where the temporary
> cursor is not used outside the iteration. Keep the explicit cursor form
> where the next entry is still needed by the surrounding code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Beside the fact that this does not apply,
I don't see a reason why is this needed for BPF sub-tree.

[...]
