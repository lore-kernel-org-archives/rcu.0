Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B803EE1D8
	for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900864; cv=pass; b=YveT0T4sUyKurHOf9jB+aODFSRk12gJDNHv5Hf1LVhSEcER83ASeO1wMwM5EgvdIType7KeaGbQCq+ILFZkNjEyrqAhs+IMOn35aq98e1XWkL7m2K2dKusw08gh9YDC8v/nGBNRu/9OiryzgULDqjaExH/nRG3/wk9nFJlFNDgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900864; c=relaxed/simple;
	bh=U0ffMrN9iYq+XPm4XD31Pu1yXO27cq5hdojeBC7k+68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKdOYakFMpsKts1cauueZjoiIiOoz9HUL6ixDms0VYWghbkduoKAS4UqtxRHnIktp7959mL3qb7WflM3+LEfRFhitf075apxclinppIXe/qUdFr9Po5q0zFfiCnj9v26/I14TkgdFVcgcPqleRAew1gQscYELloHE0FS7w3BuvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1+mzGDh; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1+mzGDh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so58896266b.3
        for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 06:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900857; cv=none;
        d=google.com; s=arc-20260327;
        b=UEmXB0SiUg6yx9aHQW102nwGkm7CTkqlMYiX0DAqv4tyNIgzU/zWSpsW7QuYVYzxQR
         igH7hhFxf2p4hPoENFHGRH8lLoRxy2/5hySoz8nsfefZGA280ujieJ1Cb0hPORbFZZfq
         p+GJRIEPQ/CxDeFgiuNRYnCY7Z27o4XEzwcrV8SSoqcEF8bCfgAct3EUoWQhrPU3YNlU
         zm3HOFocmAiPspFpROFfNSluF6Vh8iRipG0bOuHc26GyJzdSfuLE4ZhYY2VTwL2SfqRz
         bFlereQfv6KcRMuJyYoSqmKrGP6qgDAU7WQg+3KbD0fnxmHikuUWHXpOk7WhsxrkP6Xt
         HldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PN23B5XlAgpFObkH0AHMNuR+BLSqm448Xz71hnelBr0=;
        fh=g3Olj3+OLPGuHVs0Th83cqiB42XFpw6WmLDKDKwVTyQ=;
        b=Z3wXCD8abL8dX4AHbgZtmEzpH1j4vsUSNM0LLnwdj54fY4qSZXa+E3ZmvaQMgbDpt0
         XKwXa/Ar+SkDxGCQpmGRJW1nuNXEk30iw8iczjPrxQ+bUCbgZFJnQ2pTXIqUGYaECmyY
         gAbpx6ecKZehSTkEnBz/Q7/U2hATyrgvA7RLkbSr7t7Vpvwmh4jBZxaz+PP8J5DLiVrK
         FFRgp+Ctj65IhPFjl/iIGnlqOehNNkHXVOU2IkuIXmfd3HHaJEjt3++D4nHz+iHFRDwU
         7RlMKi3ODcMuq0QjPCw2Luq8jg2fVNTYWzMbiajtuTy54HOsH8RhUqsqRojv+CkFhhJ5
         Y8MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784900857; x=1785505657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PN23B5XlAgpFObkH0AHMNuR+BLSqm448Xz71hnelBr0=;
        b=L1+mzGDheiWO5qCGrwTXKK2ql3fIoXLCVrMPW+XwECcZ8fM/n13KcfTiLd/uTEzcxP
         behavh128jv+7YT/UkDkyTYMne3HxC47fQwUj2A1AFbVxhiAWwZBqufEY6I9ny4lmTFz
         vjfJTlkPTu443Pl8Txkn9q/V7dPwXEC2227aiDn+Zfn5AcvT8u6z//m0JFduXaLQ+3SL
         A61qOSDUL6/W4QN/KKATvhfI1L6CA0U/AmzGoUeCsJN2rVOH+73m0X5WxS4QHD31Qbho
         956mdlOeRCc4skvHEYLX2hJOm078CLcHsW+ikjmbxXGu0QLxXsk/a0I4j2bZDXxCV+D9
         SrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900857; x=1785505657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PN23B5XlAgpFObkH0AHMNuR+BLSqm448Xz71hnelBr0=;
        b=KiHPA8CAQIpsBOiKHD/xDSBHvLg0LlxfNk5qbY9Ctdh/ZB26ltKOms3tsFAqN/UGIx
         YwRtBgpyJOBYeKlrWUOmUn8raVm3uld7hXBd1xpTstD+74Dn2HysAB65Z8jeTsLOB+Hm
         Nzxb5jonCRs53aNaA4ddSQqYCQbhtbQZpio7H8g7UZ/wMzZ+RjYEU0yZfqhp5UWOiulm
         rBFV8UoT70ESjKg8PJ28zL0GPgals5fn+4wk6wh9SujUga6LRHDfPOYg/7wWOB6qcL/3
         s8q8tHzfI/+3pd8o+B/w8VRLxzYfsj/H8Q2CdjM4mnemRGKutL3lulaN0nM6Q9yr4dtm
         vpvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrht1Y79YbYFKtkbbz4cVrkUXJAttPpcrzjWcOTklg5A7YGoKRhOkjFeOcL8c3rv8QVmfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLHi8C/QciAWdjmWyc2Gjrnvy+DAkfyhLO2bidMxCqi+5bw4d
	ujYYrbbOKZKMWfhPZEjCvITOLTyLfy1Mzyl+4auKlR/q8DSxD45Im2qh8vW9CZb3GhZLJKwBPM/
	ULxpflcLMLUN2+m6IJ085nog1sKQJKDk=
X-Gm-Gg: AR+sD12uAnvyAZj9LBi3I+/sHTTZpUo5o2y7uPDqXvFYphnBXVrFhAJvRkW7csu3pKd
	cUQCsbNFcPIpNeMDd6Kfzh2eTGHiKCytK+PZSqD3g6hMAajmAi2ezwdQScivlTZ5cHqKnAut0YD
	ct2RZDkWDzZWZT5zny7rAlHgNDoKzVGFZclxKsI/LhpzNh96Rrjpe8GvKN2XcZwPk4P7KgKUQVB
	O9ky5XGbjlPNp8yR7fZQS/HlxpJR1LY5JgUFdbbnJcE5ktrxLTXFPQEtlPimy3Y1+t4H8esSAOd
	GA==
X-Received: by 2002:a17:906:1005:20b0:c12:36ff:6eb2 with SMTP id
 a640c23a62f3a-c1c50cbb19emr222021366b.51.1784900856530; Fri, 24 Jul 2026
 06:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <062ddbcd-dac1-4ee1-9d3f-ef115a667d6a@paulmck-laptop>
 <amNeS_ahHPLqXIGT@localhost.localdomain> <CANk7y0hQQ3oDKt+_8oh4t=8NfMRSa80a9jGr+DG+zbrcuUskTA@mail.gmail.com>
In-Reply-To: <CANk7y0hQQ3oDKt+_8oh4t=8NfMRSa80a9jGr+DG+zbrcuUskTA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 24 Jul 2026 14:47:22 +0100
X-Gm-Features: AUfX_mwOHnMG6p4r9uDOx6NaiKYGAJIz6IcmUpk_Log793NOv0CuPlF6b6eC-z4
Message-ID: <CANk7y0isSWC0mARzqhn_4OWb+oHkrAt9k_83j_V3eDzKGbsxjA@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] RCU: Enable callbacks to benefit from expedited
 grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:52=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Fri, Jul 24, 2026 at 1:45=E2=80=AFPM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> >
> > Le Thu, Jul 23, 2026 at 05:31:17PM -0700, Paul E. McKenney a =C3=A9crit=
 :
> > > On Wed, Jun 24, 2026 at 06:23:42AM -0700, Puranjay Mohan wrote:
> > > > This series lets call_rcu() callbacks be reclaimed as soon as eithe=
r a
> > > > normal or an expedited grace period that covers them has elapsed, r=
ather
> > > > than always waiting for a normal grace period.
> > > >
> > > > Motivation
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Today there is an asymmetry: synchronize_rcu_expedited() callers ge=
t fast
> > > > reclaim, but call_rcu() callers never benefit from those same exped=
ited
> > > > grace periods, even though an expedited GP proves exactly the same =
thing
> > > > as a normal one -- all pre-existing readers are done.  When expedit=
ed GPs
> > > > are running on the system (driven by other subsystems), call_rcu()
> > > > callbacks that could already be freed instead sit in RCU_WAIT_TAIL =
until
> > > > the next normal GP.  This series treats a grace period as a grace p=
eriod
> > > > regardless of how it was driven, so memory is reclaimed sooner.
> > > >
> > > > Design
> > > > =3D=3D=3D=3D=3D=3D
> > > > Callback segments now record both the normal and expedited grace-pe=
riod
> > > > sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases=
 a
> > > > segment as soon as poll_state_synchronize_rcu_full() reports that e=
ither
> > > > has completed.  Three notification paths are taught about expedited
> > > > completion so the advance actually happens: the NOCB rcuog kthreads=
,
> > > > the rcu_pending() tick gate, and rcu_core().
> > > >
> > > > Changelog:
> > > > RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@k=
ernel.org/
> > > > Changes in v1:
> > > >  - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp=
_seq
> > > >    and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederi=
c).
> > > >  - The rcu_segcblist segment field stays named gp_seq; only its typ=
e
> > > >    changes (Frederic).
> > > >  - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
> > > >    (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
> > > >    rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps =
on),
> > > >    and the wait condition only checked the normal ->gp_seq.  The rc=
uog
> > > >    grace-period wait now tracks a struct rcu_gp_seq and is released=
 via
> > > >    poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the=
 leaf
> > > >    node through the new rcu_nocb_exp_cleanup() (Frederic).
> > > >  - rcu_pending() uses a new memory-ordering-free
> > > >    poll_state_synchronize_rcu_full_unordered() to avoid memory barr=
iers
> > > >    on every tick, leaving the ordering duty to rcu_core() (Frederic=
).
> > > >
> > > > Still open: Frederic asked whether the first smp_mb() in
> > > > poll_state_synchronize_rcu_full() is needed on the callback-advance=
 path
> > > > (patch 6).  That path still uses the fully ordered helper; only
> > > > rcu_pending() was switched to the unordered variant.  Happy to revi=
sit.
> > > >
> > > > Puranjay Mohan (11):
> > > >   rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
> > > >   rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
> > > >   rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
> > > >   rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
> > > >   rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedit=
ed
> > > >     GPs
> > > >   rcu: Enable RCU callbacks to benefit from expedited grace periods
> > > >   rcu: Update comments for gp_seq and expedited GP tracking
> > > >   rcu: Wake NOCB rcuog kthreads on expedited grace period completio=
n
> > > >   rcu: Detect expedited grace period completion in rcu_pending()
> > > >   rcu: Advance callbacks for expedited GP completion in rcu_core()
> > > >   rcuscale: Add concurrent expedited GP threads for callback scalin=
g
> > > >     tests
> > >
> > > I do see the occasional failure when running TREE01, as in a failure =
or
> > > four every couple hundred hours of testing.  This is the only rcutort=
ure
> > > scenario that exercises callback (de)offloading, which might (or migh=
t
> > > not) be a clue.
> > >
> > > The console log of a failing run is attached, or you can find it here=
:
> > >
> > > https://drive.google.com/file/d/1EH2P4SDy2a-SJndkN3GbCTGAXxI2xevm/vie=
w?usp=3Dsharing
> > >
> > > This is a "??? Writer stall state" failure, where rcutorture never le=
arns
> > > of grace-period completion.  Possibly because no grace period complet=
ed.
> > > But there are no RCU CPU stall warnings.  In addition, these two line=
s
> > >
> > > [  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 -=
>state D cpu 1
> > > . . .
> > > [ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 -=
>state D cpu 1
> > >
> > > show that the grace-period sequence number advanced from 152813 to
> > > 736160 in about 50 minutes.  So grace periods really are completing,
> > > lots of them.
> > >
> > > This rcutorture scenario has rcu_nocbs CPUs, and CPU 5 is in trouble:
> > >
> > > [  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(14838=
0/168068).N295B101 q516 S CPU 16
> > > . . .
> > > [ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(1=
48380/168068).N295B101 q516 S CPU 16
> > >
> > > There are 120 callbacks on the WAIT segment, which are waiting on
> > > grace-period sequence number 148380, which was long gone even back at
> > > 631.032657 seconds in (g152813).  There are 295 more callbacks in the=
 NEXT
> > > segment, which long ago should have been assigned a grace period and =
moved
> > > into the currently empty NEXT_READY segment (which is the "." right b=
efore
> > > the "N295").  There are yet another 101 callbacks on the bypass list.
> > >
> > > This suggests that the rcuog kthread isn't being awakened when it
> > > should be.  And that something is failing to advance callbacks out of
> > > NEXT in a timely fashion.
> > >
> > > Thoughts?
> >
> > If a grace period has elapsed while in the middle of nocb_gp_wait(),
> > after the call to rcu_advance_cbs() and before the following polling wh=
ich
> > determines if we a grace period must be waited upon, then the kthread
> > will wait for new callbacks only (and will ignore waiting callbacks tha=
t
> > can now be advanced).
> >
> > Does the following help?
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 6da1b8f52476..96d76eb6259d 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -792,22 +792,12 @@ static noinline_for_stack void nocb_gp_wait(struc=
t rcu_data *my_rdp)
> >                                                            RCU_NEXT_REA=
DY_TAIL);
> >                         raw_spin_unlock_rcu_node(rnp); /* irqs disabled=
. */
> >                 }
> > -               // Need to wait on some grace period?
> > +
> >                 WARN_ON_ONCE(wasempty &&
> >                              !rcu_segcblist_restempty(&rdp->cblist,
> >                                                       RCU_NEXT_READY_TA=
IL));
> > -               /*
> > -                * Only request a GP wait if the next pending callback'=
s
> > -                * GP has not already completed (normal or expedited).
> > -                * If poll_state_synchronize_rcu_full() says it complet=
ed,
> > -                * then rcu_advance_cbs() above already moved those
> > -                * callbacks to RCU_DONE_TAIL, so there is no GP to wai=
t
> > -                * for.  Any remaining callbacks got new (future) GP
> > -                * numbers from rcu_accelerate_cbs() inside
> > -                * rcu_advance_cbs() and will be handled on the next pa=
ss.
> > -                */
> > -               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > -                   !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
> > +               // Need to wait on some grace period?
> > +               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
> >                         /*
> >                          * Track the earliest pending normal and expedi=
ted GP
> >                          * across the group so the wait below can be re=
leased by
>
>
> This looks correct to me, this optimization with
> !poll_state_synchronize_rcu_full(&cur_gp_seq) opened up this race as
> you correctly explained.

My local reproducer says that the problem is gone, but let's see what
Paul's 100s of hours of testing says.
