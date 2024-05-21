Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4B7F470;
	Tue, 21 May 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298696; cv=none; b=Vm2t3C9KEAcRw6z6CZBlaXHZ4nzmO1mEAjccDKhtEyNC9V3HnHWlt+0JS5T2Oh6HUz6lm6k5/FyvdIWo9HpwmHKsrDuMqOhZg47MJe61VREThx3EuijGtlhHqD5UgsTvmlaxEuaTIRF8/9W/tDMT8T7sjRKFQtEdBGaclNvifv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298696; c=relaxed/simple;
	bh=sSUSRKrmceuENWL/KzJXA4iWNHco2sU8T4eWTx8iK8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TApQbfWVL8DDf60LC7DmlNrQPIxXDldGCn9PkXRLOSHfJPWMX8D18XFglTbNPtnSVcXV9oFOpqUOVmhpEYAk1pCBBe8J7OFnrI6UBES8ZuarxtJDBF930uIbBRjXHHPA6A08vc33ajizFOls3Xx8hyTmrQczoATciBJVeqE+z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/ixNslF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/ixNslF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22190C32786;
	Tue, 21 May 2024 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716298696;
	bh=sSUSRKrmceuENWL/KzJXA4iWNHco2sU8T4eWTx8iK8w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A/ixNslFKpAMaGwMJPmUMBS3sKWP7fxSt6EtcwoBetsgM4KgifX/h6D90UKZeG2Jj
	 6paLjUManLE3KD7+DAB9+Nh3ZcyGoSwESBwe3O+54GO8qV2x5ImKu5ABRzwR2DvgmK
	 MIW3XrvkzkK1cbkZgzFJZeg7XEpWc/gzfj2dI/L5Gojfmb7lP98STFgwKKPKJPx6Es
	 ZXNcPvxegWh8ruJOYows4jt/tSUkYcXUd6/ALPtCmnBvpAXg1GA2pqWIDpcdXlaby4
	 8UchifamgX1Wg3wDwjrm3B5vZKTZsbmcC3GRGpegJIZrAE96DNdbRYD3nSRrKW28IT
	 ilB+5pJ2KUjsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD82FCE0A32; Tue, 21 May 2024 06:38:15 -0700 (PDT)
Date: Tue, 21 May 2024 06:38:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] rcu/tasks: Further comment ordering around current
 task snapshot on TASK-TRACE
Message-ID: <b3018a43-02af-47f9-b7e9-a639dfd026f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-3-frederic@kernel.org>
 <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>
 <Zku1kDj_LjK3WxaA@pavilion.home>
 <24467166-5f00-45f2-867f-40b8a836d085@paulmck-laptop>
 <ZkxwnZacvXqfHxZD@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkxwnZacvXqfHxZD@localhost.localdomain>

On Tue, May 21, 2024 at 11:59:57AM +0200, Frederic Weisbecker wrote:
> Le Mon, May 20, 2024 at 04:25:33PM -0700, Paul E. McKenney a écrit :
> > Good points!  How about the following?
> > 
> > 		// Note that cpu_curr_snapshot() picks up the target
> > 		// CPU's current task while its runqueue is locked with
> > 		// an smp_mb__after_spinlock().  This ensures that either
> > 		// the grace-period kthread will see that task's read-side
> > 		// critical section or the task will see the updater's pre-GP
> > 		// accesses.  The trailng smp_mb() in cpu_curr_snapshot()
> 
> *trailing

Good catch!

> > 		// does not currently play a role other than simplify
> > 		// that function's ordering semantics.  If these simplified
> > 		// ordering semantics continue to be redundant, that smp_mb()
> > 		// might be removed.
> > 
> > Keeping in mind that the commit's log fully lays out the troublesome
> > scenario.
> 
> Yep, looks very good!
> 
> Thanks!

Very good, I will fold this in on my next rebase.

							Thanx, Paul
