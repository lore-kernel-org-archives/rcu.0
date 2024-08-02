Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B21EB4AB
	for <rcu@vger.kernel.org>; Fri,  2 Aug 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567681; cv=none; b=W7qx16VU+H2FDzp35HJfeGdzmr6Bgw8jLbXwUCFTBwVeiwpZsL0Jv2ivm+oCfs5v72C73IIncGovurxyxuqcN+MHjgHBZyiIdjWZSKM1L+MYFBWPDfjgpCxBQ7X2taJ0YEUhLUyW3DmFnyXoQVssokc7B07AaFfx7+1aU1B0EvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567681; c=relaxed/simple;
	bh=oYJkLj89UCyzyGgF62Sb26I22RTfMZyRd7vlYxmXY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK1F8UemeBbA/lQ09F8AXRTomeOS2uxfTINgZMeLpS1TNXGCrcqd32q6WP4a+kfOaoHfGSNUf50NbeE36klkHnbiQ2tM/3oqfZm5GajehdKN1MN7RGKPaEY4uNGZEXTruIUbDmZR0XmKIhudsZ4+/V90E8bjk2ZeSeAQKFCU/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb7Rzdsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb7Rzdsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E973C32786;
	Fri,  2 Aug 2024 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722567680;
	bh=oYJkLj89UCyzyGgF62Sb26I22RTfMZyRd7vlYxmXY7E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Mb7Rzdsn5IsTtlrxfOVsOJTXt5IGUDF9CuHcAyd8SUfeo+YcTTxYiAnPQUvone5UV
	 b3M8G//X2EWqhh69W4gxqZT6uAFGVIF+z3Du76G5AtrYTigmDxsujnSvJj3eZghonU
	 8kFaWRW7yRfN60Yg53rBwwPFRub/BoXi8HQJOkpoVAKcirWQeWdtgwd058Rfc8XCwI
	 SPljw6KTIHzCmYPHoqIhTkD2PTymQt90kJpGTXya7BsRrrlPdIkxQCCRxhYzjaUsi3
	 ODlnz9TF5MBVxra6+tDJb5n10QAX85MRLpESn+tAMhDo3XtjmHCVWeutFh3ILy/rUh
	 xlNi8K8begoOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24A24CE09F8; Thu,  1 Aug 2024 20:01:20 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:01:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>

On Thu, Aug 01, 2024 at 09:48:45PM -0400, Olivier Langlois wrote:
> fyi,
> 
> I have found the source!!!
> 
>      test_kraken-695     [001] d.h.. 21957.157432: timer_start:
> timer=0000000076c6a349 function=mix_interrupt_randomness
> expires=4297132992 [timeout=0] bucket_expiry=4297132993 cpu=1 idx=1
> flags=P
>      test_kraken-695     [001] d.h.. 21964.197366: timer_start:
> timer=000000006ea403de function=do_nocb_deferred_wakeup_timer
> expires=4297133697 [timeout=1] bucket_expiry=4297133698 cpu=1 idx=2
> flags=
>      test_kraken-695     [001] d.h.. 21964.197368: timer_start:
> timer=0000000076c6a349 function=mix_interrupt_randomness
> expires=4297133696 [timeout=0] bucket_expiry=4297133697 cpu=1 idx=1
> flags=P
> 
> enqueue_timer() is calling trigger_dyntick_cpu()...
> 
> the vast majority of these timers are from mix_interrupt_randomness but
> there is also the occasional do_nocb_deferred_wakeup_timer...
> 
> every time I see a trace, at the same time, I see the interrupt count
> increment... there is possible doubt...
> 
> Now, it is time to find a solution or a workaround but I was so happy
> of my discovery that I wanted to share!

Very good!!!

The do_nocb_deferred_wakeup_timer() is due to call_rcu() being invoked
in a context where it might not be safe to do a wakeup().  RCU doesn't
have a lot of choice in this situation, so the usual approach is to
figure out what is invoking call_rcu() on your nohz_full CPUs and to
make it run elsewhere.

I don't know what is happening with mix_interrupt_randomness().

							Thanx, Paul
