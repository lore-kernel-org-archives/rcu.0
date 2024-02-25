Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C7FBE5
	for <rcu@vger.kernel.org>; Sun, 25 Feb 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708857722; cv=none; b=jaG32WBrc5KYYN6I94ZrLG+0jL9wQFX/xhkwvkrpWWtwleOfuecfiU/Y9cRl/40ySmdJrTqzzTvAEZNkznyhr4RBg1Cy/qAkFIyCZx607PiPrOjvS6+rmKJeGYU2dCYsYWlk5EzkaTenKQSkaWoj+G1n/kywCVPJRhgk3RAaULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708857722; c=relaxed/simple;
	bh=Gc2ypxcA1xXfwE7U4AofrxGDsRcnr3j0xrGCDzjKm04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwWUyrj73sHcmv12TBoxOP/OVSJEyD6XvikSn2qLn6p5023i9ocQnwlul2ZwkPplaiWz6nSzuA3sRdjK5uEBMaUvpePfjYZ/8GqtGgLWfKNXhbf6TWEEHeNMVRChkRfmeiI7UjpW52bdFPvFTY9wgfTkzTCWYeI3lUAZxLLtb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg9NVRDA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg9NVRDA"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so2448650a12.3
        for <rcu@vger.kernel.org>; Sun, 25 Feb 2024 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708857718; x=1709462518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71VPWwLLQ6OS/EGMdmHkVFUM5gSYkRAeaWj/8XPqfHM=;
        b=Dg9NVRDAVb0a08RWOZCstJIEct9CJ94EuXNZKbcK2p7C0P8iX+n0xA+EtSNfVxGwIO
         HNuiY4eZp+8vnDZnXk2OIS560LFyofZUIXTS3nEa2q1xHUdHxe24Ik+mpckCbrX3VrTd
         gyks6t5Xav/Il2MODbXRTGV4VeoqKzJS6keIvs4mo9KJrsNvHkVVIRdWMqeEEbXy5S8S
         /z26X45L3Z3eDJdrLuhrB+MCj3uDeRqk7qX+o+7qfVZVhzF3mhEvUBnqMZesMrcXCn3d
         IRpyDUZKl1w6Zi11L6axLGsIgNGOj9lGYwDoGC+AAH4edcvCdqMyjoH8DMS1tHMheX1v
         CxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708857718; x=1709462518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71VPWwLLQ6OS/EGMdmHkVFUM5gSYkRAeaWj/8XPqfHM=;
        b=UJHGw8RlsLwr7h11jjUKd1PeokV6h/Ur0I//AjaAI2zOffmm17IzF87p4BrJ960nfq
         D8MVm4LY3dT82kBpiz/dYOzoHpTi95i90mF0R9D7YXOJ+O1lvRPBp/kdNtK4eyTwR9k8
         s0ObNCPn3vCkCFspx+1hYEUp8nNFatBT0Pax50Es5048BwTnHNvkVDIscmCb3CZg5vhi
         5B4Hx94o9UnW80e0b1GdZSfYa8aO31N8YP266kQtdac9Bv5wxcvKBP/KPRJAoSKU9YZG
         mXDcX3/u/5ZAIs05j2NHR5ycWc9xUjwmEvVtDEzMpaGoRNokvTkIzdWnhjfAtcfnXSzo
         Ur9A==
X-Forwarded-Encrypted: i=1; AJvYcCWwfrA+FmBOCjgmNylI8oixT6Cw01wXhDWOHl1twlODNl2NP6euuHomFN2i6DKSLMM8w/UDEAEhsaXOF5u0ZnEwKI4Y
X-Gm-Message-State: AOJu0Ywp6+UoxYaMlOf9mDNQgm1lthsNAVgnCXH5efbwV0dZJ/SylEwS
	mGnDQIer/uoc4yGxu/QksLr1GEdGKe0EoLUk8j7Vix+xr70WSq0nDQG5HcKXmrXCO/85aJn541/
	TPK+vEfW3KzlRlaaoU2AJnyftNK0=
X-Google-Smtp-Source: AGHT+IGNwbo5MmXlh2VqRpuc7Zh+6AQevwBcMNsm8DrrLQrX+mN/jYl8Imaj1jcs0dx93TJ6u9u40yRFI3p6s5aUfv8=
X-Received: by 2002:a05:6402:1817:b0:564:4221:9aa9 with SMTP id
 g23-20020a056402181700b0056442219aa9mr2858620edy.38.1708857717833; Sun, 25
 Feb 2024 02:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD8CoPAKw7eXC5iTKJk=6NQi3HEOLAujFXQRD9ViB0eDQFYRLw@mail.gmail.com>
 <f856fa0a-2195-4eef-baf3-2b031770b97a@paulmck-laptop>
In-Reply-To: <f856fa0a-2195-4eef-baf3-2b031770b97a@paulmck-laptop>
From: Ze Gao <zegao2021@gmail.com>
Date: Sun, 25 Feb 2024 18:41:46 +0800
Message-ID: <CAD8CoPB5MEHV6v+z5znY8apkaACM+s3oUu-tTttuQ29iRvU9EQ@mail.gmail.com>
Subject: Re: Questions on RCU memory guarantees in linux
To: paulmck@kernel.org
Cc: neeraj.iitr10@gmail.com, joel@joelfernandes.org, frederic@kernel.org, 
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 6:19=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Adding some additional RCU experts on CC.
>
> On Fri, Feb 23, 2024 at 03:22:13PM +0800, Ze Gao wrote:
> > Dear Paul,
> >
> > I'm reading this article [1] by you and have doubts about how these
> > memory guarantees are provided in Linux.
> >
> > As quoted from [1], RCU needs to make sure:
> >
> > >1. Each CPU that has an RCU read-side critical section that begins bef=
ore synchronize_rcu() >starts is guaranteed to execute a full memory barrie=
r between the time that the RCU read-side >critical section ends and the ti=
me that synchronize_rcu() returns. Without this guarantee, a pre-> existing=
 RCU read-side critical section might hold a reference to the newly removed=
 struct foo > after the kfree() on line 14 of remove_gp_synchronous().
> >
> > >2. Each CPU that has an RCU read-side critical section that ends after=
 synchronize_rcu() >returns is guaranteed to execute a full memory barrier =
between the time that synchronize_rcu() >begins and the time that the RCU r=
ead-side critical section begins. Without this guarantee, a >later RCU read=
-side critical section running after the kfree() on line 14 of >remove_gp_s=
ynchronous() might later run do_something_gp() and find the newly deleted >=
struct foo.
> >
> > FWIW,  I can understand the necessity for smp_mb() for both cases you
> > have posted in the quick quiz. But I'm really curious about how
> > Tree-RCU with !CONFIG_PREEMPT provides such
> > guarantees where obviously smp_mb() cannot be provided by
> > rcu_read_{lock, unlock}.
> >
> >  Also, I see you've answered another related question in a different
> > quiz about how RCU infers quiescent states,  After digging for a
> > while, I try to make the best guess of the answers so here is my
> > understanding:
> >
> > 1) both Guarantee #1 and #2 are to make sure any loads/stores by
> > updater are properly propagated to newly arriving readers so to avoid
> >
> > 2) according to 1), so in cases where rcu_read_{lock, unlock}
> > generates no code, the smp_mb() is actually provided by where the CPU
> > reports a quiescent state. IOW, Tree-RCU with !CONFIG_PREEMPT provides
> > Guarantee #1 and #2 by extending the grace period requested by
> > synchronize_rcu(), so in both following cases you mentioned, smp_mb()
> > can be provided by accessing rcu_node structure's ->lock field
> > mentioned in [2].
>
> So far so good.

First and most importantly, thanks for your attention and replies, which me=
ans
a lot to me!

> > Case A:
> > CPU 1: rcu_read_lock()
> > CPU 1: q =3D rcu_dereference(gp); /* Very likely to return p. */
> > CPU 0: list_del_rcu(p);
> > CPU 0: synchronize_rcu() starts.
> > CPU 1: do_something_with(q->a); /* No smp_mb(), so might happen after
> > kfree(). */
> > CPU 1: rcu_read_unlock()
>
> Here CPU 1 must report its quiescent state to the RCU core code.  This
> involves locking and memory barriers that ensure that the rcu_read_lock()
> is seen by all to precede the return from synchronize_rcu().
>
> > CPU 0: synchronize_rcu() returns.
> > CPU 0: kfree(p);
> >
> > Case B:
> > CPU 0: list_del_rcu(p);
> > CPU 0: synchronize_rcu() starts.
>
> If synchronize_rcu() cannot prove that it started before a given
> rcu_read_lock(), it must assume that the rcu_read_lock() was there first.
> This is mediated by the RCU core code that sees that the grace period
> started. So if CPU 1 sees the grace period as having started before the
> rcu_read_lock(), then the grace period will not wait for the correspondin=
g

So it means CPU 1 has already reported its QS for the recent most
GP to the RCU core, and already see the published value (actually all
writes before synchronize_rcu() ), so it's not necessary to wait for it.

I think I understand it a little bit: this is all about GP tracking. And fr=
om
a high level of overview.

1)  gp seq updating provides smp_mb() for all with the updater included.
2)  RCU core checks gp seq and does QS reporting provides smp_mb() for
the readers

such that each reader CPU who reports its QS for a given GP is
guaranteed to see all
loads/writes by the updater who initiates the GP.

or maybe 2) provides all smp_mb() already.

I don't know if I get it right.

> rcu_read_unlock().  Otherwise, it will wait, avoiding the situation
> shown below.
> Again, with locks and memory barriers providing ordering.
>
> > CPU 1: rcu_read_lock()
> > CPU 1: q =3D rcu_dereference(gp); /* Might return p if no memory barrie=
r. */
> > CPU 0: synchronize_rcu() returns.
> > CPU 0: kfree(p);
> > CPU 1: do_something_with(q->a); /* Boom!!! */
> > CPU 1: rcu_read_unlock()
> >
> > I should've studied the code to find the answer, but It may take years
> > to know the details :).
> > (no kidding given the large codebase and its complicacy).  So I'm
> > being bold to directly write to you for help. Please forgive me for
> > being reckless.
> >
> > Appreciate your excellent docs on this topic and look forward to your
> > comments to clear my doubts.
>
> As you say, the code is non-trivial.  Something about needing to scale
> to systems having thousands of CPUs, conserve energy on battery-powered
> systems, tolerate CPUs coming and going (for example, in suspend/resume),
> help to provide deep sub-millisecond real-time latencies, work properly
> when being used before it is initialized during kernel boot, and so on.
>
> So [3] is the summary I wrote up to communicate how this works (sadly, al=
l
> 648 lines of it), with [4] being a graphical summary of how things work.
> Studying these carefully over a period of time has proven quite helpful
> to some people.
>
> Section 4 of [5] gives an overview, but with less detail.  It might
> be a good place to get a running start for digging through [3][4].
> We have a bunch of low-level RCU design documents publicly available
> [6], which might also be helpful.
>
> Or you might wish to take a look at a simpler RCU implementation, which
> faces the same issues, but which is easier to get one's head around.
> Userspace RCU is such an implementation (and there are many others
> [8]), and its web page [8] points to a great deal of documentation,
> perhaps most notably the February 2012 IEEE TPDS paper.

Thanks for the great materials and advice, which I should digest for a whil=
e.

> This is not easy stuff, and I encourage you to keep at it!

Yes, It's hard, but I hope my curiosity can bring me a little further.
:) And again,
thanks for your encouragement and glad to learn from you and your
brilliant work.

Thanks,
        -- Ze

>                                                         Thanx, Paul
>
> > Regards,
> >         -- Ze
> > ---
> > [1]: https://dri.freedesktop.org/docs/drm/RCU/Design/Requirements/Requi=
rements.html#memory-barrier-guarantees
> > [2]: https://dri.freedesktop.org/docs/drm/RCU/Design/Memory-Ordering/Tr=
ee-RCU-Memory-Ordering.html#what-is-tree-rcu-s-grace-period-memory-ordering=
-guarantee
>
> [3]: https://dri.freedesktop.org/docs/drm/RCU/Design/Memory-Ordering/Tree=
-RCU-Memory-Ordering.html#what-is-tree-rcu-s-grace-period-memory-ordering-g=
uarantee
> [4] https://www.kernel.org/doc/Documentation/RCU/Design/Memory-Ordering/T=
ree-RCU-Diagram.html
> [5] https://github.com/michaliskok/rcu/blob/master/rcupaper.pdf
> [6] https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYu=
tdSIajfpLA/edit?usp=3Dsharing
> [7] https://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.=
html
>     Section 9.5.5 has a list of uses and implementations.
> [8] https://liburcu.org
