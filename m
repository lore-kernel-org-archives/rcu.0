Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAC3B3BFE;
	Tue,  8 Sep 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910483; cv=none; b=YJurTDbTQ2V2DVQ7oSDuGLNobTmzWl3oaCCJ8M50OcMR4/NAKOvStw1dHpVC9y7K0k+aaq+rEJC+WXX+cBVsKhavq2FvtksDrmbybmPlWlGscr2GnUMGaxUvZWKxzcxhxgq/U6ZCezaIOQdVuVKsydBtpv3nbIZ4xpfANYvzR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910483; c=relaxed/simple;
	bh=0ExDBC0dfdE0x3yGT23aTAIZs7eBWeW/fyRcIg12amA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PweA81FFE5/PSfon0ezasjwIdaI6CHp8+8e5738IVq5LHGFLuNVBdGk/JXKSUf7Ga46Dtr8xV1amVSr5rMipYv/Ik5VULa+IrmLJz1uGGmzgIGVzwZRtaQtVg+fdR2Z3ekeysXux8OnyjoJFlBCKJTwBLQzl6F5pB4p8M2Vq4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQcCtGjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQcCtGjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C51F00A3A;
	Tue,  8 Sep 2026 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910481;
	bh=Js8IfcfN72NT5tEaZgrnZChYseuSgm2FBzJVwGp31k4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DQcCtGjJ+g1lCp3kRJswgXnbtpmkR0CjTwGTSIm3vR6ZQPDeddECTgke0GAPgNsZO
	 j4pMPB9r6LjYDOTf4tUUMSO0M3IQ4ZWAfagM1V1CnDGCSml7Nw6D8VeFmTUhuqk6em
	 4W925lPQAz2s9zPz6II9oBIG9RiIIEaE70xvMXzOIrWqSF1YiJffeau9Pn94KGNsml
	 NzUfU31Y5OpH3ofcfwARnPYVdaYBfLLtdNDCy2xGDEK8xzpc7UaLMA8QxMfLI7FB9O
	 m/xZonUTZ3voouYju3RSxbtHJSedqxlDpxwsFNHQTBDe5EF23m2fnypLIVwYEareW4
	 OOXCo5C6TMo+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 52CB2CE18F4; Tue,  8 Sep 2026 16:34:41 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:34:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] rcutorture: Add atomic-SRCU support to torture.sh
Message-ID: <fc49190e-6cec-435d-b853-db906a1e33e3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-5-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-5-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:20PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Add the --do-atomic-srcu argument to torture.sh, which runs the
> SRCU-N, SRCU-P, and SRCU-T scenarios, thus covering both Tree SRCU
> (SRCU-N and SRCU-P) and Tiny SRCU (SRCU-T), with
> rcutorture.reader_flavor=0x10 appended to the boot parameters so
> that it takes precedence over each scenario's own reader-flavor
> setting.  This exercises srcu_read_lock_atomic(),
> srcu_read_unlock_atomic(), and synchronize_srcu_atomic().
> 
> As with other torture.sh tests, the --do-kcsan argument runs a
> KCSAN+PROVE_LOCKING variant of this test.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Queued for testing and review, thank you!

							Thanx, Paul

> ---
>  .../selftests/rcutorture/bin/torture.sh       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index f0083891ee81..8885812d866a 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -68,6 +68,7 @@ do_clocksourcewd="${ifnotaarch64}"
>  do_rt=yes
>  do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
>  do_srcu_lockdep=yes
> +do_atomic_srcu=no
>  do_rcu_rust=no
>  
>  # doyesno - Helper function for yes/no arguments
> @@ -103,6 +104,7 @@ usage () {
>  	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
>  	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
>  	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
> +	echo "       --do-atomic-srcu / --do-no-atomic-srcu / --no-atomic-srcu"
>  	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
>  	echo "       --guest-cpu-limit N"
>  	echo "       --kcsan-kmake-arg kernel-make-arguments"
> @@ -148,6 +150,7 @@ do
>  		do_kcsan=yes
>  		do_clocksourcewd="${ifnotaarch64}"
>  		do_srcu_lockdep=yes
> +		do_atomic_srcu=yes
>  		;;
>  	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
>  		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
> @@ -183,6 +186,7 @@ do
>  		do_kcsan=no
>  		do_clocksourcewd=no
>  		do_srcu_lockdep=no
> +		do_atomic_srcu=no
>  		;;
>  	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
>  		do_normal=`doyesno "$1" --do-normal`
> @@ -212,6 +216,9 @@ do
>  	--do-srcu-lockdep|--do-no-srcu-lockdep|--no-srcu-lockdep)
>  		do_srcu_lockdep=`doyesno "$1" --do-srcu-lockdep`
>  		;;
> +	--do-atomic-srcu|--do-no-atomic-srcu|--no-atomic-srcu)
> +		do_atomic_srcu=`doyesno "$1" --do-atomic-srcu`
> +		;;
>  	--duration)
>  		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
>  		mult=1
> @@ -497,6 +504,23 @@ then
>  	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
>  fi
>  
> +# Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
> +# (SRCU-T).  The reader flavor selects srcu_read_lock_atomic() and
> +# synchronize_srcu_atomic().  Tiny SRCU requires SMP=n, which aarch64
> +# does not support.
> +if test "$do_atomic_srcu" = "yes"
> +then
> +	torture_bootargs="rcutorture.reader_flavor=0x10"
> +	configs_atomic_srcu="SRCU-N SRCU-P"
> +	if test "$ifnotaarch64" = yes
> +	then
> +		configs_atomic_srcu="$configs_atomic_srcu SRCU-T"
> +	fi
> +	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
> +		--allcpus --duration "$duration_rcutorture" \
> +		--configs "$configs_atomic_srcu" --trust-make
> +fi
> +
>  if test "$do_locktorture" = "yes"
>  then
>  	torture_bootargs="torture.disable_onoff_at_boot"
> -- 
> 2.43.0
> 
