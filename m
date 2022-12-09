Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C9C4332F
	for <rcu@archiver.kernel.org>; Fri,  9 Dec 2022 23:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLIXXe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Dec 2022 18:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIXXd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Dec 2022 18:23:33 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDC29360
        for <rcu@vger.kernel.org>; Fri,  9 Dec 2022 15:23:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so9268689lfb.13
        for <rcu@vger.kernel.org>; Fri, 09 Dec 2022 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+icRteLLplEp3Ek/NXtDd9Se354lCSj/qCUgEIA000k=;
        b=gAqZH17K6r2+VNZVHPk61uPPLKx4h3U28CM81aZWpAIWUmu8PiVAYYGJo/TNew5m1c
         UaLumuIOpDBpPu91/QWAnSz5Tf8lcWI1569hlbnXtxO1r4zBxWIUl9kJIlwuDnPSC9Or
         B5Y8rRhjWNs4jEn8TtjN93iqcYgr+lwi9gMFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+icRteLLplEp3Ek/NXtDd9Se354lCSj/qCUgEIA000k=;
        b=osPi0Id0lTKAjcMDAXqlTFBeayDMaflF4b8DCkSbqGWQVVUl0/yhSPGuL2cq77X/wb
         RHGbgzmNdBTKN0uyPYj8Orrz79PrvuQJuTpCXVNEmr+mv9lXrSm/4ntL71lsudq6oc+E
         fqH3V9QDyWwD7IkcD75D/iOQf06/5dTmVag4hyjIlGKwvRGkvdfJn/B5x9KvNIHN2TYp
         zwzMQr0sXYVEN6rSf9uABnhl058NHd7b6cBK0YfsBteOzDtZDmdRja8otP+oBac5813S
         Ym/qG2Ien8WfXOqw/yM7DeRQUIdiWq+Q1nb4nJf0c6Xky4OwBn8CeTAs9ctuyNEsEU94
         3YXA==
X-Gm-Message-State: ANoB5pmTYGKPV7V1ZUpOyCy/www8Oq8IAPw+DoCTSA9Ncl/qKsFG9nUE
        HDjM38KViboS3zDMEe/RzMzihVDtbwNdip5U1Ff8cVqHp7+usxUF
X-Google-Smtp-Source: AA0mqf6qdZxMmQuUzYi3g1p036fYDzU1mxpBVEonNWDL16/oHB1VOmEcCib4omGOHlK2nPv+IKw5U8c7BOgTaJk/ALg=
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id
 c8-20020a056512324800b004aa148d5168mr30344867lfr.561.1670628210994; Fri, 09
 Dec 2022 15:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org> <20221209163759.6s7pqf5wdvy32ywn@offworld>
 <CAEXW_YRyhXvvyiw=TrPLk4UwBThqeUh+aP_pvCiBSr6Mko2zxg@mail.gmail.com> <20221209223232.2dqjeamad6nhlcmp@offworld>
In-Reply-To: <20221209223232.2dqjeamad6nhlcmp@offworld>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 9 Dec 2022 23:23:19 +0000
Message-ID: <CAEXW_YTLuRU2fxnijoez8m8n50L-FcU46cOLUPgp15m0C8fdxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 9, 2022 at 10:56 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 09 Dec 2022, Joel Fernandes wrote:
>
> >> >-               * Boost priority once every ~50k operations. When the
> >> >-               * task tries to take the lock, the rtmutex it will account
> >> >+               * Boost priority once every rt_boost_factor operations. When
> >> >+               * the task tries to take the lock, the rtmutex it will account
> >>
> >> Nit: maybe refer to it as 'rt_boost_factor'?
> >
> >Sorry, I did not follow. Refer to what?
>
> Just use single quotes to refer to the parameter.

Ah, got it. Will do (either next respin or Paul can do it) and thank you.


 - Joel
