Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D9C3F2D1
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33016206E6
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="h0wbAKXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEW0A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:26:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40900 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEWZ7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 17:25:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so469636qka.7
        for <rcu@vger.kernel.org>; Thu, 05 Mar 2020 14:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DS3YcKqO0mcvZOjaCwu0fyqXymHyb+ZjqvrmGOweESY=;
        b=h0wbAKXuAqwo28k+L1LitMTs7AAC/dVZRZ2ITanvKFmMHIay2KcQrKUAHY3sE7abTX
         DcHRM3gVQZaSUpyYNLENY9/JOWsxRnBTGFpngQAUriNZhOBOC7/UYjW66aigFhvl29fV
         Tl+TyKlrgIiewIPKtGdZmt8rj93Ymk1zIkzHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DS3YcKqO0mcvZOjaCwu0fyqXymHyb+ZjqvrmGOweESY=;
        b=XAOOFe0L6uqIm4eT8eXxoQWDqnlmV7vvzigCwdp0tiQRND4D5iLFg6Pr7OVh+iQfAt
         ev2valialcYpZ4t/NCYDdGUdOMqwf1Ek2izeJXLil+ZmsbsWZmTkKa+zJvbi40JjaVVU
         nDCdj4HfUs66OHxuTioWGO3g1U9tZ5U2mWW49RDT6gx5QDZc5NCnnxGmluO8bGpnsdwl
         lvy4hBRa3JydDYl/d9SG0L9xHXNthmX7oXn3+zVrpljG9+aHf+GlbUi3fPUm/i7vV3x4
         Ms5s1nd8oqTKQz/+tH3KJIxW201WVq/EZh25/EO9cLJiGw8N/ZzuUzZjs86RN+istgHb
         SIsw==
X-Gm-Message-State: ANhLgQ2rlWc1hqIv4ozTc+AUkCKCdYRIIh2SpTlcQRmUHMz0YnfBWZM+
        5/eWX4xD9lpV83K6w+rHjdGwdA==
X-Google-Smtp-Source: ADFU+vt1oVNptXPz9F8bBpIDh+C+Grp42hvsIUhuEafTJkrTFcfHcFAnWPnE/23LP587vsl/ZjoSkQ==
X-Received: by 2002:a37:4d10:: with SMTP id a16mr210869qkb.325.1583447158811;
        Thu, 05 Mar 2020 14:25:58 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g1sm6910713qkl.55.2020.03.05.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:25:58 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:25:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH linus/master 2/2] rcu/tree: Add a shrinker to prevent OOM
 due to kfree_rcu() batching
Message-ID: <20200305222557.GC66450@google.com>
References: <20200305221323.66051-1-joel@joelfernandes.org>
 <20200305221323.66051-2-joel@joelfernandes.org>
 <20200305221753.GA66450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305221753.GA66450@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 05, 2020 at 05:17:53PM -0500, Joel Fernandes wrote:
> On Thu, Mar 05, 2020 at 05:13:23PM -0500, Joel Fernandes (Google) wrote:
> > To reduce grace periods and improve kfree() performance, we have done
> > batching recently dramatically bringing down the number of grace periods
> > while giving us the ability to use kfree_bulk() for efficient kfree'ing.
> > 
> > However, this has increased the likelihood of OOM condition under heavy
> > kfree_rcu() flood on small memory systems. This patch introduces a
> > shrinker which starts grace periods right away if the system is under
> > memory pressure due to existence of objects that have still not started
> > a grace period.
> > 
> > With this patch, I do not observe an OOM anymore on a system with 512MB
> > RAM and 8 CPUs, with the following rcuperf options:
> > 
> > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000
> > rcuperf.kfree_rcu_test=1 rcuperf.kfree_mult=2
> 
> Paul,
> I may have to rebase this patch on top of Vlad's kfree_bulk() work. But let
> us discuss patch and I can rebase it and repost it once patch looks Ok to
> you. (The kfree_bulk() work should not affect the patch).

BTW, we can also use the scheme in the future to keep garbage uncollected
until memory pressure. That way you defer grace periods for longer similar to
the paper [1], until the MM layer thinks the party is over. For one, I am not
too confident about the shrinker's ability to handle transient memory spikes.
If I remember, the shrinker is best-effort.

But one step at a time :)

thanks,

 - Joel

[1] https://dl.acm.org/doi/10.1145/3190508.3190522

