Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D1C433E0
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C02071A
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 21:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590788482;
	bh=6n+Rp4FGRExT/6myULM6CpFZrhrN2xWEy5n1d1ABetU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SwhrO5F6ZwESdmMkwC62/xEiVbPZnPOfcuQz42U8SRKcM3jvQ/jaKJN9K1Ogu3DeM
	 bwwoHH21agEB9jU+zpuhbMAfLpxIM7H9iCE5/ZVxM55aADTe1z2hethTzJnuBvZ741
	 Se/jKbBMIh3arTf4IpB57Su0p/hxV1AO8tsbNrWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2VlW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 17:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2VlV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 17:41:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343DF206F0;
        Fri, 29 May 2020 21:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590788481;
        bh=6n+Rp4FGRExT/6myULM6CpFZrhrN2xWEy5n1d1ABetU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zTbpR2JsYpqV4B2drhOeBqsfvd4ZouKKZ2EFPMBIZCGzKDSVbitYyp998/6FMYfPg
         N31Wloe8lu9P3yDjWGUts3A5C2cg4et2ENCUXXrQg78SOmv9+L9Tzd120qCWdws0B+
         M9w3kpvESPtHAI6bh0o3ug1zQJM4T/QOKtvFqZmM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1BFE93522A6E; Fri, 29 May 2020 14:41:21 -0700 (PDT)
Date:   Fri, 29 May 2020 14:41:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refperf: work around 64-bit division
Message-ID: <20200529214121.GH2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200529201600.493808-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529201600.493808-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 29, 2020 at 10:15:51PM +0200, Arnd Bergmann wrote:
> A 64-bit division was introduced in refperf, breaking compilation
> on all 32-bit architectures:
> 
> kernel/rcu/refperf.o: in function `main_func':
> refperf.c:(.text+0x57c): undefined reference to `__aeabi_uldivmod'
> 
> Work it by using div_u64 to mark the expensive operation.
> 
> Fixes: bd5b16d6c88d ("refperf: Allow decimal nanoseconds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Many thanks, Arnd!

I queued this and reverted my earlier 64-bit-only restriction, pushing
the result out on the -rcu tree's "dev" branch.  I also added a couple
of Reported-by entries.

							Thanx, Paul

> ---
>  kernel/rcu/refperf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
> index 47df72c492b3..c2366648981d 100644
> --- a/kernel/rcu/refperf.c
> +++ b/kernel/rcu/refperf.c
> @@ -386,7 +386,7 @@ static int main_func(void *arg)
>  		if (torture_must_stop())
>  			goto end;
>  
> -		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
> +		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
>  	}
>  
>  	// Print the average of all experiments
> @@ -397,9 +397,14 @@ static int main_func(void *arg)
>  	strcat(buf, "Threads\tTime(ns)\n");
>  
>  	for (exp = 0; exp < nruns; exp++) {
> +		u64 avg;
> +		u32 rem;
> +
>  		if (errexit)
>  			break;
> -		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
> +
> +		avg = div_s64_rem(result_avg[exp], 1000, &rem);
> +		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);
>  		strcat(buf, buf1);
>  	}
>  
> -- 
> 2.26.2
> 
