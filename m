Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6D37BE81
	for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789298949; cv=none; b=lXSHNqTn3A5lPDhzootIGfge4kBFoC90jW1lukTNJ3xwcpb5LlNTtbELe099N44ewzKy1wOouA+GOHH7bc2JvqEInCdxetwP10tRjc20XuSgButXI2Rmp3H3fIicsJLnODt7BInBClVQ/bI+nCcssJ1EsnYTwhHfI6n1PzeGDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789298949; c=relaxed/simple;
	bh=Tj8qk0XwgG6OI6eappubnNJZNj7JVE4Eznyplit1vfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw5OSTAP1ZZsSajiTD+AhSI3obuBYjrCPhTq/8+5TCTyUD+rW1Ge+QaaHHXlGUothEYiW6/8EJwfzSxJLTPjv9vobFOsloseopQ7YfBz2RiwwIcIvQQpoIh2zlyisg1+cfuyFuibrUgNPy3l8uxiDb68ws17TsqW65lFyaWumbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCAbM6aM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCAbM6aM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so7344855e9.2
        for <rcu@vger.kernel.org>; Sun, 13 Sep 2026 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789298946; x=1789903746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8/tv6bYjr/JxaCBgXPuXjqSK44p/M/ZKAj7rPsQHeE=;
        b=TCAbM6aMgt4CNBcwAm76o0w4qBImbbdr1uw7o6QOWqjTkAEBk8sC9r0NPDvKkcz7HS
         OTByZNqKT1gTq7ZS4b/WlCR2kXfuJ8+MXvRbmS/aw1cG48lSQZg0P6guMqB1esqsWH7m
         EjZnBXlMs1N0dPccOm9gPspEd7iuPafYVHONk9U2QS1A7LKhAuZjjcdqtL9tU2QR/K9Y
         miTa9ghh0HlG2iwYE/4bTo1oHPMeQwLSQdSlLSumanabf9WkS7E66q18Ii5mKLwx6BHo
         5IqtJIHyJvxVFSY/3lVF/dOOlhyYsTP1uyCURzY/dVs8HnBoNL2lBT4+JoPlC7v7zSCc
         pmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789298946; x=1789903746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8/tv6bYjr/JxaCBgXPuXjqSK44p/M/ZKAj7rPsQHeE=;
        b=LvCJGjDc0DDv2g/jFPyrTErXaN5fOeqZMIO711Sy4Pi18K+LXeMW1wc83odOt9kk1P
         a2WSitCiwI1r65hww8Ou4JW9p8NjPUw2Pps6u30fXgELumnTCeYHm8XYgmYvSLTQXR1t
         Txvl6YmCbqoBMIxShvurJ3lLjcPlWZhiMsZigMaTeEOG+IbPY2rTluUCQ1XRnSz7eVoJ
         tQWFha+MRKsMEK0vbMxyEnoICsSFxnntXfjNZhH1ED4U/bmiyG3v4xweiS9TgGWwriEg
         qzYA4ZTeeKQj+d8MehKvjCaKwvDkIkym0IjpZBOf1dZtVupKbeRWNWCTpvGw35sA5iHF
         BHIA==
X-Forwarded-Encrypted: i=1; AKwUvBz9vBq8N1JueS5Yd7CbBf/iZnAmHkSwkKUe3J1LkBfss+1WEKjR+6dr8q97L/J8laLDhxM=@vger.kernel.org
X-Gm-Message-State: AFuF++lE5XJ+Lz4MKODGtNL+yt4TwfTtJUNLKKcLNBcPF32bMGG7Q5u1
	EEWC+rNHpQIWohgxS1KNv+NiSVg4ByXri1UHdZrPr3JCM+qpuPWE48ZP
X-Gm-Gg: AYBFou1pmymfm/dqolA22qwY0YvjzZe0HxazDEgTCLb/lEy7vyXJ9KZY60E/jg9rOvC
	GqNgdNP1Ofr1YvmMZxvDBi9R8hsPkpx0jcti82qNjDxnJY4ZRWg0TEpp5rmFiow5RyehOk8Oa/+
	RKCoyoCcRZk1mTFdH2ptE4oCsQ0cjmjg5jx6ku5PbO1hssqLV/FlSjQl7vfHgf4+qy/lObIHkfO
	yy9kznzmQiUz9Z1Ez1aTiBUEwl588KIRmeQCkvyjLKNfNInYpHHh4On2qhvI1Ejgz3APMjn5Phv
	9S2ws6mJnz7PNeFtP2bM4cEd1mtchHiK4J6fWcnPmATI5+Yxjk+qu0Zu30wlupV0FkM+pE4ivkF
	Nci58NoIzMgoTCzmqYV7RG9dr6T0P5ny8pxB2qDVyIdF3KOMNHbRUbLc56VDGCz+OxhCEnrLjgI
	GL+QYF2zgFVB2/nl3P1gRJznV6BXPtef44V71ZCinbDDnebWtNtu2SeFvZ9hP01HUHAtQ5YC1uJ
	sknAHKhJPF+jX9oHwSYZshHwCjbz7RyWoI2
X-Received: by 2002:a05:600c:4ecc:b0:49e:6be6:d783 with SMTP id 5b1f17b1804b1-49e6be6d9dbmr138768675e9.0.1789298945625;
        Sun, 13 Sep 2026 04:29:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm17806381f8f.10.2026.09.13.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 04:29:05 -0700 (PDT)
Date: Sun, 13 Sep 2026 12:28:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Josef Bacik
 <josef@toxicpanda.com>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, x86@kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Andy
 Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
Message-ID: <20260913122859.4d5067cd@pumpkin>
In-Reply-To: <ffffa178-c475-4249-a609-c5d222704987@paulmck-laptop>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
	<20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
	<DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>
	<14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
	<DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com>
	<8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
	<20260912221400.4045198b@pumpkin>
	<ffffa178-c475-4249-a609-c5d222704987@paulmck-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 15:31:24 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Sat, Sep 12, 2026 at 10:14:00PM +0100, David Laight wrote:
> > On Sat, 12 Sep 2026 11:03:34 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > In the old kernels, yes, we have current->trc_reader_nesting++.
> > > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > > other thins is a bit faster and does not need to hook into the scheduler.  
> > 
> > Isn't that rather architecture dependant?
> > It is fine on x86, but on arm incrementing a per-cpu variable is
> > significantly expensive.  
> 
> Last I heard, slow ARM increments of per-CPU variables were to be a
> transitory phenomemon.  Plus changes late last year greatly sped up the
> per-CPU increment operations.

There are some unapplied patches to improve per-cpu operations for both
arm64 and s390.
Without those preemption has to be disabled (in current->xxx) which requires
a conditional call in the preempt enable path.

David

> Plus this change removed some hundreds
> of lines of RCU code.
> 
> 							Thanx, Paul
> 

