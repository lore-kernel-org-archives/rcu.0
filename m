Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75823BE14A;
	Wed,  2 Sep 2026 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379512; cv=none; b=Mv/A9zHAQ1aq2kRPqfNP8nkwGsFFQDzvIInNac9Gly53oOlOZkH1PE0b8dvYwVp8Z3glaZfiV6jntyp4lJmfIeSQhpga7oGheoB3HeMWrTi2xybvhnr2p0C9CJJfuWWmefTO/dhVytXwARjpfaXiGBPFoT1hjTWSv4QOqk/ItZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379512; c=relaxed/simple;
	bh=xOLweDAUhJHb3uPDxOkfYsZlsvsQu1qeHz/xG91XUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2rChh+ke4PPaX1QpviW1d6Ceitf+rjodOoXLR/twra213i/Ep286PawvOf3ddkkiiWDFHFJdhvJMM0ehJCbREoYrsfeGo5m9eH5dMnG4xG30rgk33wPZWHUpKgt18pf+EGBr5KUr9ar+raYE345mj2L6n49TErwYEnApwrxhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjvq5yqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjvq5yqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0D41F000E9;
	Wed,  2 Sep 2026 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379510;
	bh=RmeS5xzPDulYCFy6SsF+FcbwbGwjF176hm4pIlzlWs8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gjvq5yqsDHPPbYrD/yzuk1lZhm+77Kpokgr41N1g5mo8QL2bkK/fXDvOcHLJOB2ep
	 0fgvJvoudmOrYQRDCgZhAP6DhDdowHOr5EZt71Yb1+89jNQnSo3AlAG8dU044qMw08
	 NVz+XPX8cSDW4Sk2qReMzcciZ0snnYYjERXIKIZVJI+txhWd3ACMukc5bdj+4Y+V2S
	 CgS1WhjielBVJXJ6jCjJWora+A/4b2WsNzPrjkKRX3GL7z28k2JF44hH+ipu85kaUA
	 uKyAg3nH5yaq17FuxZTApyUMp6+OwARdED8vWDbkB0u0jvLjO/Q1HnyeibvShrBZVt
	 trfZM6RlD4uhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03CD5CE114B; Wed,  2 Sep 2026 13:05:10 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:05:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: Zqiang <qiang.zhang@linux.dev>, teigland@redhat.com,
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
Message-ID: <13011d40-6580-4e19-af0a-739f7cdad115@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
 <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
 <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
 <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
 <CAK-6q+geOEoHBAJdJ3ZdYF3WSLP9bbsY=6uxiJOY8a=qgiHZmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+geOEoHBAJdJ3ZdYF3WSLP9bbsY=6uxiJOY8a=qgiHZmQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 01:13:50PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Wed, Sep 2, 2026 at 12:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 02, 2026 at 10:30:15AM -0400, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Wed, Sep 2, 2026 at 10:16 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > > > >
> > > > > >
> > > > > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > > > > >  srcu protected connection and node hash tables and hand each
> > > > > >  element to call_srcu() for deferred freeing (connection_release()
> > > > > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > > > > >  callbacks are invoked only after an SRCU grace period, which may
> > > > > >  happen after the exit function has already returned.
> > > > > >
> > > > > >  These exit functions are reached from exit_dlm() on module unload.
> > > > > >  Once they return, module teardown continues and the module text
> > > > > >  may be unloaded while call_srcu() callbacks are still pending. When
> > > > > >  such a callback finally runs, it executes freed module code and
> > > > > >  touches the static SRCU domains that are being torn down, resulting
> > > > > >  in a use-after-free.
> > > > > >
> > > > > I thought again about this and in my opinion this is not possible as
> > > > > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > > > > handling when the module is unloaded.
> > > >
> > > > When the moudle unload, the srcu_module_going() will call cleanup_srcu_struct()
> > > > and free_percpu(ssp->sda) to release resource. but we not call srcu_barrier(),
> > > > the srcu_barrier() should be called before cleanup_srcu_struct().
> > > >
> > > >
> > > > > I know that srcu subsystem does a lot of magic with modules init/exit
> > > > > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > > > > See
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/main.c?h=v7.3-rc1#n2711
> > > > >
> > > > > so this patch should be reverted. If they don't use a barrier there,
> > > > > the fix should be in the SRCU subsystem, but I believe the current
> > > > > SRCU implementation already handles this.
> > > >
> > > > The srcu_barrier() need to be called, there are some description
> > > > from Documentation/RCU/rcubarrier.rst:
> > > >
> > > > rcu_barrier()
> > > > -------------
> > > >
> > > > This situation can be handled by the rcu_barrier() primitive.  Rather
> > > > than waiting for a grace period to elapse, rcu_barrier() waits for all
> > > > outstanding RCU callbacks to complete.  Please note that rcu_barrier()
> > > > does **not** imply synchronize_rcu(), in particular, if there are no RCU
> > > > callbacks queued anywhere, rcu_barrier() is within its rights to return
> > > > immediately, without waiting for anything, let alone a grace period.
> > > >
> > > > Pseudo-code using rcu_barrier() is as follows:
> > > >
> > > >    1. Prevent any new RCU callbacks from being posted.
> > > >    2. Execute rcu_barrier().
> > > >    3. Allow the module to be unloaded.
> > > >
> > > > There is also an srcu_barrier() function for SRCU, and you of course
> > > > must match the flavor of srcu_barrier() with that of call_srcu().
> > > > If your module uses multiple srcu_struct structures, then it must also
> > > > use multiple invocations of srcu_barrier() when unloading that module.
> > > > For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> > > > call_srcu() on srcu_struct_2, then the following three lines of code
> > > > will be required when unloading::
> > > >
> > > >   1  rcu_barrier();
> > > >   2  srcu_barrier(&srcu_struct_1);
> > > >   3  srcu_barrier(&srcu_struct_2);
> > > > ....
> > >
> > > yes, I can see this makes problems when there is kmem_cache involved
> > > and you need to be sure it's being done before you destroy the
> > > kmem_cache.
> > >
> > > This is not the case here.
> > >
> > > I looked more into srcu functionality "cleanup_srcu_struct()"
> > > (srcutiny) and it does "flush_work(&ssp->srcu_work)", workfn is
> > > "srcu_drive_gp()" and the comment states "Workqueue handler to drive
> > > one grace period and invoke any callbacks that become ready as a
> > > result."
> > >
> > > In my opinion "cleanup_srcu_struct()" should be sure there are no
> > > pending operations.
> >
> > If the user never passed this srcu_struct structure to call_srcu(),
> > then there would be nothing to clean up.  Now, maybe all SRCU use cases
> > are OK with the extra srcu_barrier() overhead at cleanup_srcu_struct()
> > time, but as far as I know, that is still a "maybe".
> >
> 
> Okay, I agree with the "maybe" argument, then maybe we add a comment
> to "cleanup_srcu_struct()" that there must be a "srcu_barrier()"
> called before. Except "call_srcu()" is never being used.
> 
> > And of course, cleanup_srcu_struct() has no ability to prevent the
> > user from doing a (buggy!) concurrent call to synchronize_srcu() or
> > call_srcu(), which would defeat any attempt by cleanup_srcu_struct()
> > to do this pending-operation cleanup.
> >
> > Or am I missing your point?
> 
> I use "DEFINE_STATIC_SRCU()" that does the srcu cleanup for me and I
> was confused I need to care about "srcu_barrier()" before module exit.
> Then "DEFINE_STATIC_SRCU()" needs a comment as well to call
> "srcu_barrier()" before module exit functionality as my initial
> thought would be it would do that for me as I am even not a caller of
> "cleanup_srcu_struct()".
> 
> All of this, of course, should happen in a safe context. Wheras for
> "DEFINE_STATIC_SRCU()" I would assume after users module exit function
> there is nothing going on anymore.

Fair point!  How about this?

Now I am wondering if the various DEFINE_SRCU() macros need kernel-doc
headers...

							Thanx, Paul

------------------------------------------------------------------------

commit 2a20fcf8bd8ffffd0e7cdd0adf80e41d1efdfc2b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Sep 2 12:58:24 2026 -0700

    srcutree: Explicitly note DEFINE_SRCU() needs for srcu_barrier()
    
    In the core kernel, an srcu_struct structure created by DEFINE_SRCU()
    or friends lives as long as the kernel does, so there are no particular
    requirements surrounding the end of that structure's life.  In contrast,
    when DEFINE_SRCU() and friends are used within a module, the corresponding
    srcu_struct structures' lifetimes end when that module exits.  This in
    turn means that if such a structure was passed to call_srcu(), then
    srcu_barrier() must be invoked after the last call_srcu() invocation
    but before the module exits.
    
    This commit therefore adds a comment stating this.
    
    Reported-by: Alexander Aring <aahringo@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ad9d9658b0a2f5..93b76e54389432 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -214,6 +214,12 @@ struct srcu_struct {
  * instead of smp_mb(), and given that the first (for example)
  * srcu_read_lock_fast() might race with the first synchronize_srcu(),
  * this different must be specified at initialization time.
+ *
+ * If you use any of the DEFINE_SRCU() functions within a module, the
+ * module-entry code will invoke init_srcu_struct() and the module-exit
+ * code will invoke cleanup_srcu_struct().  This means that if your module
+ * passes the resulting srcu_struct structure to call_srcu(), you will
+ * need to also pass this structure to srcu_barrier() prior to module exit.
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, fast, is_static)							\
