Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D6D299;
	Thu, 27 Jun 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454584; cv=none; b=gAvD95kBNjt2po3+l2EaoOEsc7RZR7fXxl/1TjnF9Lu/ZkcsjHRsz5fRqGnYhydDZVKn3H6EwOqNZj7n2JzLFsMr1TIYt3SeMCJK/E/j0pS4ogJivuLUi/ifW9h+oHT2oe1aJ2v6ZR03YaQIGsspnKQCITv53GTY2DgmRe0OPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454584; c=relaxed/simple;
	bh=SNmXUZaPD8/jIFyllpvzim8/Hv6kDHBMJLdeyAHgdFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idexF5OKVfXhWYt6/1FtuYEkJJI9K8VfwUj3Qqa/ICPQtmv6xGK7TR2VX4ohI0DHfvIhuUrZ7DuLzUuwwPmdn3Dvr4jU+axhBFWYzvPfbuJntEAb/h4XLvpNM1giRH6irxk4th0yFhVDOzecMak6Y7Y0Odq+hUAgr3RXmR3b3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XETogSz5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XETogSz5"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso111146961fa.1;
        Wed, 26 Jun 2024 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719454581; x=1720059381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DveGNeDVjuCDjhS9k/j3k6/jkRn9D6b5kOIHQkM86o=;
        b=XETogSz5skZSUuCoeh1swywZ5nyvePF1ufGcbh38fbCYpDwuCEQQJMNcVnD42+56Ge
         fQCS66LhZibJQZnItL5fUVHU0eaM/10qgn/fZNCw6BZyFLwsUUOHvMFZl5wGfM8t7YfL
         MZLcQaiswZL7pR7bywK5YJ+9Ob7FgqziT4Bof0az1PgA1Le/Yd/oW6oyXHvPleq92MF/
         TrkBa5EBCjdamfOSYedA7ofdRw3GZOI79HJRBboAVyr3ka7WlX3b+SMax4MoUYhRoHCe
         WqvPmWXaEVhpCDywYO197eP5Lc0dltiCe7u4V/dgBPtVbcXYAlU9Glhkce9VvB9sfsO2
         1dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719454581; x=1720059381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DveGNeDVjuCDjhS9k/j3k6/jkRn9D6b5kOIHQkM86o=;
        b=E0TnaD0uIWrjSGV2q4qlZxSOMjsmDG9JBbaM/QB2eISiPuV8+vj7u/0ZLx7x51NKPb
         4VVql+N8ZDcGSP4dPLEvSN9fpw30pR971gQDKkAb51R6QB1LlHc03KLDCz0gFMX6qZzs
         iwEI6uTL450xw/uizkC7T3oDS51PSepgH2vYzg9zyqr2SmXSt7wtYKqYHkkzycE7oaFh
         pV6h5QilW/yKIdSpJS2S+EW655bVyymfpC+OyKBKlO4julmV+StopfMwX0OYSDTHQ/sV
         zNfB6W8j94rTyFHS8ZpkmeaMuy1vZ34TequHzTOFz8ZM4uVEo/q4hreIAC6d9S2B2a0K
         RwNw==
X-Forwarded-Encrypted: i=1; AJvYcCWbyibMpEht8P4omnYWHg/Kuxh5Gi6+qN6jXIz2BoPORxav4bdSD3DS85SHc5w2CRrBepY3StaMb54vEHP8oTVF+sDB3Lm9E4IyiR0PLOVBqxk/mo24fRfeK+w/AXxtGZt+
X-Gm-Message-State: AOJu0YyJahAJBJS6sVvp9S+vTVdEn2Dnz9YyGer7i+fbgyEuaVxe9PT1
	1R1keDAG/KsO6cZ+LCYsmxs19IHLwALsLDLkSDTjh7oPKCiWSNG2n72S4EMnt2h8Vx5KOoTLaSA
	DoJ2L18SOv9WiSJjCbqHjjF4JMXs=
X-Google-Smtp-Source: AGHT+IHqmQIOc4Rc7jTTUAeQFjvlWvn6OyeOFTr2ZR2eDW+NjrF6pjGZgx0KHmx7keF2Q6ikQOUdmdvNbbVRcfxkJyU=
X-Received: by 2002:a2e:321a:0:b0:2ec:4d8a:785a with SMTP id
 38308e7fff4ca-2ec5b2c4e90mr99595001fa.4.1719454580215; Wed, 26 Jun 2024
 19:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org> <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
 <ZnwiCsor-cku3ETF@localhost.localdomain> <CAFwiDX8EL8q-ihiXR8GSu5AxmRGs8w4z682nWMMMqDe2phLjuQ@mail.gmail.com>
 <ZnyQJGJGeAbTSEhv@pavilion.home>
In-Reply-To: <ZnyQJGJGeAbTSEhv@pavilion.home>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Thu, 27 Jun 2024 07:46:08 +0530
Message-ID: <CAFwiDX8TP4EzsnFCfrj-2iKVdXGqsM5_eLexp=qpqnd7qEE-bw@mail.gmail.com>
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:33=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 26, 2024 at 10:49:05PM +0530, Neeraj upadhyay a =C3=A9crit :
> > On Wed, Jun 26, 2024 at 7:43=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le Wed, Jun 12, 2024 at 01:57:20PM +0530, Neeraj upadhyay a =C3=A9cri=
t :
> > > > On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > >
> > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > >
> > > > > When the grace period kthread checks the extended quiescent state
> > > > > counter of a CPU, full ordering is necessary to ensure that eithe=
r:
> > > > >
> > > > > * If the GP kthread observes the remote target in an extended qui=
escent
> > > > >   state, then that target must observe all accesses prior to the =
current
> > > > >   grace period, including the current grace period sequence numbe=
r, once
> > > > >   it exits that extended quiescent state.
> > > > >
> > > > > or:
> > > > >
> > > > > * If the GP kthread observes the remote target NOT in an extended
> > > > >   quiescent state, then the target further entering in an extende=
d
> > > > >   quiescent state must observe all accesses prior to the current
> > > > >   grace period, including the current grace period sequence numbe=
r, once
> > > > >   it enters that extended quiescent state.
> > > > >
> > > > > This ordering is enforced through a full memory barrier placed ri=
ght
> > > > > before taking the first EQS snapshot. However this is superfluous
> > > > > because the snapshot is taken while holding the target's rnp lock=
 which
> > > > > provides the necessary ordering through its chain of
> > > > > smp_mb__after_unlock_lock().
> > > > >
> > > > > Remove the needless explicit barrier before the snapshot and put =
a
> > > > > comment about the implicit barrier newly relied upon here.
> > > > >
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +=
++---
> > > > >  kernel/rcu/tree.c                                          | 7 +=
+++++-
> > > > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Me=
mory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memor=
y-Ordering.rst
> > > > > index 5750f125361b0..728b1e690c646 100644
> > > > > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Or=
dering.rst
> > > > > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Or=
dering.rst
> > > > > @@ -149,9 +149,9 @@ This case is handled by calls to the strongly=
 ordered
> > > > >  ``atomic_add_return()`` read-modify-write atomic operation that
> > > > >  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> > > > >  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> > > > > -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> > > > > -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> > > > > -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> > > > > +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire=
()``
> > > > > +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_si=
nce()``
> > > > > +(both of which rely on acquire semantics) to detect idle CPUs.
> > > > >
> > > > >  +---------------------------------------------------------------=
--------+
> > > > >  | **Quick Quiz**:                                               =
        |
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index f07b8bff4621b..1a6ef9c5c949e 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *r=
np, struct rcu_data *rdp)
> > > > >   */
> > > > >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> > > > >  {
> > > > > -       rdp->dynticks_snap =3D rcu_dynticks_snap(rdp->cpu);
> > > > > +       /*
> > > > > +        * Full ordering against accesses prior current GP and al=
so against
> > > > > +        * current GP sequence number is enforced by current rnp =
locking
> > > > > +        * with chained smp_mb__after_unlock_lock().
> > > > > +        */
> > > >
> > > > It might be worth mentioning that this chained smp_mb__after_unlock=
_lock()
> > > > is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_fq=
s_loop() ?
> > >
> > > Right!
> > >
> > > How about this?
> > >
> >
> > Looks good to me, thanks! Minor comment (ditto for the other patch) bel=
ow
> >
> >
> > >     /*
> > >      * Full ordering against accesses prior current GP and also again=
st
> >
> > Nit: "prior to current GP" ?
>
> Thanks. On a second thought and just to make sure we don't forget why we =
did
> what we did after a few years, I expanded some more, still ok with the fo=
llowing?
>

Yes, looks good!


Thanks
Neeraj

>         /*
>          * Full ordering between remote CPU's post idle accesses and upda=
ter's
>          * accesses prior to current GP (and also the started GP sequence=
 number)
>          * is enforced by rcu_seq_start() implicit barrier and even furth=
er by
>          * smp_mb__after_unlock_lock() barriers chained all the way throu=
ghout the
>          * rnp locking tree since rcu_gp_init() and up to the current lea=
f rnp
>          * locking.
>          *
>          * Ordering between remote CPU's pre idle accesses and post grace=
 period's
>          * accesses is enforced by the below acquire semantic.
>          */
>
> Thanks.
