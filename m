Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696D3016FB;
	Sat, 12 Sep 2026 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789252285; cv=none; b=Y/SXfcsDTX2TbB3rGeHLP7lNE2qHnJ45BnX5UHdCkGKxPqFTl+7LiIijAPoq+5XZyPVfXqwplBv4Ma0EfMtDQkeTCyvgfbtcLDnzgWgb4N1ooL20Q4D4RL6J4X8pWUktWrhO0FF3CsKNDGNGvXOib3cRwgtlOwmpJzBLLjOlFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789252285; c=relaxed/simple;
	bh=SzldhfQcocuSssHju/vjgsaHpsnS78DT2Y1S9P03mTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL3hC46s5IMX0kV9bAlbE5wljXVIPTIfB7RhmplgVbWZlngsS8yOzD6O7fGQEJ0FilP7+0Yf04dQrV2K/egiXHX2wmskKos65sLGGmaP6gIO6Cw0L25kLdQvholRrQke2DB7cZ7hA4j8Ae6p+csaflUe/maHPEVnvv/7YM7xmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVts4P+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVts4P+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5401E1F000FF;
	Sat, 12 Sep 2026 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789252284;
	bh=ce1HX5koLmAjYA7zzAHVeJdUkobP3h1/gtoI/ft1GtQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PVts4P+ZFRMNDP8IPda+oXXNIXvO3R62sGgiWrzFfvap+u4GoPR1dLdGGy1nA0Ytv
	 9fvL2deDyqRn/CzAhHJjEhGwZ5OAuVc1ga/S9ipJo7/P+0z1zArvcm+jE34YnTRk2r
	 bN80Leor8ep5neouVAB55Kn+ZdojDTppn7WbzVcdKArvfbTFSNU2IgySo2UA5sFUU8
	 Z6dbvvFLJjFVTcEO2IO3MHptg1MK8nbOVxr+EpfImqmCw/EkpZEVQ8cipgPpzd4nsr
	 g14pK3zn/l64SXO2vt4ABs94DMJN1Yr+vAqyP9X4MSsPkbnbKUh3IgJ94cqk9WHRfV
	 AqhUafm/316dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17205CE17BD; Sat, 12 Sep 2026 15:31:24 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:31:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
Message-ID: <ffffa178-c475-4249-a609-c5d222704987@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>
 <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
 <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com>
 <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
 <20260912221400.4045198b@pumpkin>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912221400.4045198b@pumpkin>

On Sat, Sep 12, 2026 at 10:14:00PM +0100, David Laight wrote:
> On Sat, 12 Sep 2026 11:03:34 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > In the old kernels, yes, we have current->trc_reader_nesting++.
> > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > other thins is a bit faster and does not need to hook into the scheduler.
> 
> Isn't that rather architecture dependant?
> It is fine on x86, but on arm incrementing a per-cpu variable is
> significantly expensive.

Last I heard, slow ARM increments of per-CPU variables were to be a
transitory phenomemon.  Plus changes late last year greatly sped up the
per-CPU increment operations.  Plus this change removed some hundreds
of lines of RCU code.

							Thanx, Paul
