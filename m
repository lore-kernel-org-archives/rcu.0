Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FCC43219
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 11:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0423A34
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 11:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbhANLiN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbhANLhj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D0C061573;
        Thu, 14 Jan 2021 03:36:24 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m10so6062361lji.1;
        Thu, 14 Jan 2021 03:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifz4TFn+khIyJvPV2SClr7wzFb1XDFOLQogN3WDT4Qo=;
        b=vec6UOjx8zMPDVURW15aoBpKh/YOCw+/knGaIavNdwPxU3OWYak8LDzulcTs5zVtew
         hxZrKeyfzjRQP4386IexjECbrRs9D0bby2D6b9tkGA3eAGEGeRxBPZ7IIu1wP6WrJOW5
         2rVn2AGXIFpJseayQG4rBXL5PtA+Z2Xz5Qi3W8rth5X6xExSUVQREtQG0t2qgLTiLszn
         FUYbH5PPXTsBmGjHC2mjkWpvynbbWVK6w2WWp1JlIjOVvKe1Nvtchr+YCs5i2drylr8P
         FemjYCjWE4bQpRyJ3ypv8K6KTO9dB18ORfwa2p+2ggCkMYXb/9hJm0AHdKgJSIIb896T
         Z8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifz4TFn+khIyJvPV2SClr7wzFb1XDFOLQogN3WDT4Qo=;
        b=Gozbe9t56Rhq8LXuDtCVsWvsXTWqTFQjbaOMfFA2jge7mMmx/lU0pMrnwPoJv/Mz17
         RojtNV4DzO+DgJGyYuZXhh10lEsUDNluUMJNkGcZ97uUyM33jTIrlkNf9ED9nOii6syR
         n6h4NZTyzfEIinbaypzMG1lFlynmVbeewQAc6NyzAuvRjvpERKQtRxuS27qtv0K4b9MS
         jHJ3gpY6+xqlyFeekptmI3rNijOawP2EBcsHU9cjUgar+3RHTKGW5jpJe+aR1nBKQmdD
         LQ0yWcpzfLbaBpRpXpx2Q3hywqPgcqPR9KWcekE3FiznGrT0tvj37DfEMj5L4ofM4lUA
         heeA==
X-Gm-Message-State: AOAM532skFMQrc7CIEWo95UUN0NdsnxgSpKf+ptXGe35GpP2fJ44L6gg
        R9QuTIp6wOkiAaxgiJ1iFso=
X-Google-Smtp-Source: ABdhPJzAz+B2BPWZ8CjGGt6zXIGRXf90d4nFuPfWngg2W/+EI+kGLI0xddgXry2gSn6/mz3vOtd3EA==
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr2923025ljm.445.1610624182794;
        Thu, 14 Jan 2021 03:36:22 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n10sm431522ljg.139.2021.01.14.03.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:36:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 14 Jan 2021 12:36:19 +0100
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: better document kfree_rcu()
Message-ID: <20210114113619.GA49982@pc638.lan>
References: <2ec9a8bc8b411b04e2f541b285cc0a133a6d94de.1610608910.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec9a8bc8b411b04e2f541b285cc0a133a6d94de.1610608910.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 14, 2021 at 08:22:02AM +0100, Mauro Carvalho Chehab wrote:
> After changeset 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro"),
> kernel-doc now emits two warnings:
> 
> 	./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
> 	./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'
> 
> What's happening here is that some macro magic was added in order
> to call two different versions of kfree_rcu(), being the first one
> with just one argument and a second one with two arguments.
> 
> That makes harder to document the kfree_rcu() arguments, which
> also reflects on the documentation text.
> 
> In order to make clearer that this macro accepts optional
> arguments, by using macro concatenation, changing its
> definition from:
> 	#define kfree_rcu kvfree_rcu
> 
> to:
> 	#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
> 
> That not only helps kernel-doc to understand the macro arguemnts,
> but also provides a better C definition that makes clearer that
> the first argument is mandatory and the second one is optional.
> 
> Fixes: 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/rcupdate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index bd04f722714f..5cc6deaa5df2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -881,7 +881,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu kvfree_rcu
> +#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
>  
>  /**
>   * kvfree_rcu() - kvfree an object after a grace period.
> -- 
> 2.29.2
> 
I think it is fair enough. I checked the "kernel-doc" and after this
change it does not detect any violations which are in question.

Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
