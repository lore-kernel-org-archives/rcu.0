Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB718C03A
	for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116684; cv=none; b=Nsx5N+OMw2mLbdpVkKB2ecmO1t5vDQepHZ7DwCUa1AY/QEoea8Jqh2bMloTwCMlerUgrBVtIplEnKhRDCFn0tvqUCOIyBFgT5hhmgnzeegzqtWtL47xdgkvEqLJL8GjQvsBZ/EEp4hw+JybrrSfXtagrcO8K+R9+UMIofvjWNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116684; c=relaxed/simple;
	bh=EoIZuEwvQElY9fCK6xRnxQtzEEM79Nd09hGYt3/arHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df6evKdccKLwjbNPu8QBnw1IlaKix2Qw1FmIl3Dt4IPhYuBM7ZM5YuesXxLpOQqQnvXdQ+LMVceQMhUM/Pwc6GxGcnyxTXMzv1YwCzT4/hP1whRyKO/WP22D77H84hizNV9TSuWE6YFh9Y2M+O5MDjNsekS18kd93w8cZU4OqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=VD6yHw8u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VD6yHw8u"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283dedso66486505e9.3
        for <rcu@vger.kernel.org>; Tue, 28 Jan 2025 18:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738116681; x=1738721481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNwGxs4BJR7UxzLLK1j3FpTZ1TR4WEj4/Jpe2fcVBII=;
        b=VD6yHw8uCC4qQuotsnuhbj+jzYGJhl02hiwshjzYQOcMO/an1Yle5+N/d+SkRISP73
         vkeyOoB4ToD6uixJ107LAEHT68CKqw1xThheiI0Ri+GOJDtmOdUAYlE4YjRQfj3I6pHS
         yK2VEu9hQ6JlqSIQT/ByT9CFnrV0zURHW1v9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738116681; x=1738721481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNwGxs4BJR7UxzLLK1j3FpTZ1TR4WEj4/Jpe2fcVBII=;
        b=qk70QOEZzT5sctKMOvR0dsXs/IQ65YDgXK59JAV1LWKDw8rcAwHzprUrlbAqEHoNeW
         hQdwJzwcULTy5lZAHrGGZPenq5YdCI8xYW7PpMVKp4z47KIS7t74Nt7zZTUIVOu8k71G
         dnwb0lO3I4Q6cCj2NeI8w/URqStb+M9tS5F9bs3kR8BHBJ5tAC7uEKbMKfhF4Y45Ov6l
         gOW929+8BYZZjk09fDFrmhHGQaTmacLGCmSlAQl9tyn3o7KjwV9yUJgEwIxUXmSPrKCf
         1EyFpn6eb2omZwJCVjdiFDMMB6/stRyRu2ZFLvVYI33YoWG3mg0T+5ljJw8GqE03jtcn
         92Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU+nxb/+mUacdpvGZuADnRm1DyUbqlsDunwjUPO9yo8ctVdMRpHdRrPRDmKofqz0Wytrh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tLqfPEsJrncrAqG2G4AppDIux6j5UVb3BGyNE8ohVrEw6xTD
	XFmh9iFO6fpui5OnkUReetjj5Uo1KMjcaHV1k9UDFeEhU5aKnvdbzRkDbLO3bRghQqghGU61jCN
	Gbjmf6KGUgcr+moHVXjT8NWFkhvFw+CWYEyZmaQ==
X-Gm-Gg: ASbGncuBW9vrUA84bpeWMasobaEo9yiy2VXOVsZCKtFgTMi29BXhRjnqjLn0I5fA1cQ
	h73ASnf2tN9K5CmLt2o3UO1TguKxZoLZf0W/9kyoYP0WBqLFZyx0irSFoS4hm12ir88LvBn0fqP
	4W2BzWxMlK
X-Google-Smtp-Source: AGHT+IHtvIVNJtC6U6BVx92cHaFpbCSXGIbhPS45SK2GzkFQ4E7Zf2BN+2qgPKXGGVgRsspaXbkdqI+LNCe1qRT85Hg=
X-Received: by 2002:a05:6000:144d:b0:38a:88ac:ed0d with SMTP id
 ffacd0b85a97d-38c51941b32mr748472f8f.12.1738116680664; Tue, 28 Jan 2025
 18:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128000737.1264218-1-joel@joelfernandes.org>
 <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>
 <20250129012248.GA3853708@joelbox2> <435e9637-6c5e-48a3-8d5d-c96ed890eb15@paulmck-laptop>
 <CAEXW_YTRo6Y-YExOc=BDaMMh-S9--tB3LBYCZ6UR18hnL9Lnkg@mail.gmail.com> <038e394f-7030-4406-b24e-512cefbe8bb6@paulmck-laptop>
In-Reply-To: <038e394f-7030-4406-b24e-512cefbe8bb6@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 28 Jan 2025 21:11:03 -0500
X-Gm-Features: AWEUYZkeIlr2dEyTJAyRJS7V6xEJRRDaDVkQwXTx36eqlzRLAQPZMOY8g_jPn2A
Message-ID: <CAEXW_YQJMeu3VQWHZjNmdS4ODqqkRjZ=Xpx2o+_pRREZPzF0WA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:47=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Jan 28, 2025 at 08:38:57PM -0500, Joel Fernandes wrote:
> > On Tue, Jan 28, 2025 at 8:33=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
> > > > On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> > > > > On Mon, Jan 27, 2025 at 7:07=E2=80=AFPM Joel Fernandes (Google)
> > > > > <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > The rcu_seq_done() API has a large "false-negative" windows of =
size
> > > > > > ULONG_MAX/2, where after wrap around, it is possible that it wi=
ll think
> > > > > > that a GP has not completed if a wrap around happens and the de=
lta is
> > > > > > large.
> > > > > >
> > > > > > rcu_seq_done_exact() is more accurate avoiding this wrap around=
 issue,
> > > > > > by making the window of false-negativity by only 3 GPs. Use thi=
s logic
> > > > > > for rcu_seq_done() which is a nice negative code delta and coul=
d
> > > > > > potentially avoid issues in the future where rcu_seq_done() was
> > > > > > reporting false-negatives for too long.
> > > > > >
> > > > > > rcutorture runs of all scenarios for 15 minutes passed. Code in=
spection
> > > > > > was done of all users to convince the change would work.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > > I am leaving a 60 minute overnight run of all scenarios on my per=
sonal
> > > > > server for further testing.
> > > >
> > > > The run passed, details below:
> > > >
> > > >  --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
> > > > Results directory:
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration =
60
> > > > RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total=
-gps=3D57880] n_max_cbs: 0
> > > > SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=
=3D79242] n_max_cbs: 150000
> > > > SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gp=
s=3D460117] n_max_cbs: 150000
> > > > SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=
=3D80299] n_max_cbs: 150000
> > > > SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gp=
s=3D1035602] n_max_cbs: 50000
> > > > SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-g=
ps=3D988459] n_max_cbs: 50000
> > > > SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-g=
ps=3D1092927] n_max_cbs: 1000
> > > > TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=
=3D57808]
> > > > TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=
=3D57936]
> > > > TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=
=3D57508]
> > > > TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=3D0] =
n_max_cbs: 57078
> > > > TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=3D0] n_=
max_cbs: 2619
> > > > TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 tot=
al-gps=3D45844] n_max_cbs: 50000
> > > > TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0=
 total-gps=3D305456] n_max_cbs: 100000
> > > > TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=
=3D120151]
> > > > TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=
=3D365162] n_max_cbs: 1139244
> > > > TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=
=3D441393] n_max_cbs: 1341765
> > > > TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=
=3D238225] n_max_cbs: 236765
> > > > TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=
=3D308880] n_max_cbs: 82801
> > > > TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=
=3D52094]
> > > > TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=
=3D1923688] n_max_cbs: 1845334
> > > >  --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0
> > >
> > > Very good!
> > >
> > > How would you go about analyzing whether this is really safe vs. gett=
ing
> > > just getting lucky and not having provoked an overflow?
> >
> > I would probably add a more specific test case stressing the API, or
> > even a unit test of just the API by passing a range of sequences.. I
> > should go ahead and do that but it sounds like you feel there is an
> > issue with the patch? :)
>
> 2^31 (let alone 2^63) is a very large number of grace periods, and
> so it is hard to test grace-period sequence-number wrap.
>
> Not impossible, though...

I realized with some simple tests this can break because of some
ambiguity around whether a wraparound really happened:

say *sp is 100, and s is 200.

This could either be a full 32/64-bit wrap around, or it could be that
*sp is not yet caught up. I guess there is no way to distinguish
between the two cases.

For this example, ULONG_CMP_GE will be false and ULONG_CMP_LT will be
true making the new rcu_seq_done() version to be true.

But if *sp is not yet caught up, that means the new rcu_seq_done()
should be false, not true!

Sigh, I look like a fool now. But I am also wondering what makes
rcu_seq_done_exact() correct then - because it cannot really tell when
a wrap around actually occurred. Hmmm...

Confused,

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
> > >                                                         Thanx, Paul
> > >
> > > > thanks,
> > > >
> > > >  - Joel
> > > >
> > > >
> > > > >
> > > > > thanks,
> > > > >
> > > > >  - Joel
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  kernel/rcu/rcu.h  | 13 ++-----------
> > > > > >  kernel/rcu/tree.c |  6 +++---
> > > > > >  2 files changed, 5 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > index eed2951a4962..c2ca196907cb 100644
> > > > > > --- a/kernel/rcu/rcu.h
> > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsign=
ed long *sp, unsigned long s)
> > > > > >
> > > > > >  /*
> > > > > >   * Given a snapshot from rcu_seq_snap(), determine whether or =
not a
> > > > > > - * full update-side operation has occurred.
> > > > > > + * full update-side operation has occurred while also handling
> > > > > > + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/g=
uard-band.
> > > > > >   */
> > > > > >  static inline bool rcu_seq_done(unsigned long *sp, unsigned lo=
ng s)
> > > > > > -{
> > > > > > -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
> > > > > > -}
> > > > > > -
> > > > > > -/*
> > > > > > - * Given a snapshot from rcu_seq_snap(), determine whether or =
not a
> > > > > > - * full update-side operation has occurred, but do not allow t=
he
> > > > > > - * (ULONG_MAX / 2) safety-factor/guard-band.
> > > > > > - */
> > > > > > -static inline bool rcu_seq_done_exact(unsigned long *sp, unsig=
ned long s)
> > > > > >  {
> > > > > >         unsigned long cur_s =3D READ_ONCE(*sp);
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index b77ccc55557b..835600cec9ba 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_=
rcu_full);
> > > > > >  bool poll_state_synchronize_rcu(unsigned long oldstate)
> > > > > >  {
> > > > > >         if (oldstate =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > > > -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldsta=
te)) {
> > > > > > +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
> > > > > >                 smp_mb(); /* Ensure GP ends before subsequent a=
ccesses. */
> > > > > >                 return true;
> > > > > >         }
> > > > > > @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(stru=
ct rcu_gp_oldstate *rgosp)
> > > > > >
> > > > > >         smp_mb(); // Order against root rcu_node structure grac=
e-period cleanup.
> > > > > >         if (rgosp->rgos_norm =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > > > -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) =
||
> > > > > > +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
> > > > > >             rgosp->rgos_exp =3D=3D RCU_GET_STATE_COMPLETED ||
> > > > > > -           rcu_seq_done_exact(&rcu_state.expedited_sequence, r=
gosp->rgos_exp)) {
> > > > > > +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->=
rgos_exp)) {
> > > > > >                 smp_mb(); /* Ensure GP ends before subsequent a=
ccesses. */
> > > > > >                 return true;
> > > > > >         }
> > > > > > --
> > > > > > 2.34.1
> > > > > >
