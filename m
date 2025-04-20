Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEA647;
	Sun, 20 Apr 2025 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745108489; cv=none; b=KDkkSW43yNECMd8ev0yRRIzxkb9uP1AZg9FiWyfoYIinE4KfVpL9Auitj8r30y4jTeN7Q4WqiArMbauoXk8ybzTuEDIJiGk/VUdEmEwzOYdWojujnez9dKKxNjhQaIcMf2pM776LwYnZXRRFKdAaYV9O8Wrzfo5wEBQ9g2qrQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745108489; c=relaxed/simple;
	bh=rZuukaW3diAf5pHqdu7NbmQkIvsNnCYFbeDogA39qGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljgYfJmD4pqs01wBOGjbhZ4i44ka1EGqpbcB+fEnu95nw/crm1qyI6XKLv3l4Z/ndHfMfZU4uW35wVqBMBRUGkTWDfPWbkS/lmKhFqQuE3g0qx3YSeYfZMVGZaxsyzMc7Z70VMwbOyB35MhfBYDPBiW5qKjLD2yjKN97STrpbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWhfBSFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWhfBSFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED72C4CEE7;
	Sun, 20 Apr 2025 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745108489;
	bh=rZuukaW3diAf5pHqdu7NbmQkIvsNnCYFbeDogA39qGE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rWhfBSFsXrtSnNMHTwE1wiZ+CvEkkBW040Wfwmuc5NS6F5wPOQFVjRHg6oU6b+1sY
	 0pCWLrDSDEjYiVLg0ngKfajeqeMVxCnU7PN+BNBTQYvN//idIro6viEB14xYRlknZL
	 nULzeP2lNpunjoQInoRWzDHnNxu4vg3wPuZkfN1dlZdEAU86M7dYsdzXAJjuZ5uP25
	 44Ks0XctBr+EgLA5qnG+4AF/cELnQv8ZZzhddf7rZzMmKD3N59eEbsUuY2kALcBTVD
	 +0mV+Op8xsT1C/EBT8eK1bOjCc/RS6QVOicjZMyLE9m8Utq8c6zraA8IVvwwDVsmVQ
	 NqrXBludGrWcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAF4BCE095D; Sat, 19 Apr 2025 17:21:28 -0700 (PDT)
Date: Sat, 19 Apr 2025 17:21:28 -0700
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
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <9377c713-9a23-4ac3-ac2e-b5af105706a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
 <5ee46103-caef-46ac-8660-4b9f4bb5e4f0@nvidia.com>
 <587e21be-9595-4625-b929-0e8b4a215a43@paulmck-laptop>
 <8603B8C7-DE79-4362-BE60-DE95ABE015BE@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8603B8C7-DE79-4362-BE60-DE95ABE015BE@nvidia.com>

On Wed, Apr 16, 2025 at 11:19:22AM +0000, Joel Fernandes wrote:
> 
> 
> > On Apr 15, 2025, at 8:19 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Apr 14, 2025 at 11:05:45AM -0400, Joel Fernandes wrote:
> >> On 4/10/2025 2:29 PM, Paul E. McKenney wrote:
> >>>> +static int rcu_gpwrap_lag_init(void)
> >>>> +{
> >>>> +    if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> >>>> +        pr_alert("rcu-torture: lag timing parameters must be positive\n");
> >>>> +        return -EINVAL;
> >>> When rcutorture is initiated by modprobe, this makes perfect sense.
> >>> 
> >>> But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> >>> testing and do other testing but splat so that the bogus scripting can
> >>> be fixed, (2) Force default values and splat as before, (3) Splat and
> >>> halt the system.
> >>> 
> >>> The usual approach has been #1, but what makes sense in this case?
> >> 
> >> If the user deliberately tries to prevent the test, I am Ok with #3 which I
> >> believe is the current behavior. But otherwise #1 is also Ok with me but I don't
> >> feel strongly about doing that.
> >> 
> >> If we want to do #3, it will just involve changing the "return -EINVAL" to
> >> "return 0" but also may need to be doing so only if RCU torture is a built-in.
> >> 
> >> IMO the current behavior is reasonable than adding more complexity for an
> >> unusual case for a built-in?
> > 
> > The danger is that someone adjusts a scenario, accidentally disables
> > *all* ->gpwrap testing during built-in tests (kvm.sh, kvm-remote,sh,
> > and torture.sh), and nobody notices.  This has tripped me up in the
> > past, hence the existing splats in rcutorture, but only for runs with
> > built-in rcutorture.
> 
> But in the code we are discussing, we will splat with an error if either parameter is set to 0?  Sorry if I missed something.

The idea would be to instead splat if the user requested a given type of
testing, but that request conflicted with some other setting so that the
user's request had to be refused.  If the user did not request a given
type of testing (so that the corresponding parameter was zero), no splats.

Also, no splats of this type for modprobe (error return instead), rather,
modprobe gets an error code in this case.

Or am I missing the point of your question?

							Thanx, Paul

> >> On the other hand if the issue is with providing the user with a way to disable
> >> gpwrap testing, that should IMO be another parameter than setting the _mins
> >> parameters to be 0. But I think we may not want this testing disabled since it
> >> is already "self-disabled" for the first 25 miutes.
> > 
> > We do need a way of disabling the testing on long runs for fault-isolation
> > purposes.
> 
> Thanks, I will add an option for this.
> 
> > 
> > For example, rcutorture.n_up_down=0 disables SRCU up/down testing.
> > Speaking of which, I am adding a section on that topic to this document:
> > 
> > https://docs.google.com/document/d/1RoYRrTsabdeTXcldzpoMnpmmCjGbJNWtDXN6ZNr_4H8/edit?usp=sharing
> 
> Nice, thanks,
> 
>  - Joel
> 
> 
> > 
> >                            Thanx, Paul
