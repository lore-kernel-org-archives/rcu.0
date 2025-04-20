Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F731853;
	Sun, 20 Apr 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172252; cv=none; b=P7UQ1CRxe0PPyQMPqLVWAeU6/BbVqinbtAwe3O2aQMd3XbUuTglkmAuNDh9wiZLhvHvsTDMTDvB9wxtheVgwyYgO9/vGRDGnEbJzlHUAHxB6k3qmWdsQBKeUEZdrbbcWIa9o6pDfgrBw7fdR/ez/35pEY/Vv9p+sR46hVcMJ+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172252; c=relaxed/simple;
	bh=T+GbBim5jBNYcdKeeuABEcSsvYL+8u94gjikD9a5U5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGv5EZxtHv2GP3xXwg5hnXliLp9OYmRZSvuYS5cJw68cRt13WinHOKpTMy+N7wQ6ppY55UX2fjpkRTy/Kpmqg7ihrKSrSgQbsxVOGGGpfLk7bHRaR6w+Z7/iDvUt11nESfX9/dVVWerJLvaSe2JkSWWl8cb/o6hCPav9o48gSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG2Dzs1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG2Dzs1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3BAC4CEE2;
	Sun, 20 Apr 2025 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745172252;
	bh=T+GbBim5jBNYcdKeeuABEcSsvYL+8u94gjikD9a5U5Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LG2Dzs1E/UlDWoKL0lclSs6en9f3lubHOsngTgqrCbImXnyyvwEvOfLnp03hyqwf6
	 53hzs+sLozHU4TGF9Isl85xQrdyP84sKKLuw1keMBPT/nJUrw7skCU1bJ5Wt7QB+1m
	 g3WF32yWBPRXccurXb6WC0wnQ59FamR9s9vvvoq8Xoxod7aPb5/KeQ0JO5WM/NLgeY
	 81iL6Z6dx87T+aI4MmY5mZIeXpcgLw3v//o4vBCHkeL5U8RFcKmzDXf0r4oSF2ASfs
	 HDVTn3JjEMxjhoPV4IDDhhY9TIxeSREI1VMb+R8E12mKwHtap3pxi2asDzIfVGI2YQ
	 0h5AH9SzGrNwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7E684CE0875; Sun, 20 Apr 2025 11:04:11 -0700 (PDT)
Date: Sun, 20 Apr 2025 11:04:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of -&gt;gpwrap
Message-ID: <04b48040-7fe3-4732-98ae-2ea830832bb7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9377c713-9a23-4ac3-ac2e-b5af105706a1@paulmck-laptop>
 <174511682031.107.5797546463429118570@patchwork.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174511682031.107.5797546463429118570@patchwork.local>

On Sun, Apr 20, 2025 at 02:40:20AM -0000, Joel Fernandes wrote:
> Hello, Paul,
> 
> On April 20, 2025, 12:21 a.m. UTC Paul E. McKenney wrote:
> > On Wed, Apr 16, 2025 at 11:19:22AM +0000, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Apr 15, 2025, at 8:19 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Mon, Apr 14, 2025 at 11:05:45AM -0400, Joel Fernandes wrote:
> > > >> On 4/10/2025 2:29 PM, Paul E. McKenney wrote:
> > > >>>> +static int rcu_gpwrap_lag_init(void)
> > > >>>> +{
> > > >>>> +    if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> > > >>>> +        pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > > >>>> +        return -EINVAL;
> > > >>> When rcutorture is initiated by modprobe, this makes perfect sense.
> > > >>> 
> > > >>> But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> > > >>> testing and do other testing but splat so that the bogus scripting can
> > > >>> be fixed, (2) Force default values and splat as before, (3) Splat and
> > > >>> halt the system.
> > > >>> 
> > > >>> The usual approach has been #1, but what makes sense in this case?
> > > >> 
> > > >> If the user deliberately tries to prevent the test, I am Ok with #3 which I
> > > >> believe is the current behavior. But otherwise #1 is also Ok with me but I don't
> > > >> feel strongly about doing that.
> > > >> 
> > > >> If we want to do #3, it will just involve changing the "return -EINVAL" to
> > > >> "return 0" but also may need to be doing so only if RCU torture is a built-in.
> > > >> 
> > > >> IMO the current behavior is reasonable than adding more complexity for an
> > > >> unusual case for a built-in?
> > > > 
> > > > The danger is that someone adjusts a scenario, accidentally disables
> > > > *all* ->gpwrap testing during built-in tests (kvm.sh, kvm-remote,sh,
> > > > and torture.sh), and nobody notices.  This has tripped me up in the
> > > > past, hence the existing splats in rcutorture, but only for runs with
> > > > built-in rcutorture.
> > > 
> > > But in the code we are discussing, we will splat with an error if either
> > > parameter is set to 0?  Sorry if I missed something.
> > 
> > The idea would be to instead splat if the user requested a given type of
> > testing, but that request conflicted with some other setting so that the
> > user's request had to be refused.  If the user did not request a given
> > type of testing (so that the corresponding parameter was zero), no splats.
> > 
> > Also, no splats of this type for modprobe (error return instead), rather,
> > modprobe gets an error code in this case.
> > 
> > Or am I missing the point of your question?
> 
> No you are not missing anything. I just felt I already made the change you are
> talking about because if user misconfigures the timing params, it will print an
> error. But if you feel something is missing, I'd appreciate a prototype patch!

OK, I see that you are relying on the splat after the "unwind" label
in rcu_torture_init(), which is perfectly legitimate.  Apologies for
my confusion!

> > > >> On the other hand if the issue is with providing the user with a way to disable
> > > >> gpwrap testing, that should IMO be another parameter than setting the _mins
> > > >> parameters to be 0. But I think we may not want this testing disabled since it
> > > >> is already "self-disabled" for the first 25 miutes.
> > > > 
> > > > We do need a way of disabling the testing on long runs for fault-isolation
> > > > purposes.
> > > 
> > > Thanks, I will add an option for this.
> 
> I still have to fix this, and will add it to the other fix we needed to make
> because of the issue you found (kthread_should_stop() splat).

Very good, and thank you!

							Thanx, Paul
