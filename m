Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4261C4332F
	for <rcu@archiver.kernel.org>; Wed, 14 Dec 2022 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLNXPD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLNXPB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 18:15:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449913DF2
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 15:15:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p36so12968322lfa.12
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzdgOz9gyjgH/qFtgaJL32M0dERZsKAxOLJDC6S8iQY=;
        b=XClglf5f+07TSaa2FELqubUMVQofVbKWE0rHR3vTLkFBamNmofDKIXp+8dPy2J0EGA
         5IyuqtNyK6Fv1uiHblBAkxuQBEwj+pAWFkoTdHXYDIZtPfObeZVnzMggavti4/di/niy
         gXNFu+PXnwQqqkQtZVtMSxAuKYDFegntYu2rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzdgOz9gyjgH/qFtgaJL32M0dERZsKAxOLJDC6S8iQY=;
        b=nc/t+q5avRndMHBgVw7cl4cnoo7haSBEinA+SB+Oohw0L6obwO7+qoSuImGtr2toPw
         9VHT+lUKLYyYy+lSrrxG3v74NqebPm2kaX+kdTiKzWjmaYIm1079YjF54ntvY9H4VJmQ
         beO/DsQGUcHw60UPZLdXmIRXvb1Y4oOLiqK3OYCbM8EQ9SNhVgP1lvhhY5CbaKz3YxqP
         z99Q672vlQroOX3Fb6qU0vZhflZoB+X/JVW8yhLaaiLp1bdOdP26clDU9gGM+mD00oXe
         wx9QYB/+NmjDJfja2pdl32d3aiPlVsbpyDwtUcOu3wMwp6SG6AnPyhixX159G44Rwk5e
         NWXQ==
X-Gm-Message-State: ANoB5plktIj+j3/zeRP2vpSlzo2o/i2xN+4IXVFbEbthGQ+CjPhAFm7G
        LNx+3nTqaDoV+z08DjbMkeBcvRBhiMl43ygtysfj7A==
X-Google-Smtp-Source: AA0mqf6gRfFfYu+dHou0MOsrfZ3Kk7Ne2XNfijmAQ+m6/3UVcFQsCPe4RlKT4jq4SRiO/YekkPUrenaa1YpAWL6aE9M=
X-Received: by 2002:ac2:5442:0:b0:4b5:1e8:9594 with SMTP id
 d2-20020ac25442000000b004b501e89594mr20417185lfn.583.1671059699364; Wed, 14
 Dec 2022 15:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
 <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
In-Reply-To: <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 23:14:48 +0000
Message-ID: <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 14, 2022 at 11:10 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > I also did not get why you care about readers that come and ago (you
> > > > mentioned the first reader seeing incorrect idx and the second reader
> > > > seeing the right flipped one, etc). Those readers are irrelevant
> > > > AFAICS since they came and went, and need not be waited on , right?.
> > >
> > > The comment is attempting to show (among other things) that we don't
> > > need to care about readers that come and go more than twice during that
> > > critical interval of time during the counter scans.
> >
> > Why do we need to care about readers that come and go even once? Once
> > they are gone, they have already done an unlock() and their RSCS is
> > over, so they need to be considered AFAICS.
> >
>
> Aargh, I meant: "so they need to be considered AFAICS".

Trying again: "so they need not be considered AFAICS".

Anyway, my 1 year old son is sick so signing off for now. Thanks.


 - Joel
