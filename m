Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C425145FE8;
	Sat,  5 Apr 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743880198; cv=none; b=lQ/h6xCGlrvDwU7sRsbV4c7q2LnuAh2zd8BtCA2yFhikKlh6rMRxkFCOvj1lXeelq4tIO9Vg0Dk43+r9O543TMq1sQLiPBzOYMMzZAVSD14rsjzBLFw4/lFTqMkuMpK8NBfhFCRkKVTAcNGy5RtAbQwxsuaxg9//UjJ4XtR+pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743880198; c=relaxed/simple;
	bh=OauDZOuslXTCYnl130mst/mTqaCXUcMHb7UAgFIjc3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTLDWho5Y9NKcerh2/2iUuQtcbu4Xje9fg6aiv2swR2n5mAiiCoRlza6lrv91PNlfLLB2bl3Mm8uA/pXlJh2TE2YzXtWen45PpwbKGza7kzf6mSISxO2pEZ4Mk7U6Ica+hIMWdwtvldrR3wOXjboCdljT7Wf9GET4Bl0fgK30Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JInR5ldy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JInR5ldy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F46C4CEE4;
	Sat,  5 Apr 2025 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743880196;
	bh=OauDZOuslXTCYnl130mst/mTqaCXUcMHb7UAgFIjc3c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JInR5ldy8Cy9DqV4wHRfRSKA2yuknZxamwx/TO6wOIVi2FvGJI350oO82HRX8xu3f
	 ziDNIx0e0hIojFB/IA+7zuSce7ZmuWI/jy4mGdcivH77z6QA9k6pjbHpAkNYKlpfnE
	 ijyoLnQNCorRdmTPMUoUuSVzpopANP4vX6YobL9GWX8DTjcZaLn+44ivm4YirDQurA
	 6H59MatRLppL6caQQmF2OLyyEP6k2Xuzga8x8gjYvP6mRBgOZHnWIZLgxfdL1svRR5
	 6OUaplX/VUTl7imiPjGmTQmAUnbINOEqoPaR2l0+srDfLFXK3ciTaNkkbFMCa7fG2f
	 5abQlgngIiZ/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50F24CE0565; Sat,  5 Apr 2025 12:09:56 -0700 (PDT)
Date: Sat, 5 Apr 2025 12:09:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <616886d9-2511-4f4e-bd64-c1500b4104bf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c9c19caa-68c1-4012-bd82-38a24c9edb60@paulmck-laptop>
 <174385625883.111.5710608020798879272@patchwork.local>
 <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
 <9707440F-315F-4A33-8EEC-DDAC86538264@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9707440F-315F-4A33-8EEC-DDAC86538264@nvidia.com>

On Sat, Apr 05, 2025 at 05:54:00PM +0000, Joel Fernandes wrote:
> > On Apr 5, 2025, at 1:23 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Sat, Apr 05, 2025 at 12:30:58PM -0000, Joel Fernandes wrote:
> >> Hello, Paul,
> >> 
> >>> On Sat, 5 Apr 2025 12:26:12 GMT, "Paul E. McKenney" wrote:
> >>> On Sat, Mar 29, 2025 at 07:01:42PM -0400, Joel Fernandes wrote:
> >>>> Currently, the ->gpwrap is not tested (at all per my testing) due to the
> >>>> requirement of a large delta between a CPU's rdp->gp_seq and its node's
> >>>> rnp->gpseq.
> >>>> 
> >>>> This results in no testing of ->gpwrap being set. This patch by default
> >>>> adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> >>>> between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> >>>> configurable, including the active time for the setting and a full
> >>>> testing cycle.
> >>>> 
> >>>> By default, the first 25 minutes of a test will have the _default_
> >>>> behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> >>>> we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> >>>> this is reasonable since we at least add a little bit of testing for
> >>>> usecases where ->gpwrap is set.
> >>>> 
> >>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>> 
> >>> I ran this as follows:
> >>> 
> >>> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10m --configs "TREE01" --bootargs "rcutorture.ovf_cycle_mins=7" --trust-make
> >>> 
> >>> Once I actually applied your patch, I did get this:
> >>> 
> >>> [  601.891042] gpwraps: 13745
> >>> 
> >>> Which seems to indicate some testing.  ;-)
> >> 
> >> Thanks a lot for running it. I am wondering if I should check in tree.c (only in
> >> testing mode), if the wraps are too many and restrict testing if so. Otherwise,
> >> it is hard to come up with a constant that ensures the wraps are under control.
> >> On the other hand, since this is only for 5 minutes every 30 minutes, we can leave
> >> it as is and avoid the complexity.
> > 
> > I don't (yet) see a problem with lots of wraps.
> > 
> >>> Additional comments inline.
> >>> 
> >>>                            Thanx, Paul
> >>> 
> >>>> ---
> >>>> kernel/rcu/rcu.h        |  4 +++
> >>>> kernel/rcu/rcutorture.c | 64 +++++++++++++++++++++++++++++++++++++++++
> >>>> kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
> >>>> kernel/rcu/tree.h       |  1 +
> >>>> 4 files changed, 101 insertions(+), 2 deletions(-)
> >>>> 
> >>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >>>> index eed2951a4962..9a15e9701e02 100644
> >>>> --- a/kernel/rcu/rcu.h
> >>>> +++ b/kernel/rcu/rcu.h
> >>>> @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >>>>                   unsigned long c_old,
> >>>>                   unsigned long c);
> >>>> void rcu_gp_set_torture_wait(int duration);
> >>>> +void rcu_set_torture_ovf_lag(unsigned long lag);
> >>>> +int rcu_get_gpwrap_count(int cpu);
> >>>> #else
> >>>> static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> >>>> {
> >>>> @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >>>>    do { } while (0)
> >>>> #endif
> >>>> static inline void rcu_gp_set_torture_wait(int duration) { }
> >>>> +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> >>>> +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> >>> 
> >>> Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)
> >>> 
> >>> But shouldn't these be function pointers in rcu_torture_ops?  That way if
> >>> some other flavor of RCU starts doing wrap protection for its grace-period
> >>> sequence numbers, this testing can apply directly to that flavor as well.
> >> 
> >> These are here because 'rdp' is not accessible AFAIK from rcutorture.c.
> >> I could add wrappers to these and include them as pointers the a struct as well.
> >> But I think these will still stay to access rdp.
> > 
> > Why not just pass in the CPU number and let the pointed-to function find
> > the rdp?
> 
> You mean provide a helper from tree.c that is called in rcutorture, then helper function returning an rdp?
> 
> If so, I can certainly do that, was just not sure if this sort of thing was ok since nothing else in rcutorture accesses rdp directly :)

Actually, this is done quite a bit.

For example, the "rcu" .gp_kthread_dbg() function pointer is set to
show_rcu_gp_kthreads(), which is defined either in rcu.h (for Tiny) or
in tree_stall.h (for Tree).  Alternatively, sometimes a small wrapper
function is defined in rcutorture.c which calls functions defined
differently for different RCU flavors.

So please feel free to create a function pointer and to define the
function in tree.c.  But learn from my many mistakes and make sure to
provide a suitable definition for Tiny RCU!  ;-)

							Thanx, Paul

> Thanks,
> 
> - Joel
> 
> 
> > 
> >>> Then the pointers can simply be NULL in kernels built with CONFIG_SMP=n.
> >>> 
> >>>> #endif
> >>>> unsigned long long rcutorture_gather_gp_seqs(void);
> >>>> void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> >>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >>>> index 895a27545ae1..79a72e70913e 100644
> >>>> --- a/kernel/rcu/rcutorture.c
> >>>> +++ b/kernel/rcu/rcutorture.c
> >>>> @@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
> >>>> torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> >>>> torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
> >>>> torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> >>>> +torture_param(int, ovf_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> >>>> +torture_param(int, ovf_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> >>>> +torture_param(int, ovf_lag_gps, 8, "Value to set for set_torture_ovf_lag during an active testing period.");
> >>> 
> >>> Given that "ovf" means just "overflow", would it make sense to get a "gp"
> >>> in there?  Maybe just "gpwrap_..."?
> >>> 
> >>> "What is in a name?"  ;-)
> >> 
> >> Sure, makes sense I will rename.
> > 
> > Thank you!
> > 
> >>> I could argue with the defaults, but I run long tests often enough that
> >>> I am not worried about coverage.  As long as we remember to either run
> >>> long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
> >>> with ->gpwrap code.
> >>> 
> >>>> torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
> >>>> torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> >>>> torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> >>>> @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
> >>>>    int i;
> >>>>    long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> >>>>    long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> >>>> +    long n_gpwraps = 0;
> >>>>    struct rcu_torture *rtcp;
> >>>>    static unsigned long rtcv_snap = ULONG_MAX;
> >>>>    static bool splatted;
> >>>> @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
> >>>>            pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> >>>>            batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> >>>>        }
> >>>> +        n_gpwraps += rcu_get_gpwrap_count(cpu);
> >>>>    }
> >>>>    for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> >>>>        if (pipesummary[i] != 0)
> >>>> @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
> >>>>    pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> >>>>    pr_cont("nocb-toggles: %ld:%ld\n",
> >>> 
> >>> The "\n" on the above line needs to be deleted.
> >> 
> >> Ok.
> >> 
> >>>>        atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> >>>> +    pr_cont("gpwraps: %ld\n", n_gpwraps);
> >>>> 
> >>>>    pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> >>>>    if (atomic_read(&n_rcu_torture_mberror) ||
> >>>> @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
> >>>> 
> >>>> static enum cpuhp_state rcutor_hp;
> >>>> 
> >>>> +static struct hrtimer ovf_lag_timer;
> >>>> +static bool ovf_lag_active;
> >>> 
> >>> Same "ovf" naming complaint as before.
> >> 
> >> Ok.
> >> 
> >>>> +}
> >>>> +
> >>>> +static int rcu_torture_ovf_lag_init(void)
> >>>> +{
> >>>> +    if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> >>>> +        pr_alert("rcu-torture: lag timing parameters must be positive\n");
> >>>> +        return -EINVAL;
> >>>> +    }
> >>> 
> >>> Why not refuse to start this portion of the test when testing CONFIG_SMP=n
> >>> or something other than vanilla RCU?  No need to fail the test, just
> >>> print something saying that this testing won't be happening.
> >> 
> >> Got it, will do.
> > 
> > Again, thank you!
> > 
> >>>> +static void rcu_torture_ovf_lag_cleanup(void)
> >>>> +{
> >>>> +    hrtimer_cancel(&ovf_lag_timer);
> >>>> +
> >>>> +    if (ovf_lag_active) {
> >>>> +        rcu_set_torture_ovf_lag(0);
> >>>> +        ovf_lag_active = false;
> >>>> +    }
> >>>> +}
> >>> 
> >>> Did you try the modprobe/rmmod testing to verify that this
> >>> cleans up appropriately?  You could use the drgn tool to check.
> >>> See tools/rcu//rcu-cbs.py for an example drgn script that digs into the
> >>> rcu_data structures.
> >> 
> >> Nice, will check!
> >> 
> >> Will work on this and provide v2.
> > 
> > Looking forward to it!
> > 
> >                            Thanx, Paul
