Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA896C54E76
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 21:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAQV2Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAQV0y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 16:26:54 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5C4E508
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 11:45:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so48615748lfv.2
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVHl3CyYmBwOxeuIn2rI4GuiLJQNlWei9nWh+ruH28g=;
        b=OgRLjzfKd5KOKCaXGS+Y2kcI38Z+2Yub/6sPZFuD77pvpFzZlLpKlvxeWe1gz7pwap
         yKN0UWxUcLWGSOaCLuvUti/tne5oRXq/e0+qWi07lmVabjRBVLXIRoel+B2yVFLYc0zv
         TLq9idplrIeMg0mzOH2KnnszI7v9PUo1v8SA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVHl3CyYmBwOxeuIn2rI4GuiLJQNlWei9nWh+ruH28g=;
        b=cO/to2keaTLscllfOZgY6BOIcMiDbouniJJghIHU+lxDXjY+u8qp0P4TOoSaIaym61
         jXz8RYFKg3NkDzgN0ia7/w67auRY1KtY/l0r1XJzlAwdYTLTPrhRmS/E2NOhZUaNRK0E
         l/iAdh/nDCcj/3GT4SMyAL7q7JQfuywNcyzH3kve/Id7h4Lf2zafL66+JWJ4Bi2UYGhi
         pvXqClzCxxLSa2EZysYE4vx/41X4i3WwrcXQd0sFtCbf/8lFhVffaVZRBo+d2rXCNd+O
         J/KCy3+uLbOwMwoChwqtPn1ZwRIXC6tNBQPuN8vSd6NDkNUoF7h4wH/fWNBTb2KJLejt
         f+7g==
X-Gm-Message-State: AFqh2kqMomqt1+LdOFvRATjMIU5UdZmQ4nf8twk9D3eoqg6oECNWgY5t
        790PSdy0dAXsRFR89dKO+uoOw7ts3Y52l0kc4FXvzg==
X-Google-Smtp-Source: AMrXdXuzz3EDyHUSdqZSl1JThqJwC2ye2DRobi9jaBxz9vJJTfFX5SHt4UHysiacaNRt8YrvXGQ+4o3NF4WuZiO7D0E=
X-Received: by 2002:a05:6512:39ce:b0:4aa:148d:5168 with SMTP id
 k14-20020a05651239ce00b004aa148d5168mr228410lfu.561.1673984723933; Tue, 17
 Jan 2023 11:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230115162504.08ef72b0@rorschach.local.home> <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
 <20230117143224.6fbf7da8@gandalf.local.home> <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Jan 2023 19:45:12 +0000
Message-ID: <CAEXW_YRYuroym5e4ApJ8oYofsocVj6ApCmCCf07kfJy=PD-9ww@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 7:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jan 17, 2023 at 02:32:24PM -0500, Steven Rostedt wrote:
> > On Sun, 15 Jan 2023 16:34:58 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > > > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> > > > >
> > > >
> > > > Where do you plan on calling these externally, as they are being
> > > > marked exported?
> > > >
> > > > If you allow random drivers to enable this, I can see something
> > > > enabling it and hitting an error path that causes it to never disable
> > > > it.
> > >
> > > You mean, just like rcu_expedite_gp() ?
> > >
> > > > I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> > > > needed externally.
> > >
> > > At the moment it is not called externally but in the future, it could
> > > be from rcutorture. If you see rcu_expedite_gp(), that is exported
> > > too. I was just modeling it around that API.
> >
> > The reason for the export should have been mentioned in the change log if
> > the patch is not obvious to why it is being exported.
>
> Would something like this suffice?  With attribution, of course.
>
>         Export rcu_async_should_hurry(), rcu_async_hurry(), and
>         rcu_async_relax() for later use by rcutorture.

Looks good to me Paul, and thanks for the suggestion Steven!

 - Joel
