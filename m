Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BF4A484B;
	Wed,  2 Sep 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363812; cv=none; b=JgvHO+B9F65f210dNaWmtmHr55F6Yfgt2K9A9SCsoOsicpGYkPyQKU1ry/70RVNKcdNrEVRiq1bLNrhTt6ArB0+6z4AtEX+CDbDenL2zDS7XGn0iO2isjZDTtj6+XfwTS3s1pAD7tc/VnmFogcBMUfcV7q519tx2DP4CPvzRZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363812; c=relaxed/simple;
	bh=4Lh7BYDQ6oaS2gNgV+CxhrxaAiriuKMCOtvHvate3ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/5F/Yee7dNR2EUk4Eafl7yMFzaDa3YfjfFPhjFHkz3KI/YPhdyMKO8AwJPDqrDJXacr54M4JOuzfykVQPfKLBLCGE75EyxRjXmK4PBbNPuDwEjYItoTfenJftLefJhMBlYJq2ZyhqVtXond5TX7QSTe/a3uK8UXZCf1fT91DIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/fbPbcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/fbPbcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7F1F000E9;
	Wed,  2 Sep 2026 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363809;
	bh=Les5VFlgbFgzqXPR7vn/kSwqh4mo5FfhVa/8f8euHIw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=P/fbPbcRr7uZKjGVu5bNsAq8BGUNVoHEUUOU3+8AwJAfOIDK3x67xt9TduO8uqpD1
	 yXzMDc5R5olri9FV5gzq/+IFKT2el+lIoniOjUAZNY95zNDMJjmkeXHUq0ox9/vc88
	 Hv3wTlJaw38PEcIPsyupP4eEg8guWNyAzXCpyXIXzr94M3iMpuOeeI9JnklVu1WrZk
	 kFcEXQPTOgnbFtjKvZaJmOAuvTd0MOfP46zfoMn0GwvVzC8wk/X3Vbx7YlXJsnFFhR
	 4DF8Qnynp0ayuqPBJWQmgT0sP3LX7v0DHwSE3VPdvRwK0b2tOLbroLGYe/9W+xaHwN
	 fio3M3eYEMc1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90DE0CE0503; Wed,  2 Sep 2026 08:43:29 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:43:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutiny: Enable atomic SRCU flavor tracking
Message-ID: <b099065c-5808-4eb6-9dba-fcba9a2ef9ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260901074815.3145037-1-kunwu.chan@linux.dev>
 <d991297a-9bd4-4da2-89cd-002b6f2a3305@paulmck-laptop>
 <CAN_Opa81BaWxkdRyoHQBcMLbOt-n7f-4cUmxxstage1MSOu1Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa81BaWxkdRyoHQBcMLbOt-n7f-4cUmxxstage1MSOu1Hw@mail.gmail.com>

On Wed, Sep 02, 2026 at 05:18:50PM +0800, KunWu Chan wrote:
> On Wed, Sep 2, 2026 at 1:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Sep 01, 2026 at 03:48:15PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > >
> > > Set srcu_reader_flavor to SRCU_READ_FLAVOR_ATOMIC in the Tiny SRCU
> > > atomic initialization paths, so that the entry-point checks added by
> > > the previous commit can identify atomic SRCU domains.
> > >
> > > For static initialization, add a flavor parameter to
> > > __SRCU_STRUCT_INIT() and pass SRCU_READ_FLAVOR_ATOMIC through
> > > DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC().
> > >
> > > For dynamic initialization, initialize srcu_reader_flavor to zero in
> > > init_srcu_struct_fields() for the generic initialization path, and
> > > set it to SRCU_READ_FLAVOR_ATOMIC in init_srcu_struct_atomic().
> > > Handle both CONFIG_DEBUG_LOCK_ALLOC and non-debug initialization paths.
> > >
> > > Enable srcu_check_read_flavor() for Tiny SRCU, matching the Tree SRCU
> > > behavior, so that readers can verify that the requested flavor matches
> > > the SRCU domain.
> > >
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Much better!  Please see below for additional questions and comments.
> 
> Thanks Paul for the detailed reply.
> 
> >
> > > ---
> > >  include/linux/srcutiny.h | 39 +++++++++++++++++++++++++++++----------
> > >  kernel/rcu/srcutiny.c    |  1 +
> > >  2 files changed, 30 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > index 2b293336525a..9dce4b5aa084 100644
> > > --- a/include/linux/srcutiny.h
> > > +++ b/include/linux/srcutiny.h
> > > @@ -40,7 +40,7 @@ void srcu_drive_gp(struct work_struct *wp);
> > >  void srcu_tiny_irq_work(struct irq_work *irq_work);
> > >  void srcu_defer_drain(struct irq_work *irq_work);
> > >
> > > -#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored) \
> > > +#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, flavor)              \
> > >  {                                                                    \
> > >       .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
> > >       .srcu_cb_tail = &name.srcu_cb_head,                             \
> > > @@ -49,6 +49,7 @@ void srcu_defer_drain(struct irq_work *irq_work);
> > >       .defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),                   \
> > >       .defer_iw = { .node = { .u_flags = IRQ_WORK_HARD_IRQ },         \
> > >                     .func = srcu_defer_drain },                       \
> > > +     .srcu_reader_flavor = flavor,                                   \
> >
> > Don't we also need to define srcu_reader_flavor?  Or is this patch
> > supposed to be applied on top of your previous one?
> 
> Yes, this is intended to be applied on top of the previous one [1].
> [1] https://lore.kernel.org/rcu/20260831074937.2380914-1-kunwu.chan@linux.dev/
> 
> > >       __SRCU_DEP_MAP_INIT(name)                                       \
> > >  }
> > >
> > > @@ -57,29 +58,43 @@ void srcu_defer_drain(struct irq_work *irq_work);
> > >   * Tree SRCU, which needs some per-CPU data.
> > >   */
> > >  #define DEFINE_SRCU(name) \
> > > -     struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> > > +     struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
> > >  #define DEFINE_STATIC_SRCU(name) \
> > > -     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> > > +     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
> > >  #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
> > >  #define DEFINE_STATIC_SRCU_FAST(name) \
> > > -     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> > > +     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
> > >  #define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
> > >  #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
> > > -     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> > > -#define DEFINE_SRCU_ATOMIC(name) DEFINE_SRCU(name)
> > > +     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, 0)
> > > +#define DEFINE_SRCU_ATOMIC(name) \
> > > +     struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
> > >  #define DEFINE_STATIC_SRCU_ATOMIC(name) \
> > > -     static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
> > > +     static struct srcu_struct name = \
> > > +             __SRCU_STRUCT_INIT(name, name, name, SRCU_READ_FLAVOR_ATOMIC)
> > >
> > >  // Dummy structure for srcu_notifier_head.
> > >  struct srcu_usage { };
> > >  #define __SRCU_USAGE_INIT(name) { }
> > >  #define __init_srcu_struct_fast __init_srcu_struct
> > >  #define __init_srcu_struct_fast_updown __init_srcu_struct
> > > -#define __init_srcu_struct_atomic __init_srcu_struct
> > > +#define __init_srcu_struct_atomic(ssp, name, key) \
> > > +({ \
> > > +     int __ret = __init_srcu_struct(ssp, name, key); \
> > > +     if (!__ret) \
> > > +             (ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC; \
> > > +     __ret; \
> > > +})
> > >  #ifndef CONFIG_DEBUG_LOCK_ALLOC
> > >  #define init_srcu_struct_fast init_srcu_struct
> > >  #define init_srcu_struct_fast_updown init_srcu_struct
> > > -#define init_srcu_struct_atomic init_srcu_struct
> > > +#define init_srcu_struct_atomic(ssp)                                 \
> > > +     ({                                                              \
> > > +             int __ret = init_srcu_struct(ssp);                      \
> > > +             if (!__ret)                                             \
> > > +                     (ssp)->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;\
> > > +             __ret;                                                  \
> > > +     })
> > >  #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
> > >
> > >  void synchronize_srcu(struct srcu_struct *ssp);
> > > @@ -148,7 +163,11 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
> > >  void srcu_barrier(struct srcu_struct *ssp);
> > >
> > >  static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
> > > -#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> > > +#define srcu_check_read_flavor(ssp, read_flavor) \
> > > +     ({ \
> > > +             u8 __f = (ssp)->srcu_reader_flavor; \
> > > +             WARN_ON_ONCE(__f && !(__f & (read_flavor))); \
> > > +     })
> >
> > Why not make this a static inline function, along with
> > __init_srcu_struct_atomic() and init_srcu_struct_atomic() above?
> > That should simplify the code.
> 
> Thanks. I’ll rework the initialization helpers as static inline
> functions as suggested.
> 
> > >  /* Defined here to avoid size increase for non-torture kernels. */
> > >  static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > index 22f7716cbb0e..873b30ccf563 100644
> > > --- a/kernel/rcu/srcutiny.c
> > > +++ b/kernel/rcu/srcutiny.c
> > > @@ -42,6 +42,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
> > >       ssp->srcu_gp_running = false;
> > >       ssp->srcu_gp_waiting = false;
> > >       ssp->srcu_atomic_gp_flag = 0;
> > > +     ssp->srcu_reader_flavor = 0;
> > >       ssp->srcu_idx = 0;
> > >       ssp->srcu_idx_max = 0;
> > >       INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
> > > --
> > > 2.43.0
> >
> > One of the purposes of Tiny SRCU is to be tiny, and one could argue
> > that Tiny SRCU already has too much diagnostic code.  Should we include
> > these patches at all?  If we should, shouldn't they be under something
> > like CONFIG_PROVE_RCU?  Should some of the existing Tiny SRCU debugging
> > code also be under something like CONFIG_PROVE_RCU?
> >
> > Thoughts?
> 
> I agree that Tiny SRCU should keep its core as small as possible, so I think
> it is worth reconsidering how much diagnostic machinery we want to add here.
> 
> For srcu_reader_flavor, I did have some hesitation when adding it.
> Tiny SRCU did not previously have the concept of a reader flavor; I
> mainly added it
> to distinguish Tiny Atomic SRCU, following the approach used by Tree
> SRCU. If we still
> need state for this purpose, perhaps a one-bit flag would be sufficient.
> 
> One question is whether the flavor checking really needs to be part of
> srcutiny.c.
> I think there are two somewhat different cases:
> 1: checking for invalid API usage, where the purpose is to detect or
> stop misuse;
> 2: defensive handling of an invalid call, where we redirect to a safe
> implementation,
>     like in synchronize_srcu.
> 
> The first case seems more like diagnostic functionality and could
> potentially be handled
> in the common SRCU API layer under CONFIG_PROVE_RCU. The second case affects
> runtime behavior and should remain independent of CONFIG_PROVE_RCU.
> 
> This makes me wonder whether the common flavor validation could live in srcu.h,
> as part of the common SRCU interface, rather than adding more checking
> logic to srcutiny.c.
> That could centralize the validation and keep the Tiny SRCU
> implementation easier to follow,
> although it would add another wrapper layer, such as a macro or static inline.

Another approach is to let the checking in Tree SRCU cover this.
That way, the only misuses of the atomic SRCU API that are missed are
those that appear only in CONFIG_SMP=n code.  And right now, there isn't
any such uses.  There might be in the future, but perhaps this is quite
unlikely.

							Thanx, Paul
