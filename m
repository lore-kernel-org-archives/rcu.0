Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C278C4332F
	for <rcu@archiver.kernel.org>; Wed, 14 Dec 2022 23:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLNXLC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLNXK6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 18:10:58 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B311148
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 15:10:56 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h10so8246943ljk.11
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPbJtGVICGi21b9X/GDOOs7MaYuwlHUqxPV3Gfg7e4Q=;
        b=gv3hlHp4zhRp3YnpmtITYMaAdFQM73+9U3oC6Qvs0EwGGrZBjmyA40cyO6wfepz7vK
         XavMuYSKd+gNsL7dxIEyDLL9rixP9b6a7V2FOdZQvNp2eBV93QgO3RAW1elXvyyyVGYl
         EoO0nXr8CJjcku/eL7+eqQbssjsLzVkXf3bVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPbJtGVICGi21b9X/GDOOs7MaYuwlHUqxPV3Gfg7e4Q=;
        b=giiymtPlXzZjn/mcZCx7oZJ6Egx4vC+fAa//3/eLyK1R3qXUjtD14Z6CpxW2GAx6sM
         Bsm4DNhEa9SmAhvyicOhfNlPDPD7+bYXiPEZcXd8fM/L0GlAhbypUu4Eh2TXBmgPI1KW
         ikGVSSufEgaEc1JVlultzRlKGpGMQ+4FJAUd8DEmBWanB+CRVNa/3nFqMNteynKv1b06
         CQhouxFs4jL4E6wnQr7q+GKWgGb7+5vBp71eW58++yJRvCpVZUgrMjMiRL6E/oPi+aDL
         hXMi20q5SYdGUToOuVwgB4dU7trtEo5urPVyXaSKZJvnw1H10KBIbNF0AXu6y5LIJC2q
         XnTg==
X-Gm-Message-State: ANoB5pkhZc+KsQb87aV7dMj/q6xpK17SO6011NaLAZO8L4W7q4DJ+A7n
        seaFaEnyLYJUlW/+KWby4mlkwyo68n/1He+jsz2L3w==
X-Google-Smtp-Source: AA0mqf5RsdGmKzoVfCYQZR6n2uhQzTyWAuO2oZHXdncJmKGSmczZztD8TtdaqkxDiYHFK6mABgeBC37/MsRZlOagtI0=
X-Received: by 2002:a05:651c:90a:b0:277:309:73cb with SMTP id
 e10-20020a05651c090a00b00277030973cbmr33192896ljq.371.1671059454605; Wed, 14
 Dec 2022 15:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 23:10:43 +0000
Message-ID: <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > I also did not get why you care about readers that come and ago (you
> > > mentioned the first reader seeing incorrect idx and the second reader
> > > seeing the right flipped one, etc). Those readers are irrelevant
> > > AFAICS since they came and went, and need not be waited on , right?.
> >
> > The comment is attempting to show (among other things) that we don't
> > need to care about readers that come and go more than twice during that
> > critical interval of time during the counter scans.
>
> Why do we need to care about readers that come and go even once? Once
> they are gone, they have already done an unlock() and their RSCS is
> over, so they need to be considered AFAICS.
>

Aargh, I meant: "so they need to be considered AFAICS".

Thanks.
