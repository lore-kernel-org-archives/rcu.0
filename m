Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BE1C5F07;
	Thu, 23 Jan 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664186; cv=none; b=PCjm864PsAheo5/jqMtq7GV7fg+02e43+Zl8saQCvHlXQppAhSaBeZItf2NpB1waxMpWphO5oeynJuaqPDNPukUhhyr4HbNV3FPIJ9u+/OQNQTpZQEndyWrAEKiFCVLlRGO7K2bepm9diZmCuhwHCgZKfPxrpj/2f9RLy8ZHjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664186; c=relaxed/simple;
	bh=a2a9hezRmN5rsRe6Ifva6Li9ODTCcJNcen6gHodmvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6MZgGucYCUn3vhYZ9lu1+IjrnXCvuUV5Vgtksu2xQ4w/qvhI7NIm3SoUI/ZHEM6WWbybqy8XBc7OfsW52OHQj1CTnCaQpRIXMUVvjGgX/rgUY08mUFD7vXT9pTDHtcIe14rLCi8lF6xwH0AUAzW5HQqIj7RuXF73PqVKGF3MIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATT7z0v1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATT7z0v1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E058C4CED3;
	Thu, 23 Jan 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737664185;
	bh=a2a9hezRmN5rsRe6Ifva6Li9ODTCcJNcen6gHodmvjc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ATT7z0v1IJK75I37+6iXa1OG1268VxAevkj18r275DiCddChQnlozhMCTP6OOyRxF
	 B0ubwnzTPkDJsBK8Laa4BInPOCFqnEwosylC0LIg2vSTqvrh/A0fM4ZrQX7c9DoG0z
	 Sz7DX8fqyuRl0SQXDWR7OSbe6lCC+diC/KeaecrVwUBwqDvsiZal3WI9ZI6WAZwhAe
	 WSBsb4R/JYzbz+8HkWYymgPfj9gnCv8a/rHiIyUpzyKm2tbd5KGFDqrx/qjMmfZjpf
	 zAXX3N7DGV6YOfsYW8s/P/SzW9cC3iOo4pviLbcfBwIFw+uLzM+OLqQs8f0LHCkY/r
	 jJ3FQsQQWnXbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14FB5CE0C56; Thu, 23 Jan 2025 12:29:45 -0800 (PST)
Date: Thu, 23 Jan 2025 12:29:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123185828.460836-2-urezki@gmail.com>

On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> This configuration specifies the maximum number of CPUs which
> is set to 8. The problem is that it can not be overwritten for
> something higher.
> 
> Remove that configuration for TREE05, so it is possible to run
> the torture test on as many CPUs as many system has.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

You should be able to override this on the kvm.sh command line by
specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
For example, see the torture.sh querying the system's number of CPUs
and then specifying it to a number of tests.

Or am I missing something here?

						Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> index 9f48c73709ec..d6fbb82e3e6d 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
> @@ -1,5 +1,4 @@
>  CONFIG_SMP=y
> -CONFIG_NR_CPUS=8
>  CONFIG_PREEMPT_NONE=y
>  CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
> -- 
> 2.39.5
> 
