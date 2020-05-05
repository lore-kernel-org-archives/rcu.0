Return-Path: <SRS0=P2/q=6T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22436C47254
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 18:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D5C20663
	for <rcu@archiver.kernel.org>; Tue,  5 May 2020 18:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="g0cWg6Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgEESR7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 May 2020 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgEESR7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 May 2020 14:17:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C371C061A10
        for <rcu@vger.kernel.org>; Tue,  5 May 2020 11:17:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so3356364qkg.1
        for <rcu@vger.kernel.org>; Tue, 05 May 2020 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIiFqeYteULkt8HMXHFpwisB9MG8IKcghiZqCMsoJ0I=;
        b=g0cWg6SkdohT/vZF+L3QxQRRKnCQYIjurKEE6hl5xzqEYuQiqBcmUrC+JQPXp8O1TN
         HQSXJxGfRGkqYGXiM6V9+JhCYn6OUadVtrBqlrMuvKhLKncFXEj6eRvKcqeZ6QP8wVf9
         4h81ocOjTyHlbB1rWLIF47faxU2noJt8Gbcd9t7B7URgQvKiEtgcZ42A8EyZQ00/m2/C
         Wc3ewrATPCp+GxMnOMzHhY55vcuFBhXQhipjo3J2w2VsG85e47AtrUSQx9UZA6qvRmxC
         RApjwNKqE7U0DrElZuV6UF3sZKup1FaogxFi1ccOpTiR6MINHEgiBrt1AqsZRhR8KGj/
         84Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIiFqeYteULkt8HMXHFpwisB9MG8IKcghiZqCMsoJ0I=;
        b=QkMnfRcZNIehePQarJpmPLyHOCcM5XQvizqg5ugE13GhjCIECP04ZF9i13IP9WmqD4
         zajfNJDeGkMzmVArc+eJnkhX+ZqJMmBXFBH9pyPaunlZD/q67dKZ2MTFFN37CJRdNjTS
         mzI56q27Y841ff+Z+3Cz6wMgRaci3BcbSowS6GF5IX8x0x8kRkGkdLaU+bTE0J2H0KO1
         qSrT+pVFNidkNzMqzJzqOGNVfr79/Czk/ILy/t9wztl8LmEFm3hf4FbOYGBoGD0rXkB7
         +6m2MJf4xtUe6uHPSCJGDWTngnfF72WxUE3kYYVJOpBfV8G/E+CIBuisAPOpGC71BXO8
         ZQlg==
X-Gm-Message-State: AGi0PuaRdHqZ6RHyOnXwD+ySaYCAsU/SGELzpCipM5YuPCmdTOW2vHnX
        ue+iWOnJlwffkenSsMMzs1bCmA==
X-Google-Smtp-Source: APiQypJpAEYkFq2pucmgqMDdD7u0YkaYfB8Yx+SoZ7vYqW8xB1eQ6l7p5WKDojX4s1Ivx/jdf5bZmg==
X-Received: by 2002:a37:9d55:: with SMTP id g82mr4120636qke.407.1588702678150;
        Tue, 05 May 2020 11:17:58 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k2sm2602061qta.39.2020.05.05.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:17:57 -0700 (PDT)
Date:   Tue, 5 May 2020 14:17:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200505181743.GA109369@cmpxchg.org>
References: <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
 <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636>
 <20200423192115.GV17661@paulmck-ThinkPad-P72>
 <20200423195955.GA476@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423195955.GA476@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 23, 2020 at 09:59:55PM +0200, Uladzislau Rezki wrote:
> b) Double argument(with rcu_head)
> This case we consider as it gets called from atomic context even though
> it can be not. Why we consider such case as atomic: we just assume that.
> The reason is to keep it simple, because it is not possible to detect whether
> a current context is attomic or not(for all type of kernels), i mean the one
> that calls kfree_rcu().
> 
> In this case we do not have synchronize_rcu() option. Instead we have an
> object with rcu_head inside. If an allocation gets failed we just make
> use of rcu_head inside the object, regular queuing.
> 
> In this case we do not need to hard in order to obtain memory. Therefore
> my question was to Johannes what is best way here. Since we decided to
> minimize reclaiming, whereas GFP_NOWAIT wakes up kswapd if no memory.
> GFP_ATOMIC also is not good, because for (b) we do not need to waste
> it.

Waking kswapd is fine, because it's a shared facility that doesn't
just reclaim on your behalf but on behalf of a central goal: to get
the freelist back to the watermarks. If they're low, somebody will
sooner or later kick kswapd anyway to do exactly that.

So unless you ask kswapd for a high order page that is unlikely to be
needed by anybody else, you're only doing the inevitable.
