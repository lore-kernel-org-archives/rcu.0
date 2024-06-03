Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937DF12EBCA;
	Mon,  3 Jun 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434747; cv=none; b=Sbfh71l1FnJRVWAbfftisAMqU/IwmX5j2Eh6rXqNETh4+tmKj0AfmBfqJmzPZKDt4xbwuEeRWOTQjsU6NtKys9JOqRSFyhL3USBz72yxWK4nz0GJKk8Xa3+PVhrS7y/e4CBebU9u28E0qkSK6IFSVZy7tu/IjWBef/HgEPTIrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434747; c=relaxed/simple;
	bh=xGBnNUWH9srg7zslSJ4u3LNZM6ut5igRLi7ZpFcBOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0AqoYyPphpDbNkzhUXrG+cQsuI+YEUubhsnxh1PFWC2MAS7Yq71tAeLoPJkxzWj6b+wAJmgpBStb3WyZflM3IVBKveg1V09mbQ8Rn+d/dtqChrr/LH24xsatbs26IA0iy9eJeHrpYKcDpq0t40kRSG6XzLPlI3JsIcbtPOdh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVO+OWWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVO+OWWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC3C2BD10;
	Mon,  3 Jun 2024 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717434747;
	bh=xGBnNUWH9srg7zslSJ4u3LNZM6ut5igRLi7ZpFcBOdQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WVO+OWWAePkyeNvAfYUV9ZkELsUY9hTIcLfeX6XjL51dYoG7c1aL8oS6sfsLtbm3+
	 GxGu391wrK8JmYNorxgVD1ZNTqHipO9CuDk+dXZD/3x4dgWdI7n4kFU3chYb9ony06
	 TOEkbq2M592PCX/tC/Z26WKdwHRgxBpvRKxdNFhD3IWtcrMxn/Uvv/sBOSFzr3u/j6
	 Jch6+gPZz8CdkzrhuY8YDh0XTKo9amaSM96RhVCzjbEPorRuPyCGiZWWnCW5c8F6lb
	 GrV4cF4vVo8g758FpKfyZR6JQLS21kUDtsJAfjCSWWdtuhbtC5kvKKmUhvCrbHzdVi
	 +KDbmWbnnsn3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B98A3CE3B76; Mon,  3 Jun 2024 10:12:26 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:12:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops
 without ->debug_objects set
Message-ID: <4a6d1e70-ec91-4b6d-8f69-290c4ef57b7f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
 <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop>
 <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
 <CALm+0cUQuZDb6nrng+CnOXNGyy6gUWNGq9VoreU98KNkyTw_CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUQuZDb6nrng+CnOXNGyy6gUWNGq9VoreU98KNkyTw_CQ@mail.gmail.com>

On Mon, Jun 03, 2024 at 12:55:30PM +0800, Z qiang wrote:
> >
> > >
> > > On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> > > > This commit make rcu_test_debug_objects() early return when the
> > > > specified cur_ops not set the ->debug_objects.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/rcutorture.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index 08bf7c669dd3..9b8c277ab91a 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
> > > >               return;
> > > >       }
> > > >
> > > > -     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > > > -                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > > > +     if (!cur_ops->debug_objects ||
> > > > +                     WARN_ON_ONCE(cur_ops->debug_objects &&
> > >
> > > You lost me here.  Given that we have "!cur_ops->debug_objects" before
> > > that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?
> > >
> > > Also, we don't get here unless the rcutorture.object_debug kernel boot
> > > parameter is specified, don't we really want to WARN_ON_ONCE if the
> > > current flavor does not support that?
> 
> Maybe I didn't describe it clearly enough, this
> modification is mainly to filter out test types that do not support
> double call_rcu*() checking, for example tasks, tasks-rudes,
>  task-tracing  ;) .

Understood.

It is just that in my experience, it is a good thing for rcutorture to
splat when asked to do something that it cannot do.  Or do you have a
use case where this is problematic?

I don't count the fuzzers because they are supposed to avoid specifying
things that are supposed to fail.  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> > Hi, Paul
> >
> > The rcutorture.object_debug is set true, but the tasks-tracing does not support
> > duplicate cur_ops->call check, but the debug_objects test was still done.
> >
> > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > n_barrier_cbs=4 object_debug=1
> >
> > [  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> > [  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
> > [  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
> > [  106.105552] rcutorture: duplicated callback was invoked.
> > [  106.105567] rcutorture: duplicated callback was invoked.
> > [  106.111269] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
> >
> > Thanks
> > Zqiang
> >
> > >
> > > Or do you have a use case that needs to silence these warnings?
> > >
> > >                                                         Thanx, Paul
> > >
> > > > +                             (!cur_ops->call || !cur_ops->cb_barrier)))
> > > >               return;
> > > >
> > > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > > > --
> > > > 2.17.1
> > > >
