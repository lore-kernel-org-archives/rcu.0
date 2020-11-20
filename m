Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C8C56202
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4A422255
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+RENnwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgKTL7k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTL7j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 06:59:39 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8BC0613CF;
        Fri, 20 Nov 2020 03:59:39 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so13034353lfe.12;
        Fri, 20 Nov 2020 03:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ibvwxqqWhUDi9O2xUIvhnipfczvPxS9v9Q92lXKwNA=;
        b=E+RENnwRFPmloIRPsPF9987TnDlBNl4sW1tDkyIco/g/xYrJOqer8TOpyfTxsXsYLH
         TEvc4Mpo6P1v+D+ZG/Yn4KJYCrHwBS8sgzZXs4ZmvWlxqHaa4xQHhfncg5sBW0+GzaZU
         1jtfUiwYZYRniUz37Sygfv9w+aPYhTBPE2efFOQcEjbEAguytG6L9T9hVpvf7c0pfFPU
         XPsb3bKDs09QQ+WESoznWSP5JgQF1DhAcGCiyq68ws+mc2/dD+wpOW06BCDODr+Oy1+z
         qVw8VOzRqDX6Zy6PHJpO0gyyK1uzhixT9BDRCdyTjNnmYB0UTgHf51eBidTpsLHlpeN7
         +9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ibvwxqqWhUDi9O2xUIvhnipfczvPxS9v9Q92lXKwNA=;
        b=n9TDfIUvxWNJ0McAgPfIfDLQLE2j5w2hS4KdEVf1brALF5LTEW195vGYC6WBzZqeNO
         tvVbcLhnjH8sOVD/pm+ZL5WvXeqGxgi8bTAfvilh2qCbEnZdQflFM3scweyJHbLhL7TU
         fHfZRTLmS2b5lFG4l+uR5IU6C/tuiYAFg8FwoaDkbJZeuB/3j8w8JTIzJtgNdOWdh5On
         7hx7eB77BslJcbgeMz+xnxnN8pNpm6Eoz7s4YK77qQpWSvx0uso6ar6LhNUk0wJjcjAl
         LkArwlQTTJwI6KMEXq9LTVAsvu7efL2Pep69TW+ni+2Ebu+SfYZmGzG/OO8xvKqlZD+4
         vTUw==
X-Gm-Message-State: AOAM531Zoaeq8l/Md9atxkiQQg+W6hqOi9cZ2rP0htdKejmBt8TQ6e4g
        LEhc8RCkvpQoBq9CvvQU8Ys=
X-Google-Smtp-Source: ABdhPJxwBMYpxCJ5Z1QnjvybI2+pP5SKY3ok0iFap91fslmRlgBzgQpR5eVf5Tgqs0xp2oPvBhPSxQ==
X-Received: by 2002:a19:e21b:: with SMTP id z27mr7441956lfg.409.1605873577627;
        Fri, 20 Nov 2020 03:59:37 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id h12sm322311lfl.74.2020.11.20.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:59:37 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 20 Nov 2020 12:59:35 +0100
To:     Zqiang <qiang.zhang@windriver.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        urezki@gmail.com
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
Message-ID: <20201120115935.GA8042@pc636>
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119214934.GC1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:49:34PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > From: Zqiang <qiang.zhang@windriver.com>
> > 
> > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > record call stacks.
> > 
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> 
> Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> See file:///home/git/kernel.org/rcutodo.html for more info.
> 
> Adding others on CC who might have feedback on the general approach.
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index da3414522285..a252b2f0208d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		success = true;
> >  		goto unlock_return;
> >  	}
> > -
> > +	kasan_record_aux_stack(ptr);
Is that save to invoke it on vmalloced ptr.?

--
Vlad Rezki
