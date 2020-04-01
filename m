Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934CCC2D0F3
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 04:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652CF2078B
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 04:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDAEwm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:52:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDAEwl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 00:52:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 649B6AEEA;
        Wed,  1 Apr 2020 04:52:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 01 Apr 2020 15:52:25 +1100
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free memory pattern
In-Reply-To: <20200401032555.GA175966@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org> <20200331145806.GB236678@google.com> <20200331153450.GM30449@dhcp22.suse.cz> <20200331160117.GA170994@google.com> <877dz0yxoa.fsf@notabene.neil.brown.name> <20200401032555.GA175966@google.com>
Message-ID: <874ku3zu2e.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31 2020, Joel Fernandes wrote:

> On Wed, Apr 01, 2020 at 09:19:49AM +1100, NeilBrown wrote:
>> On Tue, Mar 31 2020, Joel Fernandes wrote:
>>=20
>> > On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
>> >> On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
>> >> [...]
>> >> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> >> > > index 4be763355c9fb..965deefffdd58 100644
>> >> > > --- a/kernel/rcu/tree.c
>> >> > > +++ b/kernel/rcu/tree.c
>> >> > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_h=
ead_to_object(void *obj)
>> >> > >=20=20
>> >> > >  	if (!ptr)
>> >> > >  		ptr =3D kmalloc(sizeof(unsigned long *) +
>> >> > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
>> >> > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
>> >> >=20
>> >> > Just to add, the main requirements here are:
>> >> > 1. Allocation should be bounded in time.
>> >> > 2. Allocation should try hard (possibly tapping into reserves)
>> >> > 3. Sleeping is Ok but should not affect the time bound.
>> >>=20
>> >>=20
>> >> __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
>> >> memory reserves regarless of the sleeping status.
>> >>=20
>> >> Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ =
the
>> >> memory. What does prevent the above code path to do that?
>> >
>> > Can you suggest what prevents other users of GFP_MEMALLOC from doing t=
hat
>> > also? That's the whole point of having a reserve, in normal usage no o=
ne will
>> > use it, but some times you need to use it. Keep in mind this is not a =
common
>> > case in this code here, this is triggered only if earlier allocation a=
ttempts
>> > failed. Only *then* we try with GFP_MEMALLOC with promises to free add=
itional
>> > memory soon.
>>=20
>> I think that "soon" is the key point.  Users of __GFP_MEMALLOC certainly
>> must be working to free other memory, that other memory needs to be freed
>> "soon".  In particular - sooner than all the reserve is exhausted.  This
>> can require rate-limiting.  If one allocation can result in one page
>> being freed, that is good and it is probably OK to have 1000 allocations
>> resulting in 1000 pages being freed soon.  But 10 million allocation to
>> gain 10 million pages is not such a good thing and shouldn't be needed.
>> Once those first 1000 pages have been freed, you won't need
>> __GFP_MEMALLOC allocations any more, and you must be prepare to wait for
>> them.
>>=20
>> So where does the rate-limiting happen in your proposal?  A GP can be
>> multiple milliseconds, which is time for lots of memory to be allocated
>> and for rcu-free queues to grow quite large.
>>=20
>> You mention a possible fall-back of calling synchronize_rcu().  I think
>> that needs to be a fallback that happens well before __GFP_MEMALLOC is
>> exhausted.   You need to choose some maximum amount that you will
>> allocate, then use synchronize_rcu() (or probably the _expedited
>> version) after that.  The pool of reserves are certainly there for you
>> to use, but not for you to exhaust.
>>=20
>> If you have your own rate-limiting, then I think __GFP_MEMALLOC is
>> probably OK, and also you *don't* want the memalloc to wait.  If memory
>> cannot be allocated immediately, you need to use your own fallback.
>
> Thanks a lot for explaining in detail, the RFC patch has served its purpo=
se
> well ;-)
>
> On discussing with RCU comrades, we agreed to not use GFP_MEMALLOC. But
> instead pre-allocate a cache (we do have a cache but it is not yet
> pre-allocated, just allocated on demand).
>
> About the rate limiting, we would fallback to synchronize_rcu() instead of
> sleeping in case of trobule. However I would like to add a warning if we =
ever
> hit the troublesome path mainly because that means we depleted the
> pre-allocated cache and perhaps the user should switch to adding an rcu_h=
ead
> in their structure to reduce latency. I'm adding that warning to my tree:

If this warning is only interesting to developers, I think you should
only show it to developers, not to end-users. i.e. protect it with
CONFIG_DEBUG_RCU or something like that.

NeilBrown


>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4be763355c9fb..6172e6296dd7d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -110,6 +110,10 @@ module_param(rcu_fanout_exact, bool, 0444);
>  static int rcu_fanout_leaf =3D RCU_FANOUT_LEAF;
>  module_param(rcu_fanout_leaf, int, 0444);
>  int rcu_num_lvls __read_mostly =3D RCU_NUM_LVLS;
> +/* Silence the kvfree_rcu() complaint (warning) that it blocks */
> +int rcu_kfree_nowarn;
> +module_param(rcu_kfree_nowarn, int, 0444);
> +
>  /* Number of rcu_nodes at specified level. */
>  int num_rcu_lvl[] =3D NUM_RCU_LVL_INIT;
>  int rcu_num_nodes __read_mostly =3D NUM_RCU_NODES; /* Total # rcu_nodes =
in use. */
> @@ -3266,6 +3270,12 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_ca=
llback_t func)
>  	 * state.
>  	 */
>  	if (!success) {
> +		/*
> +		 * Please embed an rcu_head and pass it along if you hit this
> +		 * warning. Doing so would avoid long kfree_rcu() latencies.
> +		 */
> +		if (!rcu_kfree_nowarn)
> +			WARN_ON_ONCE(1);
>  		debug_rcu_head_unqueue(ptr);
>  		synchronize_rcu();
>  		kvfree(ptr);

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6EHgoACgkQOeye3VZi
gbkm2w//fdZ+L31EJT6f/eM53SBbDzDAxkF0FocZ0ScJk4OLbo6kvFWVE8YToX0N
dDoKJMy7QALVFa+sLy1LSuy7h2MxSHUvRiGXVeDnzJXDjQiz4KWD4F1JzVacaICD
5cIQd8KaDNQjC92wWKHFnhtCoTSY/KAb45J96jdst+rWvRsSyRx8chXPs/Oljg+e
15W9ph8o346FvaY0q4AuA6feK2F/OxENv5+b89Y9kWd+UlTpLQWMj0nRkygK7igM
IgA/FvcqT0KOtkc3o8lTSKcci0eTbI+tNLNbwNanwyQ0tYKJCCdXfTGa8cWb9lhl
AOB3sxIkZbQl16MtH1WzCBZL1B4tDfjan8YxWCvi2lX5iaBQz/zUKQr/bth0hf93
Z/0dQNnMjjonICewh7xzjaezlkgu7GSfnOFiXQpHIhCA1qgFLGrmq/SMlnSi4XCV
l2zdWUmvAIJBQtCmT05jCBqbUWobvJm7otMuBv9hygxRGOWC+fkEUnvLEAZSdv2K
srbNgwsS09D3qL+KZ9loOgFzn9glJqOb4d2paEwn/4Z2G3MjqoM6yzkcJvYrKUBg
KHbnYHhLtVrRzvb8vE0WS3Y55MmGDhMHOjbWcWewiPGdIGUGSKeVx38TmukZ+DmY
vkUIIAD6txSrh+0pwG2+ElNvH4Q6mZmuMgteFq7dhuJdyk3dcUQ=
=JV7+
-----END PGP SIGNATURE-----
--=-=-=--
