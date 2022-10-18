Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8BC433FE
	for <rcu@archiver.kernel.org>; Tue, 18 Oct 2022 19:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJRTFs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRTFr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Oct 2022 15:05:47 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C46D577
        for <rcu@vger.kernel.org>; Tue, 18 Oct 2022 12:05:45 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u2so7972624ilv.6
        for <rcu@vger.kernel.org>; Tue, 18 Oct 2022 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvzPrSaZfa3ceXOG8MzxaBj8/gxmb/VsuOFjciM5eVk=;
        b=MwyIxjtNwXGJIkL1oFalmkQzo56zPYegOXEjRP8Vg+KRvEj2FlFh7pZ4kWhKGER+Hm
         qxvw5dNgPBGTppXvQGCBjam0hnOXkoJotuQ9mm0d7/wAcq1WCaG3pqIhLGG5acw8i+UA
         yXUxdQ6+ANs5E8vyy377kvZQW8zd7T4ZqHo1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvzPrSaZfa3ceXOG8MzxaBj8/gxmb/VsuOFjciM5eVk=;
        b=n/5wbM4FDY3DmFKkS2HIn7BNoZ2SxSNZ2InxcGUC2TSXRY1LEmEpwJO91ChaB7sGVx
         FGH01dDqFAlesHSURUjk2NTEubtaiyEa2V7fB7JS0Ry1cN2jc+BvTQRcp2XbLlGvc29M
         Kc1h1F7WyrITawhQy4Z34dYyVhsZFlWCGFG1MBDOON3K/7xiOE48PHxotMnmptd8/V3/
         YrvRd4nRJobwcwNBWUsSuahYRxic2VDnLjuFFKBOtqNklTttL0BXLTYnhgbyP97zNTOy
         LRrY+bZ9J5tu0MIa0el6M5kJayCERnknL4L3CGaJUh5w9UamzcNiJAhgSi4i94bwYUQ0
         820Q==
X-Gm-Message-State: ACrzQf1LBzkPDAKX+NdwAhwZVVTkC9NTitA+rIwp3Su01uDOwa5+Mrw4
        t75aG3vTEJ0nZOPJWbBPRLt6YOsF6xKOnlssE37g3Q==
X-Google-Smtp-Source: AMsMyM4JG7oLiNEOYaeGnE9AjJMa/amTHZn9vjIAuIXbxdposRNZe6t2767GGvHO/Tn3iDihAW4WYh3n8aHrKsXhMuU=
X-Received: by 2002:a05:6e02:1c47:b0:2fc:2672:d9c6 with SMTP id
 d7-20020a056e021c4700b002fc2672d9c6mr2665032ilg.35.1666119945229; Tue, 18 Oct
 2022 12:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
 <20221018104533.GC1166572@lothringen> <20221018175034.GU5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221018175034.GU5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Oct 2022 15:05:33 -0400
Message-ID: <CAEXW_YSaFKb7uv+wQnfdEEm41tAiXjEb=bge_0AtNFsQ2s-6Ug@mail.gmail.com>
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 18, 2022 at 1:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Oct 18, 2022 at 12:45:33PM +0200, Frederic Weisbecker wrote:
> > On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> > > When enable CONFIG_PROVE_RCU and built modules, the following
> > > error appear:
> > >
> > > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> > > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> > >
> > > This commit fix it by exporting the srcu_check_nmi_safety().
> > >
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> > Paul, whichever way you prefer, editing the commit or adding this
> > one on top.
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Thank you all!
>
> This is what I currently have, folded into Frederic's original.
>
> Thoughts?

Looks good to me, has this caught any issues yet?

Thanks.
