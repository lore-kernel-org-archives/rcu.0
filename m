Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80983C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA7206DB
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 14:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Kc8KDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC3Omi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:42:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41847 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgC3Omh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 10:42:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so18360915lji.8;
        Mon, 30 Mar 2020 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zZl8DGHxKfW9Vu36ePmFE8gP/ULjjF5tAO2pNWgNfJ8=;
        b=h3Kc8KDHcLiXfTCe9KLFRZw8NC3uNi76b2bvj8c5PfQqsPu3mTsnwZHSVXXMF+M57R
         aCZ1Yfa80MsCs0jly+WB/q5zh0bMdinYZ8efN7zr2VXsvNNhAdVLcGycLNRvwA+ITI5w
         Iu9nWHpV4YhgBBcAofo+4dW7YzLWCNCnblGhYo/cMra3um6S+d8ic31+9ibO/v8RhCez
         bGR6LAi0zzGWgXstRGtTSRCX3AgWBPN9iNVlYAritB1dFd93zUGps8o+Cb6ClXLEqZbw
         P1CCbhLNL8U9f45/x88HVfqQILzHaE1WvOBUW38y6VgTjKEk3/yTNassbR7dW4XyiLxE
         65RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zZl8DGHxKfW9Vu36ePmFE8gP/ULjjF5tAO2pNWgNfJ8=;
        b=iaqL3mhNDyXQzfhwruWQuJt4vbIP/o7T0bSBGsS2pjus7alLo9uMsn3V277CcwjmdH
         WKHjtsHqJHLeEbaO383LmJTTuoNwC5gu+uLHSO18WSlzCbfwiQBS04NsWTW0M/1nFigl
         +7ZrEwVJuFq0cQXANJ8ket8C9cu0sAtNM555HFsx8daLtJl3o4z1EMiZQuTKgmKxu1nz
         c6Rs0qlWfM5rXvVldA9W1ZAF5PHcwbjOJK4gAd5XhsSaMk2MUYUgwlT+eiBYTboVcqRL
         lm95G2lV9xxAjD+5nKv86a8mzLjPY6vm0TUdiDTxuKma+AWg9kEOmcBhgggAwyJIo9RM
         oCJQ==
X-Gm-Message-State: AGi0PuYd7A8XT06xdEBQr32TxFrw8T16FuTaLk/VlKisghrIYQXXBE8U
        3p3YPpBGOOYcqQ+dPQuHcoM=
X-Google-Smtp-Source: APiQypJDLgeyGA4Jl3+7HtQKeMzM/OnpeTMviE/XQdDGRdcozdPKungXUDu36lYdIPZMiuEU7g5uTA==
X-Received: by 2002:a2e:854e:: with SMTP id u14mr7198364ljj.95.1585579354883;
        Mon, 30 Mar 2020 07:42:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r141sm7832506lff.58.2020.03.30.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:42:34 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 30 Mar 2020 16:42:27 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 6/7] rcu/tiny: support reclaim for head-less object
Message-ID: <20200330144227.GA16651@pc636>
References: <20200323113621.12048-1-urezki@gmail.com>
 <20200323113621.12048-7-urezki@gmail.com>
 <20200330005637.GA138004@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330005637.GA138004@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> Hmm, Ok. So on -tiny, if there's any allocation failure ever, we immediately
> revert to call_rcu(). I guess we could also create a regular (non-array)
> queue for objects with an rcu_head and queue it on that (since it does not
> need allocation) in case of array allocation failure, however that may not be
> worth it. So this LGTM. Thanks!
> 
> For entire series:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> (I will submit a follow-up to fix the tagging, please let me submit Vlad's
> entire series with some patches on top -- I also did a bit of wordsmithing in
> the commit messages of this series).
>
Thank you, Joel, for your review and help!

> 
> Loved the might_sleep() idea btw, I suppose if atomic context wants to do
> kvfree_rcu(), then we could also have kfree_rcu() defer the kvfree_rcu() to
> execute from a workqueue. Thoughts? We can then allow poor insomniacs from
> calling this API :)
> 
Not sure if i understand you correctly. Could you please <snip> some code
for illustration?

As far as i understand, it should be done then synchronously. We can defer  
and queue some work to do it in worqueue context. But i am not sure how
to proccess next coming request, i.e. busy waiting until we manage to push
a new ptr. to free? But in that case it would not work if there is only
one CPU available.

Thanks!

--
Vlad Rezki
