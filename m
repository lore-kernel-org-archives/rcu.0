Return-Path: <SRS0=P2/q=6T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE4C47254
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F11206FA
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWLdkhnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEESdY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 May 2020 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEESdY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 May 2020 14:33:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B08C061A0F;
        Tue,  5 May 2020 11:33:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f11so2730879ljp.1;
        Tue, 05 May 2020 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1A1CLPbro2Ce0m0/sfeeckkizp6g/6oLtB6WnuAQzhQ=;
        b=RWLdkhnm+FEgBbgZFjFXx6x04F7jV8MEc4+8/X5DTOQjZId9DaJO0l9dsiHpH7FIeH
         M+ovPPzMId8URTefVJFmFWf1ZTt+biAH27fHxgl2IZ1OYqzBWs0elXTJnDKQW/IL7JLy
         mebWXsF1ilwXrRdf8/3DXqm597YL+4xz6xmmr2RG8/A90LbNGQpEoU5EYn3Sv3hQ9r2B
         zlxsA3nLssGFLOuYMOR9T22IheC0k/q+7aTPyoLVepm4dELKyuZq7vBm+TDvuHl8VEqw
         ot8gvaqaMe+dNI85evH059SIUavAcWMf5VUfzFr22ufkHjsoIABOaZlnwl5TPnhuisuq
         HkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1A1CLPbro2Ce0m0/sfeeckkizp6g/6oLtB6WnuAQzhQ=;
        b=pnRQwFqiPzpKYLE8IImaJGupvP4NuXk61+oYlGlLYCPCYp03DZhxekUexnW+zhLu82
         XRpc+L53EOj1G9THXdxlnr0E+IZ7pB/yWq8zRqDB2p0egwbrkm23unYC5jJxH7YD/wKd
         Z2ylc9WyKfpMhpOLao56yLC2yoXLd7ceI5Wxvdmjew1qrTcQDJ/mcCXnP+3QWYRhrT6c
         FWZjTWWAzfMDXCFfQI/D3waYGd/sUQ9S3ThlUjHJCi9VtFheUUImzwOt3Ywn2hICg++z
         lFZiIFrnwhWg1+DsUzEWnQP+GM9aQZwepfG0OzModxemPhUIRP8QDGn5gAkAnec/Wrvr
         5dnw==
X-Gm-Message-State: AGi0PubwcE6p9tySgxgZapOdAcNWktkGG547QzkPJAhzRPqsKp6aMaJ2
        G6dapc464e+eUoU4IrmtSlo=
X-Google-Smtp-Source: APiQypIwq4XkX7k8PCo25yE8idLwl/YQxeBbdUHDLElkppj69emQ+ZSanadV9cQMgT9jQQJ1cX7Png==
X-Received: by 2002:a2e:7d0f:: with SMTP id y15mr2659763ljc.91.1588703602392;
        Tue, 05 May 2020 11:33:22 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y21sm2297981ljg.66.2020.05.05.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:33:19 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 May 2020 20:33:17 +0200
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200505183317.GA28175@pc636>
References: <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
 <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636>
 <20200423192115.GV17661@paulmck-ThinkPad-P72>
 <20200423195955.GA476@pc636>
 <20200505181743.GA109369@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505181743.GA109369@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > b) Double argument(with rcu_head)
> > This case we consider as it gets called from atomic context even though
> > it can be not. Why we consider such case as atomic: we just assume that.
> > The reason is to keep it simple, because it is not possible to detect whether
> > a current context is attomic or not(for all type of kernels), i mean the one
> > that calls kfree_rcu().
> > 
> > In this case we do not have synchronize_rcu() option. Instead we have an
> > object with rcu_head inside. If an allocation gets failed we just make
> > use of rcu_head inside the object, regular queuing.
> > 
> > In this case we do not need to hard in order to obtain memory. Therefore
> > my question was to Johannes what is best way here. Since we decided to
> > minimize reclaiming, whereas GFP_NOWAIT wakes up kswapd if no memory.
> > GFP_ATOMIC also is not good, because for (b) we do not need to waste
> > it.
> 
> Waking kswapd is fine, because it's a shared facility that doesn't
> just reclaim on your behalf but on behalf of a central goal: to get
> the freelist back to the watermarks. If they're low, somebody will
> sooner or later kick kswapd anyway to do exactly that.
> 
> So unless you ask kswapd for a high order page that is unlikely to be
> needed by anybody else, you're only doing the inevitable.
>
Johannes, thank you for the clarification!

--
Vlad Rezki
