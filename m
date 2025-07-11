Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B032EA484;
	Fri, 11 Jul 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248531; cv=none; b=WBBwPKoCS9LvNlQpg2V6GS6sY4z2mLWAkhDQajQk7tPK05fLX8sVQU7wpQjfruxLO+AQkMyyrQwZR9xJO8XAevaddCE1isDAwzztXVrHznB2+jPOvy0lIOSDPoV3aJfLaig0lrxDQqSkhKmlAIgbFEzb0s0Ja5Pta/7vbP/24hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248531; c=relaxed/simple;
	bh=c9D2JdWvApd7j6G1yN6JtXvcNmPAbbTOny/mSW3rsE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCe8X3TcJI1W/eNDxKxk/DR6spd4JJBo0WyLvZ2lERO87V82WkKSmakQhZ2z0GXK6wHR9X2nqT2Xx5DRWUsLfJLqrx3dopFhRoR5J1P97IJJl7oRLEea3AFl3Y73JM1kt6sfdwIZHBAxIkAdzS1Tr93QVs+gItMlcSWrh4chRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyYC3N3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyYC3N3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48F9C4CEED;
	Fri, 11 Jul 2025 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752248530;
	bh=c9D2JdWvApd7j6G1yN6JtXvcNmPAbbTOny/mSW3rsE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyYC3N3AmwRfD3yYXfCuPF0Zt6hUX3yToWu4nEah3WA1mtUHZ/WgCLk3uUiPgdNTk
	 7j3aAQKaPjsw7m2ucgR+xsCVrfBHY1Y0bAhyaslDoHbkw5rajbQuCOdgKdumIhqUI1
	 3LEeMW8AwvwgFGTaFvLHG2d5ovBlMm+wP7c48ar46AOOnZyFnlTPyAujnpxy0tmY5p
	 zbjarZQcvbswaZhAGk9oR1pyfgGryygBPfTUE7tze78rbCcZgwSMTzn8VbL+/pL5iL
	 FMZrpXz15dottzyw5ax2sv0m16LkKziagj99Hbkpl4y5K/MHl6+SPalFns0Mw8Ds6E
	 8OjpKUi03WKVg==
Date: Fri, 11 Jul 2025 16:42:04 +0100
From: Will Deacon <will@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joelagnelf@nvidia.com, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH rcu 06/13] torture: Provide EXPERT Kconfig option for
 arm64 KCSAN torture.sh runs
Message-ID: <aHEwzENaa9hNGt2k@willie-the-truck>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
 <20250709104414.15618-7-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709104414.15618-7-neeraj.upadhyay@kernel.org>

On Wed, Jul 09, 2025 at 04:14:07PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The arm64 architecture requires that KCSAN-enabled kernels be built with
> the CONFIG_EXPERT=y Kconfig option.  This commit therefore causes the
> torture.sh script to provide this option, but only for --kcsan runs on
> arm64 systems.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/bin/torture.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index 25847042e30e..420c551b824b 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -313,6 +313,13 @@ then
>  	do_scftorture=no
>  fi
>  
> +# CONFIG_EXPERT=y is currently required for arm64 KCSAN runs.
> +kcsan_expert=
> +if test "${thisarch}" = aarch64
> +then
> +	kcsan_expert="CONFIG_EXPERT=y"
> +fi

Acked-by: Will Deacon <will@kernel.org>

Will
