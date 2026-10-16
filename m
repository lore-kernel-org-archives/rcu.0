Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84C391822
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163521; cv=none; b=p3tyecjB6jlINIzBBX2LFizI1DIX+prwnRZcwk4LglyxC57iNectfoFmhRG7YoSYwmZRsJfgl+PUWshxcqOHRz6bhCrau+/3bhPzuTqpvYHAK+QDeP4JSZGZ+EUL3PMQ2OHHNl8ByvFsIIVoQM9THhrsvPfFVMLc0EIq8QLoWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163521; c=relaxed/simple;
	bh=K3qKxMNUPwofwcMVw6AztQj1Dc0FdGqn6xi15BKgOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB1c8wqH1fIsSujRa3+lcIqag/K72S9r4SD4TEuPj412W2g6j5JOT7KmUIWB6LbpZEBAAUMuWk7WK/jnmSSzr2D+xOilc/6q1kUoIox2kRPUl+zNng4WPuuMGNSbira2Y4zKpwus2NkiuzTsnwmOIdm2us0E/o1P/zOWBylY2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxGWTmJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxGWTmJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A01F000C4;
	Fri, 16 Oct 2026 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163520;
	bh=4RpPZrd6WheY+MQ8vOvNql28iKd0YDrJ4fYQy14qA8U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lxGWTmJxarhthAiZ1CkZRtPiGqyVqNg7fdgL+d7Jn2TGPkkJc+AEVLlJI3jvoqL1C
	 hmHs1hAO/Ie7mk4RqIIsIVFqCEKc63r9S/oU5dN+xm4yB41/mA6hPEmlKsm62KI2OO
	 pghB8w3xH/aobmE21g0DbziyZKOmp8Y6eauWF9jWxkgSeDUwEBSAb+XQ6QlhYmPBS8
	 SHcyvoMMF0IDKvFbogDHhuDBEdmMea+h/30SGsPyLnr3EstqRdrVhxsXjBP/gp7ffS
	 f6h83cMHDphFeAzYDA4HzbZR4LVUZPNlAQdLnF0z+TGQKxrlGKDhks1HEEGZAnaEvu
	 43cvyJ9cgLsaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D88BCCE0854; Fri, 16 Oct 2026 08:11:59 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:11:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
Message-ID: <b18525e9-0508-42f3-8640-3177c5581926@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016102657.2347381-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016102657.2347381-1-puranjay@kernel.org>

On Fri, Oct 16, 2026 at 03:26:56AM -0700, Puranjay Mohan wrote:
> kvm.sh builds the kernel in the source tree, and kvm-build.sh and
> configinit.sh expect .config and the build products to land there.
> With KBUILD_OUTPUT set in the environment, make instead writes them to
> that directory and fails with "The source tree is not clean" or, worse,
> clobbers an unrelated build.  Unset it so kvm.sh works from such shells.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Good point!

Should it (non-fatally) complain if KBUILD_OUTPUT is set in order to avoid
silently surprising any users expecting build products to go elsewhere?

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index 86dd5c131d226..ee8266156254b 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -22,6 +22,10 @@ cd `dirname $scriptname`/../../../../../
>  # This script knows only English.
>  LANG=en_US.UTF-8; export LANG
>  
> +# The kernel is built in-tree below, so an out-of-tree KBUILD_OUTPUT in the
> +# environment would send .config and the build products somewhere else.
> +unset KBUILD_OUTPUT
> +
>  dur=$((30*60))
>  dryrun=""
>  RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
> -- 
> 2.53.0-Meta
> 
