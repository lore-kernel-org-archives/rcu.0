Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB751ADC7D;
	Thu, 23 Jan 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664224; cv=none; b=oChjEgzxEh5f5wTrnZGT+aTfHZZKzc6op+Zzaf6Guhb+Y9MpWtFq8D+ol4GhSmD3wkHtPwvOcfIWb2LaKo2RNUGA30FPcK94cey5fVHFCE8e1KUA+t7wYjjlflagaSsGckFZsGPltTVJt6H4z9/vFLEYwGYXep5iMax9MIaffv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664224; c=relaxed/simple;
	bh=qbapeJt0ClS7PLhxg4ULrYuH98zmfBYba61jRgt2qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWpWa2WdxHTuSStUIhe27/R7eMRt26L7l6qiiZUGhoKR5KOo6pIImqTHXpeZo4ZrM1eq3EfChTwEzfIBdPTEkpcknWE1tzhNtcBDcobQsjrpTpeakKEyhSTP+Kj/+hAQSintQ7UdZGd52tAhngXTx8C+RbSFGu9KIY4ZWr8Yx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFyWM9b8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFyWM9b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E2BC4CEDF;
	Thu, 23 Jan 2025 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737664223;
	bh=qbapeJt0ClS7PLhxg4ULrYuH98zmfBYba61jRgt2qjk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IFyWM9b8VoXapoLxX0pNZ/a+JZ7/GjcawaWt5dH8F6Bzg+GJxZCy8fRiyZDNn3osC
	 xFeZiii6Ma+5e8rhrkK6BZg4KHIaaZE8kFgSchIwBpaMR34I3OUXkEVOXvQkPZaS8F
	 K8BlhqG8RWl0zZKbjwhHO7lgDsNHSextw0ZKBmF7LRbQd+pZZNFvO6CQGoqsA1WS9W
	 FViF8SdipliWASHzqdBA3uatRaNx77WgTr9Nob0altgBET6E9D6UzSHLpBKTL/vVWp
	 nBEm7PpOCPeDMTL9pXbGL0xkm9XV/HSkSxDELlW3VOwIRewCcUCYEveNv5zf8qeBOP
	 fxc36RnvetUTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 685DCCE0C56; Thu, 23 Jan 2025 12:30:23 -0800 (PST)
Date: Thu, 23 Jan 2025 12:30:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 3/4] rcu: Update TREE05.boot to test normal
 synchronize_rcu()
Message-ID: <a4972f84-e3dc-4ecb-a53e-21ef9cf856a9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123185828.460836-3-urezki@gmail.com>

On Thu, Jan 23, 2025 at 07:58:27PM +0100, Uladzislau Rezki (Sony) wrote:
> Add extra parameters for rcutorture module. One is the "nfakewriters"
> which is set -1. There will be created number of test-kthreads which
> correspond to number of CPUs in a test system. Those threads randomly
> invoke synchronize_rcu() call.
> 
> Apart of that "rcu_normal" is set to 1, because it is specifically for
> a normal synchronize_rcu() testing, also a newly added parameter which
> is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
> with other callbacks in a system.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

This one looks fine to me.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

						Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
> index c419cac233ee..54f5c9053474 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
> @@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
>  rcutree.gp_init_delay=3
>  rcutree.gp_cleanup_delay=3
>  rcupdate.rcu_self_test=1
> +
> +# This part is for synchronize_rcu() testing
> +rcutorture.nfakewriters=-1
> +rcutorture.gp_sync=1
> +rcupdate.rcu_normal=1
> +rcutree.rcu_normal_wake_from_gp=1
> -- 
> 2.39.5
> 
