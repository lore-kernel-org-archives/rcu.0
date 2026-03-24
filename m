Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B03D6478
	for <rcu@vger.kernel.org>; Tue, 24 Mar 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364220; cv=pass; b=AOI/yU+rlYGAR5MNoTNlTdM57fwJyy0mCkeAxL5VyoTHzzUUoO+bTzlmhhhJB6CWaEY8f2aFWftOIxlrnjL/gkakkGv9Bkxieo4B0sD3ExdToipsM3McERhkb41XB/AFRkrHoWv4Ip0hFu5xaialJToEmPhH4h6QcROL9+mY+mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364220; c=relaxed/simple;
	bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyVP6bPvGd/sa3K6+J6u+H+qmQ38OlHYpXtcTSJOQ6CrONE9dQApGKFVem43kR8p1ddDBrF3ZzkUIzHBb7hXepixLM3cp2F/nwbn3lA3Ql0zs6rQ5Z0WFsYiCUtRLdswzH4VheTGcmxbRFiQcIDGRqXNfFwqnbJMzxCpv7zT0Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHes4MmM; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHes4MmM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso5900184f8f.1
        for <rcu@vger.kernel.org>; Tue, 24 Mar 2026 07:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364216; cv=none;
        d=google.com; s=arc-20240605;
        b=fi/5wG1Pdq+baeVa2qRelQWuzZBgpBgO880Jo+09KrOm7jVd4pdbwy2L8xSwPqr4kF
         FzIu6Jj7vZu3I8zNXdSMiR7vw1tPvZxSkuPFYmtDahrtqQNKp32O/gLo+SlwgBbLaA3B
         GnmsNLev7UnBoZtO0ULnAC9d8b8I+pBEKg5Lnv4L218klJ1p+0L4Foc3dX6isZLUk9KC
         kuylarSvhRbAYHD6AdvUynHZUGGn2vWQC1lkaDhYRDB4kwrsdFjxSyYQxCu9dSvPjLeV
         AU5sBLtv/YMGMgz975L5JLevmbjt9IEikBauAhoC3R0Kews7SMUZcYJxZIftB3AP23sX
         aNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        fh=Vm/8H629j+qsj6nuQoRMaqRUFc9MJANs4QsGJ372yAs=;
        b=Ln6/B5VZLttUO6Mqcn/83/7Mq9XUwWDwILUdP4j/AyiYt4N18J1tIMPqgi0K2cNVrG
         mfWLILFRrBSDWalSa5v/pdGjDglAmGAj+zrDg0ROqFmSGdMRC+vL5kQgEw3hi6fdinzO
         sOwhi2N46ws/LiVQkcLi3eyr+AOa+Z5Huz0JkDTMXbC5WithpeucHKCxOSHsHt9NT0cd
         WxjoR0EBUUgKkcZ4GE0HaRZq7oFeo+IOeno7S17a3bAp57AmJd88UImIF5/VuxCbTlZq
         F2j6frOh/UGZRA/5I6rJgeVSvvHaYIWtET+FaTNtVUDtWMiq5XSyATzIxFSoiKJKpxPE
         sGpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364216; x=1774969016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        b=UHes4MmMkvnIgPzDKr67BGZJbzItgQvMmv0nzbjQgDxHuFe+PndO67DiVGt187xkhQ
         pQLWYaPW51FItojAvzWf5srj1TZ1CSR67V7Ar8Or7Vl6AM1x/fSA53vX5C23lwSL/n3U
         ZC9VU+sO9ULum5zdr+puPRxgatyoV3s4NHWaueY86YtcF2ZMjJYjuJn+4SnZA23lV5Jx
         dVyF4k4TDjk3yJZlKwljygKtZwUsjs9aShUKj23olCzOQWFVT4Kwzmy4pCzug1HCnZUj
         lQNaQcTvXVZKcoY43XXUNgWQVreQQCVxhfLnr/t6w6m3CJbp02Rvf7XHnMHyIavc2wva
         d4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364216; x=1774969016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        b=d7e2p0Aili5NpKZvZ6MLQ6gcQ/1aKYe90OiPg2+JZDxVCQAMzBoj2W26Azeg5DZC3k
         FtFDLRpzr14aRoFV7gXW3KGN0Uv2Rs2RTAzpqFVdtYnCcKGV7Ye9/omPTADVy/rhdrio
         F5rfPuuTDcT67qO+ZvsAtWBcu3edBuCr03zYDEYaDID1E6Snx5ey5dQWcjgMxWhojpM7
         z4CE8AmtuQNer2OrOWWvNN9X9XhCyKDiTBPXfexTcUhE8kZtryuQX5cfG7qQ9iq5vZtA
         hG6rEOusJancec/qvfIKkDF82vzSFKfdPfrUqBYxwLqoCpD4JED+/VBdU1GEux5KrqNA
         fLlg==
X-Forwarded-Encrypted: i=1; AJvYcCWFKawc5KHAe7/khpG9FwEGioAf62YOSLusYtu2G2TO0xU2p2IPwNJjyk0SxHfilAD4OIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgRMwsAIsR0ETpQ7Sxa0KFHnCAD9WGydGFi0ytGf7wqAEA2/C
	rbuD5gQQpwnRlpR7a18S0gGqvHXBdQ1eWHiN3k4p9OJa1sOcZxdzaAJ17Nz5n1CijLOODvusQLp
	ypObqEiicGD/I0VMaYzKlaTM1LfjyTlo=
X-Gm-Gg: ATEYQzzUkH/Wl6ohXexHtZ0HZRN38owvBv5Y1w+TIOQo9XTq8/QE66IB/3hRjm3NQNM
	1BV7ONwuqEHHQSaGkuiinTEet1osSEGcN646OjqVYjsnxK4GuVyOW2s4/pNeDtjDJ/yEPWdRsLr
	xkz89xSb96NSTgWUbsCj1sY8zVfG6jJCI771T5tZGQLbmuwRK/qdmeUvmLOWcPhYbtLusr9uRvC
	+HjiF+sucuRCPB/lNzitV5R48h4ySrwFZnxYlOFdPyO6SGybqtH5rTdOp7pfIYOimPl3LtpBLYz
	do/BDcH6UN42TvYQXmiRwkyvuBNXTUMCVHAlQ1XkvET2+6pC3d20x2ilJ6rwu1RvGf0n7wcw7qG
	ttcCvfIoAbd0Zixb8chOVM74PuQ==
X-Received: by 2002:a05:6000:608:b0:439:fdd5:10b5 with SMTP id
 ffacd0b85a97d-43b6426d710mr26863361f8f.39.1774364216239; Tue, 24 Mar 2026
 07:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org> <acJ1HRXomQhbTN4_@localhost.localdomain>
In-Reply-To: <acJ1HRXomQhbTN4_@localhost.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:56:44 -0700
X-Gm-Features: AQROBzDJ2iP-PoWSWyhZ84FyoYg7DjuQTXoVPXfPQvooPzE1dJu3zm52xoJ_bGk
Message-ID: <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Neeraj upadhyay <neeraj.iitr10@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:27=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a =C3=A9crit :
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument ca=
n
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> >
> > [boqun: Apply Joel's feedback]
> > [boqun: Apply Andrea's test feedback]
> >
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms=
 of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@=
nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Tested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
>
> I have the feeling that this problem should be solved at the BPF
> level. Tracepoints can fire at any time, in that sense they are like NMIs=
,
> and NMIs shouldn't acquire locks, let alone call call_rcu_*()
>
> BPF should arrange for delaying such operations to more appropriate conte=
xts.
>
> I understand this is a regression trigerred by an RCU change but to me it
> rather reveals a hidden design issue rather than an API breakage.

You all are still missing that rcu_tasks_trace was developed
exclusively for bpf with bpf requirements.
Then srcu_fast was introduced and then it looked like that
task_trace can be replaced with srcu_fast and that's where the problems
discovered. So either task_trace need to be resurrected
or srcu_fast needs to be fixed.
Let's punt to bpf subsystem isn't an option.
At this rate we will have rcu_bpf. Which rcu_tasks_trace effectively was.
