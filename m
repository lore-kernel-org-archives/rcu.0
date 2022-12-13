Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D16C4167B
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 20:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiLMUvb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 15:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiLMUva (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 15:51:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4431EAE8
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 12:51:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so6911432lfb.13
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtopGNdAVUpvCsyIX1KgtU4sqTtYdCSzIci1F+/mf5I=;
        b=iXvUqXzJcYDv9nNH6IVXFyfUZLa9Ec2A1fJHkMV/Ptc4Kod8dpeVkvD/tT3Vjy2AqM
         e7iqrSfHToE5ZGqCSMZnhikb7BlakvbsM6EcZ2cNxm9OHmlfnmJjxG8exKl6Ny1BwESz
         0cyNg/f7OwddvuMcrKmdU9bAd+Sr2ZPxafFyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtopGNdAVUpvCsyIX1KgtU4sqTtYdCSzIci1F+/mf5I=;
        b=yt0x3YWeMC4QVHqkW76DeqYk6P/SeOf2fyWkWVkXtUI5B3fHo4uS5eIGmi3ubQtaCI
         UdjgW/9ehGK4eCXDz9vngBEQJLrVJGfk70RgX9YXcCCDkC8kNTeRSztd7MqXCOzfQFPq
         qPhzTcDTORj0hG8MJuDEjXgkpCuuCeff+frkQ4hiueph+JEwNu4nfGLFtvDUPstAOpiC
         fHFxs2+7N2/TWXw+EWQNjav3tiIM8NCe3Zr5vbEZd8m/aVoz+DELICLWDKsqy881ffH0
         TAnTRxSadMxhMobvx7/fhoVEMSYOjBF4HN7kc/R+uVsWFl/yq1hIVPOH/SrWXS6/QECb
         SMpQ==
X-Gm-Message-State: ANoB5plXQG+e1KlnHFMF5IRygmHnzAPHD/G3GK3cTIXl6CiIHa4g699p
        ySluzT5ot4FWZo+TrryNk4B+DGAfG7M2TmClkQkKYRA0Gx3yEw==
X-Google-Smtp-Source: AA0mqf4p1MV1rnbaiMPJkPJlZFAq+ZI68Md7kh2S23YTDleUAxgd2sI+eda1vxGt5QYsGjj3TlgCb3QZ5sCuxxBB/Bk=
X-Received: by 2002:a05:6512:b26:b0:4b4:f7aa:4e4 with SMTP id
 w38-20020a0565120b2600b004b4f7aa04e4mr20840495lfu.128.1670964687872; Tue, 13
 Dec 2022 12:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org> <20221213202443.GU4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221213202443.GU4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 13 Dec 2022 15:51:16 -0500
Message-ID: <CAEXW_YRXaq-GSpbRqeioQ-M1LHZGdis_qOA8thj8w6EndkB4qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 3:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Dec 09, 2022 at 02:23:04AM +0000, Joel Fernandes (Google) wrote:
> > Currently RT boosting is only done for rtmutex_lock, however with proxy
> > execution, we also have the mutex_lock participating in priorities. To
> > exercise the testing better, add RT boosting to other lock testing types
> > as well, using a new knob (rt_boost).
> >
> > Tested with boot parameters:
> > locktorture.torture_type=mutex_lock
> > locktorture.onoff_interval=1
> > locktorture.nwriters_stress=8
> > locktorture.stutter=0
> > locktorture.rt_boost=1
> > locktorture.rt_boost_factor=1
> > locktorture.nlocks=3
> >
> > For the rtmutex test, rt_boost is always enabled even if disabling is
> > requested.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Nice, thank you!
>
> Except that "git am -3" doesn't know about the commit on which this
> is based.  Could you please rebase onto the -rcu tree's "dev" branch?
>
> Though there is nothing touching kernel/locking/locktorture.c in
> -rcu at the moment, so I confess some curiosity as to exactly what
> these patches are based on.  ;-)

Ah, I am not sure any more as it has been some time but I believe it
was v5.15. My bad and I rebased it on to rcu/dev branch and resent it
just now :)

Thank you!

 - Joel
