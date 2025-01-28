Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F61E1A32;
	Tue, 28 Jan 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738099170; cv=none; b=bYCC75ldnZhasadLv69Miwgq1gl3zQD1Ui91xnM8dBwf8q0gGbowEOfReBhwWZk4quVXECpSzEbS9dDBz6KNKNwz68WhkEHarTgf0UPi2O61X9FHHl/lUzkItNlcA2upfA3doQORocq/EaSxrfqmAEt1xoZaWoeAI94ZshJoOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738099170; c=relaxed/simple;
	bh=OtgesMmgqYSR1qvSeqRYKH1SRZYJHICz1Ex4WxtdkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXMveY6SRsuMSTzHHZ0pjSZFmjuwbl0A6ezPptgOtj3MjG3aM4/1qFq+fyWnzA8ldj9Nme76pvD9DYpo+fcwUeU7vaQjLszZQ8ZLPnryYrVR80SMbH6hhNAQz/TM1THbmF4AC+YSjuieKIvMMEVuPCpGE/Z/WDghS/a0B9Ye+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leU8xJD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leU8xJD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F3AC4CED3;
	Tue, 28 Jan 2025 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738099169;
	bh=OtgesMmgqYSR1qvSeqRYKH1SRZYJHICz1Ex4WxtdkUs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=leU8xJD2cb3afkl8U4yezFP/371m8l/UgFPRLyhbmdjlth1mFuPCArF65OpDWf92Q
	 113uWtCapoGQ0Hjlpa8PcSX7iUWQ0W4PaZZjCOgBIZdOnUj0Yzqa7/iRlRz0iKooS7
	 E9b/W62tmJR/OAlar37WH5+9uB0awDiNmUx/IjylyS+T5yMt9scvhojrFIuXcQa6iW
	 9OQ/qGE3YJJrztBsf6ZPs4lWqr0EbIN8nvalPqD+4Q4xXtqjWTL+qmkfTogxaSMnzI
	 CqzYnTvtei0KDik62aDcJ/Y5d9x2pMT5uPhtgdOEiRKnMlsQHhYNSJGEWx7NzMyt6T
	 wkbVUpwoe/c9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 145CDCE1160; Tue, 28 Jan 2025 13:19:29 -0800 (PST)
Date: Tue, 28 Jan 2025 13:19:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/4] rcutorture: Allow a negative value for nfakewriters
Message-ID: <ec8a3ccb-b3d7-421d-86c6-e1035b69cd55@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <Z5lEN8WdvPyq7dRs@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5lEN8WdvPyq7dRs@pc636>

On Tue, Jan 28, 2025 at 09:55:19PM +0100, Uladzislau Rezki wrote:
> Hello, Paul!
> 
> > Currently "nfakewriters" parameter can be set to any value but
> > there is no possibility to adjust it automatically based on how
> > many CPUs a system has where a test is run on.
> > 
> > To address this, if the "nfakewriters" is set to negative it will
> > be adjusted to num_possible_cpus() during torture initialization.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d26fb1d33ed9..6bc161e1e8ac 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -4050,6 +4050,10 @@ rcu_torture_init(void)
> >  					  writer_task);
> >  	if (torture_init_error(firsterr))
> >  		goto unwind;
> > +
> > +	if (nfakewriters < 0)
> > +		nfakewriters = (int) num_possible_cpus();
> > +
> >  	if (nfakewriters > 0) {
> >  		fakewriter_tasks = kcalloc(nfakewriters,
> >  					   sizeof(fakewriter_tasks[0]),
> > -- 
> > 2.39.5
> > 
> 
> Don't you mind to take this as well? It is needed for:
> 
> rcu: Update TREE05.boot to test normal synchronize_rcu()

I would, but could you please set something up like we have for
nreaders (the module parameter) and nrealreaders (the value actually
used throughout).  I freely admit that nrealfakereaders sounds a bit
strange, so please feel free to either embrace the strangeness or propose
an alternative.  ;-)

The reason for this is so that, on a system with 128 CPUs, the user can
distinguish between having specified (say) nfakewriters=128 on the one
hand or nfakewriters=-1 on the other.

							Thanx, Paul
