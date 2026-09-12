Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85F381E91
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242060; cv=none; b=cFrQGEjQhwhqv/qJhYD/xCldpK6kVhVZyHwmLw0VMwN86rukhQemAAlGjTHOpDrVurbYWM2r5oY7fl+LjND7qZsG4jhn2HGxxhLHDeLcbi7P0IwFAuuqTveqPsHBvmtDa2VYEK/t7Rj30aUEnIWHnd0ZylGtHSeu2b/bpUqHb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242060; c=relaxed/simple;
	bh=Fg3k93J+NnauWx+3Z+BYbTT2WHUzh/cuAEcclS6y3ms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H16RVmCxE3eSmQVjioNUHKaDlwr4/sJR3MH51Twazhe7/0xNi59ARXzeFCKXZtHfGUo2sYAuj1YYz4tDMnaTqEUT3kg9PPYNwS6/YlS3sCy8bGAvduW/icgmt6oMGeuEXbxdrpFOsDfJFyq6rf+12yij37pU8EoMedAJ/SdetbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdL8Tpdf; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdL8Tpdf"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6aa9606ddadso1715207eaf.0
        for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242058; x=1789846858; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/mW9uIl4IQ84J3enCrJFqvgB+YMh25zxbJWRDQHZcYo=;
        b=hdL8TpdfrOnsp8icWzp7H9iP1o4b4ff7BeOjoL79h4VOB7Mi6IPUtkUAsdZtSvGWwY
         G5S4oixFN/qeznuCur5B4gc2bSVe1MLjnzZkQ7sCtiMWHNDvIpW7Njy83RaekEGJfsR8
         uBar9fpNP8lY8JkBGfS5tr+LkGAtKGPJe5TmeIp8OLJfC6ZUfW1aY64veWs450nV/hiG
         lAAeDTT4Nb6gB9crfFPc3Hnu0lUOghQtcutwfJGRfdY/gWa0Rle4PGL5cYr/WxeqduxL
         t9HwIy3rA8i+vi44eDI2IZZE+xh853xSBvG4vdqzZ5ApW6bDRml9lMb+xYwImLjcHGLM
         YUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242058; x=1789846858;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mW9uIl4IQ84J3enCrJFqvgB+YMh25zxbJWRDQHZcYo=;
        b=BKjVE+wddbnLkUPxiTJkL86+p0wEi8fMuiYxYgO+twnMgnMyW90nHe0eKy0ENh/ZZA
         gKkiUTWWwZzOyqEmLM2VUOvZuK1PPbQyqvAEgvimvq1ARq9IZJP9CpZCQpzrErjeCsKX
         dQFUzRnjarm6sdkV5G0H23Y8OqcH49lKqfUyjtxCoDRhCTHrO/aBeS7L2mCZvDDfFG1i
         KCJM/eXTkZPrHcdEVbxjOx3Z0H5BF8CsajXNApseb/oqijXHja3c05l4aENmx7Sc9PiL
         j3UFJjHsrFBjG8Y17g9O2SHpeBW1PmEyuQxAs1lgA4MmTelWoxTDY8/k0lqclne8GGOs
         fLAw==
X-Forwarded-Encrypted: i=1; AKwUvBxSC41OZzKmdmQq6qDsCmJesJZfDF8YPt5XXqkeOaRo2zK6OZ+9KqtWW1GbTHEVzVcm484=@vger.kernel.org
X-Gm-Message-State: AFuF++noF/nQWXrKhIUKi7691IphdmeiH6UI7I7ZkaVj36GSFl/wRY4D
	mfmAxJI5/xD8/JcGorZ1b5tG+E2JToGeq2vi31pb27bv3/RY26yXNJar
X-Gm-Gg: AYBFou2lDu1MRMWwmX50Bs9DZoW9BUnVnppnbmLKmcoas63fw6E+Usk3Mgpk4HbHzzx
	5UkagBHE+KzY8Ti0Y2CpddHUa89oy9uUud/ORsckRa47NNme4KmZWkQeKMSLUhwJxocbP4EQg5b
	JKaGQXnjtHCH+T6izoAbbFUk2VPmcVz/3kCB0vmpINxhy+JxD0K0R2I/wcVzFCDjIH1PV9G1Lfp
	R5vvbA+0eTOOuHeGFnRMMJEwcBXrnW3FaOqBuXwic11dBnXoWWEqD8J8SA4Avpy6kAtysl/BP42
	fOinUL5jMphaZ9GVN8X1r8D/v+jYO5ANy0U9mc51pvweWW7g1WP+6WRDRklYcFRz83aRFov/VXn
	ncc3o42a7PKjc+YJP0iJmcmw2o1iEKtUgPPP5+qqoqTvC5pBPwBuX4iJtNVfis2Zy6bAolQ7rS3
	NkbKKNEst2PKT93z5QQtB/4DgmCKsXnw6js3YgZTXAR0Lobl6Ypt8996JpGPMp+gyB4J7bYnybd
	JBtgNdjGTgk9Leor3pI3/lsk6ZEFsHiRcCDNZ5rCP4hhQ235N/Q9Gtvm61DKxkZqh435i92Ihk=
X-Received: by 2002:a05:6820:f034:b0:6c0:c954:e534 with SMTP id 006d021491bc7-6c0c9550c4dmr5760632eaf.38.1789242057820;
        Sat, 12 Sep 2026 12:40:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0996dc5a6sm6404372eaf.6.2026.09.12.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 12:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 12:40:55 -0700
Message-Id: <DLDLDGTSBHA0.32TYNBSKKPFXH@gmail.com>
Cc: "Josef Bacik" <josef@toxicpanda.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <x86@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross" <jgross@suse.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <paulmck@kernel.org>
X-Mailer: aerc
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com> <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com> <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com> <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop> <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com> <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
In-Reply-To: <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>

On Sat Sep 12, 2026 at 11:03 AM PDT, Paul E. McKenney wrote:
>
> In the old kernels, yes, we have current->trc_reader_nesting++.
> In the newer kernels, Tasks Trace RCU is instead implemented in terms
> of SRCU-fast, which instead increments per-CPU counters.  Which among
> other thins is a bit faster and does not need to hook into the scheduler.

old kernels? I'm confused.
rcu_read_lock_trace() in bpf-next is doing t->trc_reader_nesting++
and then calls __srcu_read_lock_fast().

Are you talking about some RCU branch that you target for next merge window=
?

>
> So we have several ways forward:
>
> 1.	Revert the implementation of RCU Tasks Trace in terms of
> 	SRCU-fast, and use the existing current->trc_reader_nesting++,
> 	as you suggest.
>
> 2.	Deprecate RCU Tasks Trace entirely in favor of RCU Tasks
> 	augmented by rcu_tasks_trampoline_enter() and friends, as
> 	I was suggesting.
>
> 3.	Implement rcu_tasks_trampoline_enter() in terms of SRCU-fast,
> 	keeping the speedup, and put a synchronize_srcu() in the
> 	RCU Tasks grace-period mechanism.  This again deprecates
> 	RCU Tasks Trace entirely in favor of the augmented RCU Tasks.
>
> 4.	It is always good to explicitly state the apparent status quo,
> 	which involves redundant trampoline entry/exit overhead.
>
> 5.	As always, your additional ideas here!
>
> 							Thanx, Paul

