Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C49C43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 22:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24662080C
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 22:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgCaWUE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:20:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCaWUE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 18:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F5BFAEF9;
        Tue, 31 Mar 2020 22:20:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 01 Apr 2020 09:19:49 +1100
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free memory pattern
In-Reply-To: <20200331160117.GA170994@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org> <20200331145806.GB236678@google.com> <20200331153450.GM30449@dhcp22.suse.cz> <20200331160117.GA170994@google.com>
Message-ID: <877dz0yxoa.fsf@notabene.neil.brown.name>
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

> On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
>> On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
>> [...]
>> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> > > index 4be763355c9fb..965deefffdd58 100644
>> > > --- a/kernel/rcu/tree.c
>> > > +++ b/kernel/rcu/tree.c
>> > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head=
_to_object(void *obj)
>> > >=20=20
>> > >  	if (!ptr)
>> > >  		ptr =3D kmalloc(sizeof(unsigned long *) +
>> > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
>> > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
>> >=20
>> > Just to add, the main requirements here are:
>> > 1. Allocation should be bounded in time.
>> > 2. Allocation should try hard (possibly tapping into reserves)
>> > 3. Sleeping is Ok but should not affect the time bound.
>>=20
>>=20
>> __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
>> memory reserves regarless of the sleeping status.
>>=20
>> Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ the
>> memory. What does prevent the above code path to do that?
>
> Can you suggest what prevents other users of GFP_MEMALLOC from doing that
> also? That's the whole point of having a reserve, in normal usage no one =
will
> use it, but some times you need to use it. Keep in mind this is not a com=
mon
> case in this code here, this is triggered only if earlier allocation atte=
mpts
> failed. Only *then* we try with GFP_MEMALLOC with promises to free additi=
onal
> memory soon.

I think that "soon" is the key point.  Users of __GFP_MEMALLOC certainly
must be working to free other memory, that other memory needs to be freed
"soon".  In particular - sooner than all the reserve is exhausted.  This
can require rate-limiting.  If one allocation can result in one page
being freed, that is good and it is probably OK to have 1000 allocations
resulting in 1000 pages being freed soon.  But 10 million allocation to
gain 10 million pages is not such a good thing and shouldn't be needed.
Once those first 1000 pages have been freed, you won't need
__GFP_MEMALLOC allocations any more, and you must be prepare to wait for
them.

So where does the rate-limiting happen in your proposal?  A GP can be
multiple milliseconds, which is time for lots of memory to be allocated
and for rcu-free queues to grow quite large.

You mention a possible fall-back of calling synchronize_rcu().  I think
that needs to be a fallback that happens well before __GFP_MEMALLOC is
exhausted.   You need to choose some maximum amount that you will
allocate, then use synchronize_rcu() (or probably the _expedited
version) after that.  The pool of reserves are certainly there for you
to use, but not for you to exhaust.

If you have your own rate-limiting, then I think __GFP_MEMALLOC is
probably OK, and also you *don't* want the memalloc to wait.  If memory
cannot be allocated immediately, you need to use your own fallback.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6DwgUACgkQOeye3VZi
gbn8dw//VrVoUDhphrjEjsJyukpCM0UjwbId09tUpvlEYfWlx15r7Xx+z0+hJCtC
E0AI/g9iPmv1rln63hebTXYZcsXFygsZSY9a+YQaPxyPk01dnqGer7fOVQN8qYzK
Au4I0MxmeaH9/wTPzlzPUppNqOWhgYB9+Z9FJXxgLlzmgQaGkTzrvqEH43Fp/H9/
E2bgWXPKTwds03SpucOMDCrU+foZrA7pfT3RzNNjcbHI6/W118gbvawPlIAPhec1
6Cb9TS54XeiUP4gLixiummpdb5zK5MYH65HCL4CaHPI+2XOfMuSYQRIhshjOe3jx
i8e/+zZGT8ZCQwgjA7NCL8R/zaswheDgo1SFPbAcfLAcJ4nmeXXnHt2MIGin/MYv
sV36qdaXSDS/ldBspq/peBpCp3UF6Hma1n2lJdH+de5f7HHT2uu9MklgFiZupr2s
aeZOQ5hRRApU54HnKtexU2h8Txj1t+RK/LXxqOAa4gx0VRKD4Y0DZ7uUUA3cHbno
SnTXxHyBbVOlGEI0YozLoSLmzkm6d38DugOjbWnAUL6jr/mP2EvihaD4Nsu9f1fP
yc/iMtb67JhWvnBEFzFVGBkmIr3yBWNBzg1bbYbppXSrdusC2Fy5kzLE7e0puk5B
O604On3Np16ezCYNutPK6NZJDIAI4pFrraHl3NhzvfMMqkBQncY=
=pEbp
-----END PGP SIGNATURE-----
--=-=-=--
