Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC423F8899
	for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897570; cv=pass; b=sXVkZBlc4Wzm0AGSghewQts5DRckOLLS9gnmUf78EcJ3/H2CoKL5Rb1g3oNb5kKkUZGCCRpVKPB5pZUS6FYlTsEYMWgj1rHswXXnXdd+tpR58vYAm2jEKExv453ZpQPWq86N2a9VRmfrVnP9D3ftnuJozk3H/5Ou6UqLpIiKZnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897570; c=relaxed/simple;
	bh=H5Wj73ezMjb+EAZvwJvzcK4Qn/TjeY71l0GEXNihPJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jn37s5rpLjDh0jHLMOs2Z2Vp/b4T9bHQaJOQvdny3DdiCzc4VDU32dnxZLdn6isMyyPmrteBazPw0Efgo9B1Rn7VTXDtIEaC+hlDbT9KQEIcgQGBfghAX4c4Y+pPglM8rbZI9DTepVWtRLhmRsx/bb/q15KmrYAgnHxb7jigyVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRq0naTW; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRq0naTW"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1670dad7a8so62423266b.3
        for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 05:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784897563; cv=none;
        d=google.com; s=arc-20260327;
        b=MBn54tkcyd4zIBUJhNrlUn31brnHy2k+4txh4cYpp7lDCXg3KaSo1ZCZ5clHFDqaqx
         TfDVnmFQRtkHng2prjjfekKHWWCmViO+Vak+zmEXMSP50uo6rFzdSiIBBrJaPnXsiPor
         zgKRmGhIpRbKpBaeiC8kFCIe5dS9eS5TJk0goJELTD/RBgJFtKiUduxkUEBfnLrj59fR
         My2vXcCewaeV0uANMWwsgOvnF3A3sn8KJpraW7njFrsz+n0dWj/gesCCFF+fK0NOMzCm
         UXFhWU4Z8MIlEw02IreO2Y8WyEw2b+rttS6t7dTd1iZGshHaeeXGX/VHsoDwKv1UIF0D
         Nkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        fh=YG1vdy11ixD/utfmnnJ5veuiOXgU5dYEgjgHbGn46xM=;
        b=W1dZElBsrzPpFkwogof0zOCKGRR5XnyzM7p4duhFEtNk6v79MA/bIPzO5mJmBGp26j
         ccam0zCGKn6VMmjS+wa+xt7jOlL9eWcsMVC2t4i+nlwh/aO3KFXk0TwKqWGe3dEYK7AX
         SZuj2J2euAG7/tYNNt68sdLMwZMaXxXiQkveW7lrlsRz/EBKcqxPLrL8W7dFecYhcE/j
         /8qi48a1QXEbMK+udT4B94i5WbzecZEDkTEOtDOilREF96LRfXDwFOFSXEEyWRQsk7Ui
         3mlctKTuQZvpUzrHSkW6jRSNO82Y023ngCzS4hhLSQjCi2h5nHwqE3zx6YvmhOdt+AXL
         SJdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784897563; x=1785502363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        b=KRq0naTWVrnHYHQ0RUrbLGk7mHAs4kdLzdhJZV+Fkt4RNjteFc1KzkIXewpj3k34/d
         f+vRs871+t7aeAX1WT7ABw2WvEmGL+dZIZRpCTnbdsAm1q858zeURkcjWdopdBh/fgOe
         V50YPlMVU3tQndO20FRcwOFhctvRSA0A6mZOGrYSr0wwqy5TaEiiCP1+AD/ZkSCVvaZb
         fT0E4Xk4OeL7KIX5nhXBoaxsjQhmw74CXR3sImLvziF9mpbsJhDSVRHEZR0M47ytyw4k
         Xi0D083et0fhz0NcqY9jbtHXmSow36UahwvDE/+c26wvwN6jKNamRbBDgFan4U0PwuQC
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784897563; x=1785502363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        b=T40+cz0O7CzuAoVh5rV/fCVTv0HQENVixnZgwFUQ9xFkbv3Xoba7KnweIG3TmlzpS+
         GNH80AaPLujIXrIexW8C3VDoKzxad3rNVZR54b7Xm/PzugoiuQY8RBkIeAeBnlt+2dz7
         cDxJKIFY2w3jPe7THVXotd2VX1ThlhZZUxQzgb4MXN9AGCuxvR8GXV76yredpnkLS02s
         rGSaO6jWRLYNdqYMcDiF9QLQC4TASSjGbPqNaAWdldkL5KO7/nj/GAc0Y0tMBzQl2yuM
         YLEdf7jdcE4e/tYfZK3h+l9Uru/Z8CSfxvYqYQ3dkFFByEKlq6U6PXMIbIEPIywSO15c
         rAKw==
X-Forwarded-Encrypted: i=1; AHgh+RoI1mG4419rC29i6I56rTg2O8dPrMVwjTHrmXRwERTlx0NzIaTiLP4hZ4bR/pmoA+Zklkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJw3WOwtU11yzp9KyBqlY6yGS/eDsVftMWehkACWaqcTiTyNp
	DXObq+5RrNUJEPThAFDTl7fuClW0ZEemYMl0D8vJxLkGnqy6F/SV6xsYzMMtuI7rL78mJOLEHW7
	iw66iHJV/eFIE9MGTETeKvzI3/TZa3hU=
X-Gm-Gg: AR+sD13G0gjS5zQJ3dQITBOyP5lASy22umZg3YY7+I5/nzU2pbGoRyUAGEWBlvivcYy
	XyXhea/odhHLsCMZyKIBv5FYbKC4HrJO3kKca48JxjJGrXo3SmJVBo5hu+lt46/2dHTfS06K4rv
	7armFmKN9dtyNVn7aXwsz7rGs/5P8I9qIXKn8eHW/P+GRby7XHPwfilZFaQPn5IEvhlKA08nj7n
	mDHmgwSpgs7dxjJTXLs6BlMad9kTY4jjSBTl8jcvuHQy979bsIqTSIE/gyHuUwPgXVBlK07rpiW
	iQ==
X-Received: by 2002:a17:906:478a:b0:c1c:2fd3:bbd7 with SMTP id
 a640c23a62f3a-c1c509d3485mr332428066b.26.1784897563116; Fri, 24 Jul 2026
 05:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <062ddbcd-dac1-4ee1-9d3f-ef115a667d6a@paulmck-laptop>
 <amNeS_ahHPLqXIGT@localhost.localdomain>
In-Reply-To: <amNeS_ahHPLqXIGT@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 24 Jul 2026 13:52:28 +0100
X-Gm-Features: AUfX_mxSjHfjWkcj0LEqQto_dwl1af8NQPOTnuA8saQXKYY5X49y2FXuKVGCVFM
Message-ID: <CANk7y0hQQ3oDKt+_8oh4t=8NfMRSa80a9jGr+DG+zbrcuUskTA@mail.gmail.com>
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

On Fri, Jul 24, 2026 at 1:45=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Jul 23, 2026 at 05:31:17PM -0700, Paul E. McKenney a =C3=A9crit :
> > On Wed, Jun 24, 2026 at 06:23:42AM -0700, Puranjay Mohan wrote:
> > > This series lets call_rcu() callbacks be reclaimed as soon as either =
a
> > > normal or an expedited grace period that covers them has elapsed, rat=
her
> > > than always waiting for a normal grace period.
> > >
> > > Motivation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Today there is an asymmetry: synchronize_rcu_expedited() callers get =
fast
> > > reclaim, but call_rcu() callers never benefit from those same expedit=
ed
> > > grace periods, even though an expedited GP proves exactly the same th=
ing
> > > as a normal one -- all pre-existing readers are done.  When expedited=
 GPs
> > > are running on the system (driven by other subsystems), call_rcu()
> > > callbacks that could already be freed instead sit in RCU_WAIT_TAIL un=
til
> > > the next normal GP.  This series treats a grace period as a grace per=
iod
> > > regardless of how it was driven, so memory is reclaimed sooner.
> > >
> > > Design
> > > =3D=3D=3D=3D=3D=3D
> > > Callback segments now record both the normal and expedited grace-peri=
od
> > > sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases a
> > > segment as soon as poll_state_synchronize_rcu_full() reports that eit=
her
> > > has completed.  Three notification paths are taught about expedited
> > > completion so the advance actually happens: the NOCB rcuog kthreads,
> > > the rcu_pending() tick gate, and rcu_core().
> > >
> > > Changelog:
> > > RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@ker=
nel.org/
> > > Changes in v1:
> > >  - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp_s=
eq
> > >    and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederic)=
.
> > >  - The rcu_segcblist segment field stays named gp_seq; only its type
> > >    changes (Frederic).
> > >  - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
> > >    (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
> > >    rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps on=
),
> > >    and the wait condition only checked the normal ->gp_seq.  The rcuo=
g
> > >    grace-period wait now tracks a struct rcu_gp_seq and is released v=
ia
> > >    poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the l=
eaf
> > >    node through the new rcu_nocb_exp_cleanup() (Frederic).
> > >  - rcu_pending() uses a new memory-ordering-free
> > >    poll_state_synchronize_rcu_full_unordered() to avoid memory barrie=
rs
> > >    on every tick, leaving the ordering duty to rcu_core() (Frederic).
> > >
> > > Still open: Frederic asked whether the first smp_mb() in
> > > poll_state_synchronize_rcu_full() is needed on the callback-advance p=
ath
> > > (patch 6).  That path still uses the fully ordered helper; only
> > > rcu_pending() was switched to the unordered variant.  Happy to revisi=
t.
> > >
> > > Puranjay Mohan (11):
> > >   rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
> > >   rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
> > >   rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
> > >   rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
> > >   rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
> > >     GPs
> > >   rcu: Enable RCU callbacks to benefit from expedited grace periods
> > >   rcu: Update comments for gp_seq and expedited GP tracking
> > >   rcu: Wake NOCB rcuog kthreads on expedited grace period completion
> > >   rcu: Detect expedited grace period completion in rcu_pending()
> > >   rcu: Advance callbacks for expedited GP completion in rcu_core()
> > >   rcuscale: Add concurrent expedited GP threads for callback scaling
> > >     tests
> >
> > I do see the occasional failure when running TREE01, as in a failure or
> > four every couple hundred hours of testing.  This is the only rcutortur=
e
> > scenario that exercises callback (de)offloading, which might (or might
> > not) be a clue.
> >
> > The console log of a failing run is attached, or you can find it here:
> >
> > https://drive.google.com/file/d/1EH2P4SDy2a-SJndkN3GbCTGAXxI2xevm/view?=
usp=3Dsharing
> >
> > This is a "??? Writer stall state" failure, where rcutorture never lear=
ns
> > of grace-period completion.  Possibly because no grace period completed=
.
> > But there are no RCU CPU stall warnings.  In addition, these two lines
> >
> > [  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 ->s=
tate D cpu 1
> > . . .
> > [ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 ->s=
tate D cpu 1
> >
> > show that the grace-period sequence number advanced from 152813 to
> > 736160 in about 50 minutes.  So grace periods really are completing,
> > lots of them.
> >
> > This rcutorture scenario has rcu_nocbs CPUs, and CPU 5 is in trouble:
> >
> > [  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(148380/=
168068).N295B101 q516 S CPU 16
> > . . .
> > [ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(148=
380/168068).N295B101 q516 S CPU 16
> >
> > There are 120 callbacks on the WAIT segment, which are waiting on
> > grace-period sequence number 148380, which was long gone even back at
> > 631.032657 seconds in (g152813).  There are 295 more callbacks in the N=
EXT
> > segment, which long ago should have been assigned a grace period and mo=
ved
> > into the currently empty NEXT_READY segment (which is the "." right bef=
ore
> > the "N295").  There are yet another 101 callbacks on the bypass list.
> >
> > This suggests that the rcuog kthread isn't being awakened when it
> > should be.  And that something is failing to advance callbacks out of
> > NEXT in a timely fashion.
> >
> > Thoughts?
>
> If a grace period has elapsed while in the middle of nocb_gp_wait(),
> after the call to rcu_advance_cbs() and before the following polling whic=
h
> determines if we a grace period must be waited upon, then the kthread
> will wait for new callbacks only (and will ignore waiting callbacks that
> can now be advanced).
>
> Does the following help?
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 6da1b8f52476..96d76eb6259d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -792,22 +792,12 @@ static noinline_for_stack void nocb_gp_wait(struct =
rcu_data *my_rdp)
>                                                            RCU_NEXT_READY=
_TAIL);
>                         raw_spin_unlock_rcu_node(rnp); /* irqs disabled. =
*/
>                 }
> -               // Need to wait on some grace period?
> +
>                 WARN_ON_ONCE(wasempty &&
>                              !rcu_segcblist_restempty(&rdp->cblist,
>                                                       RCU_NEXT_READY_TAIL=
));
> -               /*
> -                * Only request a GP wait if the next pending callback's
> -                * GP has not already completed (normal or expedited).
> -                * If poll_state_synchronize_rcu_full() says it completed=
,
> -                * then rcu_advance_cbs() above already moved those
> -                * callbacks to RCU_DONE_TAIL, so there is no GP to wait
> -                * for.  Any remaining callbacks got new (future) GP
> -                * numbers from rcu_accelerate_cbs() inside
> -                * rcu_advance_cbs() and will be handled on the next pass=
.
> -                */
> -               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> -                   !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
> +               // Need to wait on some grace period?
> +               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
>                         /*
>                          * Track the earliest pending normal and expedite=
d GP
>                          * across the group so the wait below can be rele=
ased by


This looks correct to me, this optimization with
!poll_state_synchronize_rcu_full(&cur_gp_seq) opened up this race as
you correctly explained.

Thanks,
Puranjay
