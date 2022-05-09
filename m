Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48046C433F5
	for <rcu@archiver.kernel.org>; Mon,  9 May 2022 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiEIREK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 May 2022 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiEIREJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 May 2022 13:04:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E91F35ED
        for <rcu@vger.kernel.org>; Mon,  9 May 2022 10:00:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e15so16025080iob.3
        for <rcu@vger.kernel.org>; Mon, 09 May 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqsMsHGXyG9e7T1X9aSpIScjJ6gnaLM4rUxWWppG2GU=;
        b=mSUBt9jSatG7/jerWq3WtP6g9asUOApFg1ooTy1txiHOrk5CKvFGpkMa47dx8kSBZR
         JnifH6GAUlsSsdlqQw1AZwHE6dVqR1WLhnylMg40CIKtYW5n7GUNH/lidBco29nf5HSO
         lFFGGF9fJLtE9YMq1JNDzzhbt/oBf+++M94t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqsMsHGXyG9e7T1X9aSpIScjJ6gnaLM4rUxWWppG2GU=;
        b=SnralpLyz2xEn6tL1ChZeUchhHkFcxrTfniQvOThJnLT5NyHa+ZDldNYenc2nqoJqU
         ftxwBg3uWUD1ywEpfGYHJPFxzTAFzzKnRsNHQJyXMf6axr2XnyiC7s1XiYJzCdomoQDT
         FHBeFM8chnc9mh88C9gniRLRm6VUp1ec54JMGPBOz70cuwy0UYFYNwudPomLL5zlZEde
         7a3B4b/8sOODktCafSKteU6xPcjNX2ed0pH1App06SkWTLSRlC5IxRx4iQzdURK2Jbx6
         m6Y0Kw2BVK2d09SlW+av0mLlqJL3ve7gBPFHlsHU7pyhY84pV+jMmRD1jl3c/KOaJIA9
         izpA==
X-Gm-Message-State: AOAM5339qFY5tFqrk0PC1xSBiQeXj8Jix2qrR1v9qUewhLunCD7JWYTs
        5j0V+Ir8NVV0Nz1eiU/pgw5usQeNSFMp+ppz0alZZgbAGCc=
X-Google-Smtp-Source: ABdhPJwhgjcxNiV+l6kPjlH83Pj9exOz3eCZAk9XacDvee7ZAlyGymXkznQYyeX4jiAp/4INkw+AKDE6t2bQKiutTYs=
X-Received: by 2002:a02:7307:0:b0:324:22bf:e119 with SMTP id
 y7-20020a027307000000b0032422bfe119mr8461079jab.183.1652115615010; Mon, 09
 May 2022 10:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220509155853.GA94897@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220509155853.GA94897@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 9 May 2022 13:00:03 -0400
Message-ID: <CAEXW_YS5=6M3AJ-SOjtRygbJozO78UDNksFzQMqH30hwvyNbtg@mail.gmail.com>
Subject: Re: tools/rcu
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks a lot Paul! I will keep that in mind. :)

Thanks,
Joel

On Mon, May 9, 2022 at 11:58 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Joel!
>
> Just following up from your tweet.  There is a tools/rcu that is likely
> to be the best place for scripts and tools that monitory RCU.
>
>                                                 Thanx, Paul
