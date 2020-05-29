Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4796C433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2A320776
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFsl90J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2WM6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2WM5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 18:12:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC55AC03E969;
        Fri, 29 May 2020 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=guXJIbvG+ThJuWW2hX2ZFCQM4ufU8AoE3UEwleDZrc4=; b=hFsl90J4G3OC+wPnUqc/v54uk0
        vERN4ROMNF+7yE1+VRq9BemvvliBdpKXQT0PhcKZlVIKH8gGRzfBuCPJWpSJxtwrc1dsNCwB1/uIn
        8got+A2tGqzZJPjbmvNqv/jIRYktHb+lJ3rkST4itqR/Et3en5MceKXTU7Hs5SC0AFyRl5Skrc23k
        XTIbYCijZpElbmqRpH+kenGL16mZwNC5qdVjdVMP59LUQU5lgF2WaZFHiOsxKjvOLI2PBGJztEOww
        Vna1v281YEERzw4veFAIraUzGB7+BrY8WJpN+LypwHYL4tNKlu3vVW9x4qWh+Eb2VCjz5yH9bOQYM
        /ERss4jw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jenFF-0000Gv-0m; Fri, 29 May 2020 22:12:53 +0000
Subject: Re: [PATCH] refperf: work around 64-bit division
To:     Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529201600.493808-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f86f377-9ef9-779f-2022-a2f5d35e7d37@infradead.org>
Date:   Fri, 29 May 2020 15:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529201600.493808-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/29/20 1:15 PM, Arnd Bergmann wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

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
> 


-- 
~Randy
