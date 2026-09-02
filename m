Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EEC4AA41C;
	Wed,  2 Sep 2026 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367443; cv=none; b=RMbv+pybXvdMChink8TlATQmKsw1oqeOKba9vR8FC8LTA0TK2xbJoI2MDVCv16rrNxWUXb03MeWz/g/oCcMZ0zZkRtgiYyWFpa9cDrK5CjZ9XjAumLILJCGpCjZ5s0IQZRa1eZJPNIWFw8wpghxXRkV7k66UpoABB9diZ8VAVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367443; c=relaxed/simple;
	bh=FnLu3w0vREYMeMJ2PF+fMJdDA4wLr0tZEu3rmJB3xPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEZ5mGldQKlgUwCHC6nrcdJ2B8rgfG6Ho2t0yJ7IS+hOLgt2IHy0djVgBJrRRrU7Tq3pMshCeOmbYN3863HdsDfRh749NsKfi+LxRVS1B7MEH4Yc+gpXkrGQHZ8HZ67P3Swba0n1AIQb/in7hdEZwoKPz+Mmhz2Nx3GIS9qh3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLQi0d3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLQi0d3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF511F000E9;
	Wed,  2 Sep 2026 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367440;
	bh=1t420v38hYbR7vS1gyz4h4LCb/FqGYHzmQoobLtMtno=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DLQi0d3+X37Me//rRdJbCMcUB8gBj8LW3JtQRsX8BhFi7qX9ec7RuM6RQk2zs7Fir
	 XOrNwKANWtOYg3zPI457Ok32jXuEy4mFAqEsVhx4OWSKYIPgphvuag57zIRUBMMIms
	 pvUgaWqT/4cMZX4N8LytMx6vdGp2n6AIS3DCSyVDa065W6LiW3Cs34kcrK7pN9i/nu
	 4cCRYLVN0V6r1F6ZLlqrIU9k98DDJGLb8eE5DgVKDKnv2lQuF3q5eQlHxmwvMko5pP
	 mjR1TBzpYVcIVkuzYR3+SKyt6V0A9uIxZML/8zASzdQ9aFytk+SVRmpjDur1tQnK96
	 Uxeqt859rGL2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73FAACE112A; Wed,  2 Sep 2026 09:44:00 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:44:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Zqiang <qiang.zhang@linux.dev>, teigland@redhat.com,
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
Message-ID: <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
 <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
 <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 10:30:15AM -0400, Alexander Aring wrote:
> Hi,
> 
> On Wed, Sep 2, 2026 at 10:16 AM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > Hi,
> > >
> > > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > >
> > > >
> > > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > > >  srcu protected connection and node hash tables and hand each
> > > >  element to call_srcu() for deferred freeing (connection_release()
> > > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > > >  callbacks are invoked only after an SRCU grace period, which may
> > > >  happen after the exit function has already returned.
> > > >
> > > >  These exit functions are reached from exit_dlm() on module unload.
> > > >  Once they return, module teardown continues and the module text
> > > >  may be unloaded while call_srcu() callbacks are still pending. When
> > > >  such a callback finally runs, it executes freed module code and
> > > >  touches the static SRCU domains that are being torn down, resulting
> > > >  in a use-after-free.
> > > >
> > > I thought again about this and in my opinion this is not possible as
> > > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > > handling when the module is unloaded.
> >
> > When the moudle unload, the srcu_module_going() will call cleanup_srcu_struct()
> > and free_percpu(ssp->sda) to release resource. but we not call srcu_barrier(),
> > the srcu_barrier() should be called before cleanup_srcu_struct().
> >
> >
> > > I know that srcu subsystem does a lot of magic with modules init/exit
> > > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > > See
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/main.c?h=v7.3-rc1#n2711
> > >
> > > so this patch should be reverted. If they don't use a barrier there,
> > > the fix should be in the SRCU subsystem, but I believe the current
> > > SRCU implementation already handles this.
> >
> > The srcu_barrier() need to be called, there are some description
> > from Documentation/RCU/rcubarrier.rst:
> >
> > rcu_barrier()
> > -------------
> >
> > This situation can be handled by the rcu_barrier() primitive.  Rather
> > than waiting for a grace period to elapse, rcu_barrier() waits for all
> > outstanding RCU callbacks to complete.  Please note that rcu_barrier()
> > does **not** imply synchronize_rcu(), in particular, if there are no RCU
> > callbacks queued anywhere, rcu_barrier() is within its rights to return
> > immediately, without waiting for anything, let alone a grace period.
> >
> > Pseudo-code using rcu_barrier() is as follows:
> >
> >    1. Prevent any new RCU callbacks from being posted.
> >    2. Execute rcu_barrier().
> >    3. Allow the module to be unloaded.
> >
> > There is also an srcu_barrier() function for SRCU, and you of course
> > must match the flavor of srcu_barrier() with that of call_srcu().
> > If your module uses multiple srcu_struct structures, then it must also
> > use multiple invocations of srcu_barrier() when unloading that module.
> > For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> > call_srcu() on srcu_struct_2, then the following three lines of code
> > will be required when unloading::
> >
> >   1  rcu_barrier();
> >   2  srcu_barrier(&srcu_struct_1);
> >   3  srcu_barrier(&srcu_struct_2);
> > ....
> 
> yes, I can see this makes problems when there is kmem_cache involved
> and you need to be sure it's being done before you destroy the
> kmem_cache.
> 
> This is not the case here.
> 
> I looked more into srcu functionality "cleanup_srcu_struct()"
> (srcutiny) and it does "flush_work(&ssp->srcu_work)", workfn is
> "srcu_drive_gp()" and the comment states "Workqueue handler to drive
> one grace period and invoke any callbacks that become ready as a
> result."
> 
> In my opinion "cleanup_srcu_struct()" should be sure there are no
> pending operations.

If the user never passed this srcu_struct structure to call_srcu(),
then there would be nothing to clean up.  Now, maybe all SRCU use cases
are OK with the extra srcu_barrier() overhead at cleanup_srcu_struct()
time, but as far as I know, that is still a "maybe".

And of course, cleanup_srcu_struct() has no ability to prevent the
user from doing a (buggy!) concurrent call to synchronize_srcu() or
call_srcu(), which would defeat any attempt by cleanup_srcu_struct()
to do this pending-operation cleanup.

Or am I missing your point?

							Thanx, Paul
