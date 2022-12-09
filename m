Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D928FC4332F
	for <rcu@archiver.kernel.org>; Fri,  9 Dec 2022 03:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiLID64 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Dec 2022 22:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLID6z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Dec 2022 22:58:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C23389D4
        for <rcu@vger.kernel.org>; Thu,  8 Dec 2022 19:58:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so2772831qta.9
        for <rcu@vger.kernel.org>; Thu, 08 Dec 2022 19:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5NBFExJQX/d6O4EBVZbzy/yhUjpt1GHLcfTjZTMaiE=;
        b=iFcKcca7ArFEQgM14qoskwpw7ghHqKQbpaVNgtX+pbj7X6cfac6FCmqpneWw3drvep
         3bqnIWeR2CaEOlNogdF5MdGRBV47vAl/x9X2ettjsd9HwNFURwSkS2GrsINYzJiX0DYf
         qdKbkYWGFLuvliEUjA2fQEgHOHx8oNmB+WVts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5NBFExJQX/d6O4EBVZbzy/yhUjpt1GHLcfTjZTMaiE=;
        b=L78VB08cgL1m7Uu3XBJJAViHIRKDSRcCoKWGWJvsSrRZZyxsALDy6ISMFvcbPBHFT1
         bf5sCwhNeMkGZ9zu/gYjnlC7R/9O1Qq03mY8xh639Byfrbp+QMUwa5Npstzc0sx38JLt
         ljh1gGBVsT5tz4RtxKJwGE1ehaeOYW0LtIe1OEnT6KGg5ob3d5daxmhxXEqGYYJcoSXu
         li4qy5L0Hp0RP2h+rrMpRPWlaqJdCrz4H317PcZ1PPSQb5NLM6Aijs5+3eOPOPL54O+O
         WhoXKGL6SQjGY6tNe2q1SiVyoc7Of0DLIxR0MJs5AyIiA+f7R11hiNOqkQG1nzve9XhA
         XoKw==
X-Gm-Message-State: ANoB5pm5w8Mn6Iiob47665U3jxJYV2++925hN4fqK7ppyeATgUEXxuRs
        zLJNehiHI6MRU7ODVnpyucXTZg==
X-Google-Smtp-Source: AA0mqf5rErhlkiiQqaAysDUvSWZ7f1LB1vbu2Rlbe1Sm5ag2aO6eDLaohQsq0nj3URy02xoQHnkN6w==
X-Received: by 2002:ac8:1013:0:b0:3a5:6961:e1c5 with SMTP id z19-20020ac81013000000b003a56961e1c5mr5613885qti.48.1670558328627;
        Thu, 08 Dec 2022 19:58:48 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b867:2d8b:5186:cf90:77eb:ee52])
        by smtp.gmail.com with ESMTPSA id bq39-20020a05620a46a700b006fbae4a5f59sm278336qkb.41.2022.12.08.19.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 19:58:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
Date:   Thu, 8 Dec 2022 22:58:36 -0500
Message-Id: <2D7B1E52-D2FC-45ED-A739-BA9A1213FD49@joelfernandes.org>
References: <20221209032550.p4tcyypgkuspp2ur@offworld>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
In-Reply-To: <20221209032550.p4tcyypgkuspp2ur@offworld>
To:     Davidlohr Bueso <dave@stgolabs.net>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 8, 2022, at 10:50 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>=20
> =EF=BB=BFOn Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:
>=20
>> Currently RT boosting is only done for rtmutex_lock, however with proxy
>> execution, we also have the mutex_lock participating in priorities. To
>> exercise the testing better, add RT boosting to other lock testing types
>> as well, using a new knob (rt_boost).
>=20
> No particular objection to the patches, but shouldn't these go as part
> of the next iteration of the PE series?

Hey Davidlohr,
Nice to hear from you. Paul was interested in these for some things he is lo=
oking at and also as general clean up ;)

Thanks.



>=20
> Thanks,
> Davidlohr
