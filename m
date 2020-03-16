Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A88C2BB1D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E106F20663
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+2jjG9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgCPTBu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:01:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbgCPTBu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 15:01:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so19973276ljp.0;
        Mon, 16 Mar 2020 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uYS9cZdWtKTFC6QZP15A1SFEyRiM+LgzLbgPtkpg2cQ=;
        b=a+2jjG9h2jbGIyEpapdN41bb+yp39HLABRjvGCQ3sHW51zL5Tofdcwfpht1Kp+bIte
         c+518ZCnWaFTJ06didi9fCkNxPCnYjDUXSo9Gu3IXPNBP0MoFYStXFm4IgCxTeTLJ0nX
         xVcA3p2M/wv2Ce9eEYvRb5ltfWY/e5rsI3WVvMCfL7T3/IF/H+70RA7F4NdvUKHV2yRj
         etTnItR0BOJZqJICMOX39pEADGDsh5OecytZmztf45zfuoItAmylQ9bH3V8su4BRSlLh
         ty6EPHkqdbC1FeNkpq+Eh6rgNvGxgtM9AQ1gOIuWTtL0Y4YB2L6tIMIJBJcwID7lyE6c
         9a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYS9cZdWtKTFC6QZP15A1SFEyRiM+LgzLbgPtkpg2cQ=;
        b=Y8HEZ/pMW7Qj7ZXn7aanmk2IEEy9FBbcLSWajC1eexKNUOW8Zt7A9VMZKR4BVYTp6Y
         TNbZOLOhlXrZ6zGgJyAIAELJ4lmVIspzewd/8wk7q5F33L/az8/YAiWRvKwFBvGnoO5s
         WFQ3wiOqkpCUyzOHrDqTjjpU91SmriZysVICrqYl8B2TWyRZpfMDSOEvbj3bwLihBWsl
         yzwD8v+Sr03iuk7BtFlomKvMwjl7nYu/GeO1mGwAIjw8E61VnJ0/9afUIEMF5uKO4Zv9
         hv/iks0UFPpArefEoMBFoi6wmv1pOUOX+OCKn1tMIsb/K9Cz1KgnDzLlOR20IedwhH/z
         LZuQ==
X-Gm-Message-State: ANhLgQ3rx6RW/ouNXRXEbJAkOxhYaCF+iQUiKJTaPfv4xxTV22wtIpUY
        oJNivUNetecZr1kv2gSyK0E=
X-Google-Smtp-Source: ADFU+vsg7XN7vW5V0ynmb+c/FycF+ZyIBfNnZHxzDNjDOdNX6Nzrm7aYp9TED1NJgxGs9QC4SMk04w==
X-Received: by 2002:a05:651c:1114:: with SMTP id d20mr420122ljo.103.1584385307535;
        Mon, 16 Mar 2020 12:01:47 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u10sm454118ljj.88.2020.03.16.12.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:01:46 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Mar 2020 20:01:44 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-ID: <20200316190144.GB10577@pc636>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-6-urezki@gmail.com>
 <20200316152541.GD190951@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316152541.GD190951@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 11:25:41AM -0400, Joel Fernandes wrote:
> On Sun, Mar 15, 2020 at 07:18:39PM +0100, Uladzislau Rezki (Sony) wrote:
> > Rename kfree_call_rcu() to the kvfree_call_rcu().
> > The reason is, it is capable of freeing vmalloc()
> > memory now.
> > 
> > Do the same with __kfree_rcu() macro, it becomes
> > __kvfree_rcu(), the reason is the same as pointed
> > above.
> 
> Vlad, this patch does not apply to my branch that I shared with you. Sorry if
> I was not clear earlier, could we work on the same branch to avoid conflicts?
> 
It was clear to me. Basically i knew that you would be able to apply it
because of slim changes. I based my work on latest Paul's branch simply
because that my current setup was based on that, it would take more time
to switch.

Next changes i will base on your branch.

> I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
> tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree
> 
> For now I manually applied 5/6. All others applied cleanly.
> 
> Updated the tree as I continue to review your patches.
>
Thanks!

--
Vlad Rezki
