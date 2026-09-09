Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C348EC8B;
	Wed,  9 Sep 2026 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993364; cv=none; b=Uta/mtmAGzKZR1Ysft+Tx/HnV0l4ORl7ZoAWBi44rRrdOMfnThmIFe2AP1X19Jv7fZwFPN4uV4a/lU9mymMju8sBEdx97RLJZULav3p+gIQ1yk4ZtsMx6klbu9Xc4t7+2tVTeE69QW8cqrHK+6UtOYZBr5fs+HvOB47iJ3Rl1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993364; c=relaxed/simple;
	bh=Sk89NQbShkfzb2tElxtF+545+YomVAsAnuWgUPrliSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PStgDa7GeY7nxpOhU1y1gBtBeQGiHtNyDjerIuPCNwLmu7brfLtDn1iUiIrpT2rLLVnNfRQ6OM70T3FneB0zAM4lsM6fl4FBJY8tO19+eVftVskye1rYzEHzNwAsVihKKE/merG7sJ1O5pYz4nv+v4jGksgg2TmW34kpl3V7M2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8/PH8ht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8/PH8ht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259B1F000FF;
	Wed,  9 Sep 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788993332;
	bh=awFuhuT81/R4r+seHT1DvBy4LdLo8zxP0ir3gEeauas=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=X8/PH8ht37xlu8MW096CVcJg6qdujG/W14wHslRcgR6VKnxyMOFhOWX88BODeVaIL
	 hNAPK4QN84yBz3294VIcZM+pHTN9B6fT6DF5py6BQK6zLGSmaK0CF3+LHTPwOJ0ACk
	 iVIJngmR7Hi7lCav2Y3OuG/X6HHTQ3+fCZX+DjQMUam45bSjio1YFSs4DTQypYoEsi
	 ke0wMSievXN+s2d9XLHaR8h//1NqJVRq/h00o/1Ypdark7SRdfqmHkjSAKImF8Xrq2
	 ap0j2ccQA5dbv9F1KYIPyg30VOn/gozA4Tga1eQuzaanZx6y+RvOgf3LgxvH3exMem
	 +linMcd1QBfBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91F35CE054B; Wed,  9 Sep 2026 15:35:32 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:35:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] rcutorture: Add atomic-SRCU support to torture.sh
Message-ID: <26b68ec0-2f21-4dc2-bfcf-20cbc38f4ceb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-5-kunwu.chan@linux.dev>
 <fc49190e-6cec-435d-b853-db906a1e33e3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc49190e-6cec-435d-b853-db906a1e33e3@paulmck-laptop>

On Tue, Sep 08, 2026 at 04:34:41PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 07, 2026 at 03:58:20PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Add the --do-atomic-srcu argument to torture.sh, which runs the
> > SRCU-N, SRCU-P, and SRCU-T scenarios, thus covering both Tree SRCU
> > (SRCU-N and SRCU-P) and Tiny SRCU (SRCU-T), with
> > rcutorture.reader_flavor=0x10 appended to the boot parameters so
> > that it takes precedence over each scenario's own reader-flavor
> > setting.  This exercises srcu_read_lock_atomic(),
> > srcu_read_unlock_atomic(), and synchronize_srcu_atomic().
> > 
> > As with other torture.sh tests, the --do-kcsan argument runs a
> > KCSAN+PROVE_LOCKING variant of this test.
> > 
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Queued for testing and review, thank you!

I did take the liberty of changing "do_atomic_srcu=no" to
"do_atomic_srcu=yes" in order to increase test coverage.

							Thanx, Paul

> > ---
> >  .../selftests/rcutorture/bin/torture.sh       | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> > index f0083891ee81..8885812d866a 100755
> > --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> > @@ -68,6 +68,7 @@ do_clocksourcewd="${ifnotaarch64}"
> >  do_rt=yes
> >  do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
> >  do_srcu_lockdep=yes
> > +do_atomic_srcu=no
> >  do_rcu_rust=no
> >  
> >  # doyesno - Helper function for yes/no arguments
> > @@ -103,6 +104,7 @@ usage () {
> >  	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
> >  	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
> >  	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
> > +	echo "       --do-atomic-srcu / --do-no-atomic-srcu / --no-atomic-srcu"
> >  	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
> >  	echo "       --guest-cpu-limit N"
> >  	echo "       --kcsan-kmake-arg kernel-make-arguments"
> > @@ -148,6 +150,7 @@ do
> >  		do_kcsan=yes
> >  		do_clocksourcewd="${ifnotaarch64}"
> >  		do_srcu_lockdep=yes
> > +		do_atomic_srcu=yes
> >  		;;
> >  	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
> >  		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
> > @@ -183,6 +186,7 @@ do
> >  		do_kcsan=no
> >  		do_clocksourcewd=no
> >  		do_srcu_lockdep=no
> > +		do_atomic_srcu=no
> >  		;;
> >  	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
> >  		do_normal=`doyesno "$1" --do-normal`
> > @@ -212,6 +216,9 @@ do
> >  	--do-srcu-lockdep|--do-no-srcu-lockdep|--no-srcu-lockdep)
> >  		do_srcu_lockdep=`doyesno "$1" --do-srcu-lockdep`
> >  		;;
> > +	--do-atomic-srcu|--do-no-atomic-srcu|--no-atomic-srcu)
> > +		do_atomic_srcu=`doyesno "$1" --do-atomic-srcu`
> > +		;;
> >  	--duration)
> >  		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
> >  		mult=1
> > @@ -497,6 +504,23 @@ then
> >  	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
> >  fi
> >  
> > +# Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
> > +# (SRCU-T).  The reader flavor selects srcu_read_lock_atomic() and
> > +# synchronize_srcu_atomic().  Tiny SRCU requires SMP=n, which aarch64
> > +# does not support.
> > +if test "$do_atomic_srcu" = "yes"
> > +then
> > +	torture_bootargs="rcutorture.reader_flavor=0x10"
> > +	configs_atomic_srcu="SRCU-N SRCU-P"
> > +	if test "$ifnotaarch64" = yes
> > +	then
> > +		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
> > +	fi
> > +	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
> > +		--allcpus --duration "$duration_rcutorture" \
> > +		--configs "$configs_atomic_srcu" --trust-make
> > +fi
> > +
> >  if test "$do_locktorture" = "yes"
> >  then
> >  	torture_bootargs="torture.disable_onoff_at_boot"
> > -- 
> > 2.43.0
> > 
