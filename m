Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A688C47080
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 04:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EECD6024A
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 04:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhEXECF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 May 2021 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhEXECE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 May 2021 00:02:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93896C061756
        for <rcu@vger.kernel.org>; Sun, 23 May 2021 21:00:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so19104060pgm.13
        for <rcu@vger.kernel.org>; Sun, 23 May 2021 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PkGL/jirzcz4Lvqb4/MaE1jMqBDDNPzHgjnDClieuEo=;
        b=RyMoNBJ5LXlz3lErKrV7Mx+2qO+5hLyS2t1/2Ij/ygzhBpM3lEEYRALvBPTm6/adVi
         i9KOdXO8aoiolkhvwTvEZ+abOqr1qHY0HBAnWR9MzpiSA9NUmaOInZywi7Yx1ssTKyDs
         awWKkQAVMDcb8L1v47QGpZRl2l9a4DKVwKg8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkGL/jirzcz4Lvqb4/MaE1jMqBDDNPzHgjnDClieuEo=;
        b=mr6GbPbMLbgs62KjL/IaObQvZDb2gVc2AD9a3MxzC4OGZkXhs7otZeTQwa6q1Pc1IT
         AKk7iG26kDvVAjz5iyZ6VLbXT58eGkI8TwAI9Yqsx1NasLA2+1ADSkRIBb1xEbJKk2pb
         0FVUufQJyJ17uokLdFhXaz95pi0YlxKIEwSlyQGioh3RAQ4LGyZHEpzMvK3CtTYwxzDI
         JEGisznh8DotITZce+iEdGJNqgpmf8iJkL1xn/qbRF5vU36DgQOjKk1sABHGmQne+OuZ
         Y9ioB7kFMlTfRJbPiMboQZBcYXUoizIRYUMCGO9EvMn2CUXrxXGES22EwdS3qxFHdQon
         JL9w==
X-Gm-Message-State: AOAM531bnjI7Sn2mMskTgqRWQzItkfW+tqtoAVWLsQsfdX/cTHBToS3I
        6vPZQh+y/+KqBIlmMOuzSGUy6w==
X-Google-Smtp-Source: ABdhPJwzqY9hiTjr90NxYZ01WoyFOoK/lrGZrXP5jkiQDmlyC/gLbRo96v9qx+cbDPzt/qZ6SeNXrg==
X-Received: by 2002:a62:1d52:0:b029:2dd:ee:1439 with SMTP id d79-20020a621d520000b02902dd00ee1439mr22124945pfd.57.1621828835108;
        Sun, 23 May 2021 21:00:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7357:1320:fdb3:1853])
        by smtp.gmail.com with ESMTPSA id o17sm3991608pgj.25.2021.05.23.21.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:00:34 -0700 (PDT)
Date:   Mon, 24 May 2021 13:00:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <YKsk3ZdDyoy9/Ga/@google.com>
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
 <20210521213855.GA3437356@paulmck-ThinkPad-P17-Gen-1>
 <YKsH3GrEoxcMf4j0@google.com>
 <20210524034645.GH4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524034645.GH4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/23 20:46), Paul E. McKenney wrote:
> 
> In theory, yes, sort of, anyway.  In practice, highly unlikely.
> The most plausible way for this to happen is for this code path to be
> delayed for a long time on a 32-bit system, so that jiffies+ULONG_MAX/2
> actually arrives.  But in that case, all sorts of other complaints
> would happen first.

I see.

> But I could make this a cmpxchg(), if that is what you are getting at.

No, it's good. I was just curious what scenario I was missing.
