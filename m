Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F041509BF;
	Thu, 30 Jan 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738216617; cv=none; b=pTwfvcwqsZKvpfXMBO3blHzupZjk80ThbfdHs3IYFGCd/kTqhOjpfX6FHoD2WFU8Cet9yXebYK5IXG2lU/N0L8NTi/7cWgdZ92r8sdrrEeR+w3dwdVFdjNVAPm+tfrQLjgGIT1ZGnHE+HjOcuEQIu9taTu6HLCtEDJsbWT5og4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738216617; c=relaxed/simple;
	bh=dVZBBc00F6OWmYwY7UnC1NqmtyPfLJtE2OcEJciVIRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC0RIzskTapd1ZfccFw6GRWlSgn6hTgasM5im//DOz33byS4XB/+FpA5M91yaUrJr9RRRLNsDQFUWkWzfQAcd/WWvxaUNgrfnKhZZL0xrRFyNMPrzLdfoFeFp70SkfJ31O2XJPOqn2JkW2VyM2X7IwwHIREuVJErMDolPoXeHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns6wvPnq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns6wvPnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1013C4CED2;
	Thu, 30 Jan 2025 05:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738216617;
	bh=dVZBBc00F6OWmYwY7UnC1NqmtyPfLJtE2OcEJciVIRk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ns6wvPnqK5NFpp9/GPXnvE5lqs2XW8G0hxXp+e2sWZWyx7M8usxA1ItetTLbFRK3R
	 O6L5ScOYk7ZJr/1Ty6KT5BlM7o4wGcGHIkGcpWGA06ghW0/R+wRVUTINg9Wogr32hm
	 nUc7+jiRgNFDTewaIpvGiuyZRLPO/xCOr50npjgFkf/jcsQmGT2nq5axZfPz1aV84x
	 8bsEFIxPu1vq0zGTSsxt7GE1BVaSOOwixApGL6IP8/8z4pYOCdy/9aykHk2DGOvRCe
	 Oz8Q8F02Vn61v/eZsMFE6eu/iQeWs/RhjhmtPJ6ufLLUuUNb0or+nl3NuuVIpevefF
	 Jp3BcxEUnd2Lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A02FCE37FA; Wed, 29 Jan 2025 21:56:56 -0800 (PST)
Date: Wed, 29 Jan 2025 21:56:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Message-ID: <ec293223-2a33-4d2f-b3ca-c011c3d987f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org>
 <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
 <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>

On Wed, Jan 29, 2025 at 06:10:10PM -0500, Joel Fernandes wrote:
> On Wed, Jan 29, 2025 at 12:25 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jan 29, 2025 at 06:34:53AM -0500, Joel Fernandes wrote:
> > >
> > >
> > > > On Jan 28, 2025, at 9:21 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > ﻿On Tue, Jan 28, 2025 at 09:13:45PM -0500, Joel Fernandes wrote:
> > > >>> On Tue, Jan 28, 2025 at 8:47 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>>
> > > >>> On Tue, Jan 28, 2025 at 08:38:57PM -0500, Joel Fernandes wrote:
> > > >>>> On Tue, Jan 28, 2025 at 8:33 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>>>>
> > > >>>>> On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
> > > >>>>>> On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> > > >>>>>>> On Mon, Jan 27, 2025 at 7:07 PM Joel Fernandes (Google)
> > > >>>>>>> <joel@joelfernandes.org> wrote:
> > > >>>>>>>>
> > > >>>>>>>> The rcu_seq_done() API has a large "false-negative" windows of size
> > > >>>>>>>> ULONG_MAX/2, where after wrap around, it is possible that it will think
> > > >>>>>>>> that a GP has not completed if a wrap around happens and the delta is
> > > >>>>>>>> large.
> > > >>>>>>>>
> > > >>>>>>>> rcu_seq_done_exact() is more accurate avoiding this wrap around issue,
> > > >>>>>>>> by making the window of false-negativity by only 3 GPs. Use this logic
> > > >>>>>>>> for rcu_seq_done() which is a nice negative code delta and could
> > > >>>>>>>> potentially avoid issues in the future where rcu_seq_done() was
> > > >>>>>>>> reporting false-negatives for too long.
> > > >>>>>>>>
> > > >>>>>>>> rcutorture runs of all scenarios for 15 minutes passed. Code inspection
> > > >>>>>>>> was done of all users to convince the change would work.
> > > >>>>>>>>
> > > >>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>>>>>
> > > >>>>>>> I am leaving a 60 minute overnight run of all scenarios on my personal
> > > >>>>>>> server for further testing.
> > > >>>>>>
> > > >>>>>> The run passed, details below:
> > > >>>>>>
> > > >>>>>> --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
> > > >>>>>> Results directory:
> > > >>>>>> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60
> > > >>>>>> RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total-gps=57880] n_max_cbs: 0
> > > >>>>>> SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=79242] n_max_cbs: 150000
> > > >>>>>> SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gps=460117] n_max_cbs: 150000
> > > >>>>>> SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=80299] n_max_cbs: 150000
> > > >>>>>> SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gps=1035602] n_max_cbs: 50000
> > > >>>>>> SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-gps=988459] n_max_cbs: 50000
> > > >>>>>> SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-gps=1092927] n_max_cbs: 1000
> > > >>>>>> TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=57808]
> > > >>>>>> TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=57936]
> > > >>>>>> TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=57508]
> > > >>>>>> TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 57078
> > > >>>>>> TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 2619
> > > >>>>>> TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 total-gps=45844] n_max_cbs: 50000
> > > >>>>>> TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0 total-gps=305456] n_max_cbs: 100000
> > > >>>>>> TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=120151]
> > > >>>>>> TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=365162] n_max_cbs: 1139244
> > > >>>>>> TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=441393] n_max_cbs: 1341765
> > > >>>>>> TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=238225] n_max_cbs: 236765
> > > >>>>>> TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=308880] n_max_cbs: 82801
> > > >>>>>> TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=52094]
> > > >>>>>> TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=1923688] n_max_cbs: 1845334
> > > >>>>>> --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0
> > > >>>>>
> > > >>>>> Very good!
> > > >>>>>
> > > >>>>> How would you go about analyzing whether this is really safe vs. getting
> > > >>>>> just getting lucky and not having provoked an overflow?
> > > >>>>
> > > >>>> I would probably add a more specific test case stressing the API, or
> > > >>>> even a unit test of just the API by passing a range of sequences.. I
> > > >>>> should go ahead and do that but it sounds like you feel there is an
> > > >>>> issue with the patch? :)
> > > >>>
> > > >>> 2^31 (let alone 2^63) is a very large number of grace periods, and
> > > >>> so it is hard to test grace-period sequence-number wrap.
> > > >>>
> > > >>> Not impossible, though...
> > > >>
> > > >> We could test a decent number of candidate sequences to cover
> > > >> different cases. Not ideal like bruteforcing, but...   Another idea is
> > > >> to hardcode/assume ULONG_MAX as 16-bit in a unit test.
> > > >
> > > > Or put the various sequence numbers into an unsigned short or even
> > > > an unsigned char.
> > > >
> > > > One set of use cases checks to see if a given CPU's ->gp_seq has fallen
> > > > too far behind the current grace period, and sets a flag to alert
> > > > that CPU.  Others rely on a false negative being functionally OK.
> > > >
> > > > Or so I believe.  ;-)
> > >
> > > Thanks, I am itching to create a visualization of all eight bit combinations and the output of both API, which will be a fun exercise however I’m missing something fundamental because as I mentioned in that 100 and 200 example, the API itself cannot distinguish between a wraparound and a legitimate delay in comparison between start and a delayed end. I need to understand this better and go through the code more. ;-/
> >
> > The big questions are "under what conditions does it need to distinguish,
> > and what are the consequences of failing to get this right?"   Also, "what
> > is the purpose of ->gpwrap?".
> 
> My understanding is we take a snapshot of a sequence and then check at
> later time if it was reached. Ok I shall explore these questions.
> Meanwhile I created the following visualization using 5-bit numbers:
> 
> https://drive.google.com/file/d/1w2sgJga7B5dye4iH0oPZ79obaKO-e_Jn/view?usp=sharing
> 
> I find as we expect, that for rcu_seq_done(), as long as the distance
> between the "running sequence" and the "target" is ULONG_MAX/2, it
> returns correct results. OTHERWISE, it can return false results. So
> for target value of 28 (in 5-bit world), only initial running values
> from 12 would return FALSE. Before number 12, everything is TRUE. This
> can cause both false-positives and false-negatives depending on the
> input, however it is possible that are no users who use it causing
> false-positives! So I guess it really depends on user.

Your last sentence is extremely important.  You need to evaluate
the consequences of false positives and false negatives on a
use-case-by-use-case basis.  Which first requires enumerating
the use cases.

> False positives:
> If the initial value is ULONG_MAX/2 away from the target, then
> rcu_seq_done() can return TRUE when *no wraparound* happened.

What exactly is the initial value and the target?

My guess is that the initial value is what was returned from
rcu_seq_snap(), but that is just a guess.  My guess is that the
target value is the value of the underlying sequence number at the
time that rcu_seq_done() is invoked, but again, that is just a guess.
Similar question for "away from the target", and similar guess.

This might sound picky, but if you think that *I* am picky, just
try the actual RCU code.  ;-)

> False negatives:
> The initial value of the snapshot was *within* the ULONG_MAX/2
> distance from target. A full *wrap around then happened*, and we ended
> where we were initially, so rcu_seq_done() should return TRUE but it
> returns FALSE because it doesn't know about the wrap.

By "where we were initially", one might reasonably guess that you meant
that the initial value and the target are one and the same.  But I suspect
that you are thinking of a third value, the value of the underlying
grace-period sequence number at the time of the call to rcu_seq_snap().
But you might be thinking of something else entirely.

> Now we move rcu_seq_done_exact. It has the exact same behavior except
> that instead of ULONG_MAX/2, the above situations are shrunk to about
> 10 counts from the target. So if target is 28, then the initial
> sequence should have been at least 18 to avoid false-positive, but
> again it is possible and I certain see in the code that it cannot be
> used this way.. (at least so far).. So all we are left with is the
> false-negative band of ~2.5 GPs..

Here, I have the same questions.  As you no doubt guessed.

> About "what are the consequences of failing to get this right".  I
> believe false-positive is unacceptable unless it is maybe debug code -
> that can break functionality in code, too short GPs and all that.
> However false-negative is OK as long as the usecase can retry later
> and can afford to wait. Did I get that much correct?

Maybe?

Please look at this on a per-use-case basis.

							Thanx, Paul
