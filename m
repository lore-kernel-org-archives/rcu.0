Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED6C2D0A3
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692B21D46
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604939099;
	bh=xNipoQ4z8uuPvlrywbWTIgXRwXBraQjwYV4ZbO4m/uc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bkfQjju1o3YGVRdlDSV4BTDKkEBoXHH9Wkogn7lZVkoDY9Sto/9OOxaopDb4gW1+7
	 tsBdvB/VjFsjGOmwvkfWxON56ZjecJ7rHJGT1L0aXIfX8gN96bas5HQzZzkPt51xcw
	 mvIGxs2/03XQ8iWU+ZDJ7GiLNzy1GdZfSoNtuECw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgKIQY6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgKIQY5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Nov 2020 11:24:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891FA221FB;
        Mon,  9 Nov 2020 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604939092;
        bh=xNipoQ4z8uuPvlrywbWTIgXRwXBraQjwYV4ZbO4m/uc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZYvDZRla620SGpQRozF7R4yCxi2xBDXuiWW6rUhqX/Jz5PSJRrBuH6euMFSeuwLcd
         fl7SWnhFZ45Bf64+GEcKrYOCknbImHJIwaqAHzIN08xHKJ36ahiCT0bjFZ1k0A7Bf+
         W5GV8KHtqR2/1m1tJMEyQrR1iVaYkwEy7Izltg9o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2C6E8352264D; Mon,  9 Nov 2020 08:24:52 -0800 (PST)
Date:   Mon, 9 Nov 2020 08:24:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements
 with a bit about design
Message-ID: <20201109162452.GK3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-2-paulmck@kernel.org>
 <20201109122317.GM2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109122317.GM2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 09, 2020 at 01:23:17PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 05, 2020 at 03:05:08PM -0800, paulmck@kernel.org wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > The rcu_barrier() section of the "Hotplug CPU" section discusses
> > deadlocks, however the description of deadlocks other than those involving
> > rcu_barrier() is rather incomplete.
> > 
> > This commit therefore continues the section by describing how RCU's
> > design handles CPU hotplug in a deadlock-free way.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 1ae79a1..98557fe 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> >  to allow the various kernel subsystems (including RCU) to respond
> >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> >  be invoked from CPU-hotplug notifiers, including even synchronous
> > -grace-period operations such as ``synchronize_rcu()`` and
> > -``synchronize_rcu_expedited()``.
> 
> I was under the impression that this rst crap now recognises func() and
> you no longer need to make the text unreadable with "``".

It was there to start with, but good point.  How about the commit
below?

						Thanx, Paul

------------------------------------------------------------------------

commit 5cec02881428f10c4a1632c3aebb666b12888958
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Nov 9 08:22:16 2020 -0800

    docs: Remove redundant "``" from Requirements.rst
    
    The docbook system has learned that "()" designates a function, so
    this commit removes the no-longer-needed "``" to improve readability
    of the raw .rst file.
    
    Reported-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index e8c84fc..cedc2e9 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -72,11 +72,11 @@ understanding of this guarantee.
 
 RCU's grace-period guarantee allows updaters to wait for the completion
 of all pre-existing RCU read-side critical sections. An RCU read-side
-critical section begins with the marker ``rcu_read_lock()`` and ends
-with the marker ``rcu_read_unlock()``. These markers may be nested, and
+critical section begins with the marker rcu_read_lock() and ends
+with the marker rcu_read_unlock(). These markers may be nested, and
 RCU treats a nested set as one big RCU read-side critical section.
-Production-quality implementations of ``rcu_read_lock()`` and
-``rcu_read_unlock()`` are extremely lightweight, and in fact have
+Production-quality implementations of rcu_read_lock() and
+rcu_read_unlock() are extremely lightweight, and in fact have
 exactly zero overhead in Linux kernels built for production use with
 ``CONFIG_PREEMPT=n``.
 
@@ -102,12 +102,12 @@ overhead to readers, for example:
       15   WRITE_ONCE(y, 1);
       16 }
 
-Because the ``synchronize_rcu()`` on line 14 waits for all pre-existing
-readers, any instance of ``thread0()`` that loads a value of zero from
-``x`` must complete before ``thread1()`` stores to ``y``, so that
+Because the synchronize_rcu() on line 14 waits for all pre-existing
+readers, any instance of thread0() that loads a value of zero from
+``x`` must complete before thread1() stores to ``y``, so that
 instance must also load a value of zero from ``y``. Similarly, any
-instance of ``thread0()`` that loads a value of one from ``y`` must have
-started after the ``synchronize_rcu()`` started, and must therefore also
+instance of thread0() that loads a value of one from ``y`` must have
+started after the synchronize_rcu() started, and must therefore also
 load a value of one from ``x``. Therefore, the outcome:
 
    ::
@@ -121,14 +121,14 @@ cannot happen.
 +-----------------------------------------------------------------------+
 | Wait a minute! You said that updaters can make useful forward         |
 | progress concurrently with readers, but pre-existing readers will     |
-| block ``synchronize_rcu()``!!!                                        |
+| block synchronize_rcu()!!!                                        |
 | Just who are you trying to fool???                                    |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
 | First, if updaters do not wish to be blocked by readers, they can use |
-| ``call_rcu()`` or ``kfree_rcu()``, which will be discussed later.     |
-| Second, even when using ``synchronize_rcu()``, the other update-side  |
+| call_rcu() or kfree_rcu(), which will be discussed later.     |
+| Second, even when using synchronize_rcu(), the other update-side  |
 | code does run concurrently with readers, whether pre-existing or not. |
 +-----------------------------------------------------------------------+
 
@@ -170,34 +170,34 @@ recovery from node failure, more or less as follows:
       29   WRITE_ONCE(state, STATE_NORMAL);
       30 }
 
-The RCU read-side critical section in ``do_something_dlm()`` works with
-the ``synchronize_rcu()`` in ``start_recovery()`` to guarantee that
-``do_something()`` never runs concurrently with ``recovery()``, but with
-little or no synchronization overhead in ``do_something_dlm()``.
+The RCU read-side critical section in do_something_dlm() works with
+the synchronize_rcu() in start_recovery() to guarantee that
+do_something() never runs concurrently with recovery(), but with
+little or no synchronization overhead in do_something_dlm().
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why is the ``synchronize_rcu()`` on line 28 needed?                   |
+| Why is the synchronize_rcu() on line 28 needed?                   |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
 | Without that extra grace period, memory reordering could result in    |
-| ``do_something_dlm()`` executing ``do_something()`` concurrently with |
-| the last bits of ``recovery()``.                                      |
+| do_something_dlm() executing do_something() concurrently with |
+| the last bits of recovery().                                      |
 +-----------------------------------------------------------------------+
 
 In order to avoid fatal problems such as deadlocks, an RCU read-side
-critical section must not contain calls to ``synchronize_rcu()``.
+critical section must not contain calls to synchronize_rcu().
 Similarly, an RCU read-side critical section must not contain anything
 that waits, directly or indirectly, on completion of an invocation of
-``synchronize_rcu()``.
+synchronize_rcu().
 
 Although RCU's grace-period guarantee is useful in and of itself, with
 `quite a few use cases <https://lwn.net/Articles/573497/>`__, it would
 be good to be able to use RCU to coordinate read-side access to linked
 data structures. For this, the grace-period guarantee is not sufficient,
-as can be seen in function ``add_gp_buggy()`` below. We will look at the
+as can be seen in function add_gp_buggy() below. We will look at the
 reader's code later, but in the meantime, just think of the reader as
 locklessly picking up the ``gp`` pointer, and, if the value loaded is
 non-\ ``NULL``, locklessly accessing the ``->a`` and ``->b`` fields.
@@ -256,8 +256,8 @@ Publish/Subscribe Guarantee
 
 RCU's publish-subscribe guarantee allows data to be inserted into a
 linked data structure without disrupting RCU readers. The updater uses
-``rcu_assign_pointer()`` to insert the new data, and readers use
-``rcu_dereference()`` to access data, whether new or old. The following
+rcu_assign_pointer() to insert the new data, and readers use
+rcu_dereference() to access data, whether new or old. The following
 shows an example of insertion:
 
    ::
@@ -279,7 +279,7 @@ shows an example of insertion:
       15   return true;
       16 }
 
-The ``rcu_assign_pointer()`` on line 13 is conceptually equivalent to a
+The rcu_assign_pointer() on line 13 is conceptually equivalent to a
 simple assignment statement, but also guarantees that its assignment
 will happen after the two assignments in lines 11 and 12, similar to the
 C11 ``memory_order_release`` store operation. It also prevents any
@@ -289,7 +289,7 @@ number of “interesting” compiler optimizations, for example, the use of
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| But ``rcu_assign_pointer()`` does nothing to prevent the two          |
+| But rcu_assign_pointer() does nothing to prevent the two          |
 | assignments to ``p->a`` and ``p->b`` from being reordered. Can't that |
 | also cause problems?                                                  |
 +-----------------------------------------------------------------------+
@@ -303,7 +303,7 @@ number of “interesting” compiler optimizations, for example, the use of
 
 It is tempting to assume that the reader need not do anything special to
 control its accesses to the RCU-protected data, as shown in
-``do_something_gp_buggy()`` below:
+do_something_gp_buggy() below:
 
    ::
 
@@ -345,7 +345,7 @@ If this function ran concurrently with a series of updates that replaced
 the current structure with a new one, the fetches of ``gp->a`` and
 ``gp->b`` might well come from two different structures, which could
 cause serious confusion. To prevent this (and much else besides),
-``do_something_gp()`` uses ``rcu_dereference()`` to fetch from ``gp``:
+do_something_gp() uses rcu_dereference() to fetch from ``gp``:
 
    ::
 
@@ -362,21 +362,21 @@ cause serious confusion. To prevent this (and much else besides),
       11   return false;
       12 }
 
-The ``rcu_dereference()`` uses volatile casts and (for DEC Alpha) memory
+The rcu_dereference() uses volatile casts and (for DEC Alpha) memory
 barriers in the Linux kernel. Should a `high-quality implementation of
 C11 ``memory_order_consume``
 [PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
-ever appear, then ``rcu_dereference()`` could be implemented as a
+ever appear, then rcu_dereference() could be implemented as a
 ``memory_order_consume`` load. Regardless of the exact implementation, a
-pointer fetched by ``rcu_dereference()`` may not be used outside of the
+pointer fetched by rcu_dereference() may not be used outside of the
 outermost RCU read-side critical section containing that
-``rcu_dereference()``, unless protection of the corresponding data
+rcu_dereference(), unless protection of the corresponding data
 element has been passed from RCU to some other synchronization
 mechanism, most commonly locking or `reference
 counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
 
-In short, updaters use ``rcu_assign_pointer()`` and readers use
-``rcu_dereference()``, and these two RCU API elements work together to
+In short, updaters use rcu_assign_pointer() and readers use
+rcu_dereference(), and these two RCU API elements work together to
 ensure that readers have a consistent view of newly added data elements.
 
 Of course, it is also necessary to remove elements from RCU-protected
@@ -388,9 +388,9 @@ data structures, for example, using the following process:
    the newly removed data element).
 #. At this point, only the updater has a reference to the newly removed
    data element, so it can safely reclaim the data element, for example,
-   by passing it to ``kfree()``.
+   by passing it to kfree().
 
-This process is implemented by ``remove_gp_synchronous()``:
+This process is implemented by remove_gp_synchronous():
 
    ::
 
@@ -413,16 +413,16 @@ This process is implemented by ``remove_gp_synchronous()``:
 
 This function is straightforward, with line 13 waiting for a grace
 period before line 14 frees the old data element. This waiting ensures
-that readers will reach line 7 of ``do_something_gp()`` before the data
-element referenced by ``p`` is freed. The ``rcu_access_pointer()`` on
-line 6 is similar to ``rcu_dereference()``, except that:
+that readers will reach line 7 of do_something_gp() before the data
+element referenced by ``p`` is freed. The rcu_access_pointer() on
+line 6 is similar to rcu_dereference(), except that:
 
-#. The value returned by ``rcu_access_pointer()`` cannot be
+#. The value returned by rcu_access_pointer() cannot be
    dereferenced. If you want to access the value pointed to as well as
-   the pointer itself, use ``rcu_dereference()`` instead of
-   ``rcu_access_pointer()``.
-#. The call to ``rcu_access_pointer()`` need not be protected. In
-   contrast, ``rcu_dereference()`` must either be within an RCU
+   the pointer itself, use rcu_dereference() instead of
+   rcu_access_pointer().
+#. The call to rcu_access_pointer() need not be protected. In
+   contrast, rcu_dereference() must either be within an RCU
    read-side critical section or in a code segment where the pointer
    cannot change, for example, in code protected by the corresponding
    update-side lock.
@@ -430,13 +430,13 @@ line 6 is similar to ``rcu_dereference()``, except that:
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Without the ``rcu_dereference()`` or the ``rcu_access_pointer()``,    |
+| Without the rcu_dereference() or the rcu_access_pointer(),    |
 | what destructive optimizations might the compiler make use of?        |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| Let's start with what happens to ``do_something_gp()`` if it fails to |
-| use ``rcu_dereference()``. It could reuse a value formerly fetched    |
+| Let's start with what happens to do_something_gp() if it fails to |
+| use rcu_dereference(). It could reuse a value formerly fetched    |
 | from this same pointer. It could also fetch the pointer from ``gp``   |
 | in a byte-at-a-time manner, resulting in *load tearing*, in turn      |
 | resulting a bytewise mash-up of two distinct pointer values. It might |
@@ -445,15 +445,15 @@ line 6 is similar to ``rcu_dereference()``, except that:
 | update has changed the pointer to match the wrong guess. Too bad      |
 | about any dereferences that returned pre-initialization garbage in    |
 | the meantime!                                                         |
-| For ``remove_gp_synchronous()``, as long as all modifications to      |
+| For remove_gp_synchronous(), as long as all modifications to      |
 | ``gp`` are carried out while holding ``gp_lock``, the above           |
 | optimizations are harmless. However, ``sparse`` will complain if you  |
 | define ``gp`` with ``__rcu`` and then access it without using either  |
-| ``rcu_access_pointer()`` or ``rcu_dereference()``.                    |
+| rcu_access_pointer() or rcu_dereference().                    |
 +-----------------------------------------------------------------------+
 
 In short, RCU's publish-subscribe guarantee is provided by the
-combination of ``rcu_assign_pointer()`` and ``rcu_dereference()``. This
+combination of rcu_assign_pointer() and rcu_dereference(). This
 guarantee allows data elements to be safely added to RCU-protected
 linked data structures without disrupting RCU readers. This guarantee
 can be used in combination with the grace-period guarantee to also allow
@@ -462,9 +462,9 @@ again without disrupting RCU readers.
 
 This guarantee was only partially premeditated. DYNIX/ptx used an
 explicit memory barrier for publication, but had nothing resembling
-``rcu_dereference()`` for subscription, nor did it have anything
+rcu_dereference() for subscription, nor did it have anything
 resembling the dependency-ordering barrier that was later subsumed
-into ``rcu_dereference()`` and later still into ``READ_ONCE()``. The
+into rcu_dereference() and later still into READ_ONCE(). The
 need for these operations made itself known quite suddenly at a
 late-1990s meeting with the DEC Alpha architects, back in the days when
 DEC was still a free-standing company. It took the Alpha architects a
@@ -474,7 +474,7 @@ documentation did not make this point clear. More recent work with the C
 and C++ standards committees have provided much education on tricks and
 traps from the compiler. In short, compilers were much less tricky in
 the early 1990s, but in 2015, don't even think about omitting
-``rcu_dereference()``!
+rcu_dereference()!
 
 Memory-Barrier Guarantees
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -484,31 +484,31 @@ demonstrates the need for RCU's stringent memory-ordering guarantees on
 systems with more than one CPU:
 
 #. Each CPU that has an RCU read-side critical section that begins
-   before ``synchronize_rcu()`` starts is guaranteed to execute a full
+   before synchronize_rcu() starts is guaranteed to execute a full
    memory barrier between the time that the RCU read-side critical
-   section ends and the time that ``synchronize_rcu()`` returns. Without
+   section ends and the time that synchronize_rcu() returns. Without
    this guarantee, a pre-existing RCU read-side critical section might
    hold a reference to the newly removed ``struct foo`` after the
-   ``kfree()`` on line 14 of ``remove_gp_synchronous()``.
+   kfree() on line 14 of remove_gp_synchronous().
 #. Each CPU that has an RCU read-side critical section that ends after
-   ``synchronize_rcu()`` returns is guaranteed to execute a full memory
-   barrier between the time that ``synchronize_rcu()`` begins and the
+   synchronize_rcu() returns is guaranteed to execute a full memory
+   barrier between the time that synchronize_rcu() begins and the
    time that the RCU read-side critical section begins. Without this
    guarantee, a later RCU read-side critical section running after the
-   ``kfree()`` on line 14 of ``remove_gp_synchronous()`` might later run
-   ``do_something_gp()`` and find the newly deleted ``struct foo``.
-#. If the task invoking ``synchronize_rcu()`` remains on a given CPU,
+   kfree() on line 14 of remove_gp_synchronous() might later run
+   do_something_gp() and find the newly deleted ``struct foo``.
+#. If the task invoking synchronize_rcu() remains on a given CPU,
    then that CPU is guaranteed to execute a full memory barrier sometime
-   during the execution of ``synchronize_rcu()``. This guarantee ensures
-   that the ``kfree()`` on line 14 of ``remove_gp_synchronous()`` really
+   during the execution of synchronize_rcu(). This guarantee ensures
+   that the kfree() on line 14 of remove_gp_synchronous() really
    does execute after the removal on line 11.
-#. If the task invoking ``synchronize_rcu()`` migrates among a group of
+#. If the task invoking synchronize_rcu() migrates among a group of
    CPUs during that invocation, then each of the CPUs in that group is
    guaranteed to execute a full memory barrier sometime during the
-   execution of ``synchronize_rcu()``. This guarantee also ensures that
-   the ``kfree()`` on line 14 of ``remove_gp_synchronous()`` really does
+   execution of synchronize_rcu(). This guarantee also ensures that
+   the kfree() on line 14 of remove_gp_synchronous() really does
    execute after the removal on line 11, but also in the case where the
-   thread executing the ``synchronize_rcu()`` migrates in the meantime.
+   thread executing the synchronize_rcu() migrates in the meantime.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
@@ -516,19 +516,19 @@ systems with more than one CPU:
 | Given that multiple CPUs can start RCU read-side critical sections at |
 | any time without any ordering whatsoever, how can RCU possibly tell   |
 | whether or not a given RCU read-side critical section starts before a |
-| given instance of ``synchronize_rcu()``?                              |
+| given instance of synchronize_rcu()?                              |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
 | If RCU cannot tell whether or not a given RCU read-side critical      |
-| section starts before a given instance of ``synchronize_rcu()``, then |
+| section starts before a given instance of synchronize_rcu(), then |
 | it must assume that the RCU read-side critical section started first. |
-| In other words, a given instance of ``synchronize_rcu()`` can avoid   |
+| In other words, a given instance of synchronize_rcu() can avoid   |
 | waiting on a given RCU read-side critical section only if it can      |
-| prove that ``synchronize_rcu()`` started first.                       |
-| A related question is “When ``rcu_read_lock()`` doesn't generate any  |
+| prove that synchronize_rcu() started first.                       |
+| A related question is “When rcu_read_lock() doesn't generate any  |
 | code, why does it matter how it relates to a grace period?” The       |
-| answer is that it is not the relationship of ``rcu_read_lock()``      |
+| answer is that it is not the relationship of rcu_read_lock()      |
 | itself that is important, but rather the relationship of the code     |
 | within the enclosed RCU read-side critical section to the code        |
 | preceding and following the grace period. If we take this viewpoint,  |
@@ -556,14 +556,14 @@ systems with more than one CPU:
 | Yes, they really are required. To see why the first guarantee is      |
 | required, consider the following sequence of events:                  |
 |                                                                       |
-| #. CPU 1: ``rcu_read_lock()``                                         |
+| #. CPU 1: rcu_read_lock()                                         |
 | #. CPU 1: ``q = rcu_dereference(gp); /* Very likely to return p. */`` |
 | #. CPU 0: ``list_del_rcu(p);``                                        |
-| #. CPU 0: ``synchronize_rcu()`` starts.                               |
+| #. CPU 0: synchronize_rcu() starts.                               |
 | #. CPU 1: ``do_something_with(q->a);``                                |
 |    ``/* No smp_mb(), so might happen after kfree(). */``              |
-| #. CPU 1: ``rcu_read_unlock()``                                       |
-| #. CPU 0: ``synchronize_rcu()`` returns.                              |
+| #. CPU 1: rcu_read_unlock()                                       |
+| #. CPU 0: synchronize_rcu() returns.                              |
 | #. CPU 0: ``kfree(p);``                                               |
 |                                                                       |
 | Therefore, there absolutely must be a full memory barrier between the |
@@ -574,14 +574,14 @@ systems with more than one CPU:
 | is roughly similar:                                                   |
 |                                                                       |
 | #. CPU 0: ``list_del_rcu(p);``                                        |
-| #. CPU 0: ``synchronize_rcu()`` starts.                               |
-| #. CPU 1: ``rcu_read_lock()``                                         |
+| #. CPU 0: synchronize_rcu() starts.                               |
+| #. CPU 1: rcu_read_lock()                                         |
 | #. CPU 1: ``q = rcu_dereference(gp);``                                |
 |    ``/* Might return p if no memory barrier. */``                     |
-| #. CPU 0: ``synchronize_rcu()`` returns.                              |
+| #. CPU 0: synchronize_rcu() returns.                              |
 | #. CPU 0: ``kfree(p);``                                               |
 | #. CPU 1: ``do_something_with(q->a); /* Boom!!! */``                  |
-| #. CPU 1: ``rcu_read_unlock()``                                       |
+| #. CPU 1: rcu_read_unlock()                                       |
 |                                                                       |
 | And similarly, without a memory barrier between the beginning of the  |
 | grace period and the beginning of the RCU read-side critical section, |
@@ -597,7 +597,7 @@ systems with more than one CPU:
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| You claim that ``rcu_read_lock()`` and ``rcu_read_unlock()`` generate |
+| You claim that rcu_read_lock() and rcu_read_unlock() generate |
 | absolutely no code in some kernel builds. This means that the         |
 | compiler might arbitrarily rearrange consecutive RCU read-side        |
 | critical sections. Given such rearrangement, if a given RCU read-side |
@@ -607,11 +607,11 @@ systems with more than one CPU:
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| In cases where ``rcu_read_lock()`` and ``rcu_read_unlock()`` generate |
+| In cases where rcu_read_lock() and rcu_read_unlock() generate |
 | absolutely no code, RCU infers quiescent states only at special       |
 | locations, for example, within the scheduler. Because calls to        |
-| ``schedule()`` had better prevent calling-code accesses to shared     |
-| variables from being rearranged across the call to ``schedule()``, if |
+| schedule() had better prevent calling-code accesses to shared     |
+| variables from being rearranged across the call to schedule(), if |
 | RCU detects the end of a given RCU read-side critical section, it     |
 | will necessarily detect the end of all prior RCU read-side critical   |
 | sections, no matter how aggressively the compiler scrambles the code. |
@@ -655,8 +655,8 @@ read-side critical section might search for a given data element, and
 then might acquire the update-side spinlock in order to update that
 element, all while remaining in that RCU read-side critical section. Of
 course, it is necessary to exit the RCU read-side critical section
-before invoking ``synchronize_rcu()``, however, this inconvenience can
-be avoided through use of the ``call_rcu()`` and ``kfree_rcu()`` API
+before invoking synchronize_rcu(), however, this inconvenience can
+be avoided through use of the call_rcu() and kfree_rcu() API
 members described later in this document.
 
 +-----------------------------------------------------------------------+
@@ -694,10 +694,10 @@ these non-guarantees were premeditated.
 Readers Impose Minimal Ordering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Reader-side markers such as ``rcu_read_lock()`` and
-``rcu_read_unlock()`` provide absolutely no ordering guarantees except
+Reader-side markers such as rcu_read_lock() and
+rcu_read_unlock() provide absolutely no ordering guarantees except
 through their interaction with the grace-period APIs such as
-``synchronize_rcu()``. To see this, consider the following pair of
+synchronize_rcu(). To see this, consider the following pair of
 threads:
 
    ::
@@ -722,7 +722,7 @@ threads:
       18   rcu_read_unlock();
       19 }
 
-After ``thread0()`` and ``thread1()`` execute concurrently, it is quite
+After thread0() and thread1() execute concurrently, it is quite
 possible to have
 
    ::
@@ -730,7 +730,7 @@ possible to have
       (r1 == 1 && r2 == 0)
 
 (that is, ``y`` appears to have been assigned before ``x``), which would
-not be possible if ``rcu_read_lock()`` and ``rcu_read_unlock()`` had
+not be possible if rcu_read_lock() and rcu_read_unlock() had
 much in the way of ordering properties. But they do not, so the CPU is
 within its rights to do significant reordering. This is by design: Any
 significant ordering constraints would slow down these fast-path APIs.
@@ -742,14 +742,14 @@ significant ordering constraints would slow down these fast-path APIs.
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| No, the volatile casts in ``READ_ONCE()`` and ``WRITE_ONCE()``        |
+| No, the volatile casts in READ_ONCE() and WRITE_ONCE()        |
 | prevent the compiler from reordering in this particular case.         |
 +-----------------------------------------------------------------------+
 
 Readers Do Not Exclude Updaters
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Neither ``rcu_read_lock()`` nor ``rcu_read_unlock()`` exclude updates.
+Neither rcu_read_lock() nor rcu_read_unlock() exclude updates.
 All they do is to prevent grace periods from ending. The following
 example illustrates this:
 
@@ -775,19 +775,19 @@ example illustrates this:
       18   spin_unlock(&my_lock);
       19 }
 
-If the ``thread0()`` function's ``rcu_read_lock()`` excluded the
-``thread1()`` function's update, the ``WARN_ON()`` could never fire. But
-the fact is that ``rcu_read_lock()`` does not exclude much of anything
-aside from subsequent grace periods, of which ``thread1()`` has none, so
-the ``WARN_ON()`` can and does fire.
+If the thread0() function's rcu_read_lock() excluded the
+thread1() function's update, the WARN_ON() could never fire. But
+the fact is that rcu_read_lock() does not exclude much of anything
+aside from subsequent grace periods, of which thread1() has none, so
+the WARN_ON() can and does fire.
 
 Updaters Only Wait For Old Readers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-It might be tempting to assume that after ``synchronize_rcu()``
+It might be tempting to assume that after synchronize_rcu()
 completes, there are no readers executing. This temptation must be
 avoided because new readers can start immediately after
-``synchronize_rcu()`` starts, and ``synchronize_rcu()`` is under no
+synchronize_rcu() starts, and synchronize_rcu() is under no
 obligation to wait for these new readers.
 
 +-----------------------------------------------------------------------+
@@ -799,10 +799,10 @@ obligation to wait for these new readers.
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| For no time at all. Even if ``synchronize_rcu()`` were to wait until  |
+| For no time at all. Even if synchronize_rcu() were to wait until  |
 | all readers had completed, a new reader might start immediately after |
-| ``synchronize_rcu()`` completed. Therefore, the code following        |
-| ``synchronize_rcu()`` can *never* rely on there being no readers.     |
+| synchronize_rcu() completed. Therefore, the code following        |
+| synchronize_rcu() can *never* rely on there being no readers.     |
 +-----------------------------------------------------------------------+
 
 Grace Periods Don't Partition Read-Side Critical Sections
@@ -892,12 +892,12 @@ period is known to end before the second grace period starts:
       28   rcu_read_unlock();
       29 }
 
-Here, if ``(r1 == 1)``, then ``thread0()``'s write to ``b`` must happen
-before the end of ``thread1()``'s grace period. If in addition
-``(r4 == 1)``, then ``thread3()``'s read from ``b`` must happen after
-the beginning of ``thread2()``'s grace period. If it is also the case
-that ``(r2 == 1)``, then the end of ``thread1()``'s grace period must
-precede the beginning of ``thread2()``'s grace period. This mean that
+Here, if ``(r1 == 1)``, then thread0()'s write to ``b`` must happen
+before the end of thread1()'s grace period. If in addition
+``(r4 == 1)``, then thread3()'s read from ``b`` must happen after
+the beginning of thread2()'s grace period. If it is also the case
+that ``(r2 == 1)``, then the end of thread1()'s grace period must
+precede the beginning of thread2()'s grace period. This mean that
 the two RCU read-side critical sections cannot overlap, guaranteeing
 that ``(r3 == 1)``. As a result, the outcome:
 
@@ -1076,8 +1076,8 @@ is captured by the following list of situations:
    b. Wait-free read-side primitives for real-time use.
 
 This focus on read-mostly situations means that RCU must interoperate
-with other synchronization primitives. For example, the ``add_gp()`` and
-``remove_gp_synchronous()`` examples discussed earlier use RCU to
+with other synchronization primitives. For example, the add_gp() and
+remove_gp_synchronous() examples discussed earlier use RCU to
 protect readers and locking to coordinate updaters. However, the need
 extends much farther, requiring that a variety of synchronization
 primitives be legal within RCU read-side critical sections, including
@@ -1104,11 +1104,11 @@ memory barriers.
 | sections.                                                             |
 | Note that it *is* legal for a normal RCU read-side critical section   |
 | to conditionally acquire a sleeping locks (as in                      |
-| ``mutex_trylock()``), but only as long as it does not loop            |
+| mutex_trylock()), but only as long as it does not loop            |
 | indefinitely attempting to conditionally acquire that sleeping locks. |
-| The key point is that things like ``mutex_trylock()`` either return   |
+| The key point is that things like mutex_trylock() either return   |
 | with the mutex held, or return an error indication if the mutex was   |
-| not immediately available. Either way, ``mutex_trylock()`` returns    |
+| not immediately available. Either way, mutex_trylock() returns    |
 | immediately without sleeping.                                         |
 +-----------------------------------------------------------------------+
 
@@ -1191,57 +1191,57 @@ for those kernels not needing it.
 
 The remaining performance requirements are, for the most part,
 unsurprising. For example, in keeping with RCU's read-side
-specialization, ``rcu_dereference()`` should have negligible overhead
+specialization, rcu_dereference() should have negligible overhead
 (for example, suppression of a few minor compiler optimizations).
-Similarly, in non-preemptible environments, ``rcu_read_lock()`` and
-``rcu_read_unlock()`` should have exactly zero overhead.
+Similarly, in non-preemptible environments, rcu_read_lock() and
+rcu_read_unlock() should have exactly zero overhead.
 
 In preemptible environments, in the case where the RCU read-side
 critical section was not preempted (as will be the case for the
-highest-priority real-time process), ``rcu_read_lock()`` and
-``rcu_read_unlock()`` should have minimal overhead. In particular, they
+highest-priority real-time process), rcu_read_lock() and
+rcu_read_unlock() should have minimal overhead. In particular, they
 should not contain atomic read-modify-write operations, memory-barrier
 instructions, preemption disabling, interrupt disabling, or backwards
 branches. However, in the case where the RCU read-side critical section
-was preempted, ``rcu_read_unlock()`` may acquire spinlocks and disable
+was preempted, rcu_read_unlock() may acquire spinlocks and disable
 interrupts. This is why it is better to nest an RCU read-side critical
 section within a preempt-disable region than vice versa, at least in
 cases where that critical section is short enough to avoid unduly
 degrading real-time latencies.
 
-The ``synchronize_rcu()`` grace-period-wait primitive is optimized for
+The synchronize_rcu() grace-period-wait primitive is optimized for
 throughput. It may therefore incur several milliseconds of latency in
 addition to the duration of the longest RCU read-side critical section.
 On the other hand, multiple concurrent invocations of
-``synchronize_rcu()`` are required to use batching optimizations so that
+synchronize_rcu() are required to use batching optimizations so that
 they can be satisfied by a single underlying grace-period-wait
 operation. For example, in the Linux kernel, it is not unusual for a
 single grace-period-wait operation to serve more than `1,000 separate
 invocations <https://www.usenix.org/conference/2004-usenix-annual-technical-conference/making-rcu-safe-deep-sub-millisecond-response>`__
-of ``synchronize_rcu()``, thus amortizing the per-invocation overhead
+of synchronize_rcu(), thus amortizing the per-invocation overhead
 down to nearly zero. However, the grace-period optimization is also
 required to avoid measurable degradation of real-time scheduling and
 interrupt latencies.
 
-In some cases, the multi-millisecond ``synchronize_rcu()`` latencies are
-unacceptable. In these cases, ``synchronize_rcu_expedited()`` may be
+In some cases, the multi-millisecond synchronize_rcu() latencies are
+unacceptable. In these cases, synchronize_rcu_expedited() may be
 used instead, reducing the grace-period latency down to a few tens of
 microseconds on small systems, at least in cases where the RCU read-side
 critical sections are short. There are currently no special latency
-requirements for ``synchronize_rcu_expedited()`` on large systems, but,
+requirements for synchronize_rcu_expedited() on large systems, but,
 consistent with the empirical nature of the RCU specification, that is
 subject to change. However, there most definitely are scalability
-requirements: A storm of ``synchronize_rcu_expedited()`` invocations on
+requirements: A storm of synchronize_rcu_expedited() invocations on
 4096 CPUs should at least make reasonable forward progress. In return
-for its shorter latencies, ``synchronize_rcu_expedited()`` is permitted
+for its shorter latencies, synchronize_rcu_expedited() is permitted
 to impose modest degradation of real-time latency on non-idle online
 CPUs. Here, “modest” means roughly the same latency degradation as a
 scheduling-clock interrupt.
 
 There are a number of situations where even
-``synchronize_rcu_expedited()``'s reduced grace-period latency is
-unacceptable. In these situations, the asynchronous ``call_rcu()`` can
-be used in place of ``synchronize_rcu()`` as follows:
+synchronize_rcu_expedited()'s reduced grace-period latency is
+unacceptable. In these situations, the asynchronous call_rcu() can
+be used in place of synchronize_rcu() as follows:
 
    ::
 
@@ -1275,19 +1275,19 @@ be used in place of ``synchronize_rcu()`` as follows:
       28 }
 
 A definition of ``struct foo`` is finally needed, and appears on
-lines 1-5. The function ``remove_gp_cb()`` is passed to ``call_rcu()``
+lines 1-5. The function remove_gp_cb() is passed to call_rcu()
 on line 25, and will be invoked after the end of a subsequent grace
-period. This gets the same effect as ``remove_gp_synchronous()``, but
+period. This gets the same effect as remove_gp_synchronous(), but
 without forcing the updater to wait for a grace period to elapse. The
-``call_rcu()`` function may be used in a number of situations where
-neither ``synchronize_rcu()`` nor ``synchronize_rcu_expedited()`` would
-be legal, including within preempt-disable code, ``local_bh_disable()``
+call_rcu() function may be used in a number of situations where
+neither synchronize_rcu() nor synchronize_rcu_expedited() would
+be legal, including within preempt-disable code, local_bh_disable()
 code, interrupt-disable code, and interrupt handlers. However, even
-``call_rcu()`` is illegal within NMI handlers and from idle and offline
-CPUs. The callback function (``remove_gp_cb()`` in this case) will be
+call_rcu() is illegal within NMI handlers and from idle and offline
+CPUs. The callback function (remove_gp_cb() in this case) will be
 executed within softirq (software interrupt) environment within the
 Linux kernel, either within a real softirq handler or under the
-protection of ``local_bh_disable()``. In both the Linux kernel and in
+protection of local_bh_disable(). In both the Linux kernel and in
 userspace, it is bad practice to write an RCU callback function that
 takes too long. Long-running operations should be relegated to separate
 threads or (in the Linux kernel) workqueues.
@@ -1295,23 +1295,23 @@ threads or (in the Linux kernel) workqueues.
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why does line 19 use ``rcu_access_pointer()``? After all,             |
-| ``call_rcu()`` on line 25 stores into the structure, which would      |
+| Why does line 19 use rcu_access_pointer()? After all,             |
+| call_rcu() on line 25 stores into the structure, which would      |
 | interact badly with concurrent insertions. Doesn't this mean that     |
-| ``rcu_dereference()`` is required?                                    |
+| rcu_dereference() is required?                                    |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
 | Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
-| changes, including any insertions that ``rcu_dereference()`` would    |
+| changes, including any insertions that rcu_dereference() would    |
 | protect against. Therefore, any insertions will be delayed until      |
 | after ``->gp_lock`` is released on line 25, which in turn means that  |
-| ``rcu_access_pointer()`` suffices.                                    |
+| rcu_access_pointer() suffices.                                    |
 +-----------------------------------------------------------------------+
 
-However, all that ``remove_gp_cb()`` is doing is invoking ``kfree()`` on
+However, all that remove_gp_cb() is doing is invoking kfree() on
 the data element. This is a common idiom, and is supported by
-``kfree_rcu()``, which allows “fire and forget” operation as shown
+kfree_rcu(), which allows “fire and forget” operation as shown
 below:
 
    ::
@@ -1338,20 +1338,20 @@ below:
       20   return true;
       21 }
 
-Note that ``remove_gp_faf()`` simply invokes ``kfree_rcu()`` and
+Note that remove_gp_faf() simply invokes kfree_rcu() and
 proceeds, without any need to pay any further attention to the
-subsequent grace period and ``kfree()``. It is permissible to invoke
-``kfree_rcu()`` from the same environments as for ``call_rcu()``.
-Interestingly enough, DYNIX/ptx had the equivalents of ``call_rcu()``
-and ``kfree_rcu()``, but not ``synchronize_rcu()``. This was due to the
+subsequent grace period and kfree(). It is permissible to invoke
+kfree_rcu() from the same environments as for call_rcu().
+Interestingly enough, DYNIX/ptx had the equivalents of call_rcu()
+and kfree_rcu(), but not synchronize_rcu(). This was due to the
 fact that RCU was not heavily used within DYNIX/ptx, so the very few
-places that needed something like ``synchronize_rcu()`` simply
+places that needed something like synchronize_rcu() simply
 open-coded it.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Earlier it was claimed that ``call_rcu()`` and ``kfree_rcu()``        |
+| Earlier it was claimed that call_rcu() and kfree_rcu()        |
 | allowed updaters to avoid being blocked by readers. But how can that  |
 | be correct, given that the invocation of the callback and the freeing |
 | of the memory (respectively) must still wait for a grace period to    |
@@ -1363,16 +1363,16 @@ open-coded it.
 | definition would say that updates in garbage-collected languages      |
 | cannot complete until the next time the garbage collector runs, which |
 | does not seem at all reasonable. The key point is that in most cases, |
-| an updater using either ``call_rcu()`` or ``kfree_rcu()`` can proceed |
-| to the next update as soon as it has invoked ``call_rcu()`` or        |
-| ``kfree_rcu()``, without having to wait for a subsequent grace        |
+| an updater using either call_rcu() or kfree_rcu() can proceed |
+| to the next update as soon as it has invoked call_rcu() or        |
+| kfree_rcu(), without having to wait for a subsequent grace        |
 | period.                                                               |
 +-----------------------------------------------------------------------+
 
 But what if the updater must wait for the completion of code to be
 executed after the end of the grace period, but has other tasks that can
 be carried out in the meantime? The polling-style
-``get_state_synchronize_rcu()`` and ``cond_synchronize_rcu()`` functions
+get_state_synchronize_rcu() and cond_synchronize_rcu() functions
 may be used for this purpose, as shown below:
 
    ::
@@ -1397,11 +1397,11 @@ may be used for this purpose, as shown below:
       18   return true;
       19 }
 
-On line 14, ``get_state_synchronize_rcu()`` obtains a “cookie” from RCU,
+On line 14, get_state_synchronize_rcu() obtains a “cookie” from RCU,
 then line 15 carries out other tasks, and finally, line 16 returns
 immediately if a grace period has elapsed in the meantime, but otherwise
 waits as required. The need for ``get_state_synchronize_rcu`` and
-``cond_synchronize_rcu()`` has appeared quite recently, so it is too
+cond_synchronize_rcu() has appeared quite recently, so it is too
 early to tell whether they will stand the test of time.
 
 RCU thus provides a range of tools to allow updaters to strike the
@@ -1421,8 +1421,8 @@ example, an infinite loop in an RCU read-side critical section must by
 definition prevent later grace periods from ever completing. For a more
 involved example, consider a 64-CPU system built with
 ``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
-CPUs 1 through 63 spin in tight loops that invoke ``call_rcu()``. Even
-if these tight loops also contain calls to ``cond_resched()`` (thus
+CPUs 1 through 63 spin in tight loops that invoke call_rcu(). Even
+if these tight loops also contain calls to cond_resched() (thus
 allowing grace periods to complete), CPU 0 simply will not be able to
 invoke callbacks as fast as the other 63 CPUs can register them, at
 least not until the system runs out of memory. In both of these
@@ -1435,21 +1435,21 @@ RCU takes the following steps to encourage timely completion of grace
 periods:
 
 #. If a grace period fails to complete within 100 milliseconds, RCU
-   causes future invocations of ``cond_resched()`` on the holdout CPUs
+   causes future invocations of cond_resched() on the holdout CPUs
    to provide an RCU quiescent state. RCU also causes those CPUs'
-   ``need_resched()`` invocations to return ``true``, but only after the
+   need_resched() invocations to return ``true``, but only after the
    corresponding CPU's next scheduling-clock.
 #. CPUs mentioned in the ``nohz_full`` kernel boot parameter can run
    indefinitely in the kernel without scheduling-clock interrupts, which
-   defeats the above ``need_resched()`` strategem. RCU will therefore
-   invoke ``resched_cpu()`` on any ``nohz_full`` CPUs still holding out
+   defeats the above need_resched() strategem. RCU will therefore
+   invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
    after 109 milliseconds.
 #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
    has been preempted within an RCU read-side critical section is
    holding out for more than 500 milliseconds, RCU will resort to
    priority boosting.
 #. If a CPU is still holding out 10 seconds into the grace period, RCU
-   will invoke ``resched_cpu()`` on it regardless of its ``nohz_full``
+   will invoke resched_cpu() on it regardless of its ``nohz_full``
    state.
 
 The above values are defaults for systems running with ``HZ=1000``. They
@@ -1460,7 +1460,7 @@ caution when changing them. Note that these forward-progress measures
 are provided only for RCU, not for `SRCU <#Sleepable%20RCU>`__ or `Tasks
 RCU <#Tasks%20RCU>`__.
 
-RCU takes the following steps in ``call_rcu()`` to encourage timely
+RCU takes the following steps in call_rcu() to encourage timely
 invocation of callbacks when any given non-\ ``rcu_nocbs`` CPU has
 10,000 callbacks, or has 10,000 more callbacks than it had the last time
 encouragement was provided:
@@ -1481,8 +1481,8 @@ RCU, not for `SRCU <#Sleepable%20RCU>`__ or `Tasks
 RCU <#Tasks%20RCU>`__. Even for RCU, callback-invocation forward
 progress for ``rcu_nocbs`` CPUs is much less well-developed, in part
 because workloads benefiting from ``rcu_nocbs`` CPUs tend to invoke
-``call_rcu()`` relatively infrequently. If workloads emerge that need
-both ``rcu_nocbs`` CPUs and high ``call_rcu()`` invocation rates, then
+call_rcu() relatively infrequently. If workloads emerge that need
+both ``rcu_nocbs`` CPUs and high call_rcu() invocation rates, then
 additional forward-progress work will be required.
 
 Composability
@@ -1496,11 +1496,11 @@ in fact may be nested arbitrarily deeply. In practice, as with all
 real-world implementations of composable constructs, there are
 limitations.
 
-Implementations of RCU for which ``rcu_read_lock()`` and
-``rcu_read_unlock()`` generate no code, such as Linux-kernel RCU when
+Implementations of RCU for which rcu_read_lock() and
+rcu_read_unlock() generate no code, such as Linux-kernel RCU when
 ``CONFIG_PREEMPT=n``, can be nested arbitrarily deeply. After all, there
 is no overhead. Except that if all these instances of
-``rcu_read_lock()`` and ``rcu_read_unlock()`` are visible to the
+rcu_read_lock() and rcu_read_unlock() are visible to the
 compiler, compilation will eventually fail due to exhausting memory,
 mass storage, or user patience, whichever comes first. If the nesting is
 not visible to the compiler, as is the case with mutually recursive
@@ -1558,11 +1558,11 @@ argue that such workloads should instead use something other than RCU,
 the fact remains that RCU must handle such workloads gracefully. This
 requirement is another factor driving batching of grace periods, but it
 is also the driving force behind the checks for large numbers of queued
-RCU callbacks in the ``call_rcu()`` code path. Finally, high update
+RCU callbacks in the call_rcu() code path. Finally, high update
 rates should not delay RCU read-side critical sections, although some
 small read-side delays can occur when using
-``synchronize_rcu_expedited()``, courtesy of this function's use of
-``smp_call_function_single()``.
+synchronize_rcu_expedited(), courtesy of this function's use of
+smp_call_function_single().
 
 Although all three of these corner cases were understood in the early
 1990s, a simple user-level test consisting of ``close(open(path))`` in a
@@ -1583,45 +1583,45 @@ Software-Engineering Requirements
 Between Murphy's Law and “To err is human”, it is necessary to guard
 against mishaps and misuse:
 
-#. It is all too easy to forget to use ``rcu_read_lock()`` everywhere
+#. It is all too easy to forget to use rcu_read_lock() everywhere
    that it is needed, so kernels built with ``CONFIG_PROVE_RCU=y`` will
-   splat if ``rcu_dereference()`` is used outside of an RCU read-side
+   splat if rcu_dereference() is used outside of an RCU read-side
    critical section. Update-side code can use
-   ``rcu_dereference_protected()``, which takes a `lockdep
+   rcu_dereference_protected(), which takes a `lockdep
    expression <https://lwn.net/Articles/371986/>`__ to indicate what is
    providing the protection. If the indicated protection is not
    provided, a lockdep splat is emitted.
    Code shared between readers and updaters can use
-   ``rcu_dereference_check()``, which also takes a lockdep expression,
-   and emits a lockdep splat if neither ``rcu_read_lock()`` nor the
+   rcu_dereference_check(), which also takes a lockdep expression,
+   and emits a lockdep splat if neither rcu_read_lock() nor the
    indicated protection is in place. In addition,
-   ``rcu_dereference_raw()`` is used in those (hopefully rare) cases
+   rcu_dereference_raw() is used in those (hopefully rare) cases
    where the required protection cannot be easily described. Finally,
-   ``rcu_read_lock_held()`` is provided to allow a function to verify
+   rcu_read_lock_held() is provided to allow a function to verify
    that it has been invoked within an RCU read-side critical section. I
    was made aware of this set of requirements shortly after Thomas
    Gleixner audited a number of RCU uses.
 #. A given function might wish to check for RCU-related preconditions
    upon entry, before using any other RCU API. The
-   ``rcu_lockdep_assert()`` does this job, asserting the expression in
+   rcu_lockdep_assert() does this job, asserting the expression in
    kernels having lockdep enabled and doing nothing otherwise.
-#. It is also easy to forget to use ``rcu_assign_pointer()`` and
-   ``rcu_dereference()``, perhaps (incorrectly) substituting a simple
+#. It is also easy to forget to use rcu_assign_pointer() and
+   rcu_dereference(), perhaps (incorrectly) substituting a simple
    assignment. To catch this sort of error, a given RCU-protected
    pointer may be tagged with ``__rcu``, after which sparse will
    complain about simple-assignment accesses to that pointer. Arnd
    Bergmann made me aware of this requirement, and also supplied the
    needed `patch series <https://lwn.net/Articles/376011/>`__.
 #. Kernels built with ``CONFIG_DEBUG_OBJECTS_RCU_HEAD=y`` will splat if
-   a data element is passed to ``call_rcu()`` twice in a row, without a
+   a data element is passed to call_rcu() twice in a row, without a
    grace period in between. (This error is similar to a double free.)
    The corresponding ``rcu_head`` structures that are dynamically
    allocated are automatically tracked, but ``rcu_head`` structures
    allocated on the stack must be initialized with
-   ``init_rcu_head_on_stack()`` and cleaned up with
-   ``destroy_rcu_head_on_stack()``. Similarly, statically allocated
+   init_rcu_head_on_stack() and cleaned up with
+   destroy_rcu_head_on_stack(). Similarly, statically allocated
    non-stack ``rcu_head`` structures must be initialized with
-   ``init_rcu_head()`` and cleaned up with ``destroy_rcu_head()``.
+   init_rcu_head() and cleaned up with destroy_rcu_head().
    Mathieu Desnoyers made me aware of this requirement, and also
    supplied the needed
    `patch <https://lkml.kernel.org/g/20100319013024.GA28456@Krystal>`__.
@@ -1638,9 +1638,9 @@ against mishaps and misuse:
    ``rcupdate.rcu_cpu_stall_suppress`` to suppress the splats. This
    kernel parameter may also be set via ``sysfs``. Furthermore, RCU CPU
    stall warnings are counter-productive during sysrq dumps and during
-   panics. RCU therefore supplies the ``rcu_sysrq_start()`` and
-   ``rcu_sysrq_end()`` API members to be called before and after long
-   sysrq dumps. RCU also supplies the ``rcu_panic()`` notifier that is
+   panics. RCU therefore supplies the rcu_sysrq_start() and
+   rcu_sysrq_end() API members to be called before and after long
+   sysrq dumps. RCU also supplies the rcu_panic() notifier that is
    automatically invoked at the beginning of a panic to suppress further
    RCU CPU stall warnings.
 
@@ -1656,7 +1656,7 @@ against mishaps and misuse:
    synchronization mechanism, for example, reference counting.
 #. In kernels built with ``CONFIG_RCU_TRACE=y``, RCU-related information
    is provided via event tracing.
-#. Open-coded use of ``rcu_assign_pointer()`` and ``rcu_dereference()``
+#. Open-coded use of rcu_assign_pointer() and rcu_dereference()
    to create typical linked data structures can be surprisingly
    error-prone. Therefore, RCU-protected `linked
    lists <https://lwn.net/Articles/609973/#RCU%20List%20APIs>`__ and,
@@ -1665,11 +1665,11 @@ against mishaps and misuse:
    other special-purpose RCU-protected data structures are available in
    the Linux kernel and the userspace RCU library.
 #. Some linked structures are created at compile time, but still require
-   ``__rcu`` checking. The ``RCU_POINTER_INITIALIZER()`` macro serves
+   ``__rcu`` checking. The RCU_POINTER_INITIALIZER() macro serves
    this purpose.
-#. It is not necessary to use ``rcu_assign_pointer()`` when creating
+#. It is not necessary to use rcu_assign_pointer() when creating
    linked structures that are to be published via a single external
-   pointer. The ``RCU_INIT_POINTER()`` macro is provided for this task
+   pointer. The RCU_INIT_POINTER() macro is provided for this task
    and also for assigning ``NULL`` pointers at runtime.
 
 This not a hard-and-fast list: RCU's diagnostic capabilities will
@@ -1743,17 +1743,17 @@ Early Boot
 ~~~~~~~~~~
 
 The Linux kernel's boot sequence is an interesting process, and RCU is
-used early, even before ``rcu_init()`` is invoked. In fact, a number of
+used early, even before rcu_init() is invoked. In fact, a number of
 RCU's primitives can be used as soon as the initial task's
 ``task_struct`` is available and the boot CPU's per-CPU variables are
-set up. The read-side primitives (``rcu_read_lock()``,
-``rcu_read_unlock()``, ``rcu_dereference()``, and
-``rcu_access_pointer()``) will operate normally very early on, as will
-``rcu_assign_pointer()``.
+set up. The read-side primitives (rcu_read_lock(),
+rcu_read_unlock(), rcu_dereference(), and
+rcu_access_pointer()) will operate normally very early on, as will
+rcu_assign_pointer().
 
-Although ``call_rcu()`` may be invoked at any time during boot,
+Although call_rcu() may be invoked at any time during boot,
 callbacks are not guaranteed to be invoked until after all of RCU's
-kthreads have been spawned, which occurs at ``early_initcall()`` time.
+kthreads have been spawned, which occurs at early_initcall() time.
 This delay in callback invocation is due to the fact that RCU does not
 invoke callbacks until it is fully initialized, and this full
 initialization cannot occur until after the scheduler has initialized
@@ -1762,22 +1762,22 @@ it would be possible to invoke callbacks earlier, however, this is not a
 panacea because there would be severe restrictions on what operations
 those callbacks could invoke.
 
-Perhaps surprisingly, ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``, will operate normally during very early
+Perhaps surprisingly, synchronize_rcu() and
+synchronize_rcu_expedited(), will operate normally during very early
 boot, the reason being that there is only one CPU and preemption is
-disabled. This means that the call ``synchronize_rcu()`` (or friends)
+disabled. This means that the call synchronize_rcu() (or friends)
 itself is a quiescent state and thus a grace period, so the early-boot
 implementation can be a no-op.
 
 However, once the scheduler has spawned its first kthread, this early
-boot trick fails for ``synchronize_rcu()`` (as well as for
-``synchronize_rcu_expedited()``) in ``CONFIG_PREEMPT=y`` kernels. The
+boot trick fails for synchronize_rcu() (as well as for
+synchronize_rcu_expedited()) in ``CONFIG_PREEMPT=y`` kernels. The
 reason is that an RCU read-side critical section might be preempted,
-which means that a subsequent ``synchronize_rcu()`` really does have to
+which means that a subsequent synchronize_rcu() really does have to
 wait for something, as opposed to simply returning immediately.
-Unfortunately, ``synchronize_rcu()`` can't do this until all of its
+Unfortunately, synchronize_rcu() can't do this until all of its
 kthreads are spawned, which doesn't happen until some time during
-``early_initcalls()`` time. But this is no excuse: RCU is nevertheless
+early_initcalls() time. But this is no excuse: RCU is nevertheless
 required to correctly handle synchronous grace periods during this time
 period. Once all of its kthreads are up and running, RCU starts running
 normally.
@@ -1820,7 +1820,7 @@ Interrupts and NMIs
 
 The Linux kernel has interrupts, and RCU read-side critical sections are
 legal within interrupt handlers and within interrupt-disabled regions of
-code, as are invocations of ``call_rcu()``.
+code, as are invocations of call_rcu().
 
 Some Linux-kernel architectures can enter an interrupt handler from
 non-idle process context, and then just never leave it, instead
@@ -1832,7 +1832,7 @@ way during a rewrite of RCU's dyntick-idle code.
 
 The Linux kernel has non-maskable interrupts (NMIs), and RCU read-side
 critical sections are legal within NMI handlers. Thankfully, RCU
-update-side primitives, including ``call_rcu()``, are prohibited within
+update-side primitives, including call_rcu(), are prohibited within
 NMI handlers.
 
 The name notwithstanding, some Linux-kernel architectures can have
@@ -1844,10 +1844,10 @@ that meets this requirement.
 
 Furthermore, NMI handlers can be interrupted by what appear to RCU to be
 normal interrupts. One way that this can happen is for code that
-directly invokes ``rcu_irq_enter()`` and ``rcu_irq_exit()`` to be called
+directly invokes rcu_irq_enter() and rcu_irq_exit() to be called
 from an NMI handler. This astonishing fact of life prompted the current
-code structure, which has ``rcu_irq_enter()`` invoking
-``rcu_nmi_enter()`` and ``rcu_irq_exit()`` invoking ``rcu_nmi_exit()``.
+code structure, which has rcu_irq_enter() invoking
+rcu_nmi_enter() and rcu_irq_exit() invoking rcu_nmi_exit().
 And yes, I also learned of this requirement the hard way.
 
 Loadable Modules
@@ -1857,45 +1857,45 @@ The Linux kernel has loadable modules, and these modules can also be
 unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
-functions, for example, any outstanding ``mod_timer()`` must be dealt
-with via ``del_timer_sync()`` or similar.
+functions, for example, any outstanding mod_timer() must be dealt
+with via del_timer_sync() or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
-invoke ``call_rcu()``, the callback function is eventually going to be
+invoke call_rcu(), the callback function is eventually going to be
 invoked, unless the system goes down first. Because it is normally
 considered socially irresponsible to crash the system in response to a
 module unload request, we need some other way to deal with in-flight RCU
 callbacks.
 
-RCU therefore provides ``rcu_barrier()``, which waits until all
+RCU therefore provides rcu_barrier(), which waits until all
 in-flight RCU callbacks have been invoked. If a module uses
-``call_rcu()``, its exit function should therefore prevent any future
-invocation of ``call_rcu()``, then invoke ``rcu_barrier()``. In theory,
-the underlying module-unload code could invoke ``rcu_barrier()``
+call_rcu(), its exit function should therefore prevent any future
+invocation of call_rcu(), then invoke rcu_barrier(). In theory,
+the underlying module-unload code could invoke rcu_barrier()
 unconditionally, but in practice this would incur unacceptable
 latencies.
 
 Nikita Danilov noted this requirement for an analogous
 filesystem-unmount situation, and Dipankar Sarma incorporated
-``rcu_barrier()`` into RCU. The need for ``rcu_barrier()`` for module
+rcu_barrier() into RCU. The need for rcu_barrier() for module
 unloading became apparent later.
 
 .. important::
 
-   The ``rcu_barrier()`` function is not, repeat,
+   The rcu_barrier() function is not, repeat,
    *not*, obligated to wait for a grace period. It is instead only required
    to wait for RCU callbacks that have already been posted. Therefore, if
    there are no RCU callbacks posted anywhere in the system,
-   ``rcu_barrier()`` is within its rights to return immediately. Even if
-   there are callbacks posted, ``rcu_barrier()`` does not necessarily need
+   rcu_barrier() is within its rights to return immediately. Even if
+   there are callbacks posted, rcu_barrier() does not necessarily need
    to wait for a grace period.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
 | Wait a minute! Each RCU callbacks must wait for a grace period to     |
-| complete, and ``rcu_barrier()`` must wait for each pre-existing       |
-| callback to be invoked. Doesn't ``rcu_barrier()`` therefore need to   |
+| complete, and rcu_barrier() must wait for each pre-existing       |
+| callback to be invoked. Doesn't rcu_barrier() therefore need to   |
 | wait for a full grace period if there is even one callback posted     |
 | anywhere in the system?                                               |
 +-----------------------------------------------------------------------+
@@ -1904,14 +1904,14 @@ unloading became apparent later.
 | Absolutely not!!!                                                     |
 | Yes, each RCU callbacks must wait for a grace period to complete, but |
 | it might well be partly (or even completely) finished waiting by the  |
-| time ``rcu_barrier()`` is invoked. In that case, ``rcu_barrier()``    |
+| time rcu_barrier() is invoked. In that case, rcu_barrier()    |
 | need only wait for the remaining portion of the grace period to       |
 | elapse. So even if there are quite a few callbacks posted,            |
-| ``rcu_barrier()`` might well return quite quickly.                    |
+| rcu_barrier() might well return quite quickly.                    |
 |                                                                       |
 | So if you need to wait for a grace period as well as for all          |
 | pre-existing callbacks, you will need to invoke both                  |
-| ``synchronize_rcu()`` and ``rcu_barrier()``. If latency is a concern, |
+| synchronize_rcu() and rcu_barrier(). If latency is a concern, |
 | you can always use workqueues to invoke them concurrently.            |
 +-----------------------------------------------------------------------+
 
@@ -1929,18 +1929,18 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as (``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``).  However, these synchronous operations
+grace-period operations such as (synchronize_rcu() and
+synchronize_rcu_expedited()).  However, these synchronous operations
 do block and therefore cannot be invoked from notifiers that execute via
-``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
+stop_machine(), specifically those between the ``CPUHP_AP_OFFLINE``
 and ``CPUHP_AP_ONLINE`` states.
 
-In addition, all-callback-wait operations such as ``rcu_barrier()`` may
+In addition, all-callback-wait operations such as rcu_barrier() may
 not be invoked from any CPU-hotplug notifier.  This restriction is due
 to the fact that there are phases of CPU-hotplug operations where the
 outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
 operation ends, which could also result in deadlock. Furthermore,
-``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
+rcu_barrier() blocks CPU-hotplug operations during its execution,
 which results in another type of deadlock when invoked from a CPU-hotplug
 notifier.
 
@@ -1955,12 +1955,12 @@ if offline CPUs block an RCU grace period for too long.
 
 An offline CPU's quiescent state will be reported either:
 
-1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
-2.  When grace period initialization (``rcu_gp_init()``) detects a
+1.  As the CPU goes offline using RCU's hotplug notifier (rcu_report_dead()).
+2.  When grace period initialization (rcu_gp_init()) detects a
     race either with CPU offlining or with a task unblocking on a leaf
     ``rcu_node`` structure whose CPUs are all offline.
 
-The CPU-online path (``rcu_cpu_starting()``) should never need to report
+The CPU-online path (rcu_cpu_starting()) should never need to report
 a quiescent state for an offline CPU.  However, as a debugging measure,
 it does emit a warning if a quiescent state was not already reported
 for that CPU.
@@ -1984,11 +1984,11 @@ room for further improvement.
 
 There is no longer any prohibition against holding any of
 scheduler's runqueue or priority-inheritance spinlocks across an
-``rcu_read_unlock()``, even if interrupts and preemption were enabled
+rcu_read_unlock(), even if interrupts and preemption were enabled
 somewhere within the corresponding RCU read-side critical section.
-Therefore, it is now perfectly legal to execute ``rcu_read_lock()``
+Therefore, it is now perfectly legal to execute rcu_read_lock()
 with preemption enabled, acquire one of the scheduler locks, and hold
-that lock across the matching ``rcu_read_unlock()``.
+that lock across the matching rcu_read_unlock().
 
 Similarly, the RCU flavor consolidation has removed the need for negative
 nesting.  The fact that interrupt-disabled regions of code act as RCU
@@ -1999,7 +1999,7 @@ Tracing and RCU
 ~~~~~~~~~~~~~~~
 
 It is possible to use tracing on RCU code, but tracing itself uses RCU.
-For this reason, ``rcu_dereference_raw_check()`` is provided for use
+For this reason, rcu_dereference_raw_check() is provided for use
 by tracing, which avoids the destructive recursion that could otherwise
 ensue. This API is also used by virtualization in some architectures,
 where RCU readers execute in environments in which tracing cannot be
@@ -2010,12 +2010,12 @@ Accesses to User Memory and RCU
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The kernel needs to access user-space memory, for example, to access data
-referenced by system-call parameters.  The ``get_user()`` macro does this job.
+referenced by system-call parameters.  The get_user() macro does this job.
 
 However, user-space memory might well be paged out, which means that
-``get_user()`` might well page-fault and thus block while waiting for the
+get_user() might well page-fault and thus block while waiting for the
 resulting I/O to complete.  It would be a very bad thing for the compiler to
-reorder a ``get_user()`` invocation into an RCU read-side critical section.
+reorder a get_user() invocation into an RCU read-side critical section.
 
 For example, suppose that the source code looked like this:
 
@@ -2041,22 +2041,22 @@ the following:
        6 do_something_with(v, user_v);
 
 If the compiler did make this transformation in a ``CONFIG_PREEMPT=n`` kernel
-build, and if ``get_user()`` did page fault, the result would be a quiescent
+build, and if get_user() did page fault, the result would be a quiescent
 state in the middle of an RCU read-side critical section.  This misplaced
 quiescent state could result in line 4 being a use-after-free access,
 which could be bad for your kernel's actuarial statistics.  Similar examples
-can be constructed with the call to ``get_user()`` preceding the
-``rcu_read_lock()``.
+can be constructed with the call to get_user() preceding the
+rcu_read_lock().
 
-Unfortunately, ``get_user()`` doesn't have any particular ordering properties,
+Unfortunately, get_user() doesn't have any particular ordering properties,
 and in some architectures the underlying ``asm`` isn't even marked
 ``volatile``.  And even if it was marked ``volatile``, the above access to
 ``p->value`` is not volatile, so the compiler would not have any reason to keep
 those two accesses in order.
 
-Therefore, the Linux-kernel definitions of ``rcu_read_lock()`` and
-``rcu_read_unlock()`` must act as compiler barriers, at least for outermost
-instances of ``rcu_read_lock()`` and ``rcu_read_unlock()`` within a nested set
+Therefore, the Linux-kernel definitions of rcu_read_lock() and
+rcu_read_unlock() must act as compiler barriers, at least for outermost
+instances of rcu_read_lock() and rcu_read_unlock() within a nested set
 of RCU read-side critical sections.
 
 Energy Efficiency
@@ -2071,26 +2071,26 @@ call.
 
 Because RCU avoids interrupting idle CPUs, it is illegal to execute an
 RCU read-side critical section on an idle CPU. (Kernels built with
-``CONFIG_PROVE_RCU=y`` will splat if you try it.) The ``RCU_NONIDLE()``
+``CONFIG_PROVE_RCU=y`` will splat if you try it.) The RCU_NONIDLE()
 macro and ``_rcuidle`` event tracing is provided to work around this
-restriction. In addition, ``rcu_is_watching()`` may be used to test
+restriction. In addition, rcu_is_watching() may be used to test
 whether or not it is currently legal to run RCU read-side critical
 sections on this CPU. I learned of the need for diagnostics on the one
-hand and ``RCU_NONIDLE()`` on the other while inspecting idle-loop code.
+hand and RCU_NONIDLE() on the other while inspecting idle-loop code.
 Steven Rostedt supplied ``_rcuidle`` event tracing, which is used quite
 heavily in the idle loop. However, there are some restrictions on the
-code placed within ``RCU_NONIDLE()``:
+code placed within RCU_NONIDLE():
 
 #. Blocking is prohibited. In practice, this is not a serious
    restriction given that idle tasks are prohibited from blocking to
    begin with.
-#. Although nesting ``RCU_NONIDLE()`` is permitted, they cannot nest
+#. Although nesting RCU_NONIDLE() is permitted, they cannot nest
    indefinitely deeply. However, given that they can be nested on the
    order of a million deep, even on 32-bit systems, this should not be a
    serious restriction. This nesting limit would probably be reached
    long after the compiler OOMed or the stack overflowed.
-#. Any code path that enters ``RCU_NONIDLE()`` must sequence out of that
-   same ``RCU_NONIDLE()``. For example, the following is grossly
+#. Any code path that enters RCU_NONIDLE() must sequence out of that
+   same RCU_NONIDLE(). For example, the following is grossly
    illegal:
 
       ::
@@ -2103,7 +2103,7 @@ code placed within ``RCU_NONIDLE()``:
 
 
    It is just as illegal to transfer control into the middle of
-   ``RCU_NONIDLE()``'s argument. Yes, in theory, you could transfer in
+   RCU_NONIDLE()'s argument. Yes, in theory, you could transfer in
    as long as you also transferred out, but in practice you could also
    expect to get sharply worded review comments.
 
@@ -2195,9 +2195,9 @@ scheduling-clock interrupt be enabled when RCU needs it to be:
    sections, and RCU believes this CPU to be idle, no problem. This
    sort of thing is used by some architectures for light-weight
    exception handlers, which can then avoid the overhead of
-   ``rcu_irq_enter()`` and ``rcu_irq_exit()`` at exception entry and
+   rcu_irq_enter() and rcu_irq_exit() at exception entry and
    exit, respectively. Some go further and avoid the entireties of
-   ``irq_enter()`` and ``irq_exit()``.
+   irq_enter() and irq_exit().
    Just make very sure you are running some of your tests with
    ``CONFIG_PROVE_RCU=y``, just in case one of your code paths was in
    fact joking about not doing RCU read-side critical sections.
@@ -2221,7 +2221,7 @@ scheduling-clock interrupt be enabled when RCU needs it to be:
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
 | But what if my driver has a hardware interrupt handler that can run   |
-| for many seconds? I cannot invoke ``schedule()`` from an hardware     |
+| for many seconds? I cannot invoke schedule() from an hardware     |
 | interrupt handler, after all!                                         |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
@@ -2243,8 +2243,8 @@ Memory Efficiency
 
 Although small-memory non-realtime systems can simply use Tiny RCU, code
 size is only one aspect of memory efficiency. Another aspect is the size
-of the ``rcu_head`` structure used by ``call_rcu()`` and
-``kfree_rcu()``. Although this structure contains nothing more than a
+of the ``rcu_head`` structure used by call_rcu() and
+kfree_rcu(). Although this structure contains nothing more than a
 pair of pointers, it does appear in many RCU-protected data structures,
 including some that are size critical. The ``page`` structure is a case
 in point, as evidenced by the many occurrences of the ``union`` keyword
@@ -2254,7 +2254,7 @@ This need for memory efficiency is one reason that RCU uses hand-crafted
 singly linked lists to track the ``rcu_head`` structures that are
 waiting for a grace period to elapse. It is also the reason why
 ``rcu_head`` structures do not contain debug information, such as fields
-tracking the file and line of the ``call_rcu()`` or ``kfree_rcu()`` that
+tracking the file and line of the call_rcu() or kfree_rcu() that
 posted them. Although this information might appear in debug-only kernel
 builds at some point, in the meantime, the ``->func`` field will often
 provide the needed debug information.
@@ -2268,14 +2268,14 @@ conditions <https://lkml.kernel.org/g/1439976106-137226-1-git-send-email-kirill.
 the Linux kernel's memory-management subsystem needs a particular bit to
 remain zero during all phases of grace-period processing, and that bit
 happens to map to the bottom bit of the ``rcu_head`` structure's
-``->next`` field. RCU makes this guarantee as long as ``call_rcu()`` is
-used to post the callback, as opposed to ``kfree_rcu()`` or some future
-“lazy” variant of ``call_rcu()`` that might one day be created for
+``->next`` field. RCU makes this guarantee as long as call_rcu() is
+used to post the callback, as opposed to kfree_rcu() or some future
+“lazy” variant of call_rcu() that might one day be created for
 energy-efficiency purposes.
 
 That said, there are limits. RCU requires that the ``rcu_head``
 structure be aligned to a two-byte boundary, and passing a misaligned
-``rcu_head`` structure to one of the ``call_rcu()`` family of functions
+``rcu_head`` structure to one of the call_rcu() family of functions
 will result in a splat. It is therefore necessary to exercise caution
 when packing structures containing fields of type ``rcu_head``. Why not
 a four-byte or even eight-byte alignment requirement? Because the m68k
@@ -2299,7 +2299,7 @@ hot code paths in performance-critical portions of the Linux kernel's
 networking, security, virtualization, and scheduling code paths. RCU
 must therefore use efficient implementations, especially in its
 read-side primitives. To that end, it would be good if preemptible RCU's
-implementation of ``rcu_read_lock()`` could be inlined, however, doing
+implementation of rcu_read_lock() could be inlined, however, doing
 this requires resolving ``#include`` issues with the ``task_struct``
 structure.
 
@@ -2312,8 +2312,8 @@ on the ``rcu_node`` structure. RCU is required to tolerate all CPUs
 continuously invoking any combination of RCU's runtime primitives with
 minimal per-operation overhead. In fact, in many cases, increasing load
 must *decrease* the per-operation overhead, witness the batching
-optimizations for ``synchronize_rcu()``, ``call_rcu()``,
-``synchronize_rcu_expedited()``, and ``rcu_barrier()``. As a general
+optimizations for synchronize_rcu(), call_rcu(),
+synchronize_rcu_expedited(), and rcu_barrier(). As a general
 rule, RCU must cheerfully accept whatever the rest of the Linux kernel
 decides to throw at it.
 
@@ -2346,7 +2346,7 @@ number of race conditions.
 RCU must avoid degrading real-time response for CPU-bound threads,
 whether executing in usermode (which is one use case for
 ``CONFIG_NO_HZ_FULL=y``) or in the kernel. That said, CPU-bound loops in
-the kernel must execute ``cond_resched()`` at least once per few tens of
+the kernel must execute cond_resched() at least once per few tens of
 milliseconds in order to avoid receiving an IPI from RCU.
 
 Finally, RCU's status as a synchronization primitive means that any RCU
@@ -2412,7 +2412,7 @@ grace periods from ever ending. The result was an out-of-memory
 condition and a system hang.
 
 The solution was the creation of RCU-bh, which does
-``local_bh_disable()`` across its read-side critical sections, and which
+local_bh_disable() across its read-side critical sections, and which
 uses the transition from one type of softirq processing to another as a
 quiescent state in addition to context switch, idle, user mode, and
 offline. This means that RCU-bh grace periods can complete even when
@@ -2420,29 +2420,29 @@ some of the CPUs execute in softirq indefinitely, thus allowing
 algorithms based on RCU-bh to withstand network-based denial-of-service
 attacks.
 
-Because ``rcu_read_lock_bh()`` and ``rcu_read_unlock_bh()`` disable and
+Because rcu_read_lock_bh() and rcu_read_unlock_bh() disable and
 re-enable softirq handlers, any attempt to start a softirq handlers
 during the RCU-bh read-side critical section will be deferred. In this
-case, ``rcu_read_unlock_bh()`` will invoke softirq processing, which can
+case, rcu_read_unlock_bh() will invoke softirq processing, which can
 take considerable time. One can of course argue that this softirq
 overhead should be associated with the code following the RCU-bh
-read-side critical section rather than ``rcu_read_unlock_bh()``, but the
+read-side critical section rather than rcu_read_unlock_bh(), but the
 fact is that most profiling tools cannot be expected to make this sort
 of fine distinction. For example, suppose that a three-millisecond-long
 RCU-bh read-side critical section executes during a time of heavy
 networking load. There will very likely be an attempt to invoke at least
 one softirq handler during that three milliseconds, but any such
 invocation will be delayed until the time of the
-``rcu_read_unlock_bh()``. This can of course make it appear at first
-glance as if ``rcu_read_unlock_bh()`` was executing very slowly.
+rcu_read_unlock_bh(). This can of course make it appear at first
+glance as if rcu_read_unlock_bh() was executing very slowly.
 
 The `RCU-bh
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes ``rcu_read_lock_bh()``, ``rcu_read_unlock_bh()``,
-``rcu_dereference_bh()``, ``rcu_dereference_bh_check()``,
-``synchronize_rcu_bh()``, ``synchronize_rcu_bh_expedited()``,
-``call_rcu_bh()``, ``rcu_barrier_bh()``, and
-``rcu_read_lock_bh_held()``. However, the update-side APIs are now
+includes rcu_read_lock_bh(), rcu_read_unlock_bh(),
+rcu_dereference_bh(), rcu_dereference_bh_check(),
+synchronize_rcu_bh(), synchronize_rcu_bh_expedited(),
+call_rcu_bh(), rcu_barrier_bh(), and
+rcu_read_lock_bh_held(). However, the update-side APIs are now
 simple wrappers for other RCU flavors, namely RCU-sched in
 CONFIG_PREEMPT=n kernels and RCU-preempt otherwise.
 
@@ -2467,27 +2467,27 @@ RCU-sched APIs have identical implementations, while kernels built with
 ``CONFIG_PREEMPT=y`` provide a separate implementation for each.
 
 Note well that in ``CONFIG_PREEMPT=y`` kernels,
-``rcu_read_lock_sched()`` and ``rcu_read_unlock_sched()`` disable and
+rcu_read_lock_sched() and rcu_read_unlock_sched() disable and
 re-enable preemption, respectively. This means that if there was a
 preemption attempt during the RCU-sched read-side critical section,
-``rcu_read_unlock_sched()`` will enter the scheduler, with all the
-latency and overhead entailed. Just as with ``rcu_read_unlock_bh()``,
-this can make it look as if ``rcu_read_unlock_sched()`` was executing
+rcu_read_unlock_sched() will enter the scheduler, with all the
+latency and overhead entailed. Just as with rcu_read_unlock_bh(),
+this can make it look as if rcu_read_unlock_sched() was executing
 very slowly. However, the highest-priority task won't be preempted, so
-that task will enjoy low-overhead ``rcu_read_unlock_sched()``
+that task will enjoy low-overhead rcu_read_unlock_sched()
 invocations.
 
 The `RCU-sched
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes ``rcu_read_lock_sched()``, ``rcu_read_unlock_sched()``,
-``rcu_read_lock_sched_notrace()``, ``rcu_read_unlock_sched_notrace()``,
-``rcu_dereference_sched()``, ``rcu_dereference_sched_check()``,
-``synchronize_sched()``, ``synchronize_rcu_sched_expedited()``,
-``call_rcu_sched()``, ``rcu_barrier_sched()``, and
-``rcu_read_lock_sched_held()``. However, anything that disables
+includes rcu_read_lock_sched(), rcu_read_unlock_sched(),
+rcu_read_lock_sched_notrace(), rcu_read_unlock_sched_notrace(),
+rcu_dereference_sched(), rcu_dereference_sched_check(),
+synchronize_sched(), synchronize_rcu_sched_expedited(),
+call_rcu_sched(), rcu_barrier_sched(), and
+rcu_read_lock_sched_held(). However, anything that disables
 preemption also marks an RCU-sched read-side critical section, including
-``preempt_disable()`` and ``preempt_enable()``, ``local_irq_save()`` and
-``local_irq_restore()``, and so on.
+preempt_disable() and preempt_enable(), local_irq_save() and
+local_irq_restore(), and so on.
 
 Sleepable RCU
 ~~~~~~~~~~~~~
@@ -2509,7 +2509,7 @@ this structure must be passed in to each SRCU function, for example,
 structure. The key benefit of these domains is that a slow SRCU reader
 in one domain does not delay an SRCU grace period in some other domain.
 That said, one consequence of these domains is that read-side code must
-pass a “cookie” from ``srcu_read_lock()`` to ``srcu_read_unlock()``, for
+pass a “cookie” from srcu_read_lock() to srcu_read_unlock(), for
 example, as follows:
 
    ::
@@ -2539,24 +2539,24 @@ period to elapse. For example, this results in a self-deadlock:
        6 srcu_read_unlock(&ss, idx);
 
 However, if line 5 acquired a mutex that was held across a
-``synchronize_srcu()`` for domain ``ss``, deadlock would still be
+synchronize_srcu() for domain ``ss``, deadlock would still be
 possible. Furthermore, if line 5 acquired a mutex that was held across a
-``synchronize_srcu()`` for some other domain ``ss1``, and if an
+synchronize_srcu() for some other domain ``ss1``, and if an
 ``ss1``-domain SRCU read-side critical section acquired another mutex
-that was held across as ``ss``-domain ``synchronize_srcu()``, deadlock
+that was held across as ``ss``-domain synchronize_srcu(), deadlock
 would again be possible. Such a deadlock cycle could extend across an
 arbitrarily large number of different SRCU domains. Again, with great
 power comes great responsibility.
 
 Unlike the other RCU flavors, SRCU read-side critical sections can run
 on idle and even offline CPUs. This ability requires that
-``srcu_read_lock()`` and ``srcu_read_unlock()`` contain memory barriers,
+srcu_read_lock() and srcu_read_unlock() contain memory barriers,
 which means that SRCU readers will run a bit slower than would RCU
-readers. It also motivates the ``smp_mb__after_srcu_read_unlock()`` API,
-which, in combination with ``srcu_read_unlock()``, guarantees a full
+readers. It also motivates the smp_mb__after_srcu_read_unlock() API,
+which, in combination with srcu_read_unlock(), guarantees a full
 memory barrier.
 
-Also unlike other RCU flavors, ``synchronize_srcu()`` may **not** be
+Also unlike other RCU flavors, synchronize_srcu() may **not** be
 invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
 periods make use of timers and the possibility of timers being
 temporarily “stranded” on the outgoing CPU. This stranding of timers
@@ -2565,7 +2565,7 @@ the CPU-hotplug process. The problem is that if a notifier is waiting on
 an SRCU grace period, that grace period is waiting on a timer, and that
 timer is stranded on the outgoing CPU, then the notifier will never be
 awakened, in other words, deadlock has occurred. This same situation of
-course also prohibits ``srcu_barrier()`` from being invoked from
+course also prohibits srcu_barrier() from being invoked from
 CPU-hotplug notifiers.
 
 SRCU also differs from other RCU flavors in that SRCU's expedited and
@@ -2576,12 +2576,12 @@ have not yet completed. (But please note that this is a property of the
 current implementation, not necessarily of future implementations.) In
 addition, if SRCU has been idle for longer than the interval specified
 by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
-by default), and if a ``synchronize_srcu()`` invocation ends this idle
+by default), and if a synchronize_srcu() invocation ends this idle
 period, that invocation will be automatically expedited.
 
 As of v4.12, SRCU's callbacks are maintained per-CPU, eliminating a
 locking bottleneck present in prior kernel versions. Although this will
-allow users to put much heavier stress on ``call_srcu()``, it is
+allow users to put much heavier stress on call_srcu(), it is
 important to note that SRCU does not yet take any special steps to deal
 with callback flooding. So if you are posting (say) 10,000 SRCU
 callbacks per second per CPU, you are probably totally OK, but if you
@@ -2592,12 +2592,12 @@ of your CPUs and the size of your memory.
 
 The `SRCU
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes ``srcu_read_lock()``, ``srcu_read_unlock()``,
-``srcu_dereference()``, ``srcu_dereference_check()``,
-``synchronize_srcu()``, ``synchronize_srcu_expedited()``,
-``call_srcu()``, ``srcu_barrier()``, and ``srcu_read_lock_held()``. It
-also includes ``DEFINE_SRCU()``, ``DEFINE_STATIC_SRCU()``, and
-``init_srcu_struct()`` APIs for defining and initializing
+includes srcu_read_lock(), srcu_read_unlock(),
+srcu_dereference(), srcu_dereference_check(),
+synchronize_srcu(), synchronize_srcu_expedited(),
+call_srcu(), srcu_barrier(), and srcu_read_lock_held(). It
+also includes DEFINE_SRCU(), DEFINE_STATIC_SRCU(), and
+init_srcu_struct() APIs for defining and initializing
 ``srcu_struct`` structures.
 
 Tasks RCU
@@ -2608,11 +2608,11 @@ required to install different types of probes. It would be good to be
 able to free old trampolines, which sounds like a job for some form of
 RCU. However, because it is necessary to be able to install a trace
 anywhere in the code, it is not possible to use read-side markers such
-as ``rcu_read_lock()`` and ``rcu_read_unlock()``. In addition, it does
+as rcu_read_lock() and rcu_read_unlock(). In addition, it does
 not work to have these markers in the trampoline itself, because there
-would need to be instructions following ``rcu_read_unlock()``. Although
-``synchronize_rcu()`` would guarantee that execution reached the
-``rcu_read_unlock()``, it would not be able to guarantee that execution
+would need to be instructions following rcu_read_unlock(). Although
+synchronize_rcu() would guarantee that execution reached the
+rcu_read_unlock(), it would not be able to guarantee that execution
 had completely left the trampoline. Worse yet, in some situations
 the trampoline's protection must extend a few instructions *prior* to
 execution reaching the trampoline.  For example, these few instructions
@@ -2623,15 +2623,15 @@ actually reached the trampoline itself.
 The solution, in the form of `Tasks
 RCU <https://lwn.net/Articles/607117/>`__, is to have implicit read-side
 critical sections that are delimited by voluntary context switches, that
-is, calls to ``schedule()``, ``cond_resched()``, and
-``synchronize_rcu_tasks()``. In addition, transitions to and from
+is, calls to schedule(), cond_resched(), and
+synchronize_rcu_tasks(). In addition, transitions to and from
 userspace execution also delimit tasks-RCU read-side critical sections.
 
 The tasks-RCU API is quite compact, consisting only of
-``call_rcu_tasks()``, ``synchronize_rcu_tasks()``, and
-``rcu_barrier_tasks()``. In ``CONFIG_PREEMPT=n`` kernels, trampolines
-cannot be preempted, so these APIs map to ``call_rcu()``,
-``synchronize_rcu()``, and ``rcu_barrier()``, respectively. In
+call_rcu_tasks(), synchronize_rcu_tasks(), and
+rcu_barrier_tasks(). In ``CONFIG_PREEMPT=n`` kernels, trampolines
+cannot be preempted, so these APIs map to call_rcu(),
+synchronize_rcu(), and rcu_barrier(), respectively. In
 ``CONFIG_PREEMPT=y`` kernels, trampolines can be preempted, and these
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
@@ -2646,8 +2646,8 @@ grace-period state machine so as to avoid the need for the additional
 latency.
 
 RCU disables CPU hotplug in a few places, perhaps most notably in the
-``rcu_barrier()`` operations. If there is a strong reason to use
-``rcu_barrier()`` in CPU-hotplug notifiers, it will be necessary to
+rcu_barrier() operations. If there is a strong reason to use
+rcu_barrier() in CPU-hotplug notifiers, it will be necessary to
 avoid disabling CPU hotplug. This would introduce some complexity, so
 there had better be a *very* good reason.
 
@@ -2664,7 +2664,7 @@ However, this combining tree does not spread its memory across NUMA
 nodes nor does it align the CPU groups with hardware features such as
 sockets or cores. Such spreading and alignment is currently believed to
 be unnecessary because the hotpath read-side primitives do not access
-the combining tree, nor does ``call_rcu()`` in the common case. If you
+the combining tree, nor does call_rcu() in the common case. If you
 believe that your architecture needs such spreading and alignment, then
 your architecture should also benefit from the
 ``rcutree.rcu_fanout_leaf`` boot parameter, which can be set to the
@@ -2685,7 +2685,7 @@ likely that adjustments will be required to more gracefully handle
 extreme loads. It might also be necessary to be able to relate CPU
 utilization by RCU's kthreads and softirq handlers to the code that
 instigated this CPU utilization. For example, RCU callback overhead
-might be charged back to the originating ``call_rcu()`` instance, though
+might be charged back to the originating call_rcu() instance, though
 probably not in production kernels.
 
 Additional work may be required to provide reasonable forward-progress
