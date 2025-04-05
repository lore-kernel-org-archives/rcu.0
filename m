Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DD22EE5;
	Sat,  5 Apr 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873778; cv=none; b=U67eoN2TNha1zQG4cIAg4CgH+lja2kVL5yRjTEepglxEoIIksA8iGopTucuwxy+SnE2tLqUbPcy4M7amw39ER30GyEjfyIYifIEU2ExvlISIfnbl18V9lPOOmJ5IbonJj8YQkqt+1M1Mpq/7zswax9uVI0x5HBpPacs6SzpBHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873778; c=relaxed/simple;
	bh=/HGdFkBDHweEqKtwu/S3Nr9JZY3SsjylPP69MMb0PyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz86ZqEzdGxS6XZ83jNGVVVBj0QXwveX+hAKHZ/nWyN77Omvs2DW/KV0Z6DuUfgy2YRGVGk9DX7Ur/0r4NikomuGBgZbT+wIW4fupMiPMrjFEw8/JekFA1cm5m2q+x/fVtn5fZWEMI3X/YWH8IwH6ZbEj85W8Rcq5U//egWq42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRq48dN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRq48dN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B864C4CEE4;
	Sat,  5 Apr 2025 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743873777;
	bh=/HGdFkBDHweEqKtwu/S3Nr9JZY3SsjylPP69MMb0PyI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YRq48dN7hmlzLxwibllkQyLQyMDy/hAWllDcO/9qb5V7sd6mIUpEjUYKc+oGjrr5R
	 a1+bhfAGXA0FFvD8XZEgjIQuu7e68L6JFX6QknPahDRMuTtlbAs73DkHeJx6XqqjxV
	 hRrDFJ399Yww+sEU7Fi4Yn6Y3/4E2hz00gPL5o12+D+X4u0gGdSYLKO9disWmnimXQ
	 V0kStMbftlZgAr8UBwMnr3RNYSMRx2DT/XZjeGi4HSalUF09QtaelHd0ETwYmbLZi2
	 ZZsHtrzppimfX3i+KZxrK9v6KjiC8yXcA0Db24S6D+ghA9L4AYOH5Zwnl54GRrv0xz
	 83l95Pj/dF+bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1FEABCE0565; Sat,  5 Apr 2025 10:22:57 -0700 (PDT)
Date: Sat, 5 Apr 2025 10:22:57 -0700
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
Message-ID: <93682939-6e82-43e7-8681-cc84539d9bc0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c9c19caa-68c1-4012-bd82-38a24c9edb60@paulmck-laptop>
 <174385625883.111.5710608020798879272@patchwork.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174385625883.111.5710608020798879272@patchwork.local>

On Sat, Apr 05, 2025 at 12:30:58PM -0000, Joel Fernandes wrote:
> Hello, Paul,
> 
> On Sat, 5 Apr 2025 12:26:12 GMT, "Paul E. McKenney" wrote:
> > On Sat, Mar 29, 2025 at 07:01:42PM -0400, Joel Fernandes wrote:
> > > Currently, the ->gpwrap is not tested (at all per my testing) due to the
> > > requirement of a large delta between a CPU's rdp->gp_seq and its node's
> > > rnp->gpseq.
> > > 
> > > This results in no testing of ->gpwrap being set. This patch by default
> > > adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> > > between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> > > configurable, including the active time for the setting and a full
> > > testing cycle.
> > > 
> > > By default, the first 25 minutes of a test will have the _default_
> > > behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> > > we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> > > this is reasonable since we at least add a little bit of testing for
> > > usecases where ->gpwrap is set.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > I ran this as follows:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10m --configs "TREE01" --bootargs "rcutorture.ovf_cycle_mins=7" --trust-make
> > 
> > Once I actually applied your patch, I did get this:
> > 
> > [  601.891042] gpwraps: 13745
> > 
> > Which seems to indicate some testing.  ;-)
> 
> Thanks a lot for running it. I am wondering if I should check in tree.c (only in
> testing mode), if the wraps are too many and restrict testing if so. Otherwise,
> it is hard to come up with a constant that ensures the wraps are under control.
> On the other hand, since this is only for 5 minutes every 30 minutes, we can leave
> it as is and avoid the complexity.

I don't (yet) see a problem with lots of wraps.

> > Additional comments inline.
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/rcu.h        |  4 +++
> > >  kernel/rcu/rcutorture.c | 64 +++++++++++++++++++++++++++++++++++++++++
> > >  kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
> > >  kernel/rcu/tree.h       |  1 +
> > >  4 files changed, 101 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index eed2951a4962..9a15e9701e02 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> > >  			       unsigned long c_old,
> > >  			       unsigned long c);
> > >  void rcu_gp_set_torture_wait(int duration);
> > > +void rcu_set_torture_ovf_lag(unsigned long lag);
> > > +int rcu_get_gpwrap_count(int cpu);
> > >  #else
> > >  static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> > >  {
> > > @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> > >  	do { } while (0)
> > >  #endif
> > >  static inline void rcu_gp_set_torture_wait(int duration) { }
> > > +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> > > +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> > 
> > Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)
> > 
> > But shouldn't these be function pointers in rcu_torture_ops?  That way if
> > some other flavor of RCU starts doing wrap protection for its grace-period
> > sequence numbers, this testing can apply directly to that flavor as well.
> 
> These are here because 'rdp' is not accessible AFAIK from rcutorture.c.
> I could add wrappers to these and include them as pointers the a struct as well.
> But I think these will still stay to access rdp.

Why not just pass in the CPU number and let the pointed-to function find
the rdp?

> > Then the pointers can simply be NULL in kernels built with CONFIG_SMP=n.
> > 
> > >  #endif
> > >  unsigned long long rcutorture_gather_gp_seqs(void);
> > >  void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 895a27545ae1..79a72e70913e 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
> > >  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> > >  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
> > >  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> > > +torture_param(int, ovf_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> > > +torture_param(int, ovf_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> > > +torture_param(int, ovf_lag_gps, 8, "Value to set for set_torture_ovf_lag during an active testing period.");
> > 
> > Given that "ovf" means just "overflow", would it make sense to get a "gp"
> > in there?  Maybe just "gpwrap_..."?
> > 
> > "What is in a name?"  ;-)
> 
> Sure, makes sense I will rename.

Thank you!

> > I could argue with the defaults, but I run long tests often enough that
> > I am not worried about coverage.  As long as we remember to either run
> > long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
> > with ->gpwrap code.
> > 
> > >  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
> > >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> > >  torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> > > @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
> > >  	int i;
> > >  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > >  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > > +	long n_gpwraps = 0;
> > >  	struct rcu_torture *rtcp;
> > >  	static unsigned long rtcv_snap = ULONG_MAX;
> > >  	static bool splatted;
> > > @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
> > >  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> > >  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> > >  		}
> > > +		n_gpwraps += rcu_get_gpwrap_count(cpu);
> > >  	}
> > >  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> > >  		if (pipesummary[i] != 0)
> > > @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
> > >  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> > >  	pr_cont("nocb-toggles: %ld:%ld\n",
> > 
> > The "\n" on the above line needs to be deleted.
> 
> Ok.
> 
> > >  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> > > +	pr_cont("gpwraps: %ld\n", n_gpwraps);
> > >  
> > >  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> > >  	if (atomic_read(&n_rcu_torture_mberror) ||
> > > @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
> > >  
> > >  static enum cpuhp_state rcutor_hp;
> > >  
> > > +static struct hrtimer ovf_lag_timer;
> > > +static bool ovf_lag_active;
> > 
> > Same "ovf" naming complaint as before.
> 
> Ok.
> 
> > > +}
> > > +
> > > +static int rcu_torture_ovf_lag_init(void)
> > > +{
> > > +	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> > > +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > Why not refuse to start this portion of the test when testing CONFIG_SMP=n
> > or something other than vanilla RCU?  No need to fail the test, just
> > print something saying that this testing won't be happening.
> 
> Got it, will do.

Again, thank you!

> > > +static void rcu_torture_ovf_lag_cleanup(void)
> > > +{
> > > +	hrtimer_cancel(&ovf_lag_timer);
> > > +
> > > +	if (ovf_lag_active) {
> > > +		rcu_set_torture_ovf_lag(0);
> > > +		ovf_lag_active = false;
> > > +	}
> > > +}
> > 
> > Did you try the modprobe/rmmod testing to verify that this
> > cleans up appropriately?  You could use the drgn tool to check.
> > See tools/rcu//rcu-cbs.py for an example drgn script that digs into the
> > rcu_data structures.
> 
> Nice, will check!
> 
> Will work on this and provide v2.

Looking forward to it!

							Thanx, Paul
