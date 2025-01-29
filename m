Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDC11712
	for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114758; cv=none; b=jDtX9TdsO0BekHbyu0NEGSAVjrfmEzoSwumNAv3ajuByPHrfQ6uFr+1jPO4K0l8FEmXSgImaPnE4yk3CK5gqI1khNG77AFh84zjfNPadkvUcG+i4vJ0Wx8Pb5EUlPDcnSqTSrZig3mwkj6CG7E3R3hSG928B23YKnHv77G+iBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114758; c=relaxed/simple;
	bh=SOK39whVZwLzTwyEEYSytGu1xKcNclDtTlqg4UHIKOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEwz5U8ajLkSVCIgYInHPSE8NLz2KNR9sFIW3PjUpr6q2WVIElBNYXVhUMjsV7eL9dupEJwQ95Bfi8GMKxjU21YFenp8m5ptvY2M+wHZqlIdur3qifgb0qs0+iyQOPtRnJ5go8FrR0s34+b97QofTNAKpo3+OV4yPaWRuRGvPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=IDqhiLnj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IDqhiLnj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283dedso66347995e9.3
        for <rcu@vger.kernel.org>; Tue, 28 Jan 2025 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738114755; x=1738719555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BQvyQtESRpP7nyviowdKzA5pmgoNLwz2H+NUuxyV8U=;
        b=IDqhiLnj7qM48IuPLOTCdfNxG/zTwXyRzAD9W3BWujCaVGr2dYXcO40cIxzoHrzjmh
         3szSmSvOIRj+4RqSZUXOqsLk7ZRbjpC9H7qY5y3pHzlmDrvdIfhSmJ+ZEZbaanb/2BvW
         U8IgaLKQIgVp/INIY9+xjqk14dbvA9xeXb6Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738114755; x=1738719555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BQvyQtESRpP7nyviowdKzA5pmgoNLwz2H+NUuxyV8U=;
        b=GO9g/FcAa8UtPdvgX6TD/Z9MsSx2aFNONX8QM7i+vRU/EhDMcSbBHi+dakvGSwYt26
         uvIXn9HBeBFGoH3sDJu61EKkJxb595iofYMZ5gwymca7y+XzklcUVefx4bSQesAjLHxo
         D+67Zvu1DOfJAwm8StER2wUgy6GcRxIpYRb6t9QT8texitgJXAFJMkB/4ZrIGU6NQX/v
         3i/DOlRwscxsDFP2hr9COWFREehwm0PlwsXSLYzO3Uc4GMbQqjcvr31iqbqgqJAEX1B4
         gmtMM3I0AXcyhMOtOKAnmK0VMTT1c0fMQJr7tANweihCTNTID0kSJjU5hhl5uUgrlFDX
         740A==
X-Forwarded-Encrypted: i=1; AJvYcCUdnwaEY6iWeeguxGiG7KiXPaZqe73a6KfXLQbscCXibEtlcMzqVzt85kpEQdrwzAoAEc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywcm+AmKUf3ImkzMa2MuJsPNdLfL75Sp/wgtKFZO5+uT11LCYv
	/zaFop/x8TbVlLwpaNED11FnQLfkvBNKa20uHQ3NYDSAg+3nvVoUWOnaAqS2zH5V8EqLQ9wCf8r
	Y4wZHwl3kpdnyKKF5y2idAEqrO5uNcN0zbb/FZA==
X-Gm-Gg: ASbGncuXHSI4yUBDjR/PiHXnFwRZdFwZViG3TfEOoTmCskc4mAF0zfpHMDlWLjKiRnM
	7aUY6jH2s2OUvdknIORx2cxRNRrhVGIGPjjex2HaGepxo+IiF4FGZo9nEyRcky+f3aBvURdxhcw
	==
X-Google-Smtp-Source: AGHT+IHFfr4D/G44F5mSh/oMdmDmvwdpvrpEqd4ztr0/G3AMGcOAcPohuRWmxXu0Btzof4LzsMJqnLWQM69AmQKFZnI=
X-Received: by 2002:a05:600c:5127:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-438dc421393mr7834475e9.29.1738114754858; Tue, 28 Jan 2025
 17:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128000737.1264218-1-joel@joelfernandes.org>
 <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>
 <20250129012248.GA3853708@joelbox2> <435e9637-6c5e-48a3-8d5d-c96ed890eb15@paulmck-laptop>
In-Reply-To: <435e9637-6c5e-48a3-8d5d-c96ed890eb15@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 28 Jan 2025 20:38:57 -0500
X-Gm-Features: AWEUYZnbGr3o5osmfqXeXp5QWnNVDhHRfC7jWE6lSu0HL0KzkpQb-L3TJ-6Su8A
Message-ID: <CAEXW_YTRo6Y-YExOc=BDaMMh-S9--tB3LBYCZ6UR18hnL9Lnkg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:33=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
> > On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> > > On Mon, Jan 27, 2025 at 7:07=E2=80=AFPM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > The rcu_seq_done() API has a large "false-negative" windows of size
> > > > ULONG_MAX/2, where after wrap around, it is possible that it will t=
hink
> > > > that a GP has not completed if a wrap around happens and the delta =
is
> > > > large.
> > > >
> > > > rcu_seq_done_exact() is more accurate avoiding this wrap around iss=
ue,
> > > > by making the window of false-negativity by only 3 GPs. Use this lo=
gic
> > > > for rcu_seq_done() which is a nice negative code delta and could
> > > > potentially avoid issues in the future where rcu_seq_done() was
> > > > reporting false-negatives for too long.
> > > >
> > > > rcutorture runs of all scenarios for 15 minutes passed. Code inspec=
tion
> > > > was done of all users to convince the change would work.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > I am leaving a 60 minute overnight run of all scenarios on my persona=
l
> > > server for further testing.
> >
> > The run passed, details below:
> >
> >  --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
> > Results directory:
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60
> > RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total-gps=
=3D57880] n_max_cbs: 0
> > SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=3D79=
242] n_max_cbs: 150000
> > SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gps=3D=
460117] n_max_cbs: 150000
> > SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=3D8=
0299] n_max_cbs: 150000
> > SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gps=3D=
1035602] n_max_cbs: 50000
> > SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-gps=
=3D988459] n_max_cbs: 50000
> > SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-gps=
=3D1092927] n_max_cbs: 1000
> > TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=3D57=
808]
> > TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=3D57=
936]
> > TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=3D5=
7508]
> > TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=3D0] n_ma=
x_cbs: 57078
> > TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=3D0] n_max_=
cbs: 2619
> > TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 total-g=
ps=3D45844] n_max_cbs: 50000
> > TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0 tot=
al-gps=3D305456] n_max_cbs: 100000
> > TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=3D120=
151]
> > TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=3D3=
65162] n_max_cbs: 1139244
> > TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=3D4=
41393] n_max_cbs: 1341765
> > TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=3D23=
8225] n_max_cbs: 236765
> > TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=3D3=
08880] n_max_cbs: 82801
> > TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=3D520=
94]
> > TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=3D1=
923688] n_max_cbs: 1845334
> >  --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0
>
> Very good!
>
> How would you go about analyzing whether this is really safe vs. getting
> just getting lucky and not having provoked an overflow?

I would probably add a more specific test case stressing the API, or
even a unit test of just the API by passing a range of sequences.. I
should go ahead and do that but it sounds like you feel there is an
issue with the patch? :)

thanks,

 - Joel


>
>                                                         Thanx, Paul
>
> > thanks,
> >
> >  - Joel
> >
> >
> > >
> > > thanks,
> > >
> > >  - Joel
> > >
> > >
> > >
> > >
> > > > ---
> > > >  kernel/rcu/rcu.h  | 13 ++-----------
> > > >  kernel/rcu/tree.c |  6 +++---
> > > >  2 files changed, 5 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index eed2951a4962..c2ca196907cb 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned l=
ong *sp, unsigned long s)
> > > >
> > > >  /*
> > > >   * Given a snapshot from rcu_seq_snap(), determine whether or not =
a
> > > > - * full update-side operation has occurred.
> > > > + * full update-side operation has occurred while also handling
> > > > + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard=
-band.
> > > >   */
> > > >  static inline bool rcu_seq_done(unsigned long *sp, unsigned long s=
)
> > > > -{
> > > > -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
> > > > -}
> > > > -
> > > > -/*
> > > > - * Given a snapshot from rcu_seq_snap(), determine whether or not =
a
> > > > - * full update-side operation has occurred, but do not allow the
> > > > - * (ULONG_MAX / 2) safety-factor/guard-band.
> > > > - */
> > > > -static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned =
long s)
> > > >  {
> > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index b77ccc55557b..835600cec9ba 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_=
full);
> > > >  bool poll_state_synchronize_rcu(unsigned long oldstate)
> > > >  {
> > > >         if (oldstate =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate))=
 {
> > > > +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
> > > >                 smp_mb(); /* Ensure GP ends before subsequent acces=
ses. */
> > > >                 return true;
> > > >         }
> > > > @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct r=
cu_gp_oldstate *rgosp)
> > > >
> > > >         smp_mb(); // Order against root rcu_node structure grace-pe=
riod cleanup.
> > > >         if (rgosp->rgos_norm =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
> > > > +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
> > > >             rgosp->rgos_exp =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > -           rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp=
->rgos_exp)) {
> > > > +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos=
_exp)) {
> > > >                 smp_mb(); /* Ensure GP ends before subsequent acces=
ses. */
> > > >                 return true;
> > > >         }
> > > > --
> > > > 2.34.1
> > > >
