Return-Path: <SRS0=NM8h=7M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17516C433E0
	for <rcu@archiver.kernel.org>; Sat, 30 May 2020 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB3E20810
	for <rcu@archiver.kernel.org>; Sat, 30 May 2020 03:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwhUp+XC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgE3Dwf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 23:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE3Dwf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 23:52:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351BC08C5C9;
        Fri, 29 May 2020 20:52:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so1979552pll.6;
        Fri, 29 May 2020 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPOEe0JbVvrLWjGaJsUspJAO9HZgDhlEO7PFO+DveQY=;
        b=JwhUp+XC4a1LWTAe8MZOAmnETNMbz6+6Zg7TXk0gxk2/vNOv/Slq/wzn113wv05uE8
         TexJwxstEMyX527uiIIuZ4ekfScAY+F0RHP2mGlntzFZVWQMMP9uk8Uszp/vAf4XJTcQ
         83wljVSm5fcXv2z4Z8QIOu97g9CBXY2rXrO1DXHrF7+ds2hADVTy69jj78r5K3w/r9X6
         rEEfbXmDA2OVXmzhDq+eUPS2iCfDA3jANYlITsDJNLxVhPAFWmtrZ7QcWcWhYUTFAqnF
         PadvIN8ZuHCLj4NHueaiNhFs5xUn4oEtYVnXKfEtNsSj5czjHTNUUECNbi/5oHsj78Ml
         57yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPOEe0JbVvrLWjGaJsUspJAO9HZgDhlEO7PFO+DveQY=;
        b=lYw5eRyVa2fg8w2hCIwuwBxvFsSCBU/AGGUZEE7yy6m3u6U/sV//E39wy24VT53VlM
         nLLhFjt6kXDGZNbeZNPTCbUHRH/CgSjAuvdaUQ0JRs/xK45RJjfTHZyvFYNnyXJGeFIU
         IlhJOtXHFe+ynYAX88dG9JUsLewM3bZLw54Z+k8r1VzigJCsEdn862fiSdYqgk4LSZQu
         YmzmT+G4d/M06IilRGuIHIbR0igOUB/Fn2KvdO31wT4ZWS4725lg4iNfgqVY2oBh3G/f
         lAlfKefZe89+MKns5649fP51kZrzzja6Oy2+ez5FkZ0rLnWEyz5T8JIUxQDTRF4S/R3/
         0nxg==
X-Gm-Message-State: AOAM533GCDO/75PkSb678shX9vo5ouSkEDqYOMNRP4wHm4r/TVN42xxf
        FDvJNmU7bclx+Ck7tNnDBoM=
X-Google-Smtp-Source: ABdhPJy+/Cu2agx0IBXD8cxTeInLVAkrgdDBRiWPqaIqKU3YAm9YiTFMMZrZcVNapJyX3yPVkoGUvw==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr5466742plb.241.1590810754080;
        Fri, 29 May 2020 20:52:34 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id gz19sm731850pjb.33.2020.05.29.20.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 20:52:33 -0700 (PDT)
Date:   Fri, 29 May 2020 20:52:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refperf: work around 64-bit division
Message-ID: <20200530035230.GA2019114@ubuntu-s3-xlarge-x86>
References: <20200529201600.493808-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529201600.493808-1-arnd@arndb.de>
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

Shouldn't this be div_u64_rem? result_avg is u64.

> +		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);

Would %03u be the better specifier since rem is u32?

>  		strcat(buf, buf1);
>  	}
>  
> -- 
> 2.26.2
> 

Cheers,
Nathan
