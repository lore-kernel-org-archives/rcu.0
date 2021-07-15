Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA654C07E96
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 14:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC23D6127C
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhGOOLn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhGOOLn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Jul 2021 10:11:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F2C061760
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 07:08:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso6346347pjz.1
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53qxuoU8eppRM5jkQ4Kk+jPNk3lJWcHi5u+XjEfD+pc=;
        b=ZTICTx9k3uv0754iy1fraBKdvHUdUWqFmJ+cE1gb88CsJOVkzbC4GkXqB6hkDd2aS8
         M/hivmpaeFOLjVtk7grKV56LsAlnxkICFVN4HAoePXJuDrYVQscR5tAZO3IcaitL6UlT
         d74IpB6j+D+hlAu+tg152h2YjWneYcVztYXjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53qxuoU8eppRM5jkQ4Kk+jPNk3lJWcHi5u+XjEfD+pc=;
        b=h16Fv0iA6EcSgf6fje72/tIwuT3UHUQY2y6UeTpWNQeMO3JgCMkrLhYbw3uHOfT3E7
         uDhFcwQo/KBeCt06i/vOfIQurLFRXA84VqJU2K2zmpHPLBRfn814lJk4lVAR1ILw+/fx
         voEYAcXvP2P2yqB8DXlyeQJCj5/od07jq7NxUmDRkbKhP73xH2D+NmZScGw99OtmItke
         xlw/R+lUfgBpDE9Zm9nCqkvnD8FicoZycP0Jv4w/rG2c3f+6c1u3OkXYmxH+LUqHi6uz
         cwUL2Yc6KZvgEAdNsMWiJmdB5bhwliZhWnfnQaAsWigz0J1uu+JOS8wiguPi2X5PYnxA
         c2iA==
X-Gm-Message-State: AOAM532fTJuHqJXMb9R2FA6scy161WQOLpY6WaW5mlFkykcZ0RUwEvrq
        TcU6JKyce3rf9FIuKDBOdfvokA==
X-Google-Smtp-Source: ABdhPJwr4orhN8EsxOujAU/gk+BQElZ62i0IgfexfrRqK76o00qh7gVKE32yOIUtHWnteORcM6O8ug==
X-Received: by 2002:a17:902:bc44:b029:12b:415:57bf with SMTP id t4-20020a170902bc44b029012b041557bfmr3534211plz.33.1626358129676;
        Thu, 15 Jul 2021 07:08:49 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:cf9:3b54:4709:3747])
        by smtp.gmail.com with ESMTPSA id u24sm6977225pfm.156.2021.07.15.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:08:48 -0700 (PDT)
Date:   Thu, 15 Jul 2021 23:08:41 +0900
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
Message-ID: <YPBBaSnoGSeQtawz@google.com>
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <YO/7WS/WefdkFFbj@google.com>
 <20210715133241.GJ4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715133241.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/07/15 06:32), Paul E. McKenney wrote:
> > 
> > Hello Paul,
> > 
> > I've noticed that this patch set didn't make it to Linus's tree.
> > Was it intentional?
> 
> This patch (and the 18 preceding it) didn't make the cutoff for the
> just-past merge window.

Oh, I see.

> If this patch is urgent, please let me know
> and I can push it, with luck by the end of next week.
> 
> If that one is urgent, are these two also?

No, Paul, nothing is urgent.

Many thanks for the detailed clarifications.
