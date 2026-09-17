Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C127C162
	for <rcu@vger.kernel.org>; Thu, 17 Sep 2026 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607833; cv=none; b=UKJciNb0XdqP5EH0jY0XVOQpOZFifIzUSm4ai0y5lSzoWHorrhp7pCVUTTJtkS44haApK/zR3urYbk6zJVeTLenJSk5Q8WGHGznaq+aC0Vymm4cZ7uwvQVRxlQYd97Lg95iCGLKdy5Rjm9l9zcKzQXuHOyeNnC0R/sPt1vQD8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607833; c=relaxed/simple;
	bh=3fICS9Csi+nlJQK43ytP+dop+wq8MBzte5BeTYJ0koo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDmS6qNciBzkq8f1+3A7Ad5KVma/39NnJ8LfAE/hh5G2iGhZn1IzgYk4dcQdBdYsYsxMxgIUD89LaTUXukc0nzCF6bVOYQxmWZpACvKHenApcuw8PWymzvCHdPoJgJBFAXLk2IO2Wffx1IQ5NeaZNlVx2xCiH5LWwHi3njwl2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=NuucbmMw; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="NuucbmMw"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb767cc97so2136951cf.3
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789607831; x=1790212631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5zFJ55cgnEY1OXRIavKUOEIG38H34pgZ3VgFg2bzwY=;
        b=NuucbmMwYB4rH4LdRz3rj+oUbzdl2pMAlrFl7js/lFG2OHxI06CjJtAFlNYeIWYgWc
         LOvPOwuYYcIFYxsnkb96dz6qi6uhawdiYNSt7ClpcxkPrPFqFSy2oVhXRQnMCYQuFarC
         y89aYxmRrxYboR06vMqzQU24Tm8b58j/qalTYBXmRhB6U95wFsU5NbwvWt2xt/FUlp3d
         fiFbursIuDNdBjHockPrWaBPAZp9jUaJtkvXCYvepgUQyM/blMO4Il8/S2UBMVmebDXn
         214o8+doZShoWzIX5WWWOTBtWUADeNz5c3TK/HQmyLdLaW96Y3nW7WnE4qNAt3th1kKR
         xDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607831; x=1790212631;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5zFJ55cgnEY1OXRIavKUOEIG38H34pgZ3VgFg2bzwY=;
        b=HKC0z7H3qZUhyms+DqjjEXHev8yZ/IWy+Ysg++SiknpQht4a0LhpnXv0lIBHCiqAlv
         0/vxARQq9W26kruiJvpxafJa+5jzdJldIpLl1Cu7O04DGEq9Uv8j7zZIRVsz85LW5aJf
         uB6ujixzMWx5leUjKhuD7g6W9LUf5B7w9uCJi+LVFO5xYMwYCrcOU1AJKQxDjZ/c8INM
         U+kdWvGuImGKkzrnmfFetHetyhY6tULqaRYQTEQkETcU8fyeAgaUPEoiiSja5bv5dA6F
         KWSUJDM5ItzbtB/3UtgD98Lndftm93QYlRMQGYf4Rl2VSlj+XM2g6jwQ0AYfZ2vEKKZB
         zhhA==
X-Forwarded-Encrypted: i=1; AKwUvBwEdfZAy0sjTBUBe+qIzWMqc+r1CKHtG7J3hrkD6pMfoiR3bEJqmOzjlSI1umJqnjZSTX0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVo60iZ1yiY3FxUCZcNNvBD7cTY1qJ7YAjCxD60agr2uMoxdlH
	exsdxeGDPa+4HDdFkRnlUwRS0JEtDwY3ySz3TYBEKlNO1/s0hEXWgdOGmWkncSUBhQo=
X-Gm-Gg: AYBFou2plXFwcHGk0YQfZYFBBAIljpxtn/AQri8D8hokltVcQUU4gcNidd3fGofIj6U
	I9LGUAGTlxMU24ZLGgBtJFNlpYqX5pw6wQkCWWyRAIGqiJfghpzrwNZDnFIyTcsiD6zPeqxyM/f
	mexKuSh1Gz7I3ekcW/aEO6a56DcXaIWo+/9mWIxjEAcS7cGjMxviJ2FMhuXW3P0GiTli6zUb4Ys
	hAmmetIORyz74ClxAJdeFnaKTj7/S+MtXA1qrlUH1vTsJh5UFkLGwtWiRvs1UgEGw3i1nGjcGxZ
	INpTzYBthDaOvG0UK2Kc6QHAjxswxTmjszPqPw1TWNfgGcwD8ejzZXjZLDbrxVe9imwisV1yoSA
	fK8zAj32pa855oeUNKivs93oz7owxCHFsjOFiC5K+5cThNnDAnwfWn3zQmwsDbq5EKujK3qRtvT
	SphW0/kdB7M3eHtQwsMATVtd+JtYMXPOzvMy1/mOtoyQvhdxe6BHVm+jjblfsWOv9X49fD50rUD
	A16oAF32fLA+QL3kY3rn65n8E0KExBwLPK8oirroiqSlECpTVyn8Q/y
X-Received: by 2002:a05:622a:1a93:b0:530:4249:e7a9 with SMTP id d75a77b69052e-5327ed78742mr91407171cf.13.1789607830859;
        Wed, 16 Sep 2026 18:17:10 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326200b8d1sm35571491cf.12.2026.09.16.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:17:09 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:16:58 +0000
Message-ID: <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the trampoline glue
In-Reply-To: <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com> <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 03:45:16 +0000, Alexei Starovoitov wrote:
> On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> >  	__acquires(RCU)
> >  {
> > +	bpf_tramp_read_lock_trace();
> >  	rcu_read_lock_dont_migrate();
>
> This is double increment. rcu_read_lock_dont_migrate() includes
> rcu_read_lock_trace().

Unless I'm looking at the wrong tree it doesn't, on Linus' master and on
bpf-next it is

	static __always_inline void rcu_read_lock_dont_migrate(void)
	{
		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
			migrate_disable();
		rcu_read_lock();
	}

so plain RCU plus migrate_disable(), no Tasks Trace reader. That is why
the non-sleepable glue needs one added here: on these architectures the
trampoline image the glue returns into is only kept alive by Tasks RCU
while the task is a rcu_read_lock_trace() reader, and rcu_read_lock()
does not give us that.

It is two counters for a non-sleepable prog on x86-64/arm64 though,
rcu_read_lock()'s and trc_reader_nesting plus the SRCU-fast percpu one,
if that is what you meant. I don't see a way around it short of not
using Tasks Trace as the trampoline reader: the prog still needs plain
RCU for everything it dereferences, and the image needs something that
survives preemption. It is compiled out on every other configuration and
nothing changes in the JITed image. If you would rather the reader be
taken once around the whole image in the JIT instead of per prog in the
glue (which would also let the fentry-only teardown stay a single grace
period), I can do that for x86 and arm64, it is what v2 did with the
private counter.

Separately, Junseo's "bpf: keep trampoline progs alive until image
release" also adds bpf_tramp_image::nr_progs; if that lands first I will
just use it here.

Thanks,

Josef
