Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22681C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF66221F4
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEYNjhgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDPVoR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVoQ (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:44:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2DC061A0C;
        Thu, 16 Apr 2020 14:44:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so428258wrd.0;
        Thu, 16 Apr 2020 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sffAzPhQCHYxlONYOcziAs0q3Ct9dInBstNF3EUot0A=;
        b=YEYNjhgXkDenCpaBe24hLDaEJUvQf+AFbMkJW/M52iScpAsaPalPvb+cBzOAG4sWqw
         VJUdkzApo+PR/PcD6/dpOypTZD35Cn+iYnDeBotGPwhxW08ok2pII37KP12YBWBlEwTj
         zS3zoJ2kQuuLQtrKMIjJ6DVsVTg8gG34PMl4nMQ74O565/TEoKtCiFFquOfmKc3B2e2J
         jqMcujTLmug9H9x8b31CN1vi6tnRVlZBCDvetFwy1hXGPaVV+BD9Qxq+EkGT5rwDQi49
         lF2n9nFXAJNuIsIwNgPL566gMYGIiLmAyOLLCCQBJgYKHpjRsA508DIsMGXw27uti8u1
         3naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sffAzPhQCHYxlONYOcziAs0q3Ct9dInBstNF3EUot0A=;
        b=HIxTGV2oRdRTTeyPyu4t3eZBnA/PS218S2OrxeE1cPn1nZmHyQV8Shx4ST7LWoMqed
         QNW8ThFZIl9/f12yaKuKF/Vgm5La6yHH8m6EZhLzzocD9i65eZ6xqMjIQDNu6fB6Sip5
         BpZWOnn6bueK0Tc/Cdc+W8gRaf8vn2m6lMS9dJJ88tBnvD5e0Kdgj8ZPE7g14ot+75Le
         MxB1o7pR7jgrfVuTVjVRHhKiYcrzZAxkyXz+IFtJ6Znh6K5mG3Go/2lHSpwZLwUzFYot
         C1NAE3EvcEZYoV7YTTbKgNJnADSVyrGfNTMEcxJ0MgMsgSAoSjtpq7Wt8ZmFsKBzrJsz
         AuHg==
X-Gm-Message-State: AGi0PuYlr8HoOfNAF5hO9L4EFxDrVqufnC74/Y8Umth9EtjLSTML57X+
        NkgPaizFuIhE/VtC3D0SnT8=
X-Google-Smtp-Source: APiQypJKY7xZFLf/Hax5amZPWqkmcol0SYTy6Ns1Cqz64Wk+JcRO5hXIDf9tGCtdetce2kIblVptsQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr275421wrw.318.1587073455065;
        Thu, 16 Apr 2020 14:44:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s27sm20203721wra.94.2020.04.16.14.44.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 14:44:14 -0700 (PDT)
Date:   Thu, 16 Apr 2020 21:44:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, josh@joshtriplett.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: init and destroy rcu_synchronize when necessary
Message-ID: <20200416214413.uabk6ojzykiy5rol@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200415222655.9006-1-richard.weiyang@gmail.com>
 <20200416002400.GL17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416002400.GL17661@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 15, 2020 at 05:24:00PM -0700, Paul E. McKenney wrote:
>On Wed, Apr 15, 2020 at 10:26:55PM +0000, Wei Yang wrote:
>> We would skip the rcu_synchronize if it is a duplicate call back function.
>> 
>> This is not necessary to init and destroy for them.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Applied, thank you!
>
>I edited the commit log a bit.  Could you please check below to make
>sure that I didn't mess anything up?
>

Yep, the changelog looks good to me :-)

Glad you like it.

>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit d9eaddf545fe8e3e2725e2fa0bf87b59b5667c14
>Author: Wei Yang <richard.weiyang@gmail.com>
>Date:   Wed Apr 15 22:26:55 2020 +0000
>
>    rcu: Initialize and destroy rcu_synchronize only when necessary
>    
>    The __wait_rcu_gp() function unconditionally initializes and cleans up
>    each element of rs_array[], whether used or not.  This is slightly
>    wasteful and rather confusing, so this commit skips both initialization
>    and cleanup for duplicate callback functions.
>    
>    Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>index 3ce63a9..351c322 100644
>--- a/kernel/rcu/update.c
>+++ b/kernel/rcu/update.c
>@@ -391,13 +391,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> 			might_sleep();
> 			continue;
> 		}
>-		init_rcu_head_on_stack(&rs_array[i].head);
>-		init_completion(&rs_array[i].completion);
> 		for (j = 0; j < i; j++)
> 			if (crcu_array[j] == crcu_array[i])
> 				break;
>-		if (j == i)
>+		if (j == i) {
>+			init_rcu_head_on_stack(&rs_array[i].head);
>+			init_completion(&rs_array[i].completion);
> 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
>+		}
> 	}
> 
> 	/* Wait for all callbacks to be invoked. */
>@@ -408,9 +409,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> 		for (j = 0; j < i; j++)
> 			if (crcu_array[j] == crcu_array[i])
> 				break;
>-		if (j == i)
>+		if (j == i) {
> 			wait_for_completion(&rs_array[i].completion);
>-		destroy_rcu_head_on_stack(&rs_array[i].head);
>+			destroy_rcu_head_on_stack(&rs_array[i].head);
>+		}
> 	}
> }
> EXPORT_SYMBOL_GPL(__wait_rcu_gp);

-- 
Wei Yang
Help you, Help me
