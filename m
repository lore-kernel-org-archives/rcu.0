Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393EBC77B73
	for <rcu@archiver.kernel.org>; Sun, 30 Apr 2023 21:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjD3VM4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Apr 2023 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjD3VMz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Apr 2023 17:12:55 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8745018C
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 14:12:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a1462f9f6so7040687b3.3
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682889173; x=1685481173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTOeeMi+aLHq+on3/zog/+3erv/XHUhfM5oeS7oeBzs=;
        b=h1Wnfy+JxFlYpKlDxtsimf4Nsig+hpXU7pWNQzo1xYxc0qKGxmnkA4sXqoompbB9uY
         xqRHPd7zMdeFekt+4GH/sJc2rUSpR8ddIXNWSDAwMUW1FIdz1ux3f9ULt6sSGAn24wXw
         xCei6zvXIhEpwMMwtR/xNheE+9EhauJKR8g7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682889173; x=1685481173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTOeeMi+aLHq+on3/zog/+3erv/XHUhfM5oeS7oeBzs=;
        b=XSDhr17Zy2tNiAQjKhPcGionF2VzDuf5NQcl9tlAgkF1ReEyfCfzL8Z1+TJO3lcmCG
         t7Q0R7yOCaacsxBDTwNoeFkhJlA1YwqHx7gvvG4puTVSlb4KUkMWmPRS439q2F8Wy1SQ
         dJZr7AU5bC5DfrFKqZ6WR7btIyC5HX9LLH/LXd7AJ5vtr3dFv1GylftlUrvJQatd7pwT
         jM1/uEm2QJPpFeHckkMyzi2z8PCwaQR7My1dhwTzW+ZRpvqCtMYnHeHrVLdZt3T7kVqP
         GYEL8MQxxr0r7Q+ET0qguqB8qOxLbWwASzhqSQ840MJ0GwkLEyNEse5ic+Ukpyl1iJ9A
         9c1Q==
X-Gm-Message-State: AC+VfDxdPYHdrawYn1sB6pJuZ4v8K11KkVpnAoOY+oV7Sw2vVrXYhbQx
        Xc6PjalTEPmqu3PCGZ201UOOFkq0utBfQwbZRWO/yiwuKZToz/9G
X-Google-Smtp-Source: ACHHUZ4vNod2XB56McT8SuljOQhkxTkCTHaoW+tUzbVpS1uZcP2RRagRftYAbwxE6yg1tCFKmC/JRmaZD5Rz+N8i3+o=
X-Received: by 2002:a81:87c4:0:b0:54f:9cd0:990 with SMTP id
 x187-20020a8187c4000000b0054f9cd00990mr10014247ywf.18.1682889173723; Sun, 30
 Apr 2023 14:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YSFm0XNMkfodBXVx-AsgJvcvGF+kmE+ZqU0Y=ehFJx+JQ@mail.gmail.com>
 <a8ffd9f6-5696-4e49-a91d-bd9954abeb21@paulmck-laptop>
In-Reply-To: <a8ffd9f6-5696-4e49-a91d-bd9954abeb21@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 30 Apr 2023 17:12:44 -0400
Message-ID: <CAEXW_YTecqGQu+h_u+esT4a7O=QUwg88q2K3h-oEiLq1x-qWWQ@mail.gmail.com>
Subject: Re: Exp GPs and rcu_read_unlock()
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 30, 2023 at 4:50=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Apr 30, 2023 at 03:56:11PM -0400, Joel Fernandes wrote:
> > Hello,
> > Quick question (for educational purpose) for anyone - why does
> > PREEMPT=3Dn kernel not want to get help from __rcu_read_unlock() for
> > expedited grace periods?
> >
> > Basically, with PREEMPT=3Dy kernels,  rcu_read_unlock_special.b.exp_hin=
t
> > is set to true, but for PREEMPT=3Dn, no such thing is done. Furthermore=
,
> > the __rcu_read_unlock() for PREEMPT=3Dn does not help expedited GPs com=
e
> > to an end either.
> >
> > I am guessing the answer is, "no one cares about that", or "no one
> > reported needing this", but if there is another reason why a PREEMPT=3D=
n
> > kernel should not need it, do let me know :)
>
> Because PREEMPT=3Dn kernels value fast rcu_read_unlock() more than they
> value fast expedited grace periods.

Ok, makes sense.

> > To make it more interesting, it appears that CONFIG_PREEMPT=3Dy where
> > preemption is dynamically disabled, it _should_ have the  effect of
> > helping expedited GPs as far as I can see. Which further seems a
> > difference between booting PREEMPT=3Dn versus PREEMPT=3Dy + booting wit=
h
> > preemption turned off via boot option.
>
> Yes, very much so!
>
> So if you care deeply about fast expedited grace periods and less
> so about smallish rcu_read_unlock() slowdowns, but otherwise want
> non-preemptibility, CONFIG_PREEMPT_DYNAMIC=3Dy and dynamically selecting
> non-preemptible operation might be your best choice.

Makes sense, thanks!

 - Joel
